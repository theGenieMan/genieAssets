<cfcomponent output="false" alias="genieObj.nominal.warnings">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="RISK_REF" type="numeric" default="0">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="DATE_MARKED" type="date" default="">
	<cfproperty name="END_DATE" type="date" default="">    
	<cfproperty name="WSC_CODE" type="string" default="">
	<cfproperty name="WSC_DESC" type="string" default="">
	<cfproperty name="WS_NOTE" type="string" default="">
	<cfproperty name="FS_CODE" type="string" default="">	
	<cfproperty name="SUB_TYPE" type="string" default="">		

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.RISK_REF = 0;
		variables.NOMINAL_REF = "";
		variables.DATE_MARKED = "";
		variables.END_DATE = "";
		variables.WSC_CODE = "";
		variables.WSC_DESC = "";
		variables.WS_NOTE = "";
		variables.FS_CODE = "";		
		variables.SUB_TYPE = "";				
	</cfscript>

	<cffunction name="init" output="false" returntype="genieObj.nominal.warnings">
		<cfreturn this>
	</cffunction>
	<cffunction name="getRISK_REF" output="false" access="public" returntype="any">
		<cfreturn variables.RISK_REF>
	</cffunction>

	<cffunction name="setRISK_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RISK_REF = arguments.val>
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

	<cffunction name="getDATE_MARKED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_MARKED>
	</cffunction>

	<cffunction name="getDATE_MARKED_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_MARKED,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="setDATE_MARKED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_MARKED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getEND_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.END_DATE>
	</cffunction>
	
	<cffunction name="getEND_DATE_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.END_DATE,"DD/MM/YYYY")>
	</cffunction>	

	<cffunction name="setEND_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.END_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getWSC_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.WSC_CODE>
	</cffunction>

	<cffunction name="setWSC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.WSC_CODE = arguments.val>
	</cffunction>

	<cffunction name="getWSC_DESC" output="false" access="public" returntype="any">
		<cfreturn variables.WSC_DESC>
	</cffunction>

	<cffunction name="setWSC_DESC" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.WSC_DESC = arguments.val>
	</cffunction>

	<cffunction name="getWS_NOTE" output="false" access="public" returntype="any">
		<cfreturn variables.WS_NOTE>
	</cffunction>

	<cffunction name="setWS_NOTE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.WS_NOTE = arguments.val>
	</cffunction>

	<cffunction name="getFS_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.FS_CODE>
	</cffunction>

	<cffunction name="setFS_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FS_CODE = arguments.val>
	</cffunction>

	<cffunction name="getSUB_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.SUB_TYPE>
	</cffunction>

	<cffunction name="setSUB_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SUB_TYPE = arguments.val>
	</cffunction>

</cfcomponent>