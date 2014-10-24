<cfcomponent output="false" alias="genieObj.organisations.organisation"">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="NOMINAL_ASSIGNMENT_REF" type="numeric" default="0">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="ORG_TYPE" type="string" default="">
	<cfproperty name="ORG_CODE" type="string" default="">
	<cfproperty name="ORG_NAME" type="string" default="">
	<cfproperty name="DESCRIPTION" type="string" default="">
	<cfproperty name="DATE_REC" type="date" default="">
	<cfproperty name="RELATIONSHIP_TO_ORG" type="string" default="">
	<cfproperty name="TELEPHONE_1" type="string" default="">
	<cfproperty name="TELEPHONE_2" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.NOMINAL_ASSIGNMENT_REF = 0;
		variables.NOMINAL_REF = "";
		variables.ORG_TYPE = "";
		variables.ORG_CODE = "";
		variables.ORG_NAME = "";
		variables.DESCRIPTION = "";
		variables.DATE_REC = "";
		variables.RELATIONSHIP_TO_ORG = "";
		variables.TELEPHONE_1 = "";
		variables.TELEPHONE_2 = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="organisations">
		<cfreturn this>
	</cffunction>
	<cffunction name="getNOMINAL_ASSIGNMENT_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_ASSIGNMENT_REF>
	</cffunction>

	<cffunction name="setNOMINAL_ASSIGNMENT_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.NOMINAL_ASSIGNMENT_REF = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getORG_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_TYPE>
	</cffunction>

	<cffunction name="setORG_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORG_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getORG_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_CODE>
	</cffunction>

	<cffunction name="setORG_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORG_CODE = arguments.val>
	</cffunction>

	<cffunction name="getORG_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_NAME>
	</cffunction>

	<cffunction name="setORG_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORG_NAME = arguments.val>
	</cffunction>

	<cffunction name="getDESCRIPTION" output="false" access="public" returntype="any">
		<cfreturn variables.DESCRIPTION>
	</cffunction>

	<cffunction name="setDESCRIPTION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DESCRIPTION = arguments.val>
	</cffunction>

	<cffunction name="getDATE_REC" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_REC>
	</cffunction>

	<cffunction name="setDATE_REC" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_REC = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getRELATIONSHIP_TO_ORG" output="false" access="public" returntype="any">
		<cfreturn variables.RELATIONSHIP_TO_ORG>
	</cffunction>

	<cffunction name="setRELATIONSHIP_TO_ORG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RELATIONSHIP_TO_ORG = arguments.val>
	</cffunction>

	<cffunction name="getTELEPHONE_1" output="false" access="public" returntype="any">
		<cfreturn variables.TELEPHONE_1>
	</cffunction>

	<cffunction name="setTELEPHONE_1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TELEPHONE_1 = arguments.val>
	</cffunction>

	<cffunction name="getTELEPHONE_2" output="false" access="public" returntype="any">
		<cfreturn variables.TELEPHONE_2>
	</cffunction>

	<cffunction name="setTELEPHONE_2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TELEPHONE_2 = arguments.val>
	</cffunction>



</cfcomponent>