<cfcomponent output="false" alias="genieObj.vehicles.vehicle">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="VEH_REF" type="string" default="">
	<cfproperty name="VRM" type="string" default="">
	<cfproperty name="MANUFACTURER" type="string" default="">
	<cfproperty name="MODEL" type="string" default="">
	<cfproperty name="BODY_TYPE" type="string" default="">
	<cfproperty name="SHADE" type="string" default="">
	<cfproperty name="PRIMARY_COL" type="string" default="">
	<cfproperty name="SECONDARY_COL" type="string" default="">
	<cfproperty name="TEXT" type="string" default="">
	<cfproperty name="APP_REF" type="string" default="">    
	<cfproperty name="FORCE_REF" type="string" default="">
	<cfproperty name="DISPLAY_FORCE" type="string" default="">    
	<cfproperty name="SYS_REF" type="string" default="">      

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.VEH_REF = "";
		variables.VRM = "";
		variables.MANUFACTURER = "";
		variables.MODEL = "";
		variables.BODY_TYPE = "";
		variables.SHADE = "";
		variables.PRIMARY_COL = "";
		variables.SECONDARY_COL = "";
		variables.TEXT = "";
		variables.APP_REF = "";
		variables.FORCE_REF = "";
		variables.DISPLAY_FORCE = "";		
		variables.SYS_REF = "";			
	</cfscript>

	<cffunction name="init" output="false" returntype="VEHICLE">
		<cfreturn this>
	</cffunction>
	<cffunction name="getVEH_REF" output="false" access="public" returntype="any">
		<cfreturn variables.VEH_REF>
	</cffunction>

	<cffunction name="setVEH_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.VEH_REF = arguments.val>
	</cffunction>

	<cffunction name="getVRM" output="false" access="public" returntype="any">
		<cfreturn variables.VRM>
	</cffunction>

	<cffunction name="setVRM" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.VRM = arguments.val>
	</cffunction>

	<cffunction name="getMANUFACTURER" output="false" access="public" returntype="any">
		<cfreturn variables.MANUFACTURER>
	</cffunction>

	<cffunction name="setMANUFACTURER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MANUFACTURER = arguments.val>
	</cffunction>

	<cffunction name="getMODEL" output="false" access="public" returntype="any">
		<cfreturn variables.MODEL>
	</cffunction>

	<cffunction name="setMODEL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MODEL = arguments.val>
	</cffunction>

	<cffunction name="getBODY_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.BODY_TYPE>
	</cffunction>

	<cffunction name="setBODY_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BODY_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getSHADE" output="false" access="public" returntype="any">
		<cfreturn variables.SHADE>
	</cffunction>

	<cffunction name="setSHADE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SHADE = arguments.val>
	</cffunction>

	<cffunction name="getPRIMARY_COL" output="false" access="public" returntype="any">
		<cfreturn variables.PRIMARY_COL>
	</cffunction>

	<cffunction name="setPRIMARY_COL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PRIMARY_COL = arguments.val>
	</cffunction>

	<cffunction name="getSECONDARY_COL" output="false" access="public" returntype="any">
		<cfreturn variables.SECONDARY_COL>
	</cffunction>

	<cffunction name="setSECONDARY_COL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SECONDARY_COL = arguments.val>
	</cffunction>

	<cffunction name="getTEXT" output="false" access="public" returntype="any">
		<cfreturn variables.TEXT>
	</cffunction>

	<cffunction name="setTEXT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TEXT = arguments.val>
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