<cfcomponent output="false" alias="telephoneUsage">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="TEL_NO" type="string" default="">
	<cfproperty name="SOURCE" type="string" default="">
	<cfproperty name="SOURCE_ID" type="string" default="">
	<cfproperty name="USAGE" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="ADDRESS_REF" type="string" default="">
	<cfproperty name="ORGANISATION" type="string" default="">
	<cfproperty name="OIS_LOG" type="string" default="">
	<cfproperty name="INTEL_LOG" type="string" default="">
	<cfproperty name="CASE_REF" type="string" default="">
	<cfproperty name="CUSTODY_REF" type="string" default="">
	<cfproperty name="OWNER_USER" type="string" default="">
	<cfproperty name="CRIME_REF" type="numeric" default="0">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.TEL_NO = "";
		variables.SOURCE = "";
		variables.SOURCE_ID = "";
		variables.USAGE = "";
		variables.NOMINAL_REF = "";
		variables.ADDRESS_REF = "";
		variables.ORGANISATION = "";
		variables.OIS_LOG = "";
		variables.INTEL_LOG = "";
		variables.CASE_REF = "";
		variables.CUSTODY_REF = "";
		variables.OWNER_USER = "";
		variables.CRIME_REF = 0;
	</cfscript>

	<cffunction name="init" output="false" returntype="telephoneUsage">
		<cfreturn this>
	</cffunction>
	<cffunction name="getTEL_NO" output="false" access="public" returntype="any">
		<cfreturn variables.TEL_NO>
	</cffunction>

	<cffunction name="setTEL_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TEL_NO = arguments.val>
	</cffunction>

	<cffunction name="getSOURCE" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE>
	</cffunction>

	<cffunction name="setSOURCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE = arguments.val>
	</cffunction>

	<cffunction name="getSOURCE_ID" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE_ID>
	</cffunction>

	<cffunction name="setSOURCE_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE_ID = arguments.val>
	</cffunction>

	<cffunction name="getUSAGE" output="false" access="public" returntype="any">
		<cfreturn variables.USAGE>
	</cffunction>

	<cffunction name="setUSAGE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.USAGE = arguments.val>
	</cffunction>

	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS_REF" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS_REF>
	</cffunction>

	<cffunction name="setADDRESS_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS_REF = arguments.val>
	</cffunction>

	<cffunction name="getORGANISATION" output="false" access="public" returntype="any">
		<cfreturn variables.ORGANISATION>
	</cffunction>

	<cffunction name="setORGANISATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORGANISATION = arguments.val>
	</cffunction>

	<cffunction name="getOIS_LOG" output="false" access="public" returntype="any">
		<cfreturn variables.OIS_LOG>
	</cffunction>

	<cffunction name="setOIS_LOG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OIS_LOG = arguments.val>
	</cffunction>

	<cffunction name="getINTEL_LOG" output="false" access="public" returntype="any">
		<cfreturn variables.INTEL_LOG>
	</cffunction>

	<cffunction name="setINTEL_LOG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.INTEL_LOG = arguments.val>
	</cffunction>

	<cffunction name="getCASE_REF" output="false" access="public" returntype="any">
		<cfreturn variables.CASE_REF>
	</cffunction>

	<cffunction name="setCASE_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CASE_REF = arguments.val>
	</cffunction>

	<cffunction name="getCUSTODY_REF" output="false" access="public" returntype="any">
		<cfreturn variables.CUSTODY_REF>
	</cffunction>

	<cffunction name="setCUSTODY_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CUSTODY_REF = arguments.val>
	</cffunction>

	<cffunction name="getOWNER_USER" output="false" access="public" returntype="any">
		<cfreturn variables.OWNER_USER>
	</cffunction>

	<cffunction name="setOWNER_USER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OWNER_USER = arguments.val>
	</cffunction>

	<cffunction name="getCRIME_REF" output="false" access="public" returntype="any">
		<cfreturn variables.CRIME_REF>
	</cffunction>

	<cffunction name="setCRIME_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CRIME_REF = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>



</cfcomponent>