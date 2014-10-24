<cfcomponent output="false" alias="misper">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="CASE_NO" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="MISSING_START" type="date" default="">
	<cfproperty name="MISSING_END" type="date" default="">
	<cfproperty name="MISSING_PERIOD" type="string" default="">
	<cfproperty name="RISK_LEVEL" type="string" default="">
	<cfproperty name="OIC_DEALING" type="string" default="">
	<cfproperty name="ADDRESS_FOUND" type="string" default="">    
	<cfproperty name="DATE_FOUND" type="string" default="">        

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.CASE_NO = "";
		variables.NOMINAL_REF = "";
		variables.MISSING_START = "";
		variables.MISSING_END = "";
		variables.MISSING_PERIOD = "";
		variables.RISK_LEVEL = "";
		variables.OIC_DEALING = "";
		variables.ADDRESS_FOUND = "";
		variables.DATE_FOUND = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="misper">
		<cfreturn this>
	</cffunction>
	<cffunction name="getCASE_NO" output="false" access="public" returntype="any">
		<cfreturn variables.CASE_NO>
	</cffunction>

	<cffunction name="setCASE_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CASE_NO = arguments.val>
	</cffunction>

	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getMISSING_START" output="false" access="public" returntype="any">
		<cfreturn variables.MISSING_START>
	</cffunction>

	<cffunction name="setMISSING_START" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.MISSING_START = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getMISSING_END" output="false" access="public" returntype="any">
		<cfreturn variables.MISSING_END>
	</cffunction>

	<cffunction name="setMISSING_END" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.MISSING_END = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getMISSING_PERIOD" output="false" access="public" returntype="any">
		<cfreturn variables.MISSING_PERIOD>
	</cffunction>

	<cffunction name="setMISSING_PERIOD" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MISSING_PERIOD = arguments.val>
	</cffunction>

	<cffunction name="getRISK_LEVEL" output="false" access="public" returntype="any">
		<cfreturn variables.RISK_LEVEL>
	</cffunction>

	<cffunction name="setRISK_LEVEL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RISK_LEVEL = arguments.val>
	</cffunction>

	<cffunction name="getOIC_DEALING" output="false" access="public" returntype="any">
		<cfreturn variables.OIC_DEALING>
	</cffunction>

	<cffunction name="setOIC_DEALING" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OIC_DEALING = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS_FOUND" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS_FOUND>
	</cffunction>

	<cffunction name="setADDRESS_FOUND" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS_FOUND = arguments.val>
	</cffunction>

	<cffunction name="getDATE_FOUND" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_FOUND>
	</cffunction>

	<cffunction name="setDATE_FOUND" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DATE_FOUND = arguments.val>
	</cffunction>

</cfcomponent>