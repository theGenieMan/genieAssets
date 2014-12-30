<cfcomponent output="false" alias="custody">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="CUSTODY_REF" type="string" default="">     
	<cfproperty name="STATION" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="NAME" type="string" default="">
	<cfproperty name="SEX" type="string" default="">
	<cfproperty name="DOB" type="date" default="">
	<cfproperty name="ETHNIC_APP" type="string" default="">
	<cfproperty name="ARREST_TIME" type="date" default="">
	<cfproperty name="AO_FORCE" type="string" default="">
	<cfproperty name="AO_BADGE" type="string" default="">
	<cfproperty name="AO_STATION" type="string" default="">
	<cfproperty name="OIC_FORCE" type="string" default="">
	<cfproperty name="OIC_BADGE" type="string" default="">
	<cfproperty name="OIC_STATION" type="string" default="">
	<cfproperty name="ORIG_CUSTODY" type="string" default="">
	<cfproperty name="DEPARTURE_TIME" type="date" default="">
	<cfproperty name="BAIL_ANSWERED" type="string" default="">
	<cfproperty name="CREATION_DATE" type="date" default="">
	<cfproperty name="CUSTODY_TYPE" type="string" default="">
	<cfproperty name="ARREST_SUMMONS_NO" type="string" default="">
	<cfproperty name="AO_NAME" type="string" default="">
	<cfproperty name="OIC_NAME" type="string" default="">
	<cfproperty name="RIGHTS" type="string" default="">
	<cfproperty name="CHARGED" type="string" default="">
	<cfproperty name="BAIL_CANC_REASON" type="string" default="">
	<cfproperty name="NEXT_REVIEW_DATE" type="date" default="">
	<cfproperty name="REVIEW_RANK" type="string" default="">
	<cfproperty name="DETAIN_UNTIL" type="date" default="">
	<cfproperty name="STATUS" type="string" default="">
	<cfproperty name="CELL" type="string" default="">
	<cfproperty name="PLACE_OF_ARREST" type="string" default="">    
    <cfproperty name="custodyReasons" type="genieObj.custody.custodyReason[]" default="ArrayNew(1)">
    <cfproperty name="custodyDepartures" type="genieObj.custody.custodyDepartures[]" default="ArrayNew(1)">  
	<cfproperty name="nominal" type="genieObj.nominal.nominal" default="">  

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.CUSTODY_REF = "";	
		variables.STATION = "";
		variables.NOMINAL_REF = "";
		variables.NAME = "";
		variables.SEX = "";
		variables.DOB = "";
		variables.ETHNIC_APP = "";
		variables.ARREST_TIME = "";
		variables.AO_FORCE = "";
		variables.AO_BADGE = "";
		variables.AO_STATION = "";
		variables.OIC_FORCE = "";
		variables.OIC_BADGE = "";
		variables.OIC_STATION = "";
		variables.ORIG_CUSTODY = "";
		variables.DEPARTURE_TIME = "";
		variables.BAIL_ANSWERED = "";
		variables.CREATION_DATE = "";
		variables.CUSTODY_TYPE = "";
		variables.ARREST_SUMMONS_NO = "";
		variables.CUSTODY_REF = "";
		variables.AO_NAME = "";
		variables.OIC_NAME = "";
		variables.RIGHTS = "";
		variables.CHARGED = "";
		variables.BAIL_CANC_REASON = "";
		variables.NEXT_REVIEW_DATE = "";
		variables.REVIEW_RANK = "";
		variables.DETAIN_UNTIL = "";
		variables.STATUS = "";
		variables.CELL = "";
		variables.PLACE_OF_ARREST = "";	
		variables.custodyReasons = "";	
		variables.custodyDepartures = "";	
		variables.nominal="";					
	</cfscript>

	<cffunction name="init" output="false" returntype="custody">
		<cfreturn this>
	</cffunction>
	<cffunction name="getCUSTODY_REF" output="false" access="public" returntype="any">
		<cfreturn variables.CUSTODY_REF>
	</cffunction>

	<cffunction name="setCUSTODY_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CUSTODY_REF = arguments.val>
	</cffunction>


	<cffunction name="getSTATION" output="false" access="public" returntype="any">
		<cfreturn variables.STATION>
	</cffunction>

	<cffunction name="setSTATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.STATION = arguments.val>
	</cffunction>

	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getNAME" output="false" access="public" returntype="any">
		<cfreturn variables.NAME>
	</cffunction>

	<cffunction name="setNAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NAME = arguments.val>
	</cffunction>

	<cffunction name="getSEX" output="false" access="public" returntype="any">
		<cfreturn variables.SEX>
	</cffunction>

	<cffunction name="setSEX" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SEX = arguments.val>
	</cffunction>

	<cffunction name="getDOB" output="false" access="public" returntype="any">
		<cfreturn variables.DOB>
	</cffunction>

	<cffunction name="getDOB_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DOB,"DD/MM/YYYY")>
	</cffunction>

	<cffunction name="getAGE" output="false" access="public" returntype="any">
		<cfif Len(variables.DOB) GT 0>		
			<cfreturn DateDiff("YYYY",variables.DOB,now())>
		<cfelse>
			<cfreturn ''>
		</cfif>
	</cffunction>

	<cffunction name="setDOB" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DOB = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getETHNIC_APP" output="false" access="public" returntype="any">
		<cfreturn variables.ETHNIC_APP>
	</cffunction>

	<cffunction name="setETHNIC_APP" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ETHNIC_APP = arguments.val>
	</cffunction>

	<cffunction name="getARREST_TIME" output="false" access="public" returntype="any">
		<cfreturn variables.ARREST_TIME>
	</cffunction>

	<cffunction name="getARREST_TIME_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.ARREST_TIME,"DDD DD/MM/YYYY")&" "&TimeFormat(variables.ARREST_TIME,"HH:mm")>
	</cffunction>

	<cffunction name="setARREST_TIME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ARREST_TIME = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getAO_FORCE" output="false" access="public" returntype="any">
		<cfreturn variables.AO_FORCE>
	</cffunction>

	<cffunction name="setAO_FORCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.AO_FORCE = arguments.val>
	</cffunction>

	<cffunction name="getAO_BADGE" output="false" access="public" returntype="any">
		<cfreturn variables.AO_BADGE>
	</cffunction>

	<cffunction name="setAO_BADGE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.AO_BADGE = arguments.val>
	</cffunction>

	<cffunction name="getAO_STATION" output="false" access="public" returntype="any">
		<cfreturn variables.AO_STATION>
	</cffunction>

	<cffunction name="setAO_STATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.AO_STATION = arguments.val>
	</cffunction>

	<cffunction name="getOIC_FORCE" output="false" access="public" returntype="any">
		<cfreturn variables.OIC_FORCE>
	</cffunction>

	<cffunction name="setOIC_FORCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OIC_FORCE = arguments.val>
	</cffunction>

	<cffunction name="getOIC_BADGE" output="false" access="public" returntype="any">
		<cfreturn variables.OIC_BADGE>
	</cffunction>

	<cffunction name="setOIC_BADGE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OIC_BADGE = arguments.val>
	</cffunction>

	<cffunction name="getOIC_STATION" output="false" access="public" returntype="any">
		<cfreturn variables.OIC_STATION>
	</cffunction>

	<cffunction name="setOIC_STATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OIC_STATION = arguments.val>
	</cffunction>

	<cffunction name="getORIG_CUSTODY" output="false" access="public" returntype="any">
		<cfreturn variables.ORIG_CUSTODY>
	</cffunction>

	<cffunction name="setORIG_CUSTODY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ORIG_CUSTODY = arguments.val>
	</cffunction>

	<cffunction name="getDEPARTURE_TIME" output="false" access="public" returntype="any">
		<cfreturn variables.DEPARTURE_TIME>
	</cffunction>

	<cffunction name="setDEPARTURE_TIME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DEPARTURE_TIME = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getBAIL_ANSWERED" output="false" access="public" returntype="any">
		<cfreturn variables.BAIL_ANSWERED>
	</cffunction>

	<cffunction name="setBAIL_ANSWERED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BAIL_ANSWERED = arguments.val>
	</cffunction>

	<cffunction name="getCREATION_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.CREATION_DATE>
	</cffunction>

	<cffunction name="setCREATION_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CREATION_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getCUSTODY_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.CUSTODY_TYPE>
	</cffunction>

	<cffunction name="setCUSTODY_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CUSTODY_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getARREST_SUMMONS_NO" output="false" access="public" returntype="any">
		<cfreturn variables.ARREST_SUMMONS_NO>
	</cffunction>

	<cffunction name="setARREST_SUMMONS_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ARREST_SUMMONS_NO = arguments.val>
	</cffunction>


	<cffunction name="getAO_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.AO_NAME>
	</cffunction>

	<cffunction name="setAO_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.AO_NAME = arguments.val>
	</cffunction>

	<cffunction name="getOIC_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.OIC_NAME>
	</cffunction>

	<cffunction name="setOIC_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OIC_NAME = arguments.val>
	</cffunction>

	<cffunction name="getRIGHTS" output="false" access="public" returntype="any">
		<cfreturn variables.RIGHTS>
	</cffunction>

	<cffunction name="setRIGHTS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RIGHTS = arguments.val>
	</cffunction>

	<cffunction name="getCHARGED" output="false" access="public" returntype="any">
		<cfreturn variables.CHARGED>
	</cffunction>

	<cffunction name="setCHARGED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CHARGED = arguments.val>
	</cffunction>

	<cffunction name="getBAIL_CANC_REASON" output="false" access="public" returntype="any">
		<cfreturn variables.BAIL_CANC_REASON>
	</cffunction>

	<cffunction name="setBAIL_CANC_REASON" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BAIL_CANC_REASON = arguments.val>
	</cffunction>

	<cffunction name="getNEXT_REVIEW_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.NEXT_REVIEW_DATE>
	</cffunction>

	<cffunction name="getNEXT_REVIEW_DATE_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.NEXT_REVIEW_DATE,"DD/MM/YYYY")&" "&TimeFormat(variables.NEXT_REVIEW_DATE,"HH:mm")>
	</cffunction>

	<cffunction name="setNEXT_REVIEW_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.NEXT_REVIEW_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getREVIEW_RANK" output="false" access="public" returntype="any">
		<cfreturn variables.REVIEW_RANK>
	</cffunction>

	<cffunction name="setREVIEW_RANK" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REVIEW_RANK = arguments.val>
	</cffunction>

	<cffunction name="getDETAIN_UNTIL" output="false" access="public" returntype="any">
		<cfreturn variables.DETAIN_UNTIL>
	</cffunction>

	<cffunction name="setDETAIN_UNTIL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DETAIN_UNTIL = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getSTATUS" output="false" access="public" returntype="any">
		<cfreturn variables.STATUS>
	</cffunction>

	<cffunction name="setSTATUS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.STATUS = arguments.val>
	</cffunction>

	<cffunction name="getCELL" output="false" access="public" returntype="any">
		<cfreturn variables.CELL>
	</cffunction>

	<cffunction name="setCELL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CELL = arguments.val>
	</cffunction>

	<cffunction name="getPLACE_OF_ARREST" output="false" access="public" returntype="any">
		<cfreturn variables.PLACE_OF_ARREST>
	</cffunction>

	<cffunction name="setPLACE_OF_ARREST" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PLACE_OF_ARREST = arguments.val>
	</cffunction>

	<cffunction name="getCustodyReasons" output="false" access="public" returntype="any">
		<cfreturn variables.custodyReasons>
	</cffunction>

	<cffunction name="setCustodyReasons" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.custodyReasons = arguments.val>
	</cffunction>
    
	<cffunction name="getCustodyDepartures" output="false" access="public" returntype="any">
		<cfreturn variables.custodyDepartures>
	</cffunction>

	<cffunction name="setCustodyDepartures" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.custodyDepartures = arguments.val>
	</cffunction>    
	
	<cffunction name="getNominal" output="false" access="public" returntype="any">
		<cfreturn variables.nominal>
	</cffunction>

	<cffunction name="setNominal" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.nominal = arguments.val>
	</cffunction>   	

	<cffunction name="dump" output="false" access="public" returntype="any">
        <cfset var dump="">
        <cfset var x="">
        <cfset var y="">
        
        <cfoutput>
        <cfsavecontent variable="dump">
         Cust Ref=#getCUSTODY_REF()#<Br>
         Cust Type=#getCUSTODY_TYPE()#<Br>         
         Nominal Ref=#getNOMINAL_REF()#<Br>
         Name=#getNAME()#<Br>
         Arrest Time=#getARREST_TIME()#<br>
         OIC Badeg=#getOIC_BADGE()#<br>
         AS No=#getARREST_SUMMONS_NO()#<br>     
         <cfloop from="1" to="#ArrayLen(custodyReasons)#" index="y">
         reasons #variables.custodyReasons[y].getSEQ_NO()# - #variables.custodyReasons[y].getARREST_REASON_TEXT()#<Br>
         </cfloop>         
         <cfloop from="1" to="#ArrayLen(custodyDepartures)#" index="x">
         departures #variables.custodyDepartures[x].getDATE_ARRIVED()# - #variables.custodyDepartures[x].getDATE_RELEASED()# - #variables.custodyDepartures[x].getREASON_FOR_DEPARTURE()#<Br>
         </cfloop>                  
        </cfsavecontent>
        </cfoutput>
        
		<cfreturn dump>
	</cffunction>    

</cfcomponent>