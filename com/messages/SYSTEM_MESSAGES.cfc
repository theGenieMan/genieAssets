<cfcomponent output="false" alias="SYSTEM_MESSAGES">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="MESSAGE_ID" type="numeric" default="0">
	<cfproperty name="MESSAGE_TITLE" type="string" default="">
	<cfproperty name="MESSAGE" type="string" default="">
	<cfproperty name="STARTDATE" type="date" default="">
	<cfproperty name="ENDDATE" type="date" default="">
	<cfproperty name="ADDEDDATE" type="date" default="">
	<cfproperty name="ADDEDBYUID" type="string" default="">
	<cfproperty name="ADDEDBYNAME" type="string" default="">
	<cfproperty name="ISLIVE" type="string" default="">	

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.MESSAGE_ID = 0;
		variables.MESSAGE_TITLE = "";
		variables.MESSAGE = "";
		variables.STARTDATE = "";
		variables.ENDDATE = "";
		variables.ADDEDDATE = "";
		variables.ADDEDBYUID = "";
		variables.ADDEDBYNAME = "";
		variables.SYSTEM = "";		
		variables.ISLIVE = "";		
	</cfscript>

	<cffunction name="init" output="false" returntype="SYSTEM_MESSAGES">
		<cfreturn this>
	</cffunction>
	<cffunction name="getMESSAGE_ID" output="false" access="public" returntype="any">
		<cfreturn variables.MESSAGE_ID>
	</cffunction>

	<cffunction name="setMESSAGE_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.MESSAGE_ID = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getMESSAGE_TITLE" output="false" access="public" returntype="any">
		<cfreturn variables.MESSAGE_TITLE>
	</cffunction>

	<cffunction name="setMESSAGE_TITLE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MESSAGE_TITLE = arguments.val>
	</cffunction>

	<cffunction name="getMESSAGE" output="false" access="public" returntype="any">
		<cfreturn variables.MESSAGE>
	</cffunction>

	<cffunction name="setMESSAGE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MESSAGE = arguments.val>
	</cffunction>

	<cffunction name="getSTARTDATE" output="false" access="public" returntype="any">
		<cfreturn variables.STARTDATE>
	</cffunction>

	<cffunction name="setSTARTDATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.STARTDATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getENDDATE" output="false" access="public" returntype="any">
		<cfreturn variables.ENDDATE>
	</cffunction>

	<cffunction name="setENDDATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ENDDATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getADDEDDATE" output="false" access="public" returntype="any">
		<cfreturn variables.ADDEDDATE>
	</cffunction>

	<cffunction name="setADDEDDATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ADDEDDATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getADDEDBYUID" output="false" access="public" returntype="any">
		<cfreturn variables.ADDEDBYUID>
	</cffunction>

	<cffunction name="setADDEDBYUID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDEDBYUID = arguments.val>
	</cffunction>

	<cffunction name="getADDEDBYNAME" output="false" access="public" returntype="any">
		<cfreturn variables.ADDEDBYNAME>
	</cffunction>

	<cffunction name="setADDEDBYNAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDEDBYNAME = arguments.val>
	</cffunction>
	
	<cffunction name="getSYSTEM" output="false" access="public" returntype="any">
		<cfreturn variables.SYSTEM>
	</cffunction>

	<cffunction name="setSYSTEM" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SYSTEM = arguments.val>
	</cffunction>	

	<cffunction name="getISLIVE" output="false" access="public" returntype="any">
		
		<cfset var startDiff="">
		<cfset var endDiff="">
		<cfset var isLive="NO">
		
		<cfset startDiff=DateDiff("s",variables.startDate,now())>
		<cfset endDiff=DateDiff("s",now(),variables.endDate)>
		
		<cfif startDiff GT 0 and endDiff GT 0>
		  <cfset isLive="YES">
		</cfif>
		
		<cfreturn isLive>
	</cffunction>

</cfcomponent>