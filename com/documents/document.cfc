<cfcomponent output="false" alias="document">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="SERIAL_NO" type="numeric" default="0">
	<cfproperty name="DOC_NUMBER" type="string" default="">
	<cfproperty name="DOC_TYPE" type="string" default="">
	<cfproperty name="DATE_ISSUE" type="date" default="">
	<cfproperty name="DATE_EXPIRY" type="date" default="">
	<cfproperty name="DOC_NAME" type="string" default="">
	<cfproperty name="ISSUE_PLACE" type="string" default="">
	<cfproperty name="OTHER_DETAILS" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.NOMINAL_REF = "";
		variables.SERIAL_NO = 0;
		variables.DOC_NUMBER = "";
		variables.DOC_TYPE = "";
		variables.DATE_ISSUE = "";
		variables.DATE_EXPIRY = "";
		variables.DOC_NAME = "";
		variables.ISSUE_PLACE = "";
		variables.OTHER_DETAILS = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="document">
		<cfreturn this>
	</cffunction>
	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
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

	<cffunction name="getDOC_NUMBER" output="false" access="public" returntype="any">
		<cfreturn variables.DOC_NUMBER>
	</cffunction>

	<cffunction name="setDOC_NUMBER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DOC_NUMBER = arguments.val>
	</cffunction>

	<cffunction name="getDOC_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.DOC_TYPE>
	</cffunction>

	<cffunction name="setDOC_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DOC_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getDATE_ISSUE" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_ISSUE>
	</cffunction>

	<cffunction name="setDATE_ISSUE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_ISSUE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDATE_EXPIRY" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_EXPIRY>
	</cffunction>

	<cffunction name="setDATE_EXPIRY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_EXPIRY = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDOC_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.DOC_NAME>
	</cffunction>

	<cffunction name="setDOC_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DOC_NAME = arguments.val>
	</cffunction>

	<cffunction name="getISSUE_PLACE" output="false" access="public" returntype="any">
		<cfreturn variables.ISSUE_PLACE>
	</cffunction>

	<cffunction name="setISSUE_PLACE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ISSUE_PLACE = arguments.val>
	</cffunction>

	<cffunction name="getOTHER_DETAILS" output="false" access="public" returntype="any">
		<cfreturn variables.OTHER_DETAILS>
	</cffunction>

	<cffunction name="setOTHER_DETAILS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OTHER_DETAILS = arguments.val>
	</cffunction>



</cfcomponent>