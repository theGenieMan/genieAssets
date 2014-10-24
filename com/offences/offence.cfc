<cfcomponent output="false" alias="genieObj.offences.offence">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="CRIME_REF" type="numeric" default="0">
	<cfproperty name="ORG_CODE" type="string" default="">
	<cfproperty name="SERIAL_NO" type="string" default="">
	<cfproperty name="YEAR" type="numeric" default="0">
	<cfproperty name="BEAT_CODE" type="string" default="">
	<cfproperty name="INCIDENT_NO" type="string" default="">
	<cfproperty name="SOCO_REPORT_NO" type="string" default="">
	<cfproperty name="REC_WMC_CODE" type="string" default="">
	<cfproperty name="REC_HOMC_CODE" type="string" default="">
	<cfproperty name="REC_HOOC_CODE" type="string" default="">
	<cfproperty name="REC_ACPO_CAT" type="string" default="">
	<cfproperty name="REC_ACPO_SUB" type="string" default="">
	<cfproperty name="REC_OFF_CODE" type="string" default="">
	<cfproperty name="REC_TITLE" type="string" default="">
	<cfproperty name="REP_WMC_CODE" type="string" default="">
	<cfproperty name="REP_HOMC_CODE" type="string" default="">
	<cfproperty name="REP_HOOC_CODE" type="string" default="">
	<cfproperty name="REP_ACPO_CAT" type="string" default="">
	<cfproperty name="REP_ACPO_SUB" type="string" default="">
	<cfproperty name="REP_OFF_CODE" type="string" default="">
	<cfproperty name="REP_TITLE" type="string" default="">
	<cfproperty name="FIRST_COMMITTED" type="date" default="">
	<cfproperty name="LAST_COMMITTED" type="date" default="">
	<cfproperty name="NCR_CODE" type="string" default="">
	<cfproperty name="REPORT_METHOD" type="string" default="">
	<cfproperty name="REPORT_DATE" type="date" default="">
	<cfproperty name="DETECTED_FLAG" type="numeric" default="0">
	<cfproperty name="CUC_CODE" type="numeric" default="0">
	<cfproperty name="CREATED_DATE" type="date" default="">
	<cfproperty name="VALIDATION_STATUS" type="string" default="">
	<cfproperty name="HO_REPORTED_DATE" type="date" default="">
	<cfproperty name="POST_CODE" type="string" default="">
	<cfproperty name="PREMISE_KEY" type="string" default="">
	<cfproperty name="LPA" type="string" default="">
	<cfproperty name="GRID_REF" type="string" default="">
	<cfproperty name="STATUS" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.CRIME_REF = 0;
		variables.ORG_CODE = "";
		variables.SERIAL_NO = "";
		variables.YEAR = 0;
		variables.BEAT_CODE = "";
		variables.INCIDENT_NO = "";
		variables.SOCO_REPORT_NO = "";
		variables.REC_WMC_CODE = "";
		variables.REC_HOMC_CODE = "";
		variables.REC_HOOC_CODE = "";
		variables.REC_ACPO_CAT = "";
		variables.REC_ACPO_SUB = "";
		variables.REC_OFF_CODE = "";
		variables.REC_TITLE = "";
		variables.REP_WMC_CODE = "";
		variables.REP_HOMC_CODE = "";
		variables.REP_HOOC_CODE = "";
		variables.REP_ACPO_CAT = "";
		variables.REP_ACPO_SUB = "";
		variables.REP_OFF_CODE = "";
		variables.REP_TITLE = "";
		variables.FIRST_COMMITTED = "";
		variables.LAST_COMMITTED = "";
		variables.NCR_CODE = "";
		variables.REPORT_METHOD = "";
		variables.REPORT_DATE = "";
		variables.DETECTED_FLAG = 0;
		variables.CUC_CODE = 0;
		variables.CREATED_DATE = "";
		variables.VALIDATION_STATUS = "";
		variables.HO_REPORTED_DATE = "";
		variables.POST_CODE = "";
		variables.PREMISE_KEY = "";
		variables.LPA = "";
		variables.GRID_REF = "";
		variables.STATUS = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="genieObj.offences.offence">
		<cfreturn this>
	</cffunction>
	<cffunction name="getCRIME_REF" output="false" access="public" returntype="any">
		<cfreturn variables.CRIME_REF>
	</cffunction>

	<cffunction name="setCRIME_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CRIME_REF = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getORG_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_CODE>
	</cffunction>

	<cffunction name="setORG_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORG_CODE = arguments.val>
	</cffunction>

	<cffunction name="getSERIAL_NO" output="false" access="public" returntype="any">
		<cfreturn variables.SERIAL_NO>
	</cffunction>

	<cffunction name="setSERIAL_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SERIAL_NO = arguments.val>
	</cffunction>

	<cffunction name="getYEAR" output="false" access="public" returntype="any">
		<cfreturn variables.YEAR>
	</cffunction>

	<cffunction name="setYEAR" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.YEAR = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getBEAT_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.BEAT_CODE>
	</cffunction>

	<cffunction name="setBEAT_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BEAT_CODE = arguments.val>
	</cffunction>

	<cffunction name="getINCIDENT_NO" output="false" access="public" returntype="any">
		<cfreturn variables.INCIDENT_NO>
	</cffunction>

	<cffunction name="setINCIDENT_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.INCIDENT_NO = arguments.val>
	</cffunction>

	<cffunction name="getSOCO_REPORT_NO" output="false" access="public" returntype="any">
		<cfreturn variables.SOCO_REPORT_NO>
	</cffunction>

	<cffunction name="setSOCO_REPORT_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SOCO_REPORT_NO = arguments.val>
	</cffunction>

	<cffunction name="getREC_WMC_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.REC_WMC_CODE>
	</cffunction>

	<cffunction name="setREC_WMC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REC_WMC_CODE = arguments.val>
	</cffunction>

	<cffunction name="getREC_HOMC_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.REC_HOMC_CODE>
	</cffunction>

	<cffunction name="setREC_HOMC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REC_HOMC_CODE = arguments.val>
	</cffunction>

	<cffunction name="getREC_HOOC_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.REC_HOOC_CODE>
	</cffunction>

	<cffunction name="setREC_HOOC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REC_HOOC_CODE = arguments.val>
	</cffunction>

	<cffunction name="getREC_ACPO_CAT" output="false" access="public" returntype="any">
		<cfreturn variables.REC_ACPO_CAT>
	</cffunction>

	<cffunction name="setREC_ACPO_CAT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REC_ACPO_CAT = arguments.val>
	</cffunction>

	<cffunction name="getREC_ACPO_SUB" output="false" access="public" returntype="any">
		<cfreturn variables.REC_ACPO_SUB>
	</cffunction>

	<cffunction name="setREC_ACPO_SUB" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REC_ACPO_SUB = arguments.val>
	</cffunction>

	<cffunction name="getREC_OFF_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.REC_OFF_CODE>
	</cffunction>

	<cffunction name="setREC_OFF_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REC_OFF_CODE = arguments.val>
	</cffunction>

	<cffunction name="getREC_TITLE" output="false" access="public" returntype="any">
		<cfreturn variables.REC_TITLE>
	</cffunction>

	<cffunction name="setREC_TITLE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REC_TITLE = arguments.val>
	</cffunction>

	<cffunction name="getREP_WMC_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.REP_WMC_CODE>
	</cffunction>

	<cffunction name="setREP_WMC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REP_WMC_CODE = arguments.val>
	</cffunction>

	<cffunction name="getREP_HOMC_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.REP_HOMC_CODE>
	</cffunction>

	<cffunction name="setREP_HOMC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REP_HOMC_CODE = arguments.val>
	</cffunction>

	<cffunction name="getREP_HOOC_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.REP_HOOC_CODE>
	</cffunction>

	<cffunction name="setREP_HOOC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REP_HOOC_CODE = arguments.val>
	</cffunction>

	<cffunction name="getREP_ACPO_CAT" output="false" access="public" returntype="any">
		<cfreturn variables.REP_ACPO_CAT>
	</cffunction>

	<cffunction name="setREP_ACPO_CAT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REP_ACPO_CAT = arguments.val>
	</cffunction>

	<cffunction name="getREP_ACPO_SUB" output="false" access="public" returntype="any">
		<cfreturn variables.REP_ACPO_SUB>
	</cffunction>

	<cffunction name="setREP_ACPO_SUB" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REP_ACPO_SUB = arguments.val>
	</cffunction>

	<cffunction name="getREP_OFF_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.REP_OFF_CODE>
	</cffunction>

	<cffunction name="setREP_OFF_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REP_OFF_CODE = arguments.val>
	</cffunction>

	<cffunction name="getREP_TITLE" output="false" access="public" returntype="any">
		<cfreturn variables.REP_TITLE>
	</cffunction>

	<cffunction name="setREP_TITLE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REP_TITLE = arguments.val>
	</cffunction>

	<cffunction name="getFIRST_COMMITTED" output="false" access="public" returntype="any">
		<cfreturn variables.FIRST_COMMITTED>
	</cffunction>

	<cffunction name="setFIRST_COMMITTED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.FIRST_COMMITTED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getLAST_COMMITTED" output="false" access="public" returntype="any">
		<cfreturn variables.LAST_COMMITTED>
	</cffunction>

	<cffunction name="setLAST_COMMITTED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.LAST_COMMITTED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getNCR_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.NCR_CODE>
	</cffunction>

	<cffunction name="setNCR_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NCR_CODE = arguments.val>
	</cffunction>

	<cffunction name="getREPORT_METHOD" output="false" access="public" returntype="any">
		<cfreturn variables.REPORT_METHOD>
	</cffunction>

	<cffunction name="setREPORT_METHOD" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REPORT_METHOD = arguments.val>
	</cffunction>

	<cffunction name="getREPORT_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.REPORT_DATE>
	</cffunction>

	<cffunction name="setREPORT_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.REPORT_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDETECTED_FLAG" output="false" access="public" returntype="any">
		<cfreturn variables.DETECTED_FLAG>
	</cffunction>

	<cffunction name="setDETECTED_FLAG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DETECTED_FLAG = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCUC_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.CUC_CODE>
	</cffunction>

	<cffunction name="setCUC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CUC_CODE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCREATED_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.CREATED_DATE>
	</cffunction>

	<cffunction name="setCREATED_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CREATED_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getVALIDATION_STATUS" output="false" access="public" returntype="any">
		<cfreturn variables.VALIDATION_STATUS>
	</cffunction>

	<cffunction name="setVALIDATION_STATUS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.VALIDATION_STATUS = arguments.val>
	</cffunction>

	<cffunction name="getHO_REPORTED_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.HO_REPORTED_DATE>
	</cffunction>

	<cffunction name="setHO_REPORTED_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.HO_REPORTED_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getPOST_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.POST_CODE>
	</cffunction>

	<cffunction name="setPOST_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.POST_CODE = arguments.val>
	</cffunction>

	<cffunction name="getPREMISE_KEY" output="false" access="public" returntype="any">
		<cfreturn variables.PREMISE_KEY>
	</cffunction>

	<cffunction name="setPREMISE_KEY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PREMISE_KEY = arguments.val>
	</cffunction>

	<cffunction name="getLPA" output="false" access="public" returntype="any">
		<cfreturn variables.LPA>
	</cffunction>

	<cffunction name="setLPA" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LPA = arguments.val>
	</cffunction>

	<cffunction name="getGRID_REF" output="false" access="public" returntype="any">
		<cfreturn variables.GRID_REF>
	</cffunction>

	<cffunction name="setGRID_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.GRID_REF = arguments.val>
	</cffunction>

	<cffunction name="getSTATUS" output="false" access="public" returntype="any">
		<cfreturn variables.STATUS>
	</cffunction>

	<cffunction name="setSTATUS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.STATUS = arguments.val>
	</cffunction>

	<cffunction name="getCRIMENO" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_CODE&"/"&variables.SERIAL_NO&"/"&variables.YEAR>
	</cffunction>

</cfcomponent>