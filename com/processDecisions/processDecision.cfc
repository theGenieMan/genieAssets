<cfcomponent output="false" alias="genieObj.processDescisions.processDecision">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="PD_REF" type="string" default="">
	<cfproperty name="CASE_ORG" type="string" default="">
	<cfproperty name="CASE_SERIAL" type="numeric" default="0">
	<cfproperty name="CASE_YEAR" type="numeric" default="0">
	<cfproperty name="DECISION" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="CUSTODY_REF" type="string" default="">
	<cfproperty name="CUSTODY_TYPE" type="string" default="">    
   	<cfproperty name="CUSTODY_LINK" type="string" default="">
	<cfproperty name="DATE_FORMALISED" type="date" default="">
	<cfproperty name="DEFENDANT" type="string" default="">
	<cfproperty name="DOB" type="date" default="">
	<cfproperty name="SEX" type="string" default="">
	<cfproperty name="DATE_CREATED" type="date" default="">
	<cfproperty name="ARREST_SUMMONS_NO" type="string" default="">
	<cfproperty name="MIN_DAY" type="string" default="">    
	<cfproperty name="MIN_MONTH" type="string" default="">        
    <cfproperty name="MIN_YEAR" type="string" default="">        
	<cfproperty name="pdHearings" type="genieObj.processDecisions.hearings[]" default="ArrayNew(1)">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.PD_REF = "";
		variables.CASE_ORG = "";
		variables.CASE_SERIAL = 0;
		variables.CASE_YEAR = 0;
		variables.DECISION = "";
		variables.NOMINAL_REF = "";
		variables.CUSTODY_REF = "";
		variables.CUSTODY_TYPE = "";		
		variables.CUSTODY_LINK = "";		
		variables.DATE_FORMALISED = "";
		variables.DEFENDANT = "";
		variables.DOB = "";
		variables.SEX = "";
		variables.DATE_CREATED = "";
		variables.ARREST_SUMMONS_NO = "";
		variables.MIN_DAY = "";
		variables.MIN_MONTH = "";
		variables.MIN_YEAR = "";						
	</cfscript>

	<cffunction name="init" output="false" returntype="processDecision">
		<cfreturn this>
	</cffunction>
	<cffunction name="getPD_REF" output="false" access="public" returntype="any">
		<cfreturn variables.PD_REF>
	</cffunction>

	<cffunction name="setPD_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PD_REF = arguments.val>
	</cffunction>

	<cffunction name="getCASE_ORG" output="false" access="public" returntype="any">
		<cfreturn variables.CASE_ORG>
	</cffunction>

	<cffunction name="setCASE_ORG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CASE_ORG = arguments.val>
	</cffunction>

	<cffunction name="getCASE_SERIAL" output="false" access="public" returntype="any">
		<cfreturn variables.CASE_SERIAL>
	</cffunction>

	<cffunction name="setCASE_SERIAL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CASE_SERIAL = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCASE_YEAR" output="false" access="public" returntype="any">
		<cfreturn variables.CASE_YEAR>
	</cffunction>

	<cffunction name="setCASE_YEAR" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
          <cfif Len(arguments.val) IS 1>
            <cfset arguments.val="0"&arguments.val>
          </cfif>
			<cfset variables.CASE_YEAR = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDECISION" output="false" access="public" returntype="any">
		<cfreturn variables.DECISION>
	</cffunction>

	<cffunction name="setDECISION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DECISION = arguments.val>
	</cffunction>

	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getCUSTODY_REF" output="false" access="public" returntype="any">
		<cfreturn variables.CUSTODY_REF>
	</cffunction>

	<cffunction name="setCUSTODY_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CUSTODY_REF = arguments.val>
	</cffunction>
    
	<cffunction name="setCUSTODY_TYPE" output="false" access="public" returntype="void">
        <cfif Len(variables.CUSTODY_REF) GT 0>
          <cfif ListLen(variables.CUSTODY_REF,"/") GT 1>
            <cfset variables.CUSTODY_TYPE="NSPIS">
          <cfelse>
            <cfset variables.CUSTODY_TYPE="CRIMES">
          </cfif>
        </cfif>
	</cffunction>    

	<cffunction name="getCUSTODY_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.CUSTODY_TYPE>
	</cffunction>
    
	<cffunction name="getCUSTODY_LINK" output="false" access="public" returntype="any">
		<cfreturn variables.CUSTODY_LINK>
	</cffunction>

	<cffunction name="setCUSTODY_LINK" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CUSTODY_LINK = arguments.val>
	</cffunction>    

	<cffunction name="getDATE_FORMALISED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_FORMALISED>
	</cffunction>

	<cffunction name="setDATE_FORMALISED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_FORMALISED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDEFENDANT" output="false" access="public" returntype="any">
		<cfreturn variables.DEFENDANT>
	</cffunction>

	<cffunction name="setDEFENDANT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DEFENDANT = arguments.val>
	</cffunction>

	<cffunction name="getDOB" output="false" access="public" returntype="any">
		<cfreturn variables.DOB>
	</cffunction>

	<cffunction name="setDOB" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DOB = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getSEX" output="false" access="public" returntype="any">
		<cfreturn variables.SEX>
	</cffunction>

	<cffunction name="setSEX" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SEX = arguments.val>
	</cffunction>

	<cffunction name="getDATE_CREATED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_CREATED>
	</cffunction>

	<cffunction name="setDATE_CREATED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_CREATED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getARREST_SUMMONS_NO" output="false" access="public" returntype="any">
		<cfreturn variables.ARREST_SUMMONS_NO>
	</cffunction>

	<cffunction name="setARREST_SUMMONS_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ARREST_SUMMONS_NO = arguments.val>
	</cffunction>
    
	<cffunction name="getMIN_DAY" output="false" access="public" returntype="any">
		<cfreturn variables.MIN_DAY>
	</cffunction>

	<cffunction name="setMIN_DAY" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MIN_DAY = arguments.val>
	</cffunction>
    
	<cffunction name="getMIN_MONTH" output="false" access="public" returntype="any">
		<cfreturn variables.MIN_MONTH>
	</cffunction>

	<cffunction name="setMIN_MONTH" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MIN_MONTH = arguments.val>
	</cffunction>
    
	<cffunction name="getMIN_YEAR" output="false" access="public" returntype="any">
		<cfreturn variables.MIN_YEAR>
	</cffunction>

	<cffunction name="setMIN_YEAR" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MIN_YEAR = arguments.val>
	</cffunction>            

	<cffunction name="getPdHearings" output="false" access="public" returntype="any">
		<cfreturn variables.pdHearings>
	</cffunction>

	<cffunction name="setPdHearings" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.pdHearings = arguments.val>
	</cffunction>
        
	<cffunction name="dump" output="false" access="public" returntype="any">
        <cfset var dump="">
        <cfset var x="">
        <cfset var y="">
        
        <cfoutput>
        <cfsavecontent variable="dump">
         pd Ref=#getPD_REF()#<Br>
         Nominal Ref=#getNOMINAL_REF()#<Br>
         Org=#getCASE_ORG()#<Br>
         Serial=#getCASE_SERIAL()#<br>
         Year=#getCASE_YEAR()#<br>
         Cust Ref=#getCUSTODY_REF()#<br>     
         Cust Type=#getCUSTODY_TYPE()#<br>     
         Cust Link=#getCUSTODY_LINK()#<br>                                    
         Date Created =#getDATE_CREATED()#<br>
         Min Day =#getMIN_DAY()#<br>
         Min Month =#getMIN_MONTH()#<br>
         Min Year=#getMIN_YEAR()#<br>                           
         <cfloop from="1" to="#ArrayLen(pdHearings)#" index="y">
         hearings #variables.pdHearings[y].getLine_Ref()# - #variables.pdHearings[y].getHearing_Ref()#. #variables.pdHearings[y].getCourt_Name()# - #variables.pdHearings[y].getHearing_Date()# - #variables.pdHearings[y].getStatus()# #variables.pdHearings[y].getOffence_Title()#<br>
         </cfloop>         
        </cfsavecontent>
        </cfoutput>
        
		<cfreturn dump>
	</cffunction>       
    

</cfcomponent>