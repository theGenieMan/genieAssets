<cfcomponent output="false" alias="warrant">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="WARRANT_REF" type="numeric" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="DATE_ISSUED" type="date" default="">
	<cfproperty name="COURT_NAME" type="string" default="">
	<cfproperty name="DATE_EXECUTED" type="date" default="">
	<cfproperty name="EXECUTION_METHOD" type="string" default="">
	<cfproperty name="OFFENCE" type="string" default="">
	<cfproperty name="WARRANT_EXECUTED" type="string" default="">
	<cfproperty name="WARRANT_TYPE" type="string" default="">
	<cfproperty name="BAIL" type="string" default="">
	<cfproperty name="NOTEPAD" type="string" default="">
	<cfproperty name="ADDRESS" type="string" default="">
	<cfproperty name="ORG_CODE_POLICE" type="string" default="">
	<cfproperty name="OWN_SECT_CODE" type="string" default="">
	<cfproperty name="CLASSIFICATION" type="string" default="">
	<cfproperty name="WARRANT_REFERENCE" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.WARRANT_REF = "";
		variables.NOMINAL_REF = "";
		variables.DATE_ISSUED = "";
		variables.COURT_NAME = "";
		variables.DATE_EXECUTED = "";
		variables.EXECUTION_METHOD = "";
		variables.OFFENCE = "";
		variables.WARRANT_EXECUTED = "";
		variables.WARRANT_TYPE = "";
		variables.BAIL = "";
		variables.NOTEPAD = "";
		variables.ADDRESS = "";
		variables.ORG_CODE_POLICE = "";
		variables.OWN_SECT_CODE = "";
		variables.CLASSIFICATION = "";
		variables.WARRANT_REFERENCE = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="warrant">
		<cfreturn this>
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

	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getDATE_ISSUED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_ISSUED>
	</cffunction>

	<cffunction name="setDATE_ISSUED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_ISSUED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getCOURT_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.COURT_NAME>
	</cffunction>

	<cffunction name="setCOURT_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.COURT_NAME = arguments.val>
	</cffunction>

	<cffunction name="getDATE_EXECUTED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_EXECUTED>
	</cffunction>

	<cffunction name="setDATE_EXECUTED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_EXECUTED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getEXECUTION_METHOD" output="false" access="public" returntype="any">
		<cfreturn variables.EXECUTION_METHOD>
	</cffunction>

	<cffunction name="setEXECUTION_METHOD" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.EXECUTION_METHOD = arguments.val>
	</cffunction>

	<cffunction name="getOFFENCE" output="false" access="public" returntype="any">
		<cfreturn variables.OFFENCE>
	</cffunction>

	<cffunction name="setOFFENCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OFFENCE = arguments.val>
	</cffunction>

	<cffunction name="getWARRANT_EXECUTED" output="false" access="public" returntype="any">
		<cfreturn variables.WARRANT_EXECUTED>
	</cffunction>

	<cffunction name="setWARRANT_EXECUTED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.WARRANT_EXECUTED = arguments.val>
	</cffunction>

	<cffunction name="getWARRANT_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.WARRANT_TYPE>
	</cffunction>

	<cffunction name="setWARRANT_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.WARRANT_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getBAIL" output="false" access="public" returntype="any">
		<cfreturn variables.BAIL>
	</cffunction>

	<cffunction name="setBAIL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BAIL = arguments.val>
	</cffunction>

	<cffunction name="getNOTEPAD" output="false" access="public" returntype="any">
		<cfreturn variables.NOTEPAD>
	</cffunction>

	<cffunction name="setNOTEPAD" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOTEPAD = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS>
	</cffunction>

	<cffunction name="setADDRESS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS = arguments.val>
	</cffunction>

	<cffunction name="getORG_CODE_POLICE" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_CODE_POLICE>
	</cffunction>

	<cffunction name="setORG_CODE_POLICE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORG_CODE_POLICE = arguments.val>
	</cffunction>

	<cffunction name="getOWN_SECT_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.OWN_SECT_CODE>
	</cffunction>

	<cffunction name="setOWN_SECT_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OWN_SECT_CODE = arguments.val>
	</cffunction>

	<cffunction name="getCLASSIFICATION" output="false" access="public" returntype="any">
		<cfreturn variables.CLASSIFICATION>
	</cffunction>

	<cffunction name="setCLASSIFICATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CLASSIFICATION = arguments.val>
	</cffunction>

	<cffunction name="getWARRANT_REFERENCE" output="false" access="public" returntype="any">
		<cfreturn variables.WARRANT_REFERENCE>
	</cffunction>

	<cffunction name="setWARRANT_REFERENCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.WARRANT_REFERENCE = arguments.val>
	</cffunction>

	<cffunction name="dump" output="false" access="public" returntype="any">
        <cfset var dump="">
        
        <cfoutput>
        <cfsavecontent variable="dump">
		 warr ref=#getWARRANT_REF()#<br>
		 nom ref=#getNOMINAL_REF()#<br>
         date issued=#getDATE_ISSUED()#<br>
		 court=#getCOURT_NAME()#<br>
		 date exec=#getDATE_EXECUTED()#<br>
		 exec meth=#getEXECUTION_METHOD()#<br>
		 offence=#getOFFENCE()#<br>
		 warrant exec=#getWARRANT_EXECUTED()#<br>
		 type=#getWARRANT_TYPE()#<Br>
		 bail=#getBAIL()#<br>
		 notepad=#getNOTEPAD()#<br>
		 address=#getADDRESS()#<br>
		 org code pol=#getORG_CODE_POLICE()#<br>
		 owning sect=#getOWN_SECT_CODE()#<br>
		 classification=#getCLASSIFICATION()#<br>
		 warrant reference=#getWARRANT_REFERENCE()#
        </cfsavecontent>
        </cfoutput>
        
		<cfreturn dump>
	</cffunction>    

</cfcomponent>