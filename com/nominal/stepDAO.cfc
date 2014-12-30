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

	<cffunction name="getNominalSTEP" output="false" access="public" returntype="any">
		<cfargument name="nominalRef" required="true">
		<cfset var qStep="">
        
		<cfquery name="qStep" datasource="#variables.warehouseDSN#">
			SELECT step.*
			FROM   browser_owner.STEP_PACKAGES step, browser_owner.STEP_NOMINALS noms
			WHERE  noms.NOMINAL_REF=<cfqueryparam value="#nominalRef#" cfsqltype="cf_sql_varchar">
			AND    noms.PACKAGE_ID=step.PACKAGE_ID
			ORDER BY step.PACKAGE_ID DESC
		</cfquery>
                         
        <cfreturn qStep>
		
	</cffunction> 
		
</cfcomponent>