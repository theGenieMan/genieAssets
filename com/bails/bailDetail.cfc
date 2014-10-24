<cfcomponent output="false" alias="bailDetail">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="BAIL_REF" type="string" default="">
	<cfproperty name="SEQ_NO" type="numeric" default="0">
	<cfproperty name="OFFENCE_DETAIL" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.BAIL_REF = "";
		variables.SEQ_NO = 0;
		variables.OFFENCE_DETAIL = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="bailDetail">
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

	<cffunction name="getOFFENCE_DETAIL" output="false" access="public" returntype="any">
		<cfreturn variables.OFFENCE_DETAIL>
	</cffunction>

	<cffunction name="setOFFENCE_DETAIL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OFFENCE_DETAIL = arguments.val>
	</cffunction>



</cfcomponent>