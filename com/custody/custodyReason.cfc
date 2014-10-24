<cfcomponent output="false" alias="genieObj.custody.custodyReason">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="CUSTODY_REF" type="string" default="">
	<cfproperty name="SEQ_NO" type="numeric" default="0">
	<cfproperty name="ARREST_REASON_TEXT" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.CUSTODY_REF = "";
		variables.SEQ_NO = 0;
		variables.ARREST_REASON_TEXT = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="genieObj.custody.custodyReason">
		<cfreturn this>
	</cffunction>
	<cffunction name="getCUSTODY_REF" output="false" access="public" returntype="any">
		<cfreturn variables.CUSTODY_REF>
	</cffunction>

	<cffunction name="setCUSTODY_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CUSTODY_REF = arguments.val>
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

	<cffunction name="getARREST_REASON_TEXT" output="false" access="public" returntype="any">
		<cfreturn variables.ARREST_REASON_TEXT>
	</cffunction>

	<cffunction name="setARREST_REASON_TEXT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ARREST_REASON_TEXT = arguments.val>
	</cffunction>



</cfcomponent>