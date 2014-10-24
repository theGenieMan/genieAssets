<cfcomponent output="false" alias="genieObj.addresses.address">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="POST_CODE" type="string" default="">
	<cfproperty name="PREMISE_KEY" type="string" default="">
	<cfproperty name="FULL_ADDRESS" type="string" default="">
	<cfproperty name="PART_ID" type="string" default="">
	<cfproperty name="BUILDING_NUMBER" type="string" default="">
	<cfproperty name="BUILDING_NAME" type="string" default="">
	<cfproperty name="STREET_1" type="string" default="">
	<cfproperty name="STREET_2" type="string" default="">
	<cfproperty name="LOCALITY" type="string" default="">
	<cfproperty name="TOWN" type="string" default="">
	<cfproperty name="COUNTY" type="string" default="">
	<cfproperty name="OFFENCE_COUNT" type="numeric" default="0">
	<cfproperty name="NOMINAL_COUNT" type="numeric" default="0">
	<cfproperty name="INTEL_COUNT" type="numeric" default="0">
	<cfproperty name="INCIDENT_COUNT" type="numeric" default="0">
	<cfproperty name="ORG_COUNT" type="numeric" default="0">
	<cfproperty name="LPA" type="string" default="">
	<cfproperty name="GRID" type="string" default="">
	<cfproperty name="UPDATE_TIME" type="date" default="">
	<cfproperty name="APP_REF" type="string" default="">    
	<cfproperty name="FORCE_REF" type="string" default="">
	<cfproperty name="SYS_REF" type="string" default="">        

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.POST_CODE = "";
		variables.PREMISE_KEY = "";
		variables.FULL_ADDRESS = "";
		variables.PART_ID = "";
		variables.BUILDING_NUMBER = "";
		variables.BUILDING_NAME = "";
		variables.STREET_1 = "";
		variables.STREET_2 = "";
		variables.LOCALITY = "";
		variables.TOWN = "";
		variables.COUNTY = "";
		variables.OFFENCE_COUNT = 0;
		variables.NOMINAL_COUNT = 0;
		variables.INTEL_COUNT = 0;
		variables.INCIDENT_COUNT = 0;
		variables.ORG_COUNT = 0;
		variables.LPA = "";
		variables.GRID = "";
		variables.UPDATE_TIME = "";
		variables.APP_REF = "";
		variables.FORCE_REF = "";
		variables.SYS_REF = "";				
	</cfscript>

	<cffunction name="init" output="false" returntype="genieObj.addresses.address">
		<cfreturn this>
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

	<cffunction name="getPART_ID" output="false" access="public" returntype="any">
		<cfreturn variables.PART_ID>
	</cffunction>

	<cffunction name="setPART_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PART_ID = arguments.val>
	</cffunction>

	<cffunction name="getBUILDING_NUMBER" output="false" access="public" returntype="any">
		<cfreturn variables.BUILDING_NUMBER>
	</cffunction>

	<cffunction name="setBUILDING_NUMBER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BUILDING_NUMBER = arguments.val>
	</cffunction>

	<cffunction name="getBUILDING_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.BUILDING_NAME>
	</cffunction>

	<cffunction name="setBUILDING_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BUILDING_NAME = arguments.val>
	</cffunction>

	<cffunction name="getSTREET_1" output="false" access="public" returntype="any">
		<cfreturn variables.STREET_1>
	</cffunction>

	<cffunction name="setSTREET_1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.STREET_1 = arguments.val>
	</cffunction>

	<cffunction name="getSTREET_2" output="false" access="public" returntype="any">
		<cfreturn variables.STREET_2>
	</cffunction>

	<cffunction name="setSTREET_2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.STREET_2 = arguments.val>
	</cffunction>

	<cffunction name="getLOCALITY" output="false" access="public" returntype="any">
		<cfreturn variables.LOCALITY>
	</cffunction>

	<cffunction name="setLOCALITY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LOCALITY = arguments.val>
	</cffunction>

	<cffunction name="getTOWN" output="false" access="public" returntype="any">
		<cfreturn variables.TOWN>
	</cffunction>

	<cffunction name="setTOWN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TOWN = arguments.val>
	</cffunction>

	<cffunction name="getCOUNTY" output="false" access="public" returntype="any">
		<cfreturn variables.COUNTY>
	</cffunction>

	<cffunction name="setCOUNTY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.COUNTY = arguments.val>
	</cffunction>

	<cffunction name="getOFFENCE_COUNT" output="false" access="public" returntype="any">
		<cfreturn variables.OFFENCE_COUNT>
	</cffunction>

	<cffunction name="setOFFENCE_COUNT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.OFFENCE_COUNT = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getNOMINAL_COUNT" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_COUNT>
	</cffunction>

	<cffunction name="setNOMINAL_COUNT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.NOMINAL_COUNT = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getINTEL_COUNT" output="false" access="public" returntype="any">
		<cfreturn variables.INTEL_COUNT>
	</cffunction>

	<cffunction name="setINTEL_COUNT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.INTEL_COUNT = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getINCIDENT_COUNT" output="false" access="public" returntype="any">
		<cfreturn variables.INCIDENT_COUNT>
	</cffunction>

	<cffunction name="setINCIDENT_COUNT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.INCIDENT_COUNT = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getORG_COUNT" output="false" access="public" returntype="any">
		<cfreturn variables.ORG_COUNT>
	</cffunction>

	<cffunction name="setORG_COUNT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ORG_COUNT = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getLPA" output="false" access="public" returntype="any">
		<cfreturn variables.LPA>
	</cffunction>

	<cffunction name="setLPA" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LPA = arguments.val>
	</cffunction>

	<cffunction name="getGRID" output="false" access="public" returntype="any">
		<cfreturn variables.GRID>
	</cffunction>

	<cffunction name="setGRID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.GRID = arguments.val>
	</cffunction>

	<cffunction name="getUPDATE_TIME" output="false" access="public" returntype="any">
		<cfreturn variables.UPDATE_TIME>
	</cffunction>

	<cffunction name="setUPDATE_TIME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.UPDATE_TIME = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getFULL_ADDRESS" output="false" access="public" returntype="any">
	   <!---
       <cfif Len(variables.PART_ID) GT 0>
        <cfset variables.FULL_ADDRESS=ListAppend(variables.FULL_ADDRESS,variables.PART_ID,",")>
       </cfif>
       <cfif Len(variables.BUILDING_NAME) GT 0>
        <cfset variables.FULL_ADDRESS=ListAppend(variables.FULL_ADDRESS,variables.BUILDING_NAME,",")>
       </cfif>       
       <cfif Len(variables.BUILDING_NUMBER) GT 0>
        <cfset variables.FULL_ADDRESS=ListAppend(variables.FULL_ADDRESS,variables.BUILDING_NUMBER,",")>
       </cfif>       
       <cfif Len(variables.STREET_1) GT 0>
        <cfset variables.FULL_ADDRESS=ListAppend(variables.FULL_ADDRESS,variables.STREET_1,",")>
       </cfif>       
       <cfif Len(variables.LOCALITY) GT 0>
        <cfset variables.FULL_ADDRESS=ListAppend(variables.FULL_ADDRESS,variables.LOCALITY,",")>
       </cfif>                     
       <cfif Len(variables.TOWN) GT 0>
        <cfset variables.FULL_ADDRESS=ListAppend(variables.FULL_ADDRESS,variables.TOWN,",")>
       </cfif>                     
       <cfif Len(variables.COUNTY) GT 0>
        <cfset variables.FULL_ADDRESS=ListAppend(variables.FULL_ADDRESS,variables.COUNTY,",")>
       </cfif>                     
       <cfif Len(variables.POST_CODE) GT 0>
        <cfset variables.FULL_ADDRESS=ListAppend(variables.FULL_ADDRESS,variables.POST_CODE,",")>
       </cfif>      --->               
       
  	 <cfreturn variables.FULL_ADDRESS>
	</cffunction>

	<cffunction name="setFULL_ADDRESS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FULL_ADDRESS = arguments.val>
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
    
	<cffunction name="getSYS_REF" output="false" access="public" returntype="any">
		<cfreturn variables.SYS_REF>
	</cffunction>

	<cffunction name="setSYS_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SYS_REF = arguments.val>
	</cffunction>  

</cfcomponent>