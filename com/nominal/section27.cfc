<cfcomponent output="false" alias="section27">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
    <cfproperty name="S27_URN" type="string" default="">	
	<cfproperty name="DATE_CREATED" type="string" default="">
	<cfproperty name="CREATED_BY" type="string" default="">
	<cfproperty name="OFFICER" type="string" default="">
	<cfproperty name="FORCE_CODE_OC" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="SUBJECT_NAME" type="string" default="">
	<cfproperty name="DOB" type="string" default="">
	<cfproperty name="ETHNICITY" type="string" default="">
	<cfproperty name="EA_CODE" type="string" default="">
	<cfproperty name="ADDRESS" type="string" default="">
	<cfproperty name="LOCATION" type="string" default="">
	<cfproperty name="TPU" type="string" default="">
	<cfproperty name="SEX" type="string" default="">
	<cfproperty name="GROUNDS" type="string" default="">
	<cfproperty name="S27_ZONE" type="string" default="">
	<cfproperty name="S27_DATE_FROM" type="string" default="">
	<cfproperty name="S27_DATE_TO" type="string" default="">
	<cfproperty name="EXTRA_HOURS" type="string" default="">
	<cfproperty name="S27_MAP_REF" type="string" default="">
	
	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.S27_URN = "";
		variables.DATE_CREATED = "";
		variables.CREATED_BY = "";
		variables.OFFICER = "";
		variables.FORCE_CODE_OC = "";
		variables.NOMINAL_REF = "";
		variables.SUBJECT_NAME = "";
		variables.DOB = "";
		variables.ETHNICITY = "";
		variables.EA_CODE = "";
		variables.ADDRESS = "";
		variables.LOCATION = "";
		variables.TPU = "";
		variables.SEX = "";
		variables.GROUNDS = "";			
		variables.S27_ZONE = "";				
		variables.S27_DATE_FROM = "";
		variables.S27_DATE_TO = "";
		variables.EXTRA_HOURS = "";
		variables.S27_MAP_REF = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="section27">
		<cfreturn this>
	</cffunction>

	<cffunction name="getS27_URN" output="false" access="public" returntype="any">
		<cfreturn variables.S27_URN>
	</cffunction>

	<cffunction name="setS27_URN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.S27_URN = arguments.val>
	</cffunction>

	<cffunction name="getDATE_CREATED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_CREATED>
	</cffunction>

	<cffunction name="setDATE_CREATED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DATE_CREATED = arguments.val>
	</cffunction>

	<cffunction name="getCREATED_BY" output="false" access="public" returntype="any">
		<cfreturn variables.CREATED_BY>
	</cffunction>

	<cffunction name="setCREATED_BY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CREATED_BY = arguments.val>
	</cffunction>
	
	<cffunction name="getOFFICER" output="false" access="public" returntype="any">
		<cfreturn variables.OFFICER>
	</cffunction>

	<cffunction name="setOFFICER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OFFICER = arguments.val>
	</cffunction>	

	<cffunction name="getFORCE_CODE_OC" output="false" access="public" returntype="any">
		<cfreturn variables.FORCE_CODE_OCR>
	</cffunction>

	<cffunction name="setFORCE_CODE_OC" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FORCE_CODE_OC = arguments.val>
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
	
	<cffunction name="getDOB" output="false" access="public" returntype="any">
		<cfreturn variables.DOB>
	</cffunction>

	<cffunction name="setDOB" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DOB = arguments.val>
	</cffunction>	

	<cffunction name="getETHNICITY" output="false" access="public" returntype="any">
		<cfreturn variables.ETHNICITY>
	</cffunction>

	<cffunction name="setETHNICITY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ETHNICITY = arguments.val>
	</cffunction>

	<cffunction name="getEA_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.EA_CODE>
	</cffunction>

	<cffunction name="setEA_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.EA_CODE = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS>
	</cffunction>

	<cffunction name="setADDRESS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS = arguments.val>
	</cffunction>

	<cffunction name="getLOCATION" output="false" access="public" returntype="any">
		<cfreturn variables.LOCATION>
	</cffunction>

	<cffunction name="setLOCATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LOCATION = arguments.val>
	</cffunction>

	<cffunction name="getTPU" output="false" access="public" returntype="any">
		<cfreturn variables.TPU>
	</cffunction>

	<cffunction name="setTPU" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TPU = arguments.val>
	</cffunction>

	<cffunction name="getSEX" output="false" access="public" returntype="any">
		<cfreturn variables.SEX>
	</cffunction>

	<cffunction name="setSEX" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SEX = arguments.val>
	</cffunction>

	<cffunction name="getGROUNDS" output="false" access="public" returntype="any">
		<cfreturn variables.GROUNDS>
	</cffunction>

	<cffunction name="setGROUNDS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.GROUNDS = arguments.val>
	</cffunction>

	<cffunction name="getS27_ZONE" output="false" access="public" returntype="any">
		<cfreturn variables.S27_ZONE>
	</cffunction>

	<cffunction name="setS27_ZONE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.S27_ZONE = arguments.val>
	</cffunction>

	<cffunction name="getS27_DATE_FROM" output="false" access="public" returntype="any">
		<cfreturn variables.S27_DATE_FROM>
	</cffunction>

	<cffunction name="getS27_DATE_FROM_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.S27_DATE_FROM,"DD/MM/YYYY")&" "&TimeFormat(variables.S27_DATE_FROM,"HH:mm:ss")>
	</cffunction>
	
	<cffunction name="getS27_DATE_FROM_TEXT_SHORT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.S27_DATE_FROM,"DD/MM")&" "&TimeFormat(variables.S27_DATE_FROM,"HH:mm")>
	</cffunction>	

	<cffunction name="setS27_DATE_FROM" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.S27_DATE_FROM = arguments.val>
	</cffunction>

	<cffunction name="getS27_DATE_TO" output="false" access="public" returntype="any">
		<cfreturn variables.S27_DATE_TO>
	</cffunction>

	<cffunction name="getS27_DATE_TO_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.S27_DATE_TO,"DD/MM/YYYY")&" "&TimeFormat(variables.S27_DATE_TO,"HH:mm:ss")>
	</cffunction>
	
	<cffunction name="getS27_DATE_TO_TEXT_SHORT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.S27_DATE_TO,"DD/MM")&" "&TimeFormat(variables.S27_DATE_TO,"HH:mm")>
	</cffunction>	

	<cffunction name="setS27_DATE_TO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.S27_DATE_TO = arguments.val>
	</cffunction>

	<cffunction name="getEXTRA_HOURS" output="false" access="public" returntype="any">
		<cfreturn variables.EXTRA_HOURS>
	</cffunction>

	<cffunction name="setEXTRA_HOURS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.EXTRA_HOURS = arguments.val>
	</cffunction>

	<cffunction name="getS27_MAP_REF" output="false" access="public" returntype="any">
		<cfreturn variables.S27_MAP_REF>
	</cffunction>

	<cffunction name="setS27_MAP_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.S27_MAP_REF = arguments.val>
	</cffunction>

</cfcomponent>