<cfcomponent output="false" alias="genieObj.vehicles.vehicleUsages">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="VEH_REF" type="string" default="">
	<cfproperty name="USAGE" type="string" default="">
	<cfproperty name="CASE_URN" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="ORG_CODE" type="string" default="">
	<cfproperty name="START_DATE" type="date" default="">
	<cfproperty name="END_DATE" type="date" default="">
	<cfproperty name="REASON" type="string" default="">
	<cfproperty name="CRIME_REF" type="numeric" default="0">
	<cfproperty name="LOG_REF" type="numeric" default="0">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.VEH_REF = "";
		variables.USAGE = "";
		variables.CASE_URN = "";
		variables.NOMINAL_REF = "";
		variables.ORG_CODE = "";
		variables.START_DATE = "";
		variables.END_DATE = "";
		variables.REASON = "";
		variables.CRIME_REF = 0;
		variables.LOG_REF = 0;
	</cfscript>

	<cffunction name="init" output="false" returntype="VEHICLEUSAGES">
		<cfreturn this>
	</cffunction>
	<cffunction name="getVEH_REF" output="false" access="public" returntype="any">
		<cfreturn variables.VEH_REF>
	</cffunction>

	<cffunction name="setVEH_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.VEH_REF = arguments.val>
	</cffunction>

	<cffunction name="getUSAGE" output="false" access="public" returntype="any">
		<cfreturn variables.USAGE>
	</cffunction>

	<cffunction name="setUSAGE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.USAGE = arguments.val>
	</cffunction>

	<cffunction name="getCASE_URN" output="false" access="public" returntype="any">
		<cfreturn variables.CASE_URN>
	</cffunction>

	<cffunction name="setCASE_URN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CASE_URN = arguments.val>
	</cffunction>

	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getORG_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_CODE>
	</cffunction>

	<cffunction name="setORG_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORG_CODE = arguments.val>
	</cffunction>

	<cffunction name="getSTART_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.START_DATE>
	</cffunction>

	<cffunction name="setSTART_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.START_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getEND_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.END_DATE>
	</cffunction>

	<cffunction name="setEND_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.END_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getREASON" output="false" access="public" returntype="any">
		<cfreturn variables.REASON>
	</cffunction>

	<cffunction name="setREASON" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REASON = arguments.val>
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

	<cffunction name="getLOG_REF" output="false" access="public" returntype="any">
		<cfreturn variables.LOG_REF>
	</cffunction>

	<cffunction name="setLOG_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.LOG_REF = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>



</cfcomponent>