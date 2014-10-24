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

	<cffunction name="read" output="false" access="public" returntype="associate">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="wmercia">
			select 	NOMINAL_REF, NOMINAL_REF_SHARE, RELATIONSHIP, RELT_NOTES, DATE_RELT_CREATED
			from BROWSER_OWNER.NOMINAL_ASSOCIATES
			where NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#" />
		</cfquery>

		<cfscript>
			obj = createObject("component", "associate").init();
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setNOMINAL_REF_SHARE(qRead.NOMINAL_REF_SHARE);
			obj.setRELATIONSHIP(qRead.RELATIONSHIP);
			obj.setRELT_NOTES(qRead.RELT_NOTES);
			obj.setDATE_RELT_CREATED(qRead.DATE_RELT_CREATED);
			return obj;
		</cfscript>
	</cffunction>
	
	<cffunction name="getNominalAssociates" output="false" access="public" returntype="query">
		<cfargument name="nominalRef" required="true">
		<cfargument name="orderBy" required="false" default="surname">        
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
		select na.relationship, na.nominal_ref_share, na.nominal_ref_share AS NOMINAL_REF,
			  REPLACE(REPLACE(LTRIM(
				RTRIM(ND.TITLE)||' '||
        RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
        RTRIM(INITCAP(FORENAME_1))||' '||
        RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')
		    || DECODE(FAMILIAR_NAME,'','', ' (Nick ' || FAMILIAR_NAME || ')')
				|| DECODE(MAIDEN_NAME,NULL,'',' (Nee ' || MAIDEN_NAME || ')') AS Full_Name,
			   relt_notes, date_relt_created, surname_1, surname_2, forename_1, to_char(DATE_OF_BIRTH,'DD/MM/YYYY') AS DOB,
			   nd.DECEASED, to_char(DATE_OF_DEATH,'DD/MM/YYYY') AS DATE_OF_DEATH, DOD_ESTIMATE_FLAG
		from browser_owner.nominal_associates na, browser_owner.nominal_search ns, browser_owner.nominal_details nd
		where na.NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nominalRef#" />
		and na.nominal_ref_share = ns.nominal_ref
        and ns.nominal_ref=nd.nominal_ref
        <cfif arguments.orderBy is "date_created">
		order by date_relt_created desc
        <cfelseif arguments.orderBy IS "surname">
        order by SURNAME_1,FORENAME_1
        <cfelseif arguments.orderBy IS "type">
        order by RELATIONSHIP
        </cfif>
		</cfquery>      

        <cfreturn qRead>
      
	</cffunction>	

</cfcomponent>