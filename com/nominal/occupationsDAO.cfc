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

	<cffunction name="read" output="false" access="public" returntype="occupation">
		<cfargument name="nominalRef" required="true">
		<cfargument name="serialNo" required="true">        
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
				select 	*
				from BROWSER_OWNER.NOMINAL_OCCUPATIONS
				where NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nominalRef#" />
                AND   SERIAL_NO   = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.serialNo#" />
			</cfquery>
	
			<cfscript>
				obj = createObject("component", "occupations").init();
				obj.setNOMINAL_REF(qRead.NOMINAL_REF);
				obj.setSERIAL_NO(qRead.SERIAL_NO);
				obj.setOCC_CODE(qRead.OCC_CODE);
				obj.setOCC_CLASS(qRead.OCC_CLASS);
				obj.setOCCUPATION(qRead.OCCUPATION);
				obj.setOCCUPATION_DATE(qRead.OCCUPATION_DATE);
				obj.setCURRENT_WORK_LOCATION(qRead.CURRENT_WORK_LOCATION);
				obj.setORG_TYPE_PROF_BODY(qRead.ORG_TYPE_PROF_BODY);								
				obj.setORG_CODE_PROF_BODY(qRead.ORG_CODE_PROF_BODY);								
				obj.setPROF_BODY(qRead.PROF_BODY);																
				return obj;
			</cfscript>
		</cffunction>
	    
	<cffunction name="getNominalOccupations" output="false" access="public" returntype="query">
			<cfargument name="nominalRef" required="true">
			<cfset var qRead="">
	
			<cfquery name="qRead" datasource="#variables.warehouseDSN#">
				SELECT occ.*
				FROM   browser_owner.NOMINAL_OCCUPATIONS occ
				WHERE  occ.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
				ORDER BY OCCUPATION_DATE DESC
			</cfquery>
	
	        <cfreturn qRead>
	      
		</cffunction>	    
	
	
	</cfcomponent>