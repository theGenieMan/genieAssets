<cfcomponent output="false" alias="genieObj.telephones.telephone">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="TEL_NO" type="string" default="">
	<cfproperty name="SOURCE" type="string" default="">
	<cfproperty name="SOURCE_ID" type="string" default="">
	<cfproperty name="PHONE_TYPE" type="string" default="">
	<cfproperty name="SUPPLIER" type="string" default="">
	<cfproperty name="ELEC_COMMS" type="string" default="">
	<cfproperty name="STOLEN" type="string" default="">
	<cfproperty name="DATE_FROM" type="date" default="">
	<cfproperty name="DATE_TO" type="date" default="">
	<cfproperty name="NOTE" type="string" default="">
	<cfproperty name="APP_REF" type="string" default="">    
	<cfproperty name="FORCE_REF" type="string" default="">
	<cfproperty name="DISPLAY_FORCE" type="string" default="">    
	<cfproperty name="SYS_REF" type="string" default="">     

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.TEL_NO = "";
		variables.SOURCE = "";
		variables.SOURCE_ID = "";
		variables.PHONE_TYPE = "";
		variables.SUPPLIER = "";
		variables.ELEC_COMMS = "";
		variables.STOLEN = "";
		variables.DATE_FROM = "";
		variables.DATE_TO = "";
		variables.NOTE = "";
		variables.APP_REF = "";
		variables.FORCE_REF = "";
		variables.DISPLAY_FORCE = "";		
		variables.SYS_REF = "";				
	</cfscript>

	<cffunction name="init" output="false" returntype="telephone">
		<cfreturn this>
	</cffunction>
	<cffunction name="getTEL_NO" output="false" access="public" returntype="any">
		<cfreturn variables.TEL_NO>
	</cffunction>

	<cffunction name="setTEL_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TEL_NO = arguments.val>
	</cffunction>

	<cffunction name="getSOURCE" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE>
	</cffunction>

	<cffunction name="setSOURCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE = arguments.val>
	</cffunction>

	<cffunction name="getSOURCE_ID" output="false" access="public" returntype="any">
		<cfreturn variables.SOURCE_ID>
	</cffunction>

	<cffunction name="setSOURCE_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOURCE_ID = arguments.val>
	</cffunction>

	<cffunction name="getPHONE_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.PHONE_TYPE>
	</cffunction>

	<cffunction name="setPHONE_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PHONE_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getSUPPLIER" output="false" access="public" returntype="any">
		<cfreturn variables.SUPPLIER>
	</cffunction>

	<cffunction name="setSUPPLIER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SUPPLIER = arguments.val>
	</cffunction>

	<cffunction name="getELEC_COMMS" output="false" access="public" returntype="any">
		<cfreturn variables.ELEC_COMMS>
	</cffunction>

	<cffunction name="setELEC_COMMS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ELEC_COMMS = arguments.val>
	</cffunction>

	<cffunction name="getSTOLEN" output="false" access="public" returntype="any">
		<cfreturn variables.STOLEN>
	</cffunction>

	<cffunction name="setSTOLEN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.STOLEN = arguments.val>
	</cffunction>

	<cffunction name="getDATE_FROM" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_FROM>
	</cffunction>

	<cffunction name="setDATE_FROM" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_FROM = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDATE_TO" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_TO>
	</cffunction>

	<cffunction name="setDATE_TO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_TO = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getNOTE" output="false" access="public" returntype="any">
		<cfreturn variables.NOTE>
	</cffunction>

	<cffunction name="setNOTE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOTE = arguments.val>
	</cffunction>

	<cffunction name="getAPP_REF" output="false" access="public" returntype="any">
		<cfreturn variables.APP_REF>
	</cffunction>

	<cffunction name="setAPP_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.APP_REF = arguments.val>
	</cffunction>

	<cffunction name="getFORCE_REF" output="false" access="public" returntype="any">
		<cfreturn variables.FORCE_REF>
	</cffunction>

	<cffunction name="setFORCE_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FORCE_REF = arguments.val>
	</cffunction>
    
	<cffunction name="getDISPLAY_FORCE" output="false" access="public" returntype="any">
		<cfreturn variables.DISPLAY_FORCE>
	</cffunction>

	<cffunction name="setDISPLAY_FORCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DISPLAY_FORCE = arguments.val>
	</cffunction>    
    
	<cffunction name="getSYS_REF" output="false" access="public" returntype="any">
		<cfreturn variables.SYS_REF>
	</cffunction>

	<cffunction name="setSYS_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SYS_REF = arguments.val>
	</cffunction>  

</cfcomponent>