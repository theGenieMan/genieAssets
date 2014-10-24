<cfcomponent output="false" alias="familyProtection">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="CAR_EVENT_ID" type="numeric" default="0">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="ROLE_DESC" type="string" default="">
	<cfproperty name="DATE_STARTED" type="date" default="">
	<cfproperty name="DATE_FINISHED" type="date" default="">
	<cfproperty name="ROLE_REASON" type="string" default="">
	<cfproperty name="ROLE_TYPE_REF" type="numeric" default="0">
	<cfproperty name="CAR_STATUS" type="string" default="">
	<cfproperty name="CAR_EVENT_UR1" type="string" default="">
	<cfproperty name="CAR_EVENT_UR2" type="string" default="">
	<cfproperty name="CAR_EVENT_UR3" type="string" default="">
	<cfproperty name="ASSIGNMENT_REF" type="numeric" default="0">
	<cfproperty name="CONF_LOC_TYPE" type="string" default="">
	<cfproperty name="CONF_LOC_CODE" type="string" default="">
	<cfproperty name="CONF_DATE" type="date" default="">
	<cfproperty name="CAR_OFFICE_TYPE" type="string" default="">
	<cfproperty name="CAR_OFFICE_CODE" type="string" default="">
	<cfproperty name="CAR_OFFICE_TELNO" type="string" default="">
	<cfproperty name="DATE_CREATED" type="date" default="">
	<cfproperty name="FORM_DATE" type="date" default="">
	<cfproperty name="REVIEW_DATE" type="date" default="">
	<cfproperty name="BADGE_NUMBER" type="string" default="">
	<cfproperty name="CAR_EVENT_NOTE" type="NULL" default="">
	<cfproperty name="FAMILY_TITLE" type="string" default="">
	<cfproperty name="FILE_LOCATION" type="string" default="">
	<cfproperty name="ROLES" type="genieObj.familyProtection.fpRole[]" default="ArrayNew(1)">    

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.CAR_EVENT_ID = 0;
		variables.NOMINAL_REF = "";
		variables.ROLE_DESC = "";
		variables.DATE_STARTED = "";
		variables.DATE_FINISHED = "";
		variables.ROLE_REASON = "";
		variables.ROLE_TYPE_REF = 0;
		variables.CAR_STATUS = "";
		variables.CAR_EVENT_UR1 = "";
		variables.CAR_EVENT_UR2 = "";
		variables.CAR_EVENT_UR3 = "";
		variables.ASSIGNMENT_REF = 0;
		variables.CONF_LOC_TYPE = "";
		variables.CONF_LOC_CODE = "";
		variables.CONF_DATE = "";
		variables.CAR_OFFICE_TYPE = "";
		variables.CAR_OFFICE_CODE = "";
		variables.CAR_OFFICE_TELNO = "";
		variables.DATE_CREATED = "";
		variables.FORM_DATE = "";
		variables.REVIEW_DATE = "";
		variables.BADGE_NUMBER = "";
		variables.CAR_EVENT_NOTE = "";
		variables.FAMILY_TITLE = "";
		variables.FILE_LOCATION = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="familyProtection">
		<cfreturn this>
	</cffunction>
	<cffunction name="getCAR_EVENT_ID" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_EVENT_ID>
	</cffunction>

	<cffunction name="setCAR_EVENT_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CAR_EVENT_ID = arguments.val>
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

	<cffunction name="getROLE_TYPE_REF" output="false" access="public" returntype="any">
		<cfreturn variables.ROLE_TYPE_REF>
	</cffunction>

	<cffunction name="setROLE_TYPE_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ROLE_TYPE_REF = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCAR_STATUS" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_STATUS>
	</cffunction>

	<cffunction name="setCAR_STATUS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CAR_STATUS = arguments.val>
	</cffunction>

	<cffunction name="getCAR_EVENT_UR1" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_EVENT_UR1>
	</cffunction>

	<cffunction name="setCAR_EVENT_UR1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CAR_EVENT_UR1 = arguments.val>
	</cffunction>

	<cffunction name="getCAR_EVENT_UR2" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_EVENT_UR2>
	</cffunction>

	<cffunction name="setCAR_EVENT_UR2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CAR_EVENT_UR2 = arguments.val>
	</cffunction>

	<cffunction name="getCAR_EVENT_UR3" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_EVENT_UR3>
	</cffunction>

	<cffunction name="setCAR_EVENT_UR3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CAR_EVENT_UR3 = arguments.val>
	</cffunction>

	<cffunction name="getASSIGNMENT_REF" output="false" access="public" returntype="any">
		<cfreturn variables.ASSIGNMENT_REF>
	</cffunction>

	<cffunction name="setASSIGNMENT_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ASSIGNMENT_REF = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCONF_LOC_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.CONF_LOC_TYPE>
	</cffunction>

	<cffunction name="setCONF_LOC_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CONF_LOC_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getCONF_LOC_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.CONF_LOC_CODE>
	</cffunction>

	<cffunction name="setCONF_LOC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CONF_LOC_CODE = arguments.val>
	</cffunction>

	<cffunction name="getCONF_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.CONF_DATE>
	</cffunction>

	<cffunction name="setCONF_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CONF_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getCAR_OFFICE_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_OFFICE_TYPE>
	</cffunction>

	<cffunction name="setCAR_OFFICE_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CAR_OFFICE_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getCAR_OFFICE_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_OFFICE_CODE>
	</cffunction>

	<cffunction name="setCAR_OFFICE_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CAR_OFFICE_CODE = arguments.val>
	</cffunction>

	<cffunction name="getCAR_OFFICE_TELNO" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_OFFICE_TELNO>
	</cffunction>

	<cffunction name="setCAR_OFFICE_TELNO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CAR_OFFICE_TELNO = arguments.val>
	</cffunction>

	<cffunction name="getDATE_CREATED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_CREATED>
	</cffunction>

	<cffunction name="setDATE_CREATED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_CREATED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getFORM_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.FORM_DATE>
	</cffunction>

	<cffunction name="setFORM_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.FORM_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getREVIEW_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.REVIEW_DATE>
	</cffunction>

	<cffunction name="setREVIEW_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.REVIEW_DATE = arguments.val>
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

	<cffunction name="getCAR_EVENT_NOTE" output="false" access="public" returntype="any">
		<cfreturn variables.CAR_EVENT_NOTE>
	</cffunction>

	<cffunction name="setCAR_EVENT_NOTE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CAR_EVENT_NOTE = arguments.val>
	</cffunction>

	<cffunction name="getFAMILY_TITLE" output="false" access="public" returntype="any">
		<cfreturn variables.FAMILY_TITLE>
	</cffunction>

	<cffunction name="setFAMILY_TITLE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FAMILY_TITLE = arguments.val>
	</cffunction>

	<cffunction name="getFILE_LOCATION" output="false" access="public" returntype="any">
		<cfreturn variables.FILE_LOCATION>
	</cffunction>

	<cffunction name="setFILE_LOCATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FILE_LOCATION = arguments.val>
	</cffunction>

	<cffunction name="getROLES" output="false" access="public" returntype="any">
		<cfreturn variables.ROLES>
	</cffunction>

	<cffunction name="setROLES" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ROLES = arguments.val>
	</cffunction>
    
	<cffunction name="dump" output="false" access="public" returntype="any">
        <cfset var dump="">
        <cfset var x="">
        <cfset var y="">
        
        <cfoutput>
        <cfsavecontent variable="dump">
         family Title=#getFAMILY_TITLE()#<Br>
         URN=#getCAR_EVENT_UR1()#/#getCAR_EVENT_UR2()#/#getCAR_EVENT_UR3()#<Br>
         Notes=#getCAR_EVENT_NOTE()#
         <cfloop from="1" to="#ArrayLen(roles)#" index="y">
         role #variables.roles[y].getNominal_Ref()# - #variables.roles[y].getROLE_REASON()#<br>
         </cfloop>         
        </cfsavecontent>
        </cfoutput>
        
		<cfreturn dump>
	</cffunction>           

</cfcomponent>