<cfcomponent output="false" alias="genieObj.nfmls.address">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
    
    
Column Name	ID	Pk	Null?	Data Type	Default	Histogram	Encryption Alg	Salt

ADDRESS_ID	1		N	VARCHAR2 (10 Byte)		None		
PERSON_URN	2		N	VARCHAR2 (30 Byte)		None		
ADDRESS_TYPE	3		N	VARCHAR2 (2 Byte)		None		
LINE_1	4		N	VARCHAR2 (32 Byte)		None		
LINE_2	5		Y	VARCHAR2 (32 Byte)		None		
LINE_3	6		Y	VARCHAR2 (32 Byte)		None		
LINE_4	7		Y	VARCHAR2 (32 Byte)		None		
LINE_5	8		Y	VARCHAR2 (32 Byte)		None		
LINE_6	9		Y	VARCHAR2 (32 Byte)		None		
POSTCODE	10		Y	VARCHAR2 (8 Byte)		None		
ADD_POINT_REF	11		Y	VARCHAR2 (20 Byte)		None		
GRIDREF	12		Y	VARCHAR2 (13 Byte)		None		
TEL_NO	13		Y	VARCHAR2 (27 Byte)		None		
SECURITY_TYPE	14		Y	VARCHAR2 (200 Byte)		None		
SECURITY_LOCATION	15		Y	VARCHAR2 (4000 Byte)		None		
    
    
	<cfproperty name="ADDRESS_ID" type="string" default="">
	<cfproperty name="PERSON_URN" type="string" default="">
	<cfproperty name="ADDRESS_TYPE" type="string" default="">
	<cfproperty name="LINE_1" type="string" default="">
	<cfproperty name="LINE_2" type="string" default="">
	<cfproperty name="LINE_3" type="string" default="">
	<cfproperty name="LINE_4" type="string" default="">
	<cfproperty name="LINE_5" type="string" default="">
	<cfproperty name="LINE_6" type="string" default="">                    
	<cfproperty name="POSTCODE" type="date" default="">
	<cfproperty name="ADD_POINT_REF" type="string" default="">
	<cfproperty name="GRID_REF" type="string" default="">
	<cfproperty name="TEL_NO" type="string" default="">
	<cfproperty name="SECURITY_TYPE" type="string" default="">
	<cfproperty name="SECURITY_LOCATION" type="string" default="">


	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.ADDRESS_ID = "";
		variables.PERSON_URN = "";
		variables.ADDRESS_TYPE = "";
		variables.LINE_1 = "";
		variables.LINE_2 = "";
		variables.LINE_3 = "";
		variables.LINE_4 = "";
		variables.LINE_5 = "";
		variables.LINE_6 = "";										
		variables.POSTCODE = "";
		variables.ADD_POINT_REF = "";
		variables.GRID_REF = "";
		variables.TEL_NO = "";
		variables.SECURITY_TYPE = "";
		variables.SECURITY_LOCATION = "";				
	</cfscript>

	<cffunction name="init" output="false" returntype="genieObj.nflms.person">
		<cfreturn this>
	</cffunction>
	<cffunction name="getADDRESS_ID" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS_ID>
	</cffunction>

	<cffunction name="setADDRESS_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS_ID = arguments.val>
	</cffunction>

	<cffunction name="getPERSON_URN" output="false" access="public" returntype="any">
		<cfreturn variables.PERSON_URN>
	</cffunction>

	<cffunction name="setPERSON_URN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PERSON_URN = arguments.val>
	</cffunction>

	<cffunction name="getADDRESS_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.ADDRESS_TYPE>
	</cffunction>

	<cffunction name="setADDRESS_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADDRESS_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getLINE_1" output="false" access="public" returntype="any">
		<cfreturn variables.LINE_1>
	</cffunction>

	<cffunction name="setLINE_1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LINE_1 = arguments.val>
	</cffunction>
    
	<cffunction name="getLINE_2" output="false" access="public" returntype="any">
		<cfreturn variables.LINE_2>
	</cffunction>

	<cffunction name="setLINE_2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LINE_2 = arguments.val>
	</cffunction>    
    
	<cffunction name="getLINE_3" output="false" access="public" returntype="any">
		<cfreturn variables.LINE_3>
	</cffunction>

	<cffunction name="setLINE_3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LINE_3 = arguments.val>
	</cffunction>    

	<cffunction name="getLINE_4" output="false" access="public" returntype="any">
		<cfreturn variables.LINE_4>
	</cffunction>

	<cffunction name="setLINE_4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LINE_4 = arguments.val>
	</cffunction>
    
	<cffunction name="getLINE_5" output="false" access="public" returntype="any">
		<cfreturn variables.LINE_5>
	</cffunction>

	<cffunction name="setLINE_5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LINE_5 = arguments.val>
	</cffunction>    
    
	<cffunction name="getLINE_6" output="false" access="public" returntype="any">
		<cfreturn variables.LINE_6>
	</cffunction>

	<cffunction name="setLINE_6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LINE_6 = arguments.val>
	</cffunction>    

	<cffunction name="getPOSTCODE" output="false" access="public" returntype="any">
		<cfreturn variables.POSTCODE>
	</cffunction>

	<cffunction name="setPOSTCODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.POSTCODE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getADD_POINT_REF" output="false" access="public" returntype="any">
		<cfreturn variables.ADD_POINT_REF>
	</cffunction>

	<cffunction name="setADD_POINT_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ADD_POINT_REF = arguments.val>
	</cffunction>

	<cffunction name="getGRID_REF" output="false" access="public" returntype="any">
		<cfreturn variables.GRID_REF>
	</cffunction>

	<cffunction name="setGRID_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.GRID_REF = arguments.val>
	</cffunction>

	<cffunction name="getTEL_NO" output="false" access="public" returntype="any">
		<cfreturn variables.TEL_NO>
	</cffunction>

	<cffunction name="setTEL_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TEL_NO = arguments.val>
	</cffunction>
    
	<cffunction name="getSECURITY_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.SECURITY_TYPE>
	</cffunction>

	<cffunction name="setSECURITY_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SECURITY_TYPE = arguments.val>
	</cffunction>    

	<cffunction name="getSECURITY_LOCATION" output="false" access="public" returntype="any">
		<cfreturn variables.SECURITY_LOCATION>
	</cffunction>

	<cffunction name="setSECURITY_LOCATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SECURITY_LOCATION = arguments.val>
	</cffunction>    

</cfcomponent>