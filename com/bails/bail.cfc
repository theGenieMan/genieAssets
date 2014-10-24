<cfcomponent output="false" alias="bail">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="BAIL_REF" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="CUSTODY_REF" type="string" default="">
	<cfproperty name="BAIL_TYPE" type="string" default="">
	<cfproperty name="DATE_SET" type="date" default="">
	<cfproperty name="BAILED_TO_DATE" type="date" default="">
	<cfproperty name="BAILED_FROM" type="string" default="">
	<cfproperty name="BAILED_TO" type="string" default="">
	<cfproperty name="BAIL_OFFICER" type="string" default="">
	<cfproperty name="CANCELLATION_REASON" type="string" default="">
	<cfproperty name="WARRANT_REF" type="numeric" default="0">
	<cfproperty name="CANCELLATION_DATE" type="date" default="">
	<cfproperty name="STATUS" type="string" default="">
	<cfproperty name="bailDetails" type="genieObj.bail.bailDetail[]" default="ArrayNew(1)">
	<cfproperty name="bailConditions" type="genieObj.bail.bailConditions[]" default="ArrayNew(1)">        

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.BAIL_REF = "";
		variables.NOMINAL_REF = "";
		variables.CUSTODY_REF = "";
		variables.BAIL_TYPE = "";
		variables.DATE_SET = "";
		variables.BAILED_TO_DATE = "";
		variables.BAILED_FROM = "";
		variables.BAILED_TO = "";
		variables.BAIL_OFFICER = "";
		variables.CANCELLATION_REASON = "";
		variables.WARRANT_REF = 0;
		variables.CANCELLATION_DATE = "";
		variables.STATUS = "";
		variables.bailDetails = "";
		variables.bailConditions = "";				
	</cfscript>

	<cffunction name="init" output="false" returntype="bail">
		<cfreturn this>
	</cffunction>
	<cffunction name="getBAIL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.BAIL_REF>
	</cffunction>

	<cffunction name="setBAIL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BAIL_REF = arguments.val>
	</cffunction>

	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getCUSTODY_REF" output="false" access="public" returntype="any">
		<cfreturn variables.CUSTODY_REF>
	</cffunction>

	<cffunction name="setCUSTODY_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CUSTODY_REF = arguments.val>
	</cffunction>

	<cffunction name="getBAIL_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.BAIL_TYPE>
	</cffunction>

	<cffunction name="setBAIL_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BAIL_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getDATE_SET" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_SET>
	</cffunction>

	<cffunction name="getDATE_SET_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_SET,"DD/MM/YYYY")&" "&TimeFormat(variables.DATE_SET,"HH:mm")>
	</cffunction>

	<cffunction name="setDATE_SET" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_SET = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getBAILED_TO_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.BAILED_TO_DATE>
	</cffunction>

	<cffunction name="setBAILED_TO_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.BAILED_TO_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getBAILED_FROM" output="false" access="public" returntype="any">
		<cfreturn variables.BAILED_FROM>
	</cffunction>

	<cffunction name="setBAILED_FROM" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BAILED_FROM = arguments.val>
	</cffunction>

	<cffunction name="getBAILED_TO" output="false" access="public" returntype="any">
		<cfreturn variables.BAILED_TO>
	</cffunction>

	<cffunction name="setBAILED_TO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BAILED_TO = arguments.val>
	</cffunction>

	<cffunction name="getBAILED_TO_TRUNC" output="false" access="public" returntype="any">
		<cfreturn Replace(Replace(Replace(variables.BAILED_TO,', WEST MERCIA CONSTABULARY',''),'NUNEATON AND BEDWORTH DISTRICT SECTOR, WARWICKSHIRE POLICE','NUNEATON'),'SOUTHERN AREA, WARWICKSHIRE POLICE','LEAMINGTON SPA')>
	</cffunction>
	
	<cffunction name="getBAIL_OFFICER" output="false" access="public" returntype="any">
		<cfreturn variables.BAIL_OFFICER>
	</cffunction>

	<cffunction name="setBAIL_OFFICER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BAIL_OFFICER = arguments.val>
	</cffunction>

	<cffunction name="getCANCELLATION_REASON" output="false" access="public" returntype="any">
		<cfreturn variables.CANCELLATION_REASON>
	</cffunction>

	<cffunction name="setCANCELLATION_REASON" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CANCELLATION_REASON = arguments.val>
	</cffunction>

	<cffunction name="getWARRANT_REF" output="false" access="public" returntype="any">
		<cfreturn variables.WARRANT_REF>
	</cffunction>

	<cffunction name="setWARRANT_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.WARRANT_REF = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCANCELLATION_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.CANCELLATION_DATE>
	</cffunction>

	<cffunction name="setCANCELLATION_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CANCELLATION_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getSTATUS" output="false" access="public" returntype="any">
		<cfreturn variables.STATUS>
	</cffunction>

	<cffunction name="setSTATUS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.STATUS = arguments.val>
	</cffunction>
    
	<cffunction name="getBailConditions" output="false" access="public" returntype="any">
		<cfreturn variables.BailConditions>
	</cffunction>

	<cffunction name="setBailConditions" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BailConditions = arguments.val>
	</cffunction>
    
	<cffunction name="getBailDetails" output="false" access="public" returntype="any">
		<cfreturn variables.BailDetails>
	</cffunction>

	<cffunction name="setBailDetails" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BailDetails = arguments.val>
	</cffunction>        

	<cffunction name="dump" output="false" access="public" returntype="any">
        <cfset var dump="">
        <cfset var x="">
        <cfset var y="">
        
        <cfoutput>
        <cfsavecontent variable="dump">
         Bail Ref=#getBail_REF()#<Br>
         Nominal Ref=#getNOMINAL_REF()#<Br>
         Custody=#getCUSTODY_REF()#<Br>
         Bail Type=#getBAIL_TYPE()#<br>
         Date Set=#getDate_Set()#<br>         
         bailed to =#getBAILED_TO_DATE()#<br>
         <cfloop from="1" to="#ArrayLen(bailDetails)#" index="x">
         bail detail #variables.bailDetails[x].getSeq_No()# - #variables.bailDetails[x].getOffence_Detail()#<br>
         </cfloop>
         <cfloop from="1" to="#ArrayLen(bailConditions)#" index="y">
         bail condition #variables.bailConditions[y].getSeq_No()# - Cond=#variables.bailConditions[y].getCondition()#. Reason=#variables.bailConditions[y].getReason()#<br>
         </cfloop>         
        </cfsavecontent>
        </cfoutput>
        
		<cfreturn dump>
	</cffunction>    


</cfcomponent>