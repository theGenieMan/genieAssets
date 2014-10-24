<cfcomponent output="false" alias="bailCondition">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="BAIL_REF" type="string" default="">
	<cfproperty name="SEQ_NO" type="numeric" default="0">
	<cfproperty name="CONDITION" type="string" default="">
	<cfproperty name="REASON" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.BAIL_REF = "";
		variables.SEQ_NO = 0;
		variables.CONDITION = "";
		variables.REASON = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="bailCondition">
		<cfreturn this>
	</cffunction>
	<cffunction name="getBAIL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.BAIL_REF>
	</cffunction>

	<cffunction name="setBAIL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BAIL_REF = arguments.val>
	</cffunction>

	<cffunction name="getSEQ_NO" output="false" access="public" returntype="any">
		<cfreturn variables.SEQ_NO>
	</cffunction>

	<cffunction name="setSEQ_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.SEQ_NO = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCONDITION" output="false" access="public" returntype="any">
		<cfreturn variables.CONDITION>
	</cffunction>

	<cffunction name="setCONDITION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CONDITION = arguments.val>
	</cffunction>

	<cffunction name="getREASON" output="false" access="public" returntype="any">
		<cfreturn variables.REASON>
	</cffunction>

	<cffunction name="setREASON" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REASON = arguments.val>
	</cffunction>



</cfcomponent>