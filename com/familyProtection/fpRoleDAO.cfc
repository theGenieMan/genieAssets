<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="rispURL" required="true" type="String">        
        <cfargument name="rispPort" required="true" type="String">                
        <cfargument name="rispSoapAction" required="true" type="String">   
        <cfargument name="rispPersonSearchHeader" required="true" type="String">   
        <cfargument name="rispPersonSearchFooter" required="true" type="String">                   
        <cfargument name="rispPersonSummaryHeader" required="true" type="String">   
        <cfargument name="rispPersonSummaryFooter" required="true" type="String">           
        <cfargument name="rispPersonDetailHeader" required="true" type="String">   
        <cfargument name="rispPersonDetailFooter" required="true" type="String">                      
        <cfargument name="personSearchProcedure" required="true" type="String">              
        <cfargument name="geniePastePath" required="true" type="String">   
		<cfargument name="forceLookup" required="true" type="String">      
        <cfargument name="wMidsTimeout" required="true" type="String">                       
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>
        <cfset variables.rispURL=arguments.rispURL>
        <cfset variables.rispPort=arguments.rispPort>
        <cfset variables.rispSoapAction=arguments.rispSoapAction>
        <cfset variables.rispPersonSearchHeader=arguments.rispPersonSearchHeader>
        <cfset variables.rispPersonSearchFooter=arguments.rispPersonSearchFooter>
        <cfset variables.rispPersonSummaryHeader=arguments.rispPersonSummaryHeader>
        <cfset variables.rispPersonSummaryFooter=arguments.rispPersonSummaryFooter>                           
        <cfset variables.rispPersonDetailHeader=arguments.rispPersonDetailHeader>
        <cfset variables.rispPersonDetailFooter=arguments.rispPersonDetailFooter>                        
        <cfset variables.personSearchProcedure=arguments.personSearchProcedure>   
        <cfset variables.geniePastePath=arguments.geniePastePath> 
        <cfset variables.forceLookup=arguments.forceLookup> 
        <cfset variables.wMidsTimeout=arguments.wMidsTimeout> 		  
        
        <cfset variables.nominalDAO=CreateObject("component","genieObj.nominal.nominalDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 rispURL=variables.rispURL,
                                                                                                 rispPort=variables.rispPort,
                                                                                                 rispSoapAction=variables.rispSoapAction,
                                                                                                 rispPersonSearchHeader=variables.rispPersonSearchHeader,
                                                                                                 rispPersonSearchFooter=variables.rispPersonSearchFooter,    
                                                                                                 rispPersonSummaryHeader=variables.rispPersonSummaryHeader,
                                                                                                 rispPersonSummaryFooter=variables.rispPersonSummaryFooter,                                                                                                       
                                                                                                 rispPersonDetailHeader=variables.rispPersonDetailHeader,
                                                                                                 rispPersonDetailFooter=variables.rispPersonDetailFooter,                                                                                                      
                                                                                                 personSearchProcedure=variables.personSearchProcedure,
																								 geniePastePath=variables.geniePastePath,
                                                                                                 forceLookup=variables.forceLookup,
                                                                                                 wMidsTimeout=variables.wMidsTimeout                                                                                                                 
                                                                                                )>	
         
                   
        <cfreturn this />  
    </cffunction>  

	<cffunction name="read" output="false" access="public" returntype="familyProtection">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select *
			from BROWSER_OWNER.FAMILY_PROTECTION
			where CAR_EVENT_ID = <cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#arguments.obj.getCAR_EVENT_ID()#" />
            and   NOMINAL_REF  = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.obj.getNOMINAL_REF()#" />
		</cfquery>

		<cfscript>
			obj.setCAR_EVENT_ID(qRead.CAR_EVENT_ID);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setROLE_DESC(qRead.ROLE_DESC);
			obj.setDATE_STARTED(qRead.DATE_STARTED);
			obj.setDATE_FINISHED(qRead.DATE_FINISHED);
			obj.setROLE_REASON(qRead.ROLE_REASON);
			obj.setCAR_STATUS(qRead.CAR_STATUS);
			obj.setNAME(variables.nominalDAO.getWestMerciaNominalFullName(nominalRef=qRead.NOMINAL_REF));
			return obj;
		</cfscript>
	</cffunction>
    
	<cffunction name="getCarRoles" output="false" access="public" returntype="array">
		<cfargument name="carEventId" required="true">
		<cfargument name="nominalRef" required="true">
		<cfargument name="dateStarted" required="true">
		<cfargument name="roleDesc" required="true">                        
		<cfset var qCR="">
        <cfset var carRoles=ArrayNew(1)>
        <cfset var carRole="">

		<cfquery name="qCR" datasource="#variables.warehouseDSN#">
		select *
		from   BROWSER_OWNER.FAMILY_PROTECTION
        where CAR_EVENT_ID = <cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#arguments.carEventId#" />
        order by date_started desc   
		</cfquery>
        
        <cfif qCR.RecordCount GT 0>
         <cfloop query="qCR">
		  <cfscript>
            carRole=createObject('component','genieObj.familyProtection.fpRole');
			carRole.setCAR_EVENT_ID(qCR.CAR_EVENT_ID);
			carRole.setNOMINAL_REF(qCR.NOMINAL_REF);
			carRole.setROLE_DESC(qCR.ROLE_DESC);
			carRole.setDATE_STARTED(qCR.DATE_STARTED);
			carRole.setDATE_FINISHED(qCR.DATE_FINISHED);
			carRole.setROLE_REASON(qCR.ROLE_REASON);
			carRole.setCAR_STATUS(qCR.CAR_STATUS);
			carRole.setNAME(variables.nominalDAO.getWestMerciaNominalFullName(nominalRef=qCR.NOMINAL_REF));
            ArrayAppend(carRoles,carRole);
          </cfscript>  
         </cfloop>
        </cfif>

        <cfreturn carRoles>
		
	</cffunction>       

</cfcomponent>