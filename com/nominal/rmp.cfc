<cfcomponent output="false" alias="rmp">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
    <cfproperty name="RMP_URN" type="string" default="">
	<cfproperty name="RMP_TYPE" type="string" default="">	
	<cfproperty name="DATE_GENERATED" type="string" default="">
	<cfproperty name="DATE_DUE" type="string" default="">
	<cfproperty name="DATE_RECEIVED" type="string" default="">
	<cfproperty name="COMPLETED" type="string" default="">
	<cfproperty name="LPA" type="string" default="">
	
	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.RMP_URN = "";
		variables.RMP_TYPE = "";
		variables.DATE_GENERATED = "";
		variables.DATE_DUE = "";
		variables.DATE_RECEIVED = "";
		variables.COMPLETED = "";
		variables.LPA = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="rmp">
		<cfreturn this>
	</cffunction>

	<cffunction name="getRMP_URN" output="false" access="public" returntype="any">
		<cfreturn variables.RMP_URN>
	</cffunction>

	<cffunction name="setRMP_URN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RMP_URN = arguments.val>
	</cffunction>

	<cffunction name="getRMP_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.RMP_TYPE>
	</cffunction>

	<cffunction name="setRMP_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RMP_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getDATE_GENERATED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_GENERATED>
	</cffunction>

	<cffunction name="setDATE_GENERATED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DATE_GENERATED = arguments.val>
	</cffunction>
	
	<cffunction name="getDATE_GENERATED_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_GENERATED,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="getDATE_DUE" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_DUE>
	</cffunction>

	<cffunction name="setDATE_DUE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DATE_DUE = arguments.val>
	</cffunction>
	
	<cffunction name="getDATE_DUE_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_DUE,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="getDATE_RECEIVED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_RECEIVED>
	</cffunction>

	<cffunction name="setDATE_RECEIVED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DATE_RECEIVED = arguments.val>
	</cffunction>
	
	<cffunction name="getDATE_RECEIVED_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_RECEIVED,"DD/MM/YYYY")>
	</cffunction>
	
	<cffunction name="getCOMPLETED" output="false" access="public" returntype="any">
		<cfreturn variables.COMPLETED>
	</cffunction>

	<cffunction name="setCOMPLETED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.COMPLETED = arguments.val>
	</cffunction>	

	<cffunction name="getLPA" output="false" access="public" returntype="any">
		<cfreturn variables.LPA>
	</cffunction>

	<cffunction name="setLPA" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LPA = arguments.val>
	</cffunction>	
	



</cfcomponent>