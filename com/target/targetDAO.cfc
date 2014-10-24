<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="genieImageDir" required="true" type="String">        
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
        <cfset variables.genieImageDir=arguments.genieImageDir>              
           
        <cfreturn this />  
    </cffunction>   

	<cffunction name="read" output="false" access="public" returntype="genieObj.target.target">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.WarehouseDSN#">
			select TARGET_REF, NOMINAL_REF, TARGET_INTEREST_TYPE, START_DATE, END_DATE, REASON		
			from BROWSER_OWNER.TARGET_MARKERS
			where TARGET_REF = <cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#obj.getTARGET_REF()#" />
		</cfquery>

		<cfscript>
			obj.setTARGET_REF(qRead.TARGET_REF);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setTARGET_INTEREST_TYPE(qRead.TARGET_INTEREST_TYPE);
			obj.setSTART_DATE(qRead.START_DATE);
			obj.setEND_DATE(qRead.END_DATE);
			obj.setREASON(qRead.REASON);
			return obj;
		</cfscript>
	</cffunction>
    
	<cffunction name="readCurrentTarget" output="false" access="public" returntype="genieObj.target.target">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.WarehouseDsn#">
			select TARGET_REF, NOMINAL_REF, TARGET_INTEREST_TYPE, START_DATE, END_DATE, REASON		
			from BROWSER_OWNER.TARGET_MARKERS
			where NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getNOMINAL_REF()#" />
			AND    TARGET_INTEREST_TYPE <> 1
			AND    end_date >= sysdate            
		</cfquery>

		<cfscript>
			obj.setTARGET_REF(qRead.TARGET_REF);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setTARGET_INTEREST_TYPE(qRead.TARGET_INTEREST_TYPE);
			obj.setSTART_DATE(qRead.START_DATE);
			obj.setEND_DATE(qRead.END_DATE);
			obj.setREASON(qRead.REASON);
			return obj;
		</cfscript>
	</cffunction>    












</cfcomponent>