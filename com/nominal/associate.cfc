<cfcomponent output="false" alias="associate">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="NOMINAL_REF_SHARE" type="string" default="">
	<cfproperty name="RELATIONSHIP" type="string" default="">
	<cfproperty name="RELT_NOTES" type="NULL" default="">
	<cfproperty name="DATE_RELT_CREATED" type="date" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.NOMINAL_REF = "";
		variables.NOMINAL_REF_SHARE = "";
		variables.RELATIONSHIP = "";
		variables.RELT_NOTES = "";
		variables.DATE_RELT_CREATED = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="associate">
		<cfreturn this>
	</cffunction>
	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getNOMINAL_REF_SHARE" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF_SHARE>
	</cffunction>

	<cffunction name="setNOMINAL_REF_SHARE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF_SHARE = arguments.val>
	</cffunction>

	<cffunction name="getRELATIONSHIP" output="false" access="public" returntype="any">
		<cfreturn variables.RELATIONSHIP>
	</cffunction>

	<cffunction name="setRELATIONSHIP" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RELATIONSHIP = arguments.val>
	</cffunction>

	<cffunction name="getRELT_NOTES" output="false" access="public" returntype="any">
		<cfreturn variables.RELT_NOTES>
	</cffunction>

	<cffunction name="setRELT_NOTES" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RELT_NOTES = arguments.val>
	</cffunction>

	<cffunction name="getDATE_RELT_CREATED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_RELT_CREATED>
	</cffunction>

	<cffunction name="setDATE_RELT_CREATED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_RELT_CREATED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>



</cfcomponent>