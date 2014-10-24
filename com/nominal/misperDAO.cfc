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

	<cffunction name="read" output="false" access="public" returntype="misper">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
				select 	CASE_NO, NOMINAL_REF, MISSING_START, MISSING_END, MISSING_PERIOD, RISK_LEVEL, 
						OIC_DEALING, ADDRESS_FOUND, DATE_FOUND
				from BROWSER_OWNER.COMP_CASES
				where CASE_NO = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#" />
			</cfquery>
	
			<cfscript>
				obj = createObject("component", "misper").init();
				obj.setCASE_NO(qRead.CASE_NO);
				obj.setNOMINAL_REF(qRead.NOMINAL_REF);
				obj.setMISSING_START(qRead.MISSING_START);
				obj.setMISSING_END(qRead.MISSING_END);
				obj.setMISSING_PERIOD(qRead.MISSING_PERIOD);
				obj.setRISK_LEVEL(qRead.RISK_LEVEL);
				obj.setOIC_DEALING(qRead.OIC_DEALING);
				obj.setADDRESS_FOUND(qRead.ADDRESS_FOUND);
				obj.setDATE_FOUND(qRead.DATE_FOUND);								
				return obj;
			</cfscript>
		</cffunction>
	    
	<cffunction name="getNominalMisper" output="false" access="public" returntype="query">
		<cfargument name="nominalRef" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			SELECT cc.*, DECODE(RISK_LEVEL,'H','HIGH','M','MEDIUM','L','LOW') AS RISK_DESC
			FROM   browser_owner.COMP_CASES cc
			WHERE  cc.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			ORDER BY MISSING_START DESC
		</cfquery>

        <cfreturn qRead>
      
	</cffunction>	
	
	<cffunction name="getMisperByDiv" output="false" access="public" returntype="query">
		<cfargument name="divCode" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			SELECT   ns.NOMINAL_REF, cc.*, DECODE(RISK_LEVEL,'H','HIGH','M','MEDIUM','L','LOW') AS RISK_DESC
			FROM     browser_owner.NOMINAL_SEARCH ns, browser_owner.COMP_CASES cc
			WHERE    ns.COMP_STATUS IN ('M')
			AND      ns.NOMINAL_REF=cc.NOMINAL_REF
			and      cc.DATE_FOUND IS NULL
			<cfif arguments.divCode is not "H">
			and      substr(CC.CASE_NO,3,1)=<cfqueryparam value="#arguments.divCode#" cfsqltype="cf_sql_varchar">
			</cfif>
			ORDER BY cc.MISSING_START DESC
		</cfquery>

        <cfreturn qRead>
      
	</cffunction>		    
	
	<cffunction name="getMisperCount" output="false" access="public" returntype="string">
		<cfargument name="divCode" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			SELECT   COUNT(*) AS NO_MISPER
			FROM     browser_owner.NOMINAL_SEARCH ns, browser_owner.COMP_CASES cc
			WHERE    ns.COMP_STATUS IN ('M')
			AND      ns.NOMINAL_REF=cc.NOMINAL_REF
			and      cc.DATE_FOUND IS NULL
			<cfif arguments.divCode is NOT "H">
			and      substr(CC.CASE_NO,3,1)=<cfqueryparam value="#arguments.divCode#" cfsqltype="cf_sql_varchar">
			</cfif>
			ORDER BY cc.MISSING_START DESC
		</cfquery>

        <cfreturn qRead.NO_MISPER>
      
	</cffunction>	
	
	<cffunction name="getMisperAge" output="false" access="public" returntype="numeric">
		<cfargument name="divCode" required="true">
		<cfargument name="returnType" required="true">
		
		 <cfset var qRead="">
		 <cfset var datePart="">
		 <cfset var theDiff="9999999999">
		  
		 <cfswitch expression="#arguments.returnType#">
		 	 <cfcase value="hours">
			  	  <cfset datePart="h">
			 </cfcase>
			 <cfcase value="minutes">
			  	  <cfset datePart="n">
			 </cfcase> 	   
			 <cfcase value="days">
			  	  <cfset datePart="d">
			 </cfcase> 	   
			 <cfcase value="weeks">
			  	  <cfset datePart="ww">
			 </cfcase> 	   
			 <cfcase value="months">
			  	  <cfset datePart="m">
			 </cfcase> 	   
			 <cfcase value="years">
			  	  <cfset datePart="yyyy">
			 </cfcase> 	   			  	  
		 </cfswitch>

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			SELECT   MAX(MISSING_START) AS MISSING_START
			FROM     browser_owner.NOMINAL_SEARCH ns, browser_owner.COMP_CASES cc
			WHERE    ns.COMP_STATUS IN ('M')
			AND      ns.NOMINAL_REF=cc.NOMINAL_REF
			and      cc.DATE_FOUND IS NULL
			<cfif arguments.divCode is NOT "H">
			and      substr(CC.CASE_NO,3,1)=<cfqueryparam value="#arguments.divCode#" cfsqltype="cf_sql_varchar">
			</cfif>
			ORDER BY cc.MISSING_START DESC
		</cfquery>
 
        <cfif qRead.recordCount GT 0>
		  <cfif isDate(qRead.MISSING_START)>
			<cfset theDiff=DateDiff(datePart,qRead.MISSING_START,now())>
		  </cfif>
		</cfif>

        <cfreturn theDiff>
      
	</cffunction>	
	
	</cfcomponent>