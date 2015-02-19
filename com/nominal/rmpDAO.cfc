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

	<cffunction name="read" output="false" access="public" returntype="rmp">
		<cfargument name="obj" required="true">
		<cfset var qRead="">		
		<cfset var qNomsOnPlan="">		

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	*
			from    BROWSER_OWNER.RISK_MAN_PLANS
			where   RMP_URN=<cfqueryparam value="#obj.getRMP_URN()#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfscript>
			obj.setRMP_URN(qRead.RMP_URN);
			obj.setRMP_TYPE(qRead.RMP_TYPE);
			obj.setDATE_GENERATED(qRead.DATE_GENERATED);
			obj.setDATE_DUE(qRead.DATE_DUE);
			obj.setDATE_RECEIVED(qRead.DATE_RECEIVED);
			obj.setCOMPLETED(qRead.COMPLETED);
			obj.setLPA(qRead.LPA);				
			obj.setCATS_MAIN_FILE(qRead.CATS_MAIN_FILE);							
		</cfscript>
		
		<!--- get VICTIMS and OFFENDERS for the RMP 
		<cftry>--->
		
		<cfquery name="qNomsOnPlan" datasource="#variables.warehouseDSN#">
		   SELECT REPLACE(REPLACE(LTRIM(
                  		        RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
						        RTRIM(INITCAP(FORENAME_1))||' '||
						        RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')||' ('||ns.NOMINAL_REF||')' AS NOMINAL, ROLE_TYPE
			FROM   BROWSER_OWNER.RISK_MAN_PLAN_NOMINALS rmpn, BROWSER_OWNER.NOMINAL_SEARCH ns
			WHERE  rmpn.NOMINAL_REF=ns.NOMINAL_REF
			AND    rmpn.RMP_URN=<cfqueryparam value="#obj.getRMP_URN()#" cfsqltype="cf_sql_varchar">
			AND    rmpn.ROLE_TYPE IN ('Offender','Victim')
		</cfquery>
		
		<cfloop query="qNomsOnPlan">
			<cfif ROLE_TYPE IS "Victim">
			  <cfset obj.setVICTIMS(ListAppend(obj.getVICTIMS(),NOMINAL,"|"))>	
			<cfelseif ROLE_TYPE IS "Offender">
			  <cfset obj.setOFFENDERS(ListAppend(obj.getOFFENDERS(),NOMINAL,"|"))>	
			</cfif>
		</cfloop>
		
		<!---
		<cfcatch type="any">
			<cfreturn obj>
		</cfcatch>			
		</cftry>
		--->
						
		<cfreturn obj>		
	</cffunction>

	<cffunction name="getNominalRMP" output="false" access="public" returntype="any">
		<cfargument name="nominalRef" required="true">
		<cfset var qRMP="">
        <cfset var rmp="">
		<cfset var arrSearch=ArrayNew(1)>
        
		<cfquery name="qRMP" datasource="#variables.warehouseDSN#">
			SELECT rmp.RMP_URN
			FROM   browser_owner.RISK_MAN_PLANS rmp, browser_owner.RISK_MAN_PLAN_NOMINALS rmpn
			WHERE  rmpn.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			AND    rmpn.RMP_URN=rmp.RMP_URN
			ORDER BY DATE_GENERATED DESC
		</cfquery>
        
        <cfif qRMP.RecordCount GT 0>
          <cfloop query="qRMP">  
		   <cfset rmp=CreateObject("component","genieObj.nominal.rmp").init()>
           <cfset rmp.setRMP_URN(RMP_URN)>
           <cfset ArrayAppend(arrSearch,read(rmp))>		           
		  </cfloop>
        </cfif>
                 
        <cfreturn arrSearch>
		
	</cffunction> 
	
	<cffunction name="getNominalIsOnRMP" output="false" access="public" returntype="any">
		<cfargument name="nominalRef" required="true">
		<cfargument name="rmpType" required="false" default="">
		
		<cfset var qRMP="">
        <cfset var rmpStruct=structNew()>
		        
		<cfquery name="qRMP" datasource="#variables.warehouseDSN#">
			SELECT rmp.RMP_URN
			FROM   browser_owner.RISK_MAN_PLANS rmp, browser_owner.RISK_MAN_PLAN_NOMINALS rmpn
			WHERE  rmpn.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			AND    rmpn.RMP_URN=rmp.RMP_URN
			AND    rmp.COMPLETED IS NULL
			<cfif Len(arguments.rmpType) GT 0>
			AND    rmp.RMP_TYPE=<cfqueryparam value="#arguments.rmpType#" cfsqltype="cf_sql_varchar">
			</cfif>
			ORDER BY DATE_GENERATED DESC
		</cfquery>
        
        <cfif qRMP.RecordCount GT 0>            
		   <cfset rmpstruct.rmp=CreateObject("component","genieObj.nominal.rmp").init()>
           <cfset rmpstruct.rmp.setRMP_URN(qRMP.RMP_URN)>
           <cfset rmpstruct.rmp=read(rmpstruct.rmp)>
		   <cfset rmpstruct.current=true>   		           		  
		<cfelse>
		   <cfset rmpstruct.current=false>
		   <cfset rmpstruct.rmp="">
        </cfif>
                 
        <cfreturn rmpstruct>
		
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