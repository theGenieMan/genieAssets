<cfcomponent output="false">

<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="SERIAL_NO" type="string" default="">
	<cfproperty name="OCC_CODE" type="date" default="">
	<cfproperty name="OCC_CLASS" type="date" default="">
	<cfproperty name="OCCUPATION" type="date" default="">        
	<cfproperty name="OCCUPATION_DATE" type="date" default="">
	<cfproperty name="CURRENT_WORK_LOCATION" type="string" default="">
	<cfproperty name="ORG_TYPE_PROF_BODY" type="string" default="">
	<cfproperty name="ORG_CODE_PROF_BODY" type="string" default="">
	<cfproperty name="PROF_BODY" type="string" default="">    

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.NOMINAL_REF = "";
		variables.SERIAL_NO = "";
		variables.OCC_CODE = "";
		variables.OCC_CLASS = "";
		variables.OCCUPATION = "";
		variables.OCCUPATION_DATE = "";
		variables.CURRENT_WORK_LOCATION = "";
		variables.ORG_TYPE_PROF_BODY = "";
		variables.ORG_CODE_PROF_BODY = "";
		variables.PROF_BODY = "";				
	</cfscript>

	<cffunction name="init" output="false" returntype="misper">
		<cfreturn this>
	</cffunction>
    
	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getSERIAL_NO" output="false" access="public" returntype="any">
		<cfreturn variables.SERIAL_NO>
	</cffunction>

	<cffunction name="setSERIAL_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SERIAL_NO = arguments.val>
	</cffunction>

	<cffunction name="getOCC_CODE">
  		<cfreturn variables.OCC_CODE>      
	</cffunction>

	<cffunction name="setOCC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OCC_CODE = arguments.val>
	</cffunction>

	<cffunction name="getOCC_TYPE">
  		<cfreturn variables.OCC_TYPE>      
	</cffunction>

	<cffunction name="setOCC_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OCC_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getOCCPATION">
  		<cfreturn variables.OCCPATION>      
	</cffunction>

	<cffunction name="setOCCPATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OCCPATION = arguments.val>
	</cffunction>

	<cffunction name="getOCCUPATION_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.OCCUPATION_DATE>
	</cffunction>

	<cffunction name="setOCCUPATION_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.OCCUPATION_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getCURRENT_WORK_LOCATION" output="false" access="public" returntype="any">
		<cfreturn variables.CURRENT_WORK_LOCATION>
	</cffunction>

	<cffunction name="setCURRENT_WORK_LOCATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CURRENT_WORK_LOCATION = arguments.val>
	</cffunction>

	<cffunction name="getORG_TYPE_PROF_BODY" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_TYPE_PROF_BODY>
	</cffunction>

	<cffunction name="setORG_TYPE_PROF_BODY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORG_TYPE_PROF_BODY = arguments.val>
	</cffunction>

	<cffunction name="getORG_CODE_PROF_BODY" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_CODE_PROF_BODY>
	</cffunction>

	<cffunction name="setORG_CODE_PROF_BODY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OIC_DEALING = arguments.val>
	</cffunction>

	<cffunction name="getPROF_BODY" output="false" access="public" returntype="any">
		<cfreturn variables.PROF_BODY>
	</cffunction>

	<cffunction name="setPROF_BODY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PROF_BODY = arguments.val>
	</cffunction>

</cfcomponent>