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

	<cffunction name="read" output="false" access="public" returntype="alias">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="wmercia">
			select 	NOMINAL_REF_1, NOMINAL_REF_2, REL_TYPE
			from BROWSER_OWNER.NOMINAL_LINKS
			where NOMINAL_REF_1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#" />
		</cfquery>

		<cfscript>
			obj = createObject("component", "alias").init();
			obj.setNOMINAL_REF_1(qRead.NOMINAL_REF_1);
			obj.setNOMINAL_REF_2(qRead.NOMINAL_REF_2);
			obj.setREL_TYPE(qRead.REL_TYPE);
			return obj;
		</cfscript>
	</cffunction>

	<cffunction name="getNominalAliases" output="false" access="public" returntype="query">
		<cfargument name="nominalRef" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" DATASOURCE="#variables.WarehouseDSN#">	
		SELECT REPLACE(REPLACE(LTRIM(
			  		                 RTRIM(ND.TITLE)||' '||
							         RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
							         RTRIM(INITCAP(FORENAME_1))||' '||
								     RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')
										    || DECODE(FAMILIAR_NAME,'','', ' (Nick ' || FAMILIAR_NAME || ')')
											|| DECODE(MAIDEN_NAME,NULL,'',' (Nee ' || MAIDEN_NAME || ')') Name,
			   ns.NOMINAL_REF,TO_CHAR(DATE_OF_BIRTH,'DD/MM/YYYY') AS DOB, REL_TYPE
		FROM   browser_owner.NOMINAL_SEARCH ns, browser_owner.NOMINAL_LINKS nl, browser_owner.NOMINAL_DETAILS nd
		WHERE  ns.NOMINAL_REF=nl.NOMINAL_REF_2
		and    ns.NOMINAL_REF=nd.NOMINAL_REF(+)
		AND    nl.REL_TYPE IN ('ALIA','ALDB','CHRI','FORM','WEDD')
		AND    nl.NOMINAL_REF_1=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		</cfquery>
        
        <cfreturn qRead>
	</cffunction>

</cfcomponent>