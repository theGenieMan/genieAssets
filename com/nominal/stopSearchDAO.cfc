<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">        
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>              
                   
        <cfreturn this />  
    </cffunction>   

	<cffunction name="read" output="false" access="public" returntype="stopSearch">
		<cfargument name="obj" required="true">
		<cfset var qRead="">
		<cfset var qLinkedIntel="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	TO_CHAR(SS_DATE,'DD/MM/YYYY HH24:MI') AS SS_DATE,
			        NOMINAL_REF,
			        SUBJECT_NAME,
			        DOB,
			        OFFICER,
			        TPU,
			        SS_LOCATION,
			        SS_REASON,
			        SS_MAP_REF,
			        ADDRESS,
			        GROUNDS,
			        SS_POS_SEARCH,
			        SS_ARREST,
			        VEHICLE,
			        ADD_COMMENTS
			from    BROWSER_OWNER.STOP_SEARCH ss
			where   SS_URN=<cfqueryparam value="#obj.getSS_URN()#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfscript>
			obj.setSS_DATE(qRead.SS_DATE);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setSUBJECT_NAME(qRead.SUBJECT_NAME);
			obj.setSUBJECT_DOB(qRead.DOB);
			obj.setOFFICER(qRead.OFFICER);
			obj.setTPU(qRead.TPU);
			obj.setSS_MAP_REF(qRead.SS_MAP_REF);
			obj.setADDRESS(qRead.ADDRESS);
			obj.setSS_LOCATION(qRead.SS_LOCATION);
			obj.setSS_REASON(qRead.SS_REASON);
			obj.setSS_GROUNDS(qRead.GROUNDS);
			obj.setSS_POS_SEARCH(qRead.SS_POS_SEARCH);
			obj.setSS_ARREST(qRead.SS_ARREST);
			obj.setVEHICLE(qRead.VEHICLE);
			obj.setADD_COMMENTS(qRead.ADD_COMMENTS);	
		</cfscript>
		
		<cfquery name="qLinkedIntel" datasource="#variables.warehouseDSN#">
			SELECT LOG_REF
			FROM   BROWSER_OWNER.STOP_SEARCH_INTEL
			WHERE  SS_URN=<cfqueryparam value="#obj.getSS_URN()#" cfsqltype="cf_sql_varchar">
		</cfquery>
		
		<cfset obj.setLINKED_INTEL(ListToArray(ValueList(qLinkedIntel.LOG_REF,",")),",")>
						
		<cfreturn obj>		
	</cffunction>

	<cffunction name="getNominalStopSearch" output="false" access="public" returntype="any">
		<cfargument name="nominalRef" required="true">
		<cfset var qSS="">
        <cfset var stopSearch="">
		<cfset var arrSearch=ArrayNew(1)>
        
		<cfquery name="qSS" datasource="#variables.warehouseDSN#">
			SELECT ss.SS_URN
			FROM   browser_owner.STOP_SEARCH ss
			WHERE  ss.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			ORDER BY SS_DATE DESC
		</cfquery>
        
        <cfif qSS.RecordCount GT 0>
          <cfloop query="qSS">  
		   <cfset stopSearch=CreateObject("component","genieObj.nominal.stopSearch").init()>
           <cfset stopSearch.setSS_URN(SS_URN)>
           <cfset ArrayAppend(arrSearch,read(stopSearch))>		           
		  </cfloop>
        </cfif>
                 
        <cfreturn arrSearch>
		
	</cffunction> 

	<cffunction name="search" output="false" access="public" returntype="any" hint="searches the stop search data based on tpu, reason, grounds, officer, startDate, endDate">
	   <cfargument name="tpu" type="string" required="false" default="" hint="tpu to filter on">
	   <cfargument name="reason" type="string" required="false" hint="search reason eg. GOING EQUIPPED">
	   <cfargument name="grounds" type="string" required="false" hint="grounds eg. ACTING SUSPICIOUSLY">   
	   <cfargument name="officer" type="string" required="false" hint="collar of officer doing search eg. 4854">      
	   <cfargument name="startDate" type="string" required="true" hint="start date in DD-MON-YYYY HH24:MI:SS format">
	   <cfargument name="endDate" type="string" required="true" hint="end date in DD-MON-YYYY HH24:MI:SS format">   
		
		<cfset var qSS="">
		<cfset var sGround="">
		<cfset var i=1>
        
		<cfquery name="qSS" datasource="#variables.warehouseDSN#">
			SELECT ss.*
			FROM   browser_owner.STOP_SEARCH ss
			WHERE  (1=1)
			<cfif Len(arguments.tpu) GT 0>
			AND    TPU=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">	
			</cfif>
			<cfif Len(arguments.reason) GT 0>
			AND    SS_REASON IN (<cfqueryparam value="#arguments.reason#" cfsqltype="cf_sql_varchar" list="true">)	
			</cfif>
			<cfif Len(arguments.grounds) GT 0>
			AND    (
			          <cfset i=1>
			          <cfloop list="#arguments.grounds#" index="sGround" delimiters=",">
					  	  <cfif i GT 1>
							OR
						  </cfif>
						  GROUNDS LIKE <cfqueryparam value="%#sGround#%" cfsqltype="cf_sql_varchar">
					  	  <cfset i++>
					  </cfloop>
			       )	
			</cfif>
			<cfif Len(arguments.officer) GT 0>
			AND    OFFICER = <cfqueryparam value="#arguments.officer#" cfsqltype="cf_sql_varchar">	
			</cfif>		
			<cfif Len(arguments.startDate) GT 0 and Len(arguments.endDate) GT 0>
			AND    SS_DATE BETWEEN TO_DATE(<cfqueryparam value="#arguments.startDate#">,'DD-MON-YYYY HH24:MI:SS')
			                   AND TO_DATE(<cfqueryparam value="#arguments.endDate#">,'DD-MON-YYYY HH24:MI:SS')
			</cfif>										
			ORDER BY SS_DATE DESC
		</cfquery>
                         
        <cfreturn qSS>
		
	</cffunction> 

	<cffunction name="getByURN" output="false" access="public" returntype="any" hint="returns stop searches for an urn or csv list of urns">
		<cfargument name="urn" required="true">
		<cfargument name="removeNullMapRef" required="true">
		
		<cfset var SS_URN="">
        <cfset var stopSearch="">
		<cfset var arrSearch=ArrayNew(1)>
               
        
        <cfloop list="#arguments.urn#" index="SS_URN" delimiters=",">  
		   <cfset stopSearch=CreateObject("component","genieObj.nominal.stopSearch").init()>
           <cfset stopSearch.setSS_URN(SS_URN)>
		   <cfset stopSearch=read(stopSearch)>
		   <cfif arguments.removeNullMapRef>
		     <cfif Len(stopSearch.getSS_MAP_REF()) GT 0>
			   <cfset ArrayAppend(arrSearch,stopSearch)>	 
			 </cfif>
		   <cfelse>	      
           	 <cfset ArrayAppend(arrSearch,stopSearch)>
		   </cfif>		           
		</cfloop>
                 
        <cfreturn arrSearch>
		
	</cffunction> 

</cfcomponent>