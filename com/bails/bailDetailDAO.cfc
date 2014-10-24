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
    
	<cffunction name="read" output="false" access="public" returntype="bailDetail">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	BAIL_REF, SEQ_NO, OFFENCE_DETAIL
			from BROWSER_OWNER.BAIL_DETAILS
			where BAIL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#" />
		</cfquery>

		<cfscript>
			obj.setBAIL_REF(qRead.BAIL_REF);
			obj.setSEQ_NO(qRead.SEQ_NO);
			obj.setOFFENCE_DETAIL(qRead.OFFENCE_DETAIL);
			return obj;
		</cfscript>
	</cffunction>
    
	<cffunction name="readBailDetails" output="false" access="public" returntype="bailDetail[]">
		<cfargument name="bailRef" required="true">
		<cfset var bailDetails=ArrayNew(1)>
        <cfset var thisBailDetail="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	BAIL_REF, SEQ_NO, OFFENCE_DETAIL
			from BROWSER_OWNER.BAIL_DETAILS
			where BAIL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bailRef#" />
            order by seq_no
		</cfquery>

	    <cfloop query="qRead">
           <cfset thisBailDetail=CreateObject("component","genieObj.bails.bailDetail")>
           <cfset thisBailDetail.setBAIL_REF(BAIL_REF)>
           <cfset thisBailDetail.setSEQ_NO(SEQ_NO)>
           <cfset thisBailDetail.setOFFENCE_DETAIL(OFFENCE_DETAIL)>
           <cfset ArrayAppend(bailDetails,thisBailDetail)>                      
        </cfloop>
        
        <cfreturn bailDetails>
	</cffunction>    

</cfcomponent>