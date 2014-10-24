<cfcomponent output="false" alias="genieObj.intel.intelVeh">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="LOG_REF" type="numeric" default="0">
	<cfproperty name="VEH_REF" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.LOG_REF = 0;
		variables.VEH_REF = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="intelVeh">
		<cfreturn this>
	</cffunction>
	<cffunction name="getLOG_REF" output="false" access="public" returntype="any">
		<cfreturn variables.LOG_REF>
	</cffunction>

	<cffunction name="setLOG_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.LOG_REF = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getVEH_REF" output="false" access="public" returntype="any">
		<cfreturn variables.VEH_REF>
	</cffunction>

	<cffunction name="setVEH_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.VEH_REF = arguments.val>
	</cffunction>



</cfcomponent>