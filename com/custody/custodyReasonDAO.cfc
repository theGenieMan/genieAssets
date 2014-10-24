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

	<cffunction name="readCustodyReasons" output="false" access="public" returntype="genieObj.custody.custodyReason[]">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">
        <cfset var reasons=ArrayNew(1)>

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	CUSTODY_REF, SEQ_NO, ARREST_REASON_TEXT
			from BROWSER_OWNER.CUSTODY_REASONS
			where CUSTODY_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#" />
		</cfquery>

        <cfloop query="qRead">
		<cfscript>
			obj = createObject("component", "genieObj.custody.custodyReason").init();
			obj.setCUSTODY_REF(qRead.CUSTODY_REF);
			obj.setSEQ_NO(qRead.SEQ_NO);
			obj.setARREST_REASON_TEXT(qRead.ARREST_REASON_TEXT);
			ArrayAppend(reasons, obj);
		</cfscript>
        </cfloop>
        
        <cfreturn reasons>
        
	</cffunction>


</cfcomponent>