<cfcomponent output="false" alias="custodyDepartures">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="CUSTODY_REF" type="string" default="">
	<cfproperty name="DETENTION_NO" type="numeric" default="0">
	<cfproperty name="SERIAL_NO" type="numeric" default="0">
	<cfproperty name="DATE_ARRIVED" type="date" default="">
	<cfproperty name="DATE_RELEASED" type="date" default="">
	<cfproperty name="REASON_FOR_DEPARTURE" type="string" default="">
	<cfproperty name="CRIME_REF" type="numeric" default="0">
	<cfproperty name="SOURCE_ID" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.CUSTODY_REF = "";
		variables.DETENTION_NO = 0;
		variables.SERIAL_NO = 0;
		variables.DATE_ARRIVED = "";
		variables.DATE_RELEASED = "";
		variables.REASON_FOR_DEPARTURE = "";
		variables.CRIME_REF = 0;
		variables.SOURCE_ID = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="custodyDepartures">
		<cfreturn this>
	</cffunction>
	<cffunction name="getCUSTODY_REF" output="false" access="public" returntype="any">
		<cfreturn variables.CUSTODY_REF>
	</cffunction>

	<cffunction name="setCUSTODY_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CUSTODY_REF = arguments.val>
	</cffunction>

	<cffunction name="getDETENTION_NO" output="false" access="public" returntype="any">
		<cfreturn variables.DETENTION_NO>
	</cffunction>

	<cffunction name="setDETENTION_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DETENTION_NO = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSERIAL_NO" output="false" access="public" returntype="any">
		<cfreturn variables.SERIAL_NO>
	</cffunction>

	<cffunction name="setSERIAL_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.SERIAL_NO = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDATE_ARRIVED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_ARRIVED>
	</cffunction>

	<cffunction name="setDATE_ARRIVED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_ARRIVED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDATE_RELEASED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_RELEASED>
	</cffunction>

	<cffunction name="setDATE_RELEASED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_RELEASED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getREASON_FOR_DEPARTURE" output="false" access="public" returntype="any">
		<cfreturn variables.REASON_FOR_DEPARTURE>
	</cffunction>

	<cffunction name="setREASON_FOR_DEPARTURE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REASON_FOR_DEPARTURE = arguments.val>
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

	<cffunction name="getSOURCE_ID" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE_ID>
	</cffunction>

	<cffunction name="setSOURCE_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE_ID = arguments.val>
	</cffunction>



</cfcomponent>