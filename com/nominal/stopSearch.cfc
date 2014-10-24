<cfcomponent output="false" alias="stopSearch">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
    <cfproperty name="SS_URN" type="string" default="">	
	<cfproperty name="SS_DATE" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="SUBJECT_NAME" type="string" default="">
	<cfproperty name="SUBJECT_DOB" type="string" default="">
	<cfproperty name="OFFICER" type="string" default="">
	<cfproperty name="TPU" type="string" default="">
	<cfproperty name="SS_LOCATION" type="string" default="">
	<cfproperty name="SS_MAP_REF" type="string" default="">
	<cfproperty name="ADDRESS" type="string" default="">
	<cfproperty name="SS_REASON" type="string" default="">
	<cfproperty name="SS_GROUNDS" type="string" default="">
	<cfproperty name="SS_POS_SEARCH" type="string" default="">
	<cfproperty name="SS_ARREST" type="string" default="">
	<cfproperty name="VEHICLE" type="string" default="">
	<cfproperty name="LINKED_INTEL" type="array">
	
	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.SS_URN = "";
		variables.SS_DATE = "";
		variables.NOMINAL_REF = "";
		variables.SUBJECT_NAME = "";
		variables.SUBJECT_DOB = "";
		variables.OFFICER = "";
		variables.TPU = "";
		variables.SS_LOCATION = "";
		variables.SS_MAP_REF = "";
		variables.ADDRESS = "";
		variables.SS_REASON = "";
		variables.SS_GROUNDS = "";
		variables.SS_POS_SEARCH = "";
		variables.SS_ARREST = "";
		variables.VEHICLE = "";			
		variables.ADD_COMMENTS = "";				
		variables.LINKED_INTEL = arrayNew(1);
	</cfscript>

	<cffunction name="init" output="false" returntype="stopSearch">
		<cfreturn this>
	</cffunction>

	<cffunction name="getSS_URN" output="false" access="public" returntype="any">
		<cfreturn variables.SS_URN>
	</cffunction>

	<cffunction name="setSS_URN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SS_URN = arguments.val>
	</cffunction>

	<cffunction name="getSS_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.SS_DATE>
	</cffunction>

	<cffunction name="setSS_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SS_DATE = arguments.val>
	</cffunction>
	
	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getSUBJECT_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.SUBJECT_NAME>
	</cffunction>

	<cffunction name="setSUBJECT_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SUBJECT_NAME = arguments.val>
	</cffunction>
	
	<cffunction name="getSUBJECT_DOB" output="false" access="public" returntype="any">
		<cfreturn variables.SUBJECT_DOB>
	</cffunction>

	<cffunction name="setSUBJECT_DOB" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SUBJECT_DOB = arguments.val>
	</cffunction>	

	<cffunction name="getOFFICER" output="false" access="public" returntype="any">
		<cfreturn variables.OFFICER>
	</cffunction>

	<cffunction name="setOFFICER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OFFICER = arguments.val>
	</cffunction>

	<cffunction name="getTPU" output="false" access="public" returntype="any">
		<cfreturn variables.TPU>
	</cffunction>

	<cffunction name="setTPU" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TPU = arguments.val>
	</cffunction>

	<cffunction name="getSS_LOCATION" output="false" access="public" returntype="any">
		<cfreturn variables.SS_LOCATION>
	</cffunction>

	<cffunction name="setSS_LOCATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SS_LOCATION = arguments.val>
	</cffunction>

	<cffunction name="getSS_MAP_REF" output="false" access="public" returntype="any">
		<cfreturn variables.SS_MAP_REF>
	</cffunction>

	<cffunction name="setSS_MAP_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SS_MAP_REF = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS>
	</cffunction>

	<cffunction name="setADDRESS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS = arguments.val>
	</cffunction>

	<cffunction name="getSS_REASON" output="false" access="public" returntype="any">
		<cfreturn variables.SS_REASON>
	</cffunction>

	<cffunction name="setSS_REASON" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SS_REASON = arguments.val>
	</cffunction>

	<cffunction name="getSS_GROUNDS" output="false" access="public" returntype="any">
		<cfreturn variables.SS_GROUNDS>
	</cffunction>

	<cffunction name="setSS_GROUNDS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SS_GROUNDS = arguments.val>
	</cffunction>

	<cffunction name="getSS_POS_SEARCH" output="false" access="public" returntype="any">
		<cfreturn variables.SS_POS_SEARCH>
	</cffunction>

	<cffunction name="setSS_POS_SEARCH" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SS_POS_SEARCH = arguments.val>
	</cffunction>

	<cffunction name="getSS_ARREST" output="false" access="public" returntype="any">
		<cfreturn variables.SS_ARREST>
	</cffunction>

	<cffunction name="setSS_ARREST" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SS_ARREST = arguments.val>
	</cffunction>

	<cffunction name="getVEHICLE" output="false" access="public" returntype="any">
		<cfreturn variables.VEHICLE>
	</cffunction>

	<cffunction name="setVEHICLE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.VEHICLE = arguments.val>
	</cffunction>

	<cffunction name="getADD_COMMENTS" output="false" access="public" returntype="any">
		<cfreturn variables.ADD_COMMENTS>
	</cffunction>

	<cffunction name="setADD_COMMENTS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADD_COMMENTS = arguments.val>
	</cffunction>

	<cffunction name="getLINKED_INTEL" output="false" access="public" returntype="any">
		<cfreturn variables.LINKED_INTEL>
	</cffunction>

	<cffunction name="setLINKED_INTEL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LINKED_INTEL = arguments.val>
	</cffunction>

</cfcomponent>