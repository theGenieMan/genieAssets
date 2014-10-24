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

	<cffunction name="readCustodyDepartures" output="false" access="public" returntype="custodyDepartures[]">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">
        <cfset var departures=ArrayNew(1)>

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	CUSTODY_REF, DETENTION_NO, SERIAL_NO, DATE_ARRIVED, DATE_RELEASED, REASON_FOR_DEPARTURE, 
					CRIME_REF, SOURCE_ID
			from BROWSER_OWNER.CUSTODY_DEPARTURES
			where CUSTODY_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#" />
		</cfquery>

        <cfloop query="qRead">
		 <cfscript>
			obj = createObject("component", "custodyDepartures").init();
			obj.setCUSTODY_REF(qRead.CUSTODY_REF);
			obj.setDETENTION_NO(qRead.DETENTION_NO);
			obj.setSERIAL_NO(qRead.SERIAL_NO);
			obj.setDATE_ARRIVED(qRead.DATE_ARRIVED);
			obj.setDATE_RELEASED(qRead.DATE_RELEASED);
			obj.setREASON_FOR_DEPARTURE(qRead.REASON_FOR_DEPARTURE);
			obj.setCRIME_REF(qRead.CRIME_REF);
			obj.setSOURCE_ID(qRead.SOURCE_ID);
		    ArrayAppend(departures, obj);
		 </cfscript>
        </cfloop>
        
        <cfreturn departures>
        
	</cffunction>



</cfcomponent>