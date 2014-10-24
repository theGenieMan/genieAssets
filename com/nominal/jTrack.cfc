<cfcomponent output="false" alias="jTrack">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="PNC_ID" type="string" default="">
	<cfproperty name="PPO_START" type="date" default="">
	<cfproperty name="OWNER_CJA" type="string" default="">
	<cfproperty name="OWNER_BCU" type="string" default="">
	<cfproperty name="OWNER_CDRP" type="string" default="">
	<cfproperty name="PPO_IND" type="string" default="">
	<cfproperty name="PPO_END" type="date" default="">
	<cfproperty name="PPO_OWNER" type="string" default="">
	<cfproperty name="FORCE_STATION" type="string" default="">
	<cfproperty name="ADDRESS_1" type="string" default="">
	<cfproperty name="ADDRESS_2" type="string" default="">
	<cfproperty name="ADDRESS_3" type="string" default="">
	<cfproperty name="ADDRESS_4" type="string" default="">
	<cfproperty name="ADDRESS_5" type="string" default="">
	<cfproperty name="POST_CODE" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.PNC_ID = "";
		variables.PPO_START = "";
		variables.OWNER_CJA = "";
		variables.OWNER_BCU = "";
		variables.OWNER_CDRP = "";
		variables.PPO_IND = "";
		variables.PPO_END = "";
		variables.PPO_OWNER = "";
		variables.FORCE_STATION = "";
		variables.ADDRESS_1 = "";
		variables.ADDRESS_2 = "";
		variables.ADDRESS_3 = "";
		variables.ADDRESS_4 = "";
		variables.ADDRESS_5 = "";
		variables.POST_CODE = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="jTrack">
		<cfreturn this>
	</cffunction>
	<cffunction name="getPNC_ID" output="false" access="public" returntype="any">
		<cfreturn variables.PNC_ID>
	</cffunction>

	<cffunction name="setPNC_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PNC_ID = arguments.val>
	</cffunction>

	<cffunction name="getPPO_START" output="false" access="public" returntype="any">
		<cfreturn variables.PPO_START>
	</cffunction>

	<cffunction name="setPPO_START" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.PPO_START = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getOWNER_CJA" output="false" access="public" returntype="any">
		<cfreturn variables.OWNER_CJA>
	</cffunction>

	<cffunction name="setOWNER_CJA" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OWNER_CJA = arguments.val>
	</cffunction>

	<cffunction name="getOWNER_BCU" output="false" access="public" returntype="any">
		<cfreturn variables.OWNER_BCU>
	</cffunction>

	<cffunction name="setOWNER_BCU" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OWNER_BCU = arguments.val>
	</cffunction>

	<cffunction name="getOWNER_CDRP" output="false" access="public" returntype="any">
		<cfreturn variables.OWNER_CDRP>
	</cffunction>

	<cffunction name="setOWNER_CDRP" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OWNER_CDRP = arguments.val>
	</cffunction>

	<cffunction name="getPPO_IND" output="false" access="public" returntype="any">
		<cfreturn variables.PPO_IND>
	</cffunction>

	<cffunction name="setPPO_IND" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PPO_IND = arguments.val>
	</cffunction>

	<cffunction name="getPPO_END" output="false" access="public" returntype="any">
		<cfreturn variables.PPO_END>
	</cffunction>

	<cffunction name="setPPO_END" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.PPO_END = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getPPO_OWNER" output="false" access="public" returntype="any">
		<cfreturn variables.PPO_OWNER>
	</cffunction>

	<cffunction name="setPPO_OWNER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PPO_OWNER = arguments.val>
	</cffunction>

	<cffunction name="getFORCE_STATION" output="false" access="public" returntype="any">
		<cfreturn variables.FORCE_STATION>
	</cffunction>

	<cffunction name="setFORCE_STATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FORCE_STATION = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS_1" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS_1>
	</cffunction>

	<cffunction name="setADDRESS_1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS_1 = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS_2" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS_2>
	</cffunction>

	<cffunction name="setADDRESS_2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS_2 = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS_3" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS_3>
	</cffunction>

	<cffunction name="setADDRESS_3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS_3 = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS_4" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS_4>
	</cffunction>

	<cffunction name="setADDRESS_4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS_4 = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS_5" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS_5>
	</cffunction>

	<cffunction name="setADDRESS_5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS_5 = arguments.val>
	</cffunction>

	<cffunction name="getPOST_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.POST_CODE>
	</cffunction>

	<cffunction name="setPOST_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.POST_CODE = arguments.val>
	</cffunction>

	<cffunction name="dump" output="false" access="public" returntype="any">
        <cfset var dump="">
        
        <cfoutput>
        <cfsavecontent variable="dump">
         pncid=#getPNC_ID()#<Br>
         start=#getPPO_START()#<Br>
         end=#getPPO_END()#<Br>
         bcu owner=#getOWNER_BCU()#<br>
        </cfsavecontent>
        </cfoutput>
        
		<cfreturn dump>
	</cffunction>    

</cfcomponent>