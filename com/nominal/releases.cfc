<cfcomponent output="false" alias="releases">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="PNC_ID" type="string" default="">
	<cfproperty name="SURNAME" type="string" default="">
	<cfproperty name="FORENAMES" type="string" default="">
	<cfproperty name="DOB" type="date" default="">
	<cfproperty name="GENDER" type="string" default="">
	<cfproperty name="PREL_IND" type="string" default="">
	<cfproperty name="JT_IND" type="string" default="">
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="PRISONER_NO" type="string" default="">
	<cfproperty name="DIARY_DATE" type="date" default="">
	<cfproperty name="ESTABLISHMENT" type="string" default="">
	<cfproperty name="REL_TYPE" type="string" default="">
	<cfproperty name="OFFENCES" type="string" default="">
	<cfproperty name="REC_ADDRESS" type="string" default="">
	<cfproperty name="DISC_ADDRESS" type="string" default="">
	<cfproperty name="COMMITAL_COURT" type="string" default="">
	<cfproperty name="SENTENCETYPE" type="string" default="">    

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.PNC_ID = "";
		variables.SURNAME = "";
		variables.FORENAMES = "";
		variables.DOB = "";
		variables.GENDER = "";
		variables.PREL_IND = "";
		variables.JT_IND = "";
		variables.NOMINAL_REF = "";
		variables.PRISONER_NO = "";
		variables.DIARY_DATE = "";
		variables.ESTABLISHMENT = "";
		variables.REL_TYPE = "";
		variables.OFFENCES = "";
		variables.REC_ADDRESS = "";
		variables.DISC_ADDRESS = "";
		variables.COMMITAL_COURT = "";	
		variables.SENTENCE_TYPE = "";		
	</cfscript>

	<cffunction name="init" output="false" returntype="releases">
		<cfreturn this>
	</cffunction>
	<cffunction name="getPNC_ID" output="false" access="public" returntype="any">
		<cfreturn variables.PNC_ID>
	</cffunction>

	<cffunction name="setPNC_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PNC_ID = arguments.val>
	</cffunction>

	<cffunction name="getSURNAME" output="false" access="public" returntype="any">
		<cfreturn variables.SURNAME>
	</cffunction>

	<cffunction name="setSURNAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SURNAME = arguments.val>
	</cffunction>

	<cffunction name="getFORENAMES" output="false" access="public" returntype="any">
		<cfreturn variables.FORENAMES>
	</cffunction>

	<cffunction name="setFORENAMES" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FORENAMES = arguments.val>
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

	<cffunction name="getGENDER" output="false" access="public" returntype="any">
		<cfreturn variables.GENDER>
	</cffunction>

	<cffunction name="setGENDER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.GENDER = arguments.val>
	</cffunction>

	<cffunction name="getPREL_IND" output="false" access="public" returntype="any">
		<cfreturn variables.PREL_IND>
	</cffunction>

	<cffunction name="setPREL_IND" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PREL_IND = arguments.val>
	</cffunction>

	<cffunction name="getJT_IND" output="false" access="public" returntype="any">
		<cfreturn variables.JT_IND>
	</cffunction>

	<cffunction name="setJT_IND" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.JT_IND = arguments.val>
	</cffunction>

	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getPRISONER_NO" output="false" access="public" returntype="any">
		<cfreturn variables.PRISONER_NO>
	</cffunction>

	<cffunction name="setPRISONER_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PRISONER_NO = arguments.val>
	</cffunction>

	<cffunction name="getDIARY_DATE" output="false" access="public" returntype="any">
		<cfreturn variables.DIARY_DATE>
	</cffunction>

	<cffunction name="setDIARY_DATE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DIARY_DATE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getESTABLISHMENT" output="false" access="public" returntype="any">
		<cfreturn variables.ESTABLISHMENT>
	</cffunction>

	<cffunction name="setESTABLISHMENT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ESTABLISHMENT = arguments.val>
	</cffunction>

	<cffunction name="getREL_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.REL_TYPE>
	</cffunction>

	<cffunction name="setREL_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REL_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getOFFENCES" output="false" access="public" returntype="any">
		<cfreturn variables.OFFENCES>
	</cffunction>

	<cffunction name="setOFFENCES" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OFFENCES = arguments.val>
	</cffunction>

	<cffunction name="getREC_ADDRESS" output="false" access="public" returntype="any">
		<cfreturn variables.REC_ADDRESS>
	</cffunction>

	<cffunction name="setREC_ADDRESS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.REC_ADDRESS = arguments.val>
	</cffunction>

	<cffunction name="getDISC_ADDRESS" output="false" access="public" returntype="any">
		<cfreturn variables.DISC_ADDRESS>
	</cffunction>

	<cffunction name="setDISC_ADDRESS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DISC_ADDRESS = arguments.val>
	</cffunction>

	<cffunction name="getCOMMITAL_COURT" output="false" access="public" returntype="any">
		<cfreturn variables.COMMITAL_COURT>
	</cffunction>

	<cffunction name="setCOMMITAL_COURT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.COMMITAL_COURT = arguments.val>
	</cffunction>

	<cffunction name="getSENTENCETYPE" output="false" access="public" returntype="any">
		<cfreturn variables.SENTENCETYPE>
	</cffunction>

	<cffunction name="setSENTENCETYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SENTENCETYPE = arguments.val>
	</cffunction>

	<cffunction name="dump" output="false" access="public" returntype="any">
        <cfset var dump="">
        
        <cfoutput>
        <cfsavecontent variable="dump">
		    variables.PNC_ID = #getPNC_ID()#<br>
			variables.SURNAME = #getSURNAME()#<br>
			variables.FORENAMES = #getFORENAMES()#<br>
			variables.DOB = #getDOB()#<br>
			variables.GENDER = #getGENDER()#<br>
			variables.PREL_IND = #getPREL_IND()#<br>
			variables.JT_IND = #getJT_IND()#<br>
			variables.NOMINAL_REF = #getNOMINAL_REF()#<br>
			variables.PRISONER_NO = #getPRISONER_NO()#<br>
			variables.DIARY_DATE = #getDIARY_DATE()#<br>
			variables.ESTABLISHMENT = #getESTABLISHMENT()#<br>
			variables.REL_TYPE = #getREL_TYPE()#<br>
			variables.OFFENCES = #getOFFENCES()#<br>
			variables.REC_ADDRESS = #getREC_ADDRESS()#<br>
			variables.DISC_ADDRESS = #getDISC_ADDRESS()#<br>
			variables.COMMITAL_COURT = #getCOMMITAL_COURT()#<br>
        </cfsavecontent>
        </cfoutput>
        
		<cfreturn dump>
	</cffunction>

</cfcomponent>