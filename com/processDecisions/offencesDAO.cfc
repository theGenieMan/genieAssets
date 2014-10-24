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

	<cffunction name="readPdOffences" output="false" access="public" returntype="offences[]">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">
        <cfset var offences=ArrayNew(1)>

		<cfquery name="qRead" datasource="#variables.warehousedsn#">
			select 	PD_REF, LINE_REF, CRIME_REF, CRIME_NO, OFFENCE_TITLE
			from BROWSER_OWNER.PD_OFFENCES
			where PD_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#" />
		</cfquery>
        
        <cfloop query="qRead">
		<cfscript>
			obj = createObject("component", "offences").init();
			obj.setPD_REF(qRead.PD_REF);
			obj.setLINE_REF(qRead.LINE_REF);
			obj.setCRIME_REF(qRead.CRIME_REF);
			obj.setCRIME_NO(qRead.CRIME_NO);
			obj.setOFFENCE_TITLE(qRead.OFFENCE_TITLE);
			ArrayAppend(offences,obj);
		</cfscript>
        </cfloop>
        
        <cfreturn offences>
        
	</cffunction>

</cfcomponent>