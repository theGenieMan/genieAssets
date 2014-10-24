<cfcomponent output="false" alias="genieObj.property.property">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="PROPERTY_REF" type="string" default="">
	<cfproperty name="CRIME_REF" type="numeric" default="0">
	<cfproperty name="CATEGORY" type="string" default="">
	<cfproperty name="SUB_CATEGORY" type="string" default="">
	<cfproperty name="SUB_TYPE" type="string" default="">
	<cfproperty name="MANUFACTURER" type="string" default="">
	<cfproperty name="MODEL" type="string" default="">
	<cfproperty name="IDENTIFIABLE" type="string" default="">
	<cfproperty name="CARD_NUMBER" type="string" default="">
	<cfproperty name="CARD_EXPIRY" type="string" default="">
	<cfproperty name="CHEQUE_NUMBERS" type="string" default="">
	<cfproperty name="CRIME_FIRST_DATE" type="date" default="">
	<cfproperty name="PREMISE_KEY" type="string" default="">
	<cfproperty name="ORG_CODE_BEAT" type="string" default="">
	<cfproperty name="CRIME_LAST_DATE" type="date" default="">
	<cfproperty name="OTHER_MARKS" type="string" default="">
	<cfproperty name="NOTES" type="string" default="">
	<cfproperty name="MAN_SERIAL_NUMBER" type="string" default="">
	<cfproperty name="MAN_ID" type="string" default="">
	<cfproperty name="NO_OF_GEARS" type="numeric" default="0">
	<cfproperty name="GT_CODE" type="string" default="">
	<cfproperty name="FT_CODE" type="string" default="">
	<cfproperty name="FRAME_NUMBER" type="string" default="">
	<cfproperty name="VRM" type="string" default="">
	<cfproperty name="REG_COUNTRY" type="string" default="">
	<cfproperty name="ENGINE_CAPACITY" type="numeric" default="0">
	<cfproperty name="ENGINE_NUMBER" type="string" default="">
	<cfproperty name="CHASSIS_NUMBER" type="string" default="">
	<cfproperty name="UNLADEN_WEIGHT" type="numeric" default="0">
	<cfproperty name="DOCUMENT_NAME" type="string" default="">
	<cfproperty name="DOCUMENT_NUMBER" type="string" default="">
	<cfproperty name="BANK_SORT_CODE" type="string" default="">
	<cfproperty name="OFF_ORG_CODE" type="string" default="">
	<cfproperty name="OFF_SERIAL_NO" type="string" default="">
	<cfproperty name="OFF_YEAR" type="numeric" default="0">
	<cfproperty name="OFF_CREATED_DATE" type="date" default="">
	<cfproperty name="POST_CODE" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.PROPERTY_REF = "";
		variables.CRIME_REF = 0;
		variables.CATEGORY = "";
		variables.SUB_CATEGORY = "";
		variables.SUB_TYPE = "";
		variables.MANUFACTURER = "";
		variables.MODEL = "";
		variables.IDENTIFIABLE = "";
		variables.CARD_NUMBER = "";
		variables.CARD_EXPIRY = "";
		variables.CHEQUE_NUMBERS = "";
		variables.CRIME_FIRST_DATE = "";
		variables.PREMISE_KEY = "";
		variables.ORG_CODE_BEAT = "";
		variables.CRIME_LAST_DATE = "";
		variables.OTHER_MARKS = "";
		variables.NOTES = "";
		variables.MAN_SERIAL_NUMBER = "";
		variables.MAN_ID = "";
		variables.NO_OF_GEARS = 0;
		variables.GT_CODE = "";
		variables.FT_CODE = "";
		variables.FRAME_NUMBER = "";
		variables.VRM = "";
		variables.REG_COUNTRY = "";
		variables.ENGINE_CAPACITY = 0;
		variables.ENGINE_NUMBER = "";
		variables.CHASSIS_NUMBER = "";
		variables.UNLADEN_WEIGHT = 0;
		variables.DOCUMENT_NAME = "";
		variables.DOCUMENT_NUMBER = "";
		variables.BANK_SORT_CODE = "";
		variables.OFF_ORG_CODE = "";
		variables.OFF_SERIAL_NO = "";
		variables.OFF_YEAR = 0;
		variables.OFF_CREATED_DATE = "";
		variables.POST_CODE = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="PROPERTY">
		<cfreturn this>
	</cffunction>
	<cffunction name="getPROPERTY_REF" output="false" access="public" returntype="any">
		<cfreturn variables.PROPERTY_REF>
	</cffunction>

	<cffunction name="setPROPERTY_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PROPERTY_REF = arguments.val>
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

	<cffunction name="getCATEGORY" output="false" access="public" returntype="any">
		<cfreturn variables.CATEGORY>
	</cffunction>

	<cffunction name="setCATEGORY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CATEGORY = arguments.val>
	</cffunction>

	<cffunction name="getSUB_CATEGORY" output="false" access="public" returntype="any">
		<cfreturn variables.SUB_CATEGORY>
	</cffunction>

	<cffunction name="setSUB_CATEGORY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SUB_CATEGORY = arguments.val>
	</cffunction>

	<cffunction name="getSUB_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.SUB_TYPE>
	</cffunction>

	<cffunction name="setSUB_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SUB_TYPE = arguments.val>
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

	<cffunction name="getIDENTIFIABLE" output="false" access="public" returntype="any">
		<cfreturn variables.IDENTIFIABLE>
	</cffunction>

	<cffunction name="setIDENTIFIABLE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.IDENTIFIABLE = arguments.val>
	</cffunction>

	<cffunction name="getCARD_NUMBER" output="false" access="public" returntype="any">
		<cfreturn variables.CARD_NUMBER>
	</cffunction>

	<cffunction name="setCARD_NUMBER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CARD_NUMBER = arguments.val>
	</cffunction>

	<cffunction name="getCARD_EXPIRY" output="false" access="public" returntype="any">
		<cfreturn variables.CARD_EXPIRY>
	</cffunction>

	<cffunction name="setCARD_EXPIRY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CARD_EXPIRY = arguments.val>
	</cffunction>

	<cffunction name="getCHEQUE_NUMBERS" output="false" access="public" returntype="any">
		<cfreturn variables.CHEQUE_NUMBERS>
	</cffunction>

	<cffunction name="setCHEQUE_NUMBERS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CHEQUE_NUMBERS = arguments.val>
	</cffunction>

	<cffunction name="getCRIME_FIRST_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.CRIME_FIRST_DATE>
	</cffunction>

	<cffunction name="setCRIME_FIRST_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CRIME_FIRST_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getPREMISE_KEY" output="false" access="public" returntype="any">
		<cfreturn variables.PREMISE_KEY>
	</cffunction>

	<cffunction name="setPREMISE_KEY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PREMISE_KEY = arguments.val>
	</cffunction>

	<cffunction name="getORG_CODE_BEAT" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_CODE_BEAT>
	</cffunction>

	<cffunction name="setORG_CODE_BEAT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORG_CODE_BEAT = arguments.val>
	</cffunction>

	<cffunction name="getCRIME_LAST_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.CRIME_LAST_DATE>
	</cffunction>

	<cffunction name="setCRIME_LAST_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CRIME_LAST_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getOTHER_MARKS" output="false" access="public" returntype="any">
		<cfreturn variables.OTHER_MARKS>
	</cffunction>

	<cffunction name="setOTHER_MARKS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OTHER_MARKS = arguments.val>
	</cffunction>

	<cffunction name="getNOTES" output="false" access="public" returntype="any">
		<cfreturn variables.NOTES>
	</cffunction>

	<cffunction name="setNOTES" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOTES = arguments.val>
	</cffunction>

	<cffunction name="getMAN_SERIAL_NUMBER" output="false" access="public" returntype="any">
		<cfreturn variables.MAN_SERIAL_NUMBER>
	</cffunction>

	<cffunction name="setMAN_SERIAL_NUMBER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MAN_SERIAL_NUMBER = arguments.val>
	</cffunction>

	<cffunction name="getMAN_ID" output="false" access="public" returntype="any">
		<cfreturn variables.MAN_ID>
	</cffunction>

	<cffunction name="setMAN_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MAN_ID = arguments.val>
	</cffunction>

	<cffunction name="getNO_OF_GEARS" output="false" access="public" returntype="any">
		<cfreturn variables.NO_OF_GEARS>
	</cffunction>

	<cffunction name="setNO_OF_GEARS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.NO_OF_GEARS = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getGT_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.GT_CODE>
	</cffunction>

	<cffunction name="setGT_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.GT_CODE = arguments.val>
	</cffunction>

	<cffunction name="getFT_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.FT_CODE>
	</cffunction>

	<cffunction name="setFT_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FT_CODE = arguments.val>
	</cffunction>

	<cffunction name="getFRAME_NUMBER" output="false" access="public" returntype="any">
		<cfreturn variables.FRAME_NUMBER>
	</cffunction>

	<cffunction name="setFRAME_NUMBER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FRAME_NUMBER = arguments.val>
	</cffunction>

	<cffunction name="getVRM" output="false" access="public" returntype="any">
		<cfreturn variables.VRM>
	</cffunction>

	<cffunction name="setVRM" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.VRM = arguments.val>
	</cffunction>

	<cffunction name="getREG_COUNTRY" output="false" access="public" returntype="any">
		<cfreturn variables.REG_COUNTRY>
	</cffunction>

	<cffunction name="setREG_COUNTRY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REG_COUNTRY = arguments.val>
	</cffunction>

	<cffunction name="getENGINE_CAPACITY" output="false" access="public" returntype="any">
		<cfreturn variables.ENGINE_CAPACITY>
	</cffunction>

	<cffunction name="setENGINE_CAPACITY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ENGINE_CAPACITY = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getENGINE_NUMBER" output="false" access="public" returntype="any">
		<cfreturn variables.ENGINE_NUMBER>
	</cffunction>

	<cffunction name="setENGINE_NUMBER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ENGINE_NUMBER = arguments.val>
	</cffunction>

	<cffunction name="getCHASSIS_NUMBER" output="false" access="public" returntype="any">
		<cfreturn variables.CHASSIS_NUMBER>
	</cffunction>

	<cffunction name="setCHASSIS_NUMBER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CHASSIS_NUMBER = arguments.val>
	</cffunction>

	<cffunction name="getUNLADEN_WEIGHT" output="false" access="public" returntype="any">
		<cfreturn variables.UNLADEN_WEIGHT>
	</cffunction>

	<cffunction name="setUNLADEN_WEIGHT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.UNLADEN_WEIGHT = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDOCUMENT_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.DOCUMENT_NAME>
	</cffunction>

	<cffunction name="setDOCUMENT_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DOCUMENT_NAME = arguments.val>
	</cffunction>

	<cffunction name="getDOCUMENT_NUMBER" output="false" access="public" returntype="any">
		<cfreturn variables.DOCUMENT_NUMBER>
	</cffunction>

	<cffunction name="setDOCUMENT_NUMBER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DOCUMENT_NUMBER = arguments.val>
	</cffunction>

	<cffunction name="getBANK_SORT_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.BANK_SORT_CODE>
	</cffunction>

	<cffunction name="setBANK_SORT_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BANK_SORT_CODE = arguments.val>
	</cffunction>

	<cffunction name="getOFF_ORG_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.OFF_ORG_CODE>
	</cffunction>

	<cffunction name="setOFF_ORG_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OFF_ORG_CODE = arguments.val>
	</cffunction>

	<cffunction name="getOFF_SERIAL_NO" output="false" access="public" returntype="any">
		<cfreturn variables.OFF_SERIAL_NO>
	</cffunction>

	<cffunction name="setOFF_SERIAL_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OFF_SERIAL_NO = arguments.val>
	</cffunction>

	<cffunction name="getOFF_YEAR" output="false" access="public" returntype="any">
		<cfreturn variables.OFF_YEAR>
	</cffunction>

	<cffunction name="setOFF_YEAR" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.OFF_YEAR = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getOFF_CREATED_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.OFF_CREATED_DATE>
	</cffunction>

	<cffunction name="setOFF_CREATED_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.OFF_CREATED_DATE = arguments.val>
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



</cfcomponent>