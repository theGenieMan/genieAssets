<cfcomponent output="false" alias="alias">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="NOMINAL_REF_1" type="string" default="">
	<cfproperty name="NOMINAL_REF_2" type="string" default="">
	<cfproperty name="REL_TYPE" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.NOMINAL_REF_1 = "";
		variables.NOMINAL_REF_2 = "";
		variables.REL_TYPE = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="alias">
		<cfreturn this>
	</cffunction>
	<cffunction name="getNOMINAL_REF_1" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF_1>
	</cffunction>

	<cffunction name="setNOMINAL_REF_1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF_1 = arguments.val>
	</cffunction>

	<cffunction name="getNOMINAL_REF_2" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF_2>
	</cffunction>

	<cffunction name="setNOMINAL_REF_2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF_2 = arguments.val>
	</cffunction>

	<cffunction name="getREL_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.REL_TYPE>
	</cffunction>

	<cffunction name="setREL_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REL_TYPE = arguments.val>
	</cffunction>



</cfcomponent>