<cfcomponent output="false" alias="target">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="TARGET_REF" type="numeric" default="0">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="TARGET_INTEREST_TYPE" type="string" default="">
	<cfproperty name="START_DATE" type="date" default="">
	<cfproperty name="END_DATE" type="date" default="">
	<cfproperty name="REASON" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.TARGET_REF = 0;
		variables.NOMINAL_REF = "";
		variables.TARGET_INTEREST_TYPE = "";
		variables.START_DATE = "";
		variables.END_DATE = "";
		variables.REASON = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="target">
		<cfreturn this>
	</cffunction>
	<cffunction name="getTARGET_REF" output="false" access="public" returntype="any">
		<cfreturn variables.TARGET_REF>
	</cffunction>

	<cffunction name="setTARGET_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.TARGET_REF = arguments.val>
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

	<cffunction name="getTARGET_INTEREST_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.TARGET_INTEREST_TYPE>
	</cffunction>

	<cffunction name="setTARGET_INTEREST_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TARGET_INTEREST_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getSTART_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.START_DATE>
	</cffunction>

	<cffunction name="setSTART_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.START_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getEND_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.END_DATE>
	</cffunction>

	<cffunction name="setEND_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.END_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getREASON" output="false" access="public" returntype="any">
		<cfreturn variables.REASON>
	</cffunction>

	<cffunction name="setREASON" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REASON = arguments.val>
	</cffunction>

	<cffunction name="dump" output="false" access="public" returntype="any">
        <cfset var dump="">
        
        <cfoutput>
        <cfsavecontent variable="dump">
         Target Ref=#getTarget_Ref()#
         Nominal Ref=#getNOMINAL_REF()#<Br>
         Target Interest Type=#getTARGET_INTEREST_TYPE()#<Br>
         Start Date=#getSTART_DATE()#<Br>
         End Date=#getEND_DATE()#<br>
         Reason=#getREASON()#<br>         
        </cfsavecontent>
        </cfoutput>
        
		<cfreturn dump>
	</cffunction>

</cfcomponent>