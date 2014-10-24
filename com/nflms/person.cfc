<cfcomponent output="false" alias="genieObj.nfmls.person">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="PERSON_URN" type="string" default="">
	<cfproperty name="FORENAMES" type="string" default="">
	<cfproperty name="SURNAME" type="string" default="">
	<cfproperty name="ORG_NAME" type="string" default="">
	<cfproperty name="DOB" type="date" default="">
	<cfproperty name="PNCID" type="string" default="">
	<cfproperty name="HEIGHT" type="string" default="">
	<cfproperty name="MOBILE_TEL" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.PERSON_URN = "";
		variables.FORENAMES = "";
		variables.SURNAME = "";
		variables.ORG_NAME = "";
		variables.DOB = "";
		variables.PNCID = "";
		variables.HEIGHT = "";
		variables.MOBILE_TEL = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="genieObj.nflms.person">
		<cfreturn this>
	</cffunction>
	<cffunction name="getPERSON_URN" output="false" access="public" returntype="any">
		<cfreturn variables.PERSON_URN>
	</cffunction>

	<cffunction name="setPERSON_URN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PERSON_URN = arguments.val>
	</cffunction>

	<cffunction name="getFORENAMES" output="false" access="public" returntype="any">
		<cfreturn variables.FORENAMES>
	</cffunction>

	<cffunction name="setFORENAMES" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FORENAMES = arguments.val>
	</cffunction>

	<cffunction name="getSURNAME" output="false" access="public" returntype="any">
		<cfreturn variables.SURNAME>
	</cffunction>

	<cffunction name="setSURNAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SURNAME = arguments.val>
	</cffunction>

	<cffunction name="getORG_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_NAME>
	</cffunction>

	<cffunction name="setORG_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORG_NAME = arguments.val>
	</cffunction>

	<cffunction name="getDOB" output="false" access="public" returntype="any">
		<cfreturn variables.DOB>
	</cffunction>

	<cffunction name="setDOB" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DOB = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getPNCID" output="false" access="public" returntype="any">
		<cfreturn variables.PNCID>
	</cffunction>

	<cffunction name="setPNCID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PNCID = arguments.val>
	</cffunction>

	<cffunction name="getHEIGHT" output="false" access="public" returntype="any">
		<cfreturn variables.HEIGHT>
	</cffunction>

	<cffunction name="setHEIGHT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.HEIGHT = arguments.val>
	</cffunction>

	<cffunction name="getMOBILE_TEL" output="false" access="public" returntype="any">
		<cfreturn variables.MOBILE_TEL>
	</cffunction>

	<cffunction name="setMOBILE_TEL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MOBILE_TEL = arguments.val>
	</cffunction>



</cfcomponent>