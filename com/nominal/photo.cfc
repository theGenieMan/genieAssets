<cfcomponent output="false" alias="genieObj.nominal.photo">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="AS_NUM" type="string" default="0">
	<cfproperty name="AS_REF" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="date" default="">
	<cfproperty name="CREATION_DATE" type="string" default="">
	<cfproperty name="DATE_PHOTO_AND_FPRINTS" type="string" default="">
	<cfproperty name="PHOTO_AVAILABLE" type="string" default="">
	<cfproperty name="PHOTO_URL" type="string" default="">    
	<cfproperty name="SYSTEM_ID" type="string" default="">    

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.AS_NUM = "";
		variables.AS_REF = "";		
		variables.NOMINAL_REF = "";
		variables.CREATION_DATE = "";
		variables.DATE_PHOTO_AND_FPRINTS = "";
		variables.PHOTO_AVAILABLE = "";
		variables.PHOTO_URL = "";
		variables.SYSTEM_ID = "";				
	</cfscript>

	<cffunction name="init" output="false" returntype="genieObj.nominal.photo">
		<cfreturn this>
	</cffunction>
	<cffunction name="getAS_NUM" output="false" access="public" returntype="any">
		<cfreturn variables.AS_NUM>
	</cffunction>

	<cffunction name="setAS_NUM" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.AS_NUM = arguments.val>
	</cffunction>

	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getAS_REF" output="false" access="public" returntype="any">
		<cfreturn variables.AS_REF>
	</cffunction>

	<cffunction name="setAS_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.AS_REF = arguments.val>
	</cffunction>

	<cffunction name="getCREATION_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.CREATION_DATE>
	</cffunction>

	<cffunction name="setCREATION_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CREATION_DATE = arguments.val>
	</cffunction>

	<cffunction name="getDatePhotoTaken" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.CREATION_DATE,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="getDATE_PHOTO_AND_FPRINTS" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_PHOTO_AND_FPRINTS>
	</cffunction>

	<cffunction name="setDATE_PHOTO_AND_FPRINTS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DATE_PHOTO_AND_FPRINTS = arguments.val>
	</cffunction>

	<cffunction name="getPHOTO_AVAILABLE" output="false" access="public" returntype="any">
		<cfreturn variables.PHOTO_AVAILABLE>
	</cffunction>

	<cffunction name="setPHOTO_AVAILABLE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PHOTO_AVAILABLE = arguments.val>
	</cffunction>

	<cffunction name="getPHOTO_URL" output="false" access="public" returntype="any">
		<cfreturn variables.PHOTO_URL>
	</cffunction>
    
	<cffunction name="setPHOTO_URL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PHOTO_URL = arguments.val>
	</cffunction>     
   
	<cffunction name="getSYSTEM_ID" output="false" access="public" returntype="any">
		<cfreturn variables.SYSTEM_ID>
	</cffunction>

	<cffunction name="setSYSTEM_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SYSTEM_ID = arguments.val>
	</cffunction>    

	<cffunction name="dump" output="false" access="public" returntype="any">
        <cfset var dump="">
        
        <cfoutput>
        <cfsavecontent variable="dump">
         AS Ref=#getAs_Ref()#<br>
         AS Num=#getAs_Num()#<br>
         Nominal Ref=#getNOMINAL_REF()#<Br>
         Date Photo=#getDatePhotoTaken()#<Br>
         Available=#getPHOTO_AVAILABLE()#<Br>
         URL=#getPHOTO_URL()#<br>
        </cfsavecontent>
        </cfoutput>
        
		<cfreturn dump>
	</cffunction>

</cfcomponent>