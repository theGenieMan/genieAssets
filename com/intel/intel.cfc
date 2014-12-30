<cfcomponent output="false" alias="genieObj.intel.intel">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="LOG_REF" type="string" default="">
	<cfproperty name="SOURCE_LOC" type="string" default="">
	<cfproperty name="SOURCE_DOC_REF" type="string" default="">
	<cfproperty name="SOURCE" type="string" default="">
	<cfproperty name="DATE_START" type="date" default="">
	<cfproperty name="DATE_END" type="date" default="">
	<cfproperty name="DATE_CREATED" type="date" default="">
	<cfproperty name="BADGE_NUMBER" type="date" default="">
	<cfproperty name="DIVISION" type="date" default="">
	<cfproperty name="INDICATOR" type="string" default="">
	<cfproperty name="SECURITY_ACCESS_LEVEL" type="string" default="">    
	<cfproperty name="NAME" type="string" default="">
	<cfproperty name="INFO_CODE" type="string" default="">    
	<cfproperty name="SOURCE_CODE" type="string" default="">
	<cfproperty name="HAND_CODE" type="string" default="">
	<cfproperty name="ORG_CODE_FORCE" type="string" default="">
	<cfproperty name="HAND5_OPT" type="string" default="">
	<cfproperty name="HAND_GUIDANCE" type="string" default="">
	<cfproperty name="INDEXED_NOMINALS" type="array" default="">     

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.LOG_REF = "";
		variables.SOURCE_LOC = "";
		variables.SOURCE_DOC_REF = "";
		variables.SOURCE = "";
		variables.DATE_START = "";
		variables.DATE_END = "";
		variables.DATE_CREATED = "";
		variables.BADGE_NUMBER = "";
		variables.DIVISION = "";
		variables.INDICATOR = "";
		variables.SECURITY_ACCESS_LEVEL = "";
		variables.NAME = "";
		variables.INFO_CODE = "";		
		variables.SOURCE_CODE = "";
		variables.HAND_CODE = "";
		variables.ORG_CODE_FORCE = "";
		variables.HAND5_OPT = "";
		variables.HAND_GUIDANCE = "";
		variables.INDEXED_NOMINALS = "";				
	</cfscript>

	<cffunction name="init" output="false" returntype="intel">
		<cfreturn this>
	</cffunction>
	<cffunction name="getLOG_REF" output="false" access="public" returntype="any">
		<cfreturn variables.LOG_REF>
	</cffunction>

	<cffunction name="setLOG_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LOG_REF = arguments.val>
	</cffunction>

	<cffunction name="getSOURCE_LOC" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE_LOC>
	</cffunction>

	<cffunction name="setSOURCE_LOC" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE_LOC = arguments.val>
	</cffunction>

	<cffunction name="getSOURCE_DOC_REF" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE_DOC_REF>
	</cffunction>

	<cffunction name="setSOURCE_DOC_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE_DOC_REF = arguments.val>
	</cffunction>

	<cffunction name="getSOURCE" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE>
	</cffunction>

	<cffunction name="setSOURCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE = arguments.val>
	</cffunction>

	<cffunction name="getDATE_START" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_START>
	</cffunction>

	<cffunction name="getDATE_START_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_START,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="setDATE_START" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">		
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_START= arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDATE_END" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_END>
	</cffunction>

	<cffunction name="getDATE_END_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_END,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="setDATE_END" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_END = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>
	
	<cffunction name="getDATE_CREATED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_CREATED>
	</cffunction>

	<cffunction name="getDATE_CREATED_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_CREATED,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="setDATE_CREATED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_CREATED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>	

	<cffunction name="getBADGE_NUMBER" output="false" access="public" returntype="any">
		<cfreturn variables.BADGE_NUMBER>
	</cffunction>

	<cffunction name="setBADGE_NUMBER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BADGE_NUMBER = arguments.val>
	</cffunction>

	<cffunction name="getDIVISION" output="false" access="public" returntype="any">
		<cfreturn variables.DIVISION>
	</cffunction>

	<cffunction name="setDIVISION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DIVISION = arguments.val>
	</cffunction>

	<cffunction name="getINDICATOR" output="false" access="public" returntype="any">
		<cfreturn variables.INDICATOR>
	</cffunction>

	<cffunction name="setINDICATOR" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.INDICATOR = arguments.val>
	</cffunction>

	<cffunction name="getSECURITY_ACCESS_LEVEL" output="false" access="public" returntype="any">
		<cfreturn variables.SECURITY_ACCESS_LEVEL>
	</cffunction>

	<cffunction name="setSECURITY_ACCESS_LEVEL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SECURITY_ACCESS_LEVEL = arguments.val>
	</cffunction>

	<cffunction name="getNAME" output="false" access="public" returntype="any">
		<cfreturn variables.NAME>
	</cffunction>

	<cffunction name="setNAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NAME = arguments.val>
	</cffunction>
    
	<cffunction name="getINFO_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.INFO_CODE>
	</cffunction>

	<cffunction name="setINFO_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.INFO_CODE = arguments.val>
	</cffunction>    
    
	<cffunction name="getSOURCE_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE_CODE>
	</cffunction>

	<cffunction name="setSOURCE_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE_CODE = arguments.val>
	</cffunction>  

	<cffunction name="getHAND_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.HAND_CODE>
	</cffunction>

	<cffunction name="setHAND_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.HAND_CODE = arguments.val>
	</cffunction> 

	<cffunction name="getORG_CODE_FORCE" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_CODE_FORCE>
	</cffunction>

	<cffunction name="setORG_CODE_FORCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORG_CODE_FORCE = arguments.val>
	</cffunction> 

	<cffunction name="getHAND5_OPT" output="false" access="public" returntype="any">
		<cfreturn variables.HAND5_OPT>
	</cffunction>

	<cffunction name="setHAND5_OPT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.HAND5_OPT = arguments.val>
	</cffunction> 

	<cffunction name="getHAND_GUIDANCE" output="false" access="public" returntype="any">
		<cfreturn variables.HAND_GUIDANCE>
	</cffunction>

	<cffunction name="setHAND_GUIDANCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.HAND_GUIDANCE = arguments.val>
	</cffunction> 
	
	<cffunction name="getINDEXED_NOMINALS" output="false" access="public" returntype="any">
		<cfreturn variables.INDEXED_NOMINALS>
	</cffunction>

	<cffunction name="setINDEXED_NOMINALS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.INDEXED_NOMINALS = arguments.val>
	</cffunction> 	
	
</cfcomponent>