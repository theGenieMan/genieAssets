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
																								
        <cfset variables.fpRoleDAO=CreateObject("component","genieObj.familyProtection.fpRoleDAO").init(warehouseDSN=variables.warehouseDSN,
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
			select 	CAR_EVENT_ID, NOMINAL_REF, ROLE_DESC, DATE_STARTED, DATE_FINISHED, ROLE_REASON, 
					ROLE_TYPE_REF, CAR_STATUS, CAR_EVENT_UR1, CAR_EVENT_UR2, CAR_EVENT_UR3, 
					ASSIGNMENT_REF, CONF_LOC_TYPE, CONF_LOC_CODE, CONF_DATE, CAR_OFFICE_TYPE, 
					CAR_OFFICE_CODE, CAR_OFFICE_TELNO, DATE_CREATED, FORM_DATE, REVIEW_DATE, 
					BADGE_NUMBER, CAR_EVENT_NOTE, FAMILY_TITLE, FILE_LOCATION
			from BROWSER_OWNER.FAMILY_PROTECTION
			where CAR_EVENT_ID = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#arguments.obj.getCAR_EVENT_ID()#" />
		</cfquery>

		<cfscript>
			obj.setCAR_EVENT_ID(qRead.CAR_EVENT_ID);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setROLE_DESC(qRead.ROLE_DESC);
			obj.setDATE_STARTED(qRead.DATE_STARTED);
			obj.setDATE_FINISHED(qRead.DATE_FINISHED);
			obj.setROLE_REASON(qRead.ROLE_REASON);
			obj.setROLE_TYPE_REF(qRead.ROLE_TYPE_REF);
			obj.setCAR_STATUS(qRead.CAR_STATUS);
			obj.setCAR_EVENT_UR1(qRead.CAR_EVENT_UR1);
			obj.setCAR_EVENT_UR2(qRead.CAR_EVENT_UR2);
			obj.setCAR_EVENT_UR3(qRead.CAR_EVENT_UR3);
			obj.setASSIGNMENT_REF(qRead.ASSIGNMENT_REF);
			obj.setCONF_LOC_TYPE(qRead.CONF_LOC_TYPE);
			obj.setCONF_LOC_CODE(qRead.CONF_LOC_CODE);
			obj.setCONF_DATE(qRead.CONF_DATE);
			obj.setCAR_OFFICE_TYPE(qRead.CAR_OFFICE_TYPE);
			obj.setCAR_OFFICE_CODE(qRead.CAR_OFFICE_CODE);
			obj.setCAR_OFFICE_TELNO(qRead.CAR_OFFICE_TELNO);
			obj.setDATE_CREATED(qRead.DATE_CREATED);
			obj.setFORM_DATE(qRead.FORM_DATE);
			obj.setREVIEW_DATE(qRead.REVIEW_DATE);
			obj.setBADGE_NUMBER(qRead.BADGE_NUMBER);
			obj.setCAR_EVENT_NOTE(qRead.CAR_EVENT_NOTE);
			obj.setFAMILY_TITLE(qRead.FAMILY_TITLE);
			obj.setFILE_LOCATION(qRead.FILE_LOCATION);
			obj.setROLES(variables.fpRoleDAO.getCarRoles(carEventId=obj.getCar_Event_Id(),dateStarted=obj.getDATE_STARTED(),roleDesc=obj.getROLE_DESC(),nominalRef=obj.getNOMINAL_REF()));
			return obj;
		</cfscript>
	</cffunction>
    
	<cffunction name="getNominalFamilyProtection" output="false" access="public" returntype="array">
		<cfargument name="nominalRef" required="true">
		<cfset var qFP="">
        <cfset var fps=ArrayNew(1)>
        <cfset var fp="">

		<cfquery name="qFP" datasource="#variables.warehouseDSN#">
		select   distinct CAR_EVENT_ID, REVIEW_DATE
		from     BROWSER_OWNER.FAMILY_PROTECTION
		WHERE    NOMINAL_REF='#nominalRef#'
        ORDER BY REVIEW_DATE DESC
		</cfquery>
        
        <cfif qFP.RecordCount GT 0>
         <cfloop query="qFP">
          <cfset fp=CreateObject("component","genieObj.familyProtection.familyProtection")>
          <cfset fp.setCAR_EVENT_ID(CAR_EVENT_ID)>
          <cfset fp=read(fp)>
          <cfset ArrayAppend(fps,fp)>
         </cfloop>
        </cfif>

        <cfreturn fps>
		
	</cffunction>     

</cfcomponent>