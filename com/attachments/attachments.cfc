<cfcomponent output="false" alias="genieObj.attachments.attachments">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="SOURCE_SYSTEM" type="string" default="">
	<cfproperty name="SOURCE_REF" type="string" default="">
	<cfproperty name="DOCUMENT_NO" type="numeric" default="0">
	<cfproperty name="DOC_TYPE" type="string" default="">
	<cfproperty name="FILE_NAME" type="string" default="">
	<cfproperty name="ORIGINATOR" type="string" default="">
	<cfproperty name="DATE_CREATED" type="date" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.SOURCE_SYSTEM = "";
		variables.SOURCE_REF = "";
		variables.DOCUMENT_NO = 0;
		variables.DOC_TYPE = "";
		variables.FILE_NAME = "";
		variables.ORIGINATOR = "";
		variables.DATE_CREATED = "";		
	</cfscript>
	
	<cffunction name="init" output="false" returntype="genieObj.attachments.attachments">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getSOURCE_SYSTEM" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE_SYSTEM>
	</cffunction>

	<cffunction name="setSOURCE_SYSTEM" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE_SYSTEM = arguments.val>
	</cffunction>

	<cffunction name="getSOURCE_REF" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE_REF>
	</cffunction>

	<cffunction name="setSOURCE_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE_REF = arguments.val>
	</cffunction>

	<cffunction name="getDOCUMENT_NO" output="false" access="public" returntype="any">
		<cfreturn variables.DOCUMENT_NO>
	</cffunction>

	<cffunction name="setDOCUMENT_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DOCUMENT_NO = arguments.val>
	</cffunction>

	<cffunction name="getDOC_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.DOC_TYPE>
	</cffunction>

	<cffunction name="setDOC_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DOC_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getFILE_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.FILE_NAME>
	</cffunction>

	<cffunction name="setFILE_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FILE_NAME = arguments.val>
	</cffunction>

	<cffunction name="getORIGINATOR" output="false" access="public" returntype="any">
		<cfreturn variables.ORIGINATOR>
	</cffunction>

	<cffunction name="setORIGINATOR" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORIGINATOR = arguments.val>
	</cffunction>

	<cffunction name="getDATE_CREATED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_CREATED>
	</cffunction>

	<cffunction name="getDATE_CREATED_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_CREATED,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="setDATE_CREATED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DATE_CREATED = arguments.val>
	</cffunction>

</cfcomponent>