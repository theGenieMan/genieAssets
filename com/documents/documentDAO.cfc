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
                   
        <cfreturn this />  
    </cffunction>   

	<cffunction name="read" output="false" access="public" returntype="document">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehousedsn#">
			select 	NOMINAL_REF, SERIAL_NO, DOC_NUMBER, DOC_TYPE, DATE_ISSUE, DATE_EXPIRY, 
					DOC_NAME, ISSUE_PLACE, OTHER_DETAILS
			from BROWSER_OWNER.NOMINAL_DOCUMENTS
			where NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getNOMINAL_REF()#" />
		</cfquery>

		<cfscript>
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setSERIAL_NO(qRead.SERIAL_NO);
			obj.setDOC_NUMBER(qRead.DOC_NUMBER);
			obj.setDOC_TYPE(qRead.DOC_TYPE);
			obj.setDATE_ISSUE(qRead.DATE_ISSUE);
			obj.setDATE_EXPIRY(qRead.DATE_EXPIRY);
			obj.setDOC_NAME(qRead.DOC_NAME);
			obj.setISSUE_PLACE(qRead.ISSUE_PLACE);
			obj.setOTHER_DETAILS(qRead.OTHER_DETAILS);
			return obj;
		</cfscript>
	</cffunction>

	<cffunction name="getNominalDocuments" output="false" access="public" returntype="query">
		<cfargument name="nominalRef" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehousedsn#">
			select 	NOMINAL_REF, SERIAL_NO, DOC_NUMBER, DOC_TYPE, DATE_ISSUE, DATE_EXPIRY, 
					DOC_NAME, ISSUE_PLACE, OTHER_DETAILS
			from BROWSER_OWNER.NOMINAL_DOCUMENTS
			where NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nominalRef#" />
		</cfquery>
        
        <cfreturn qRead>
	</cffunction>

</cfcomponent>