<cfcomponent output="false" alias="hearings">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="PD_REF" type="string" default="">
	<cfproperty name="LINE_REF" type="string" default="">
	<cfproperty name="HEARING_REF" type="string" default="">
	<cfproperty name="COURT_NAME" type="string" default="">
	<cfproperty name="HEARING_DATE" type="date" default="">
	<cfproperty name="STATUS" type="string" default="">
	<cfproperty name="CRIME_REF" type="numeric" default="0">
	<cfproperty name="CRIME_NO" type="string" default="">
	<cfproperty name="OFFENCE_TITLE" type="string" default="">    

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.PD_REF = "";
		variables.LINE_REF = "";
		variables.HEARING_REF = "";
		variables.COURT_NAME = "";
		variables.HEARING_DATE = "";
		variables.STATUS = "";
		variables.CRIME_REF = 0;
		variables.CRIME_NO = "";
		variables.OFFENCE_TITLE = "";		
	</cfscript>

	<cffunction name="init" output="false" returntype="hearings">
		<cfreturn this>
	</cffunction>
	<cffunction name="getPD_REF" output="false" access="public" returntype="any">
		<cfreturn variables.PD_REF>
	</cffunction>

	<cffunction name="setPD_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PD_REF = arguments.val>
	</cffunction>

	<cffunction name="getLINE_REF" output="false" access="public" returntype="any">
		<cfreturn variables.LINE_REF>
	</cffunction>

	<cffunction name="setLINE_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LINE_REF = arguments.val>
	</cffunction>

	<cffunction name="getHEARING_REF" output="false" access="public" returntype="any">
		<cfreturn variables.HEARING_REF>
	</cffunction>

	<cffunction name="setHEARING_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.HEARING_REF = arguments.val>
	</cffunction>

	<cffunction name="getCOURT_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.COURT_NAME>
	</cffunction>

	<cffunction name="setCOURT_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.COURT_NAME = arguments.val>
	</cffunction>

	<cffunction name="getHEARING_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.HEARING_DATE>
	</cffunction>

	<cffunction name="setHEARING_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.HEARING_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getSTATUS" output="false" access="public" returntype="any">
		<cfreturn variables.STATUS>
	</cffunction>

	<cffunction name="setSTATUS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.STATUS = arguments.val>
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

	<cffunction name="getCRIME_NO" output="false" access="public" returntype="any">
		<cfreturn variables.CRIME_NO>
	</cffunction>

	<cffunction name="setCRIME_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CRIME_NO = arguments.val>
	</cffunction>

	<cffunction name="getOFFENCE_TITLE" output="false" access="public" returntype="any">
		<cfreturn variables.OFFENCE_TITLE>
	</cffunction>

	<cffunction name="setOFFENCE_TITLE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OFFENCE_TITLE = arguments.val>
	</cffunction>

</cfcomponent>