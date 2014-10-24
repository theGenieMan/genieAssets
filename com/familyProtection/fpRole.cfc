<cfcomponent output="false">

	<cfproperty name="CAR_EVENT_ID" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="DATE_STARTED" type="date" default="">
	<cfproperty name="DATE_FINISHED" type="date" default="">
	<cfproperty name="ROLE_REASON" type="string" default="">
	<cfproperty name="CAR_STATUS" type="string" default="">
    <cfproperty name="ROLE_DESC" type="string" default="">
    <cfproperty name="NAME" type="string" default="">    
    
	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.CAR_EVENT_ID = "";		
		variables.NOMINAL_REF = "";
		variables.ROLE_DESC = "";
		variables.DATE_STARTED = "";
		variables.DATE_FINISHED = "";
		variables.ROLE_REASON = "";
		variables.CAR_STATUS = "";		
		variables.NAME = "";		
	</cfscript>    
    
    <cffunction name="init" output="false" returntype="familyProtection">
		<cfreturn this>
	</cffunction>
    
	<cffunction name="getCAR_EVENT_ID" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_EVENT_ID>
	</cffunction>

	<cffunction name="setCAR_EVENT_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CAR_EVENT_ID = arguments.val>
	</cffunction>    
    
	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getROLE_DESC" output="false" access="public" returntype="any">
		<cfreturn variables.ROLE_DESC>
	</cffunction>

	<cffunction name="setROLE_DESC" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ROLE_DESC = arguments.val>
	</cffunction>

	<cffunction name="getDATE_STARTED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_STARTED>
	</cffunction>

	<cffunction name="setDATE_STARTED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_STARTED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDATE_FINISHED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_FINISHED>
	</cffunction>

	<cffunction name="setDATE_FINISHED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_FINISHED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getROLE_REASON" output="false" access="public" returntype="any">
		<cfreturn variables.ROLE_REASON>
	</cffunction>

	<cffunction name="setROLE_REASON" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ROLE_REASON = arguments.val>
	</cffunction>

	<cffunction name="getCAR_STATUS" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_STATUS>
	</cffunction>

	<cffunction name="setCAR_STATUS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CAR_STATUS = arguments.val>
	</cffunction>

	<cffunction name="getNAME" output="false" access="public" returntype="any">
		<cfreturn variables.NAME>
	</cffunction>

	<cffunction name="setNAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NAME = arguments.val>
	</cffunction>
    
</cfcomponent>