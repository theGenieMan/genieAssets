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
        
        <cfset variables.custodyDeparturesDAO=CreateObject("component","genieObj.custody.custodyDeparturesDAO").init(warehouseDSN=variables.warehouseDSN,
					                                                                                                 warehouseDSN2=variables.warehouseDSN2,
					                                                                                                 warehouseUID=variables.warehouseUID,
					                                                                                                 warehousePWD=variables.warehousePWD)>
                                                                                                 
        <cfset variables.custodyReasonsDAO=CreateObject("component","genieObj.custody.custodyReasonDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD)>                
           
        <cfreturn this />  
    </cffunction> 

	<cffunction name="read" output="false" access="public" returntype="custody">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	cs.CUSTODY_REF, STATION, NOMINAL_REF, NAME, SEX, DOB, 
					ETHNIC_APP, ARREST_TIME, AO_FORCE, AO_BADGE, AO_STATION, 
					OIC_FORCE, OIC_BADGE, OIC_STATION, ORIG_CUSTODY, DEPARTURE_TIME, 
					BAIL_ANSWERED, CREATION_DATE, CUSTODY_TYPE, ARREST_SUMMONS_NO,
                    AO_NAME, OIC_NAME, RIGHTS, CHARGED, BAIL_CANC_REASON, 
					NEXT_REVIEW_DATE, REVIEW_RANK, DETAIN_UNTIL, STATUS, CELL, 
					PLACE_OF_ARREST,CUSTODY_TYPE
			from BROWSER_OWNER.CUSTODY_SEARCH cs, BROWSER_OWNER.CUSTODY_DETAIL cd
			where cs.CUSTODY_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getCUSTODY_REF()#" />
            and cs.CUSTODY_REF=cd.CUSTODY_REF
		</cfquery>

		<cfscript>
			obj.setCUSTODY_REF(qRead.CUSTODY_REF);
			obj.setCUSTODY_TYPE(qRead.CUSTODY_TYPE);			
			obj.setSTATION(qRead.STATION);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setNAME(qRead.NAME);
			obj.setSEX(qRead.SEX);
			obj.setDOB(qRead.DOB);
			obj.setETHNIC_APP(qRead.ETHNIC_APP);
			obj.setARREST_TIME(qRead.ARREST_TIME);
			obj.setAO_FORCE(qRead.AO_FORCE);
			obj.setAO_BADGE(qRead.AO_BADGE);
			obj.setAO_STATION(qRead.AO_STATION);
			obj.setOIC_FORCE(qRead.OIC_FORCE);
			obj.setOIC_BADGE(qRead.OIC_BADGE);
			obj.setOIC_STATION(qRead.OIC_STATION);
			obj.setORIG_CUSTODY(qRead.ORIG_CUSTODY);
			obj.setDEPARTURE_TIME(qRead.DEPARTURE_TIME);
			obj.setBAIL_ANSWERED(qRead.BAIL_ANSWERED);
			obj.setCREATION_DATE(qRead.CREATION_DATE);
			obj.setCUSTODY_TYPE(qRead.CUSTODY_TYPE);
			obj.setARREST_SUMMONS_NO(qRead.ARREST_SUMMONS_NO);
			obj.setAO_NAME(qRead.AO_NAME);
			obj.setOIC_NAME(qRead.OIC_NAME);
			obj.setRIGHTS(qRead.RIGHTS);
			obj.setCHARGED(qRead.CHARGED);
			obj.setBAIL_CANC_REASON(qRead.BAIL_CANC_REASON);
			obj.setNEXT_REVIEW_DATE(qRead.NEXT_REVIEW_DATE);
			obj.setREVIEW_RANK(qRead.REVIEW_RANK);
			obj.setDETAIN_UNTIL(qRead.DETAIN_UNTIL);
			obj.setSTATUS(qRead.STATUS);
			obj.setCELL(qRead.CELL);
			obj.setPLACE_OF_ARREST(qRead.PLACE_OF_ARREST);		
			obj.setCustodyReasons(variables.custodyReasonsDAO.readCustodyReasons(id=obj.getCUSTODY_REF()));	
			obj.setCustodyDepartures(variables.custodyDeparturesDAO.readCustodyDepartures(id=obj.getCUSTODY_REF()));				
			return obj;
		</cfscript>
	</cffunction>
	
	<cffunction name="readInCustody" output="false" access="public" returntype="custody">
		<cfargument name="nominalRef" required="true">
		<cfset var qInCust="">
        <cfset var currentCustody=CreateObject("component","genieObj.custody.custody")>

		<cfquery name="qInCust" datasource="#variables.warehouseDSN#">
			select cs.custody_ref, station, arrest_time, STATUS
			from  browser_owner.CUSTODY_SEARCH cs, browser_owner.CUSTODY_DETAIL cd
			where  cs.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			AND    cs.custody_ref=cd.custody_ref
			AND    status IN ('C','I')
			AND    departure_time is null
			order by arrest_time desc
		</cfquery>
        
        <cfif qInCust.RecordCount GT 0>
            
          <cfset currentCustody.setCUSTODY_REF(qInCust.CUSTODY_REF)>
          <cfset currentCustody=read(currentCustody)>
        </cfif>

        <cfreturn currentCustody>
		
	</cffunction>	

	<cffunction name="getNominalCustodies" output="false" access="public" returntype="array">
		<cfargument name="nominalRef" required="true">
		<cfset var qCusts="">
        <cfset var custs=ArrayNew(1)>
        <cfset var cust="">

		<cfquery name="qCusts" datasource="#variables.warehouseDSN#">
			select 	CUSTODY_REF
			from    BROWSER_OWNER.CUSTODY_SEARCH
			where   NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nominalRef#" />
            order by CREATION_DATE desc
		</cfquery>
        
        <cfif qCusts.RecordCount GT 0>
         <cfloop query="qCusts">
          <cfset cust=CreateObject("component","genieObj.custody.custody")>
          <cfset cust.setCUSTODY_REF(CUSTODY_REF)>
          <cfset cust=read(cust)>
          <cfset ArrayAppend(custs,cust)>
         </cfloop>
        </cfif>

        <cfreturn custs>
		
	</cffunction> 

</cfcomponent>