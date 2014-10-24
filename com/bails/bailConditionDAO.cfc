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

	<cffunction name="read" output="false" access="public" returntype="bailCondition">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	BAIL_REF, SEQ_NO, CONDITION, REASON
			from BROWSER_OWNER.BAIL_CONDITIONS
			where BAIL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getBAIL_REF()#" />
		</cfquery>

		<cfscript>
			obj.setBAIL_REF(qRead.BAIL_REF);
			obj.setSEQ_NO(qRead.SEQ_NO);
			obj.setCONDITION(qRead.CONDITION);
			obj.setREASON(qRead.REASON);
			return obj;
		</cfscript>
	</cffunction>
	
	<cffunction name="readBailConditions" output="false" access="public" returntype="bailCondition[]">
		<cfargument name="bailRef" required="true">
		<cfset var bailConds=ArrayNew(1)>
        <cfset var thisBailCond="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
            select 	BAIL_REF, SEQ_NO, CONDITION, REASON
			from BROWSER_OWNER.BAIL_CONDITIONS
			where BAIL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bailRef#" />
            order by seq_no
		</cfquery>

	    <cfloop query="qRead">
           <cfset thisBailCond=CreateObject("component","genieObj.bails.bailCondition")>
           <cfset thisBailCond.setBAIL_REF(BAIL_REF)>
           <cfset thisBailCond.setSEQ_NO(SEQ_NO)>
           <cfset thisBailCond.setCONDITION(CONDITION)>
           <cfset thisBailCond.setREASON(REASON)>           
           <cfset ArrayAppend(bailConds,thisBailCond)>                      
        </cfloop>
        
        <cfreturn bailConds>
	</cffunction>    	

</cfcomponent>