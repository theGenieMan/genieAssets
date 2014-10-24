<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="geniePastePath" required="true" type="String">
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
        <cfset variables.geniePastePath=arguments.geniePastePath>   
        
        <cfset variables.bailDetailDAO=CreateObject("component","genieObj.bails.bailDetailDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD)>
                                                                                                 
        <cfset variables.bailConditionDAO=CreateObject("component","genieObj.bails.bailConditionDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD)>
           
        <cfreturn this />  
    </cffunction>   

	<cffunction name="read" output="false" access="public" returntype="bail">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	BAIL_REF, NOMINAL_REF, CUSTODY_REF, BAIL_TYPE, DATE_SET, BAILED_TO_DATE, 
					BAILED_FROM, BAILED_TO, BAIL_OFFICER, CANCELLATION_REASON, WARRANT_REF, 
					CANCELLATION_DATE, STATUS
			from BROWSER_OWNER.BAIL_SEARCH
			where BAIL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getBAIL_REF()#" />
		</cfquery>

		<cfscript>
			obj.setBAIL_REF(qRead.BAIL_REF);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setCUSTODY_REF(qRead.CUSTODY_REF);
			obj.setBAIL_TYPE(qRead.BAIL_TYPE);
			obj.setDATE_SET(qRead.DATE_SET);
			obj.setBAILED_TO_DATE(qRead.BAILED_TO_DATE);
			obj.setBAILED_FROM(qRead.BAILED_FROM);
			obj.setBAILED_TO(qRead.BAILED_TO);
			obj.setBAIL_OFFICER(qRead.BAIL_OFFICER);
			obj.setCANCELLATION_REASON(qRead.CANCELLATION_REASON);
			obj.setWARRANT_REF(qRead.WARRANT_REF);
			obj.setCANCELLATION_DATE(qRead.CANCELLATION_DATE);
			obj.setSTATUS(qRead.STATUS);
			obj.setBailDetails(variables.bailDetailDAO.readBailDetails(qRead.BAIL_REF));
			obj.setBailConditions(variables.bailConditionDAO.readBailConditions(qRead.BAIL_REF));			
			return obj;
		</cfscript>
	</cffunction>
    
	<cffunction name="readOnBail" output="false" access="public" returntype="bail">
		<cfargument name="nominalRef" required="true">
		<cfset var qOnBail="">
        <cfset var bail=CreateObject("component","genieObj.bails.bail")>

		<cfquery name="qOnBail" datasource="#variables.warehouseDSN#">
			SELECT bail_ref
			FROM  browser_owner.BAIL_SEARCH
			WHERE NOMINAL_ref = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nominalRef#" />
			AND   (BAIL_TYPE='COURT' AND trunc(bailed_to_date) >= trunc(sysdate) 
			       OR (BAIL_TYPE='POLICE' AND bailed_to_date >= sysdate))
			AND   (STATUS IS NULL OR STATUS = 'GRANTED')
		</cfquery>
        
        <cfif qOnBail.RecordCount GT 0>
            
          <cfset bail.setBAIL_REF(qOnBail.BAIL_REF)>
          <cfset bail=read(bail)>
        </cfif>

        <cfreturn bail>
		
	</cffunction>    
    
	<cffunction name="getNominalBails" output="false" access="public" returntype="array">
		<cfargument name="nominalRef" required="true">
		<cfset var qBails="">
        <cfset var bails=ArrayNew(1)>
        <cfset var bail="">

		<cfquery name="qBails" datasource="#variables.warehouseDSN#">
			SELECT bs.BAIL_REF
			FROM   browser_owner.BAIL_SEARCH BS
			WHERE  nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			ORDER BY DATE_SET DESC
		</cfquery>
        
        <cfif qBails.RecordCount GT 0>
         <cfloop query="qBails">
          <cfset bail=CreateObject("component","genieObj.bails.bail")>
          <cfset bail.setBAIL_REF(BAIL_REF)>
          <cfset bail=read(bail)>
          <cfset ArrayAppend(bails,bail)>
         </cfloop>
        </cfif>

        <cfreturn bails>
		
	</cffunction>      

	<cffunction name="getDueOnBail" output="false" access="public" returntype="array">
		<cfargument name="diaryDate" required="true">
		<cfargument name="diarySuite" required="true">
		
		<cfset var qBails="">
        <cfset var bails=ArrayNew(1)>
        <cfset var bail="">

		<cfquery name="qBails" datasource="#variables.warehouseDSN#">
			select BAIL_REF
			from   browser_owner.BAIL_SEARCH BS
			where  trunc(BS.BAILED_TO_DATE)=trunc(TO_DATE(<cfqueryparam value="#arguments.diaryDate#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))
			and    BS.CANCELLATION_DATE is null
			and    BS.BAIL_TYPE='POLICE'
			and    REPLACE(REPLACE(REPLACE(BAILED_TO, ', WEST MERCIA CONSTABULARY',''),'NUNEATON AND BEDWORTH DISTRICT SECTOR, WARWICKSHIRE POLICE','NUNEATON'),'SOUTHERN AREA, WARWICKSHIRE POLICE','LEAMINGTON SPA') IN (<cfqueryparam value="#arguments.diarySuite#" cfsqltype="cf_sql_varchar" list="true">)
			order by REPLACE(REPLACE(REPLACE(BAILED_TO, ', WEST MERCIA CONSTABULARY',''),'NUNEATON AND BEDWORTH DISTRICT SECTOR, WARWICKSHIRE POLICE','NUNEATON'),'SOUTHERN AREA, WARWICKSHIRE POLICE','LEAMINGTON SPA'), BAILED_TO_DATE 
		</cfquery>
        
        <cfif qBails.RecordCount GT 0>
         <cfloop query="qBails">
          <cfset bail=CreateObject("component","genieObj.bails.bail")>
          <cfset bail.setBAIL_REF(BAIL_REF)>
          <cfset bail=read(bail)>
          <cfset ArrayAppend(bails,bail)>
         </cfloop>
        </cfif>

        <cfreturn bails>
		
	</cffunction>    

	<cffunction name="getBailConditions" output="false" access="public" returntype="array">
		<cfargument name="fromDate" required="true">
		<cfargument name="fromTime" required="true">
		<cfargument name="toDate" required="true">
		<cfargument name="toTime" required="true">
		
		<cfset var qBails="">
        <cfset var bails=ArrayNew(1)>
        <cfset var bail="">

		<cfquery name="qBails" datasource="#variables.warehouseDSN#">
			SELECT DISTINCT(BS.BAIL_REF), DATE_SET
			FROM browser_owner.BAIL_SEARCH bs, BROWSER_OWNER.BAIL_CONDITIONS bc
			WHERE BC.BAIL_REF=BS.BAIL_REF 
			AND DATE_SET BETWEEN TO_DATE('#fromDate# #fromTime#','DD/MM/YYYY HH24:MI')
			                 AND TO_DATE('#toDate# #toTime#','DD/MM/YYYY HH24:MI')
			AND BAIL_TYPE='POLICE'
			AND STATUS <> 'CLOSED'   
			ORDER BY DATE_SET
		</cfquery>
        
        <cfif qBails.RecordCount GT 0>
         <cfloop query="qBails">
          <cfset bail=CreateObject("component","genieObj.bails.bail")>
          <cfset bail.setBAIL_REF(BAIL_REF)>
          <cfset bail=read(bail)>
          <cfset ArrayAppend(bails,bail)>
         </cfloop>
        </cfif>

        <cfreturn bails>
		
	</cffunction>   

</cfcomponent>