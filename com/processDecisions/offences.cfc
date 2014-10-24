<cfcomponent output="false" alias="offences">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="PD_REF" type="string" default="">
	<cfproperty name="LINE_REF" type="string" default="">
	<cfproperty name="CRIME_REF" type="numeric" default="0">
	<cfproperty name="CRIME_NO" type="string" default="">
	<cfproperty name="OFFENCE_TITLE" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.PD_REF = "";
		variables.LINE_REF = "";
		variables.CRIME_REF = 0;
		variables.CRIME_NO = "";
		variables.OFFENCE_TITLE = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="offences">
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