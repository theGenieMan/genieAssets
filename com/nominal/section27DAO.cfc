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

	<cffunction name="read" output="false" access="public" returntype="section27">
		<cfargument name="obj" required="true">
		<cfset var qRead="">		

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	*
			from    BROWSER_OWNER.SECTION_27 S27
			where   S27_URN=<cfqueryparam value="#obj.getS27_URN()#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfscript>
			obj.setS27_URN(qRead.S27_URN);
			obj.setDATE_CREATED(qRead.DATE_CREATED);
			obj.setCREATED_BY(qRead.CREATED_BY);
			obj.setOFFICER(qRead.OFFICER);
			obj.setFORCE_CODE_OC(qRead.FORCE_CODE_OC);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setSUBJECT_NAME(qRead.SUBJECT_NAME);
			obj.setDOB(qRead.DOB);
			obj.setETHNICITY(qRead.ETHNICITY);
			obj.setEA_CODE(qRead.EA_CODE);
			obj.setADDRESS(qRead.ADDRESS);
			obj.setLOCATION(qRead.LOCATION);
			obj.setTPU(qRead.TPU);
			obj.setSEX(qRead.SEX);						
			obj.setGROUNDS(qRead.GROUNDS);
			obj.setS27_ZONE(qRead.S27_ZONE);
			obj.setS27_DATE_FROM(qRead.S27_DATE_FROM);
			obj.setS27_DATE_TO(qRead.S27_DATE_TO);
			obj.setEXTRA_HOURS(qRead.EXTRA_HOURS);
			obj.setS27_MAP_REF(qRead.S27_MAP_REF);				
		</cfscript>
						
		<cfreturn obj>		
	</cffunction>

	<cffunction name="getNominalSection27" output="false" access="public" returntype="any">
		<cfargument name="nominalRef" required="true">
		<cfset var qS27="">
        <cfset var s27="">
		<cfset var arrSearch=ArrayNew(1)>
        
		<cfquery name="qS27" datasource="#variables.warehouseDSN#">
			SELECT s27.S27_URN
			FROM   browser_owner.SECTION_27 s27
			WHERE  s27.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			ORDER BY DATE_CREATED DESC
		</cfquery>
        
        <cfif qS27.RecordCount GT 0>
          <cfloop query="qS27">  
		   <cfset s27=CreateObject("component","genieObj.nominal.section27").init()>
           <cfset s27.setS27_URN(S27_URN)>
           <cfset ArrayAppend(arrSearch,read(s27))>		           
		  </cfloop>
        </cfif>
                 
        <cfreturn arrSearch>
		
	</cffunction> 
	
	<cffunction name="getNominalIsOnSection27" output="false" access="public" returntype="any">
		<cfargument name="nominalRef" required="true">
		<cfset var qS27="">
        <cfset var s27struct=structNew()>
		        
		<cfquery name="qS27" datasource="#variables.warehouseDSN#">
			SELECT s27.S27_URN
			FROM   browser_owner.SECTION_27 s27
			WHERE  s27.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			AND    s27.S27_DATE_FROM < SYSDATE AND s27.S27_DATE_TO > SYSDATE
		</cfquery>
        
        <cfif qS27.RecordCount GT 0>            
		   <cfset s27struct.s27=CreateObject("component","genieObj.nominal.section27").init()>
           <cfset s27struct.s27.setS27_URN(qS27.S27_URN)>
           <cfset s27struct.s27=read(s27struct.s27)>
		   <cfset s27struct.current=true>   		           		  
		<cfelse>
		   <cfset s27struct.current=false>
		   <cfset s27struct.s27="">
        </cfif>
                 
        <cfreturn s27struct>
		
	</cffunction> 	

    <!---
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
    --->
</cfcomponent>