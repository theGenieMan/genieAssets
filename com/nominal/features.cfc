<cfcomponent output="false" alias="features">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="SERIAL_NO" type="numeric" default="0">
	<cfproperty name="FEATURE_NO" type="numeric" default="0">
	<cfproperty name="FEATURE_TYPE" type="string" default="">
	<cfproperty name="FEATURE_SUBTYPE" type="numeric" default="0">
	<cfproperty name="FEATURE" type="string" default="">
	<cfproperty name="DESC1" type="string" default="">
	<cfproperty name="DESC2" type="string" default="">
	<cfproperty name="DESC3" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.NOMINAL_REF = "";
		variables.SERIAL_NO = 0;
		variables.FEATURE_NO = 0;
		variables.FEATURE_TYPE = "";
		variables.FEATURE_SUBTYPE = 0;
		variables.FEATURE = "";
		variables.DESC1 = "";
		variables.DESC2 = "";
		variables.DESC3 = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="features">
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

	<cffunction name="getFEATURE_NO" output="false" access="public" returntype="any">
		<cfreturn variables.FEATURE_NO>
	</cffunction>

	<cffunction name="setFEATURE_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.FEATURE_NO = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getFEATURE_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.FEATURE_TYPE>
	</cffunction>

	<cffunction name="setFEATURE_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FEATURE_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getFEATURE_SUBTYPE" output="false" access="public" returntype="any">
		<cfreturn variables.FEATURE_SUBTYPE>
	</cffunction>

	<cffunction name="setFEATURE_SUBTYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.FEATURE_SUBTYPE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getFEATURE" output="false" access="public" returntype="any">
		<cfreturn variables.FEATURE>
	</cffunction>

	<cffunction name="setFEATURE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FEATURE = arguments.val>
	</cffunction>

	<cffunction name="getDESC1" output="false" access="public" returntype="any">
		<cfreturn variables.DESC1>
	</cffunction>

	<cffunction name="setDESC1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DESC1 = arguments.val>
	</cffunction>

	<cffunction name="getDESC2" output="false" access="public" returntype="any">
		<cfreturn variables.DESC2>
	</cffunction>

	<cffunction name="setDESC2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DESC2 = arguments.val>
	</cffunction>

	<cffunction name="getDESC3" output="false" access="public" returntype="any">
		<cfreturn variables.DESC3>
	</cffunction>

	<cffunction name="setDESC3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DESC3 = arguments.val>
	</cffunction>



</cfcomponent>