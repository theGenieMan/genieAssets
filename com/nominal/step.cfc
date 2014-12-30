<cfcomponent output="false" alias="step">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
    <cfproperty name="STEP_URN" type="string" default="">
	<cfproperty name="PACKAGE_ID" type="string" default="">	
	<cfproperty name="RETURN_DATE" type="string" default="">
	<cfproperty name="RECEIVED_DATE" type="string" default="">
	<cfproperty name="CATEGORY_DESCRIPTION" type="string" default="">
	<cfproperty name="COMPLETED" type="string" default="">
	<cfproperty name="SECTION_NAME" type="string" default="">
	<cfproperty name="PROBLEM_OUTLINE" type="string" default="">
	<cfproperty name="NOTES" type="string" default="">
	
	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.STEP_URN = "";
		variables.PACKAGE_ID = "";
		variables.RETURN_DATE = "";
		variables.RECEIVED_DATE = "";
		variables.CATEGORY_DESCRIPTION = "";
		variables.COMPLETED = "";
		variables.SECTION_NAME = "";
		variables.PROBLEM_OUTLINE = "";
		variables.NOTES = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="rmp">
		<cfreturn this>
	</cffunction>

	<cffunction name="getSTEP_URN" output="false" access="public" returntype="any">
		<cfreturn variables.STEP_URN>
	</cffunction>

	<cffunction name="setSTEP_URN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.STEP_URN = arguments.val>
	</cffunction>

	<cffunction name="getPACKAGE_ID" output="false" access="public" returntype="any">
		<cfreturn variables.PACKAGE_ID>
	</cffunction>

	<cffunction name="setPACKAGE_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PACKAGE_ID = arguments.val>
	</cffunction>

	<cffunction name="getRETURN_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.RETURN_DATE>
	</cffunction>

	<cffunction name="setRETURN_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RETURN_DATE = arguments.val>
	</cffunction>
	
	<cffunction name="getRETURN_DATE_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.RETURN_DATE,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="getRECEIVED_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.RECEIVED_DATE>
	</cffunction>

	<cffunction name="setRECEIVED_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RECEIVED_DATE = arguments.val>
	</cffunction>
	
	<cffunction name="getRECEIVED_DATE_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.RECEIVED_DATE,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="getCATEGORY_DESCRIPTION" output="false" access="public" returntype="any">
		<cfreturn variables.CATEGORY_DESCRIPTION>
	</cffunction>

	<cffunction name="setCATEGORY_DESCRIPTION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CATEGORY_DESCRIPTION = arguments.val>
	</cffunction>
	
	<cffunction name="getCOMPLETED" output="false" access="public" returntype="any">
		<cfreturn variables.COMPLETED>
	</cffunction>

	<cffunction name="setCOMPLETED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.COMPLETED = arguments.val>
	</cffunction>	

	<cffunction name="getSECTION_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.SECTION_NAME>
	</cffunction>

	<cffunction name="setSECTION_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SECTION_NAME = arguments.val>
	</cffunction>	
	
	<cffunction name="getPROBLEM_OUTLINE" output="false" access="public" returntype="any">
		<cfreturn variables.PROBLEM_OUTLINE>
	</cffunction>

	<cffunction name="setPROBLEM_OUTLINE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PROBLEM_OUTLINE = arguments.val>
	</cffunction>	

	<cffunction name="getNOTES" output="false" access="public" returntype="any">
		<cfreturn variables.NOTES>
	</cffunction>

	<cffunction name="setNOTES" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOTES = arguments.val>
	</cffunction>	

</cfcomponent>