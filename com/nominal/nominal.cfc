<cfcomponent output="false" alias="genieObj.com.nominal.nominal">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="NOMINAL_REF" type="string" default="">
	<cfproperty name="PNCID_NO" type="string" default="">
	<cfproperty name="SURNAME_1" type="string" default="">
	<cfproperty name="SURNAME_2" type="string" default="">
	<cfproperty name="FORENAME_1" type="string" default="">
	<cfproperty name="FORENAME_2" type="string" default="">
	<cfproperty name="MAIDEN_NAME" type="string" default="">
	<cfproperty name="FAMILIAR_NAME" type="string" default="">
	<cfproperty name="FULL_NAME" type="string" default="">  
	<cfproperty name="SEX" type="string" default="">
	<cfproperty name="DATE_OF_BIRTH" type="date" default="">
	<cfproperty name="DATE_OF_DEATH" type="date" default="">    
	<cfproperty name="CRO" type="string" default="">
    <cfproperty name="HANDED" type="string" default="">
	<cfproperty name="NAME_TYPE" type="string" default="">
	<cfproperty name="TITLE" type="string" default="">
	<cfproperty name="ETHNICITY_16" type="string" default="">
	<cfproperty name="MARITAL_STATUS" type="string" default="">
	<cfproperty name="PLACE_OF_BIRTH" type="string" default="">
	<cfproperty name="HEIGHT_CMS" type="numeric" default="0">
	<cfproperty name="HEIGHT_INS" type="numeric" default="0">
	<cfproperty name="WEIGHT_KGS" type="numeric" default="0">
	<cfproperty name="WEIGHT_LBS" type="numeric" default="0">
	<cfproperty name="BUILD" type="string" default="">
	<cfproperty name="SHOE_SIZE" type="numeric" default="0">
	<cfproperty name="SHOE_UNITS" type="string" default="">
	<cfproperty name="ACCENT" type="string" default="">
	<cfproperty name="ETHNICITY_6" type="string" default="">
	<cfproperty name="OCCUPATION" type="string" default="">
	<cfproperty name="OCC_CODE" type="string" default="">
	<cfproperty name="OCC_CLASS" type="string" default="">
	<cfproperty name="POST_TOWN" type="string" default="">
	<cfproperty name="OTHER_NAMES_FLAG" type="string" default="">
	<cfproperty name="RISK_MAN_FLAG" type="string" default="">    
	<cfproperty name="RISK_MAN_TYPE" type="string" default="">        
	<cfproperty name="STEP_FLAG" type="string" default="">  
	<cfproperty name="TACAD_FLAG" type="string" default="">            
	<cfproperty name="COMP_STATUS" type="string" default="">            
	<cfproperty name="SUB_TYPE" type="string" default="">
	<cfproperty name="RANK" type="string" default="">
	<cfproperty name="BADGE_NUMBER" type="string" default="">
	<cfproperty name="DECEASED" type="string" default="">
	<cfproperty name="CURRENT_WORK_LOCATION" type="string" default="">
	<cfproperty name="ACCESS_LEVEL" type="string" default="">
	<cfproperty name="USER_ID" type="string" default="">
	<cfproperty name="APP_REF" type="string" default="">    
	<cfproperty name="FORCE_REF" type="string" default="">
	<cfproperty name="DISPLAY_FORCE" type="string" default="">    
	<cfproperty name="SYS_REF" type="string" default="">   
	<cfproperty name="RISP_PHOTO_EXISTS" type="string" default="">         
	<cfproperty name="DOB_ESTIMATE_FLAG" type="string" default="">     
	<cfproperty name="DOD_ESTIMATE_FLAG" type="string" default="">                
	<cfproperty name="COLLECTOR_DIV" type="string" default="">     
	<cfproperty name="COLLECTOR_TXT" type="string" default="">     
	<cfproperty name="GLASSES_USED" type="string" default="">     
	<cfproperty name="GLASSES_WORN" type="string" default="">     
	<cfproperty name="MOPI_GROUP" type="string" default="">        
	<cfproperty name="LATEST_PHOTO" type="photo" default="">
	<cfproperty name="LATEST_ADDRESS" type="string" default="">
	<cfproperty name="LATEST_LPA" type="string" default="">
	<cfproperty name="LATEST_GRIDREF" type="string" default="">  
	<cfproperty name="CHILD_CARE_PLAN" type="string" default="">  
	<cfproperty name="DATE_STARTED" type="string" default="">  
	<cfproperty name="DATE_FINISHED" type="string" default="">                    	             
	<cfproperty name="FS_CODE" type="string" default="">
	<cfproperty name="QUICK_STEP_FLAG" type="string" default="">
	<cfproperty name="WARNING_SUB_TYPE" type="string" default="">
	<cfproperty name="WARNINGS" type="warnings" default="">
	<cfproperty name="WARNINGS_TEXT" type="string" default="">
	<cfproperty name="PHOTOS" type="photos" default="">
	<cfproperty name="TTL_FLAG" type="string" default="">                    	             	

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.NOMINAL_REF = "";
		variables.PNCID_NO = "";
		variables.SURNAME_1 = "";
		variables.SURNAME_2 = "";
		variables.FORENAME_1 = "";
		variables.FORENAME_2 = "";
		variables.MAIDEN_NAME = "";
		variables.FAMILIAR_NAME = "";
		variables.FULL_NAME = "";
		variables.SEX = "";
		variables.DATE_OF_BIRTH = "";
		variables.DATE_OF_DEATH = "";		
		variables.CRO = "";
        variables.HANDED = "";
		variables.NAME_TYPE = "";
		variables.TITLE = "";
		variables.ETHNICITY_16 = "";
		variables.MARITAL_STATUS = "";
		variables.PLACE_OF_BIRTH = "";
		variables.HEIGHT_CMS = 0;
		variables.HEIGHT_INS = 0;
		variables.WEIGHT_KGS = 0;
		variables.WEIGHT_LBS = 0;
		variables.BUILD = "";
		variables.SHOE_SIZE = 0;
		variables.SHOE_UNITS = "";
		variables.ACCENT = "";
		variables.ETHNICITY_6 = "";
		variables.OCCUPATION = "";
		variables.OCC_CODE = "";
		variables.OCC_CLASS = "";
		variables.POST_TOWN = "";
		variables.OTHER_NAMES_FLAG = "";
		variables.RISK_MAN_FLAG = "";
		variables.RISK_MAN_TYPE = "";		
		variables.STEP_FLAG = "";		
		variables.TACAD_FLAG = "";						
		variables.COMP_STATUS = "";						
		variables.SUB_TYPE = "";
		variables.RANK = "";
		variables.BADGE_NUMBER = "";
		variables.DECEASED = "";
		variables.CURRENT_WORK_LOCATION = "";
		variables.ACCESS_LEVEL = "";
		variables.USER_ID = "";		
		variables.APP_REF = "";
		variables.FORCE_REF = "";
		variables.DISPLAY_FORCE = "";		
		variables.SYS_REF = "";	
		variables.RISP_PHOTO_EXISTS = "";			
		variables.DOB_ESTIMATE_FLAG = "";	
		variables.DOD_ESTIMATE_FLAG = "";												
		variables.COLLECTOR_DIV = "";	
		variables.COLLECTOR_TXT = "";	
		variables.GLASSES_USED = "";	
		variables.GLASSES_WORN = "";	
		variables.MOPI_GROUP = "";		
		variables.LATEST_PHOTO = "";	
		variables.LATEST_ADDRESS = "";	
		variables.LATEST_GRIDREF = "";
		variables.LATEST_LPA = "";	
		variables.CHILD_CARE_PLAN = "";	
		variables.DATE_STARTED = "";	
		variables.DATE_FINISHED = "";	
		variables.FS_CODE = "";				
		variables.QUICK_STEP_FLAG = "";	
		variables.WARNING_SUB_TYPE = "";
		variables.WARNINGS = ArrayNew(1);
		variables.WARNINGS_TEXT = "";	
		variables.PHOTOS = ArrayNew(1);
		variables.TTL_FLAG = "";																					
	</cfscript>

	<cffunction name="init" output="false" returntype="nominal">
		<cfreturn this>
	</cffunction>
	<cffunction name="getNOMINAL_REF" output="false" access="public" returntype="any">
		<cfreturn variables.NOMINAL_REF>
	</cffunction>

	<cffunction name="setNOMINAL_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NOMINAL_REF = arguments.val>
	</cffunction>

	<cffunction name="getPNCID_NO" output="false" access="public" returntype="any">
		<cfreturn variables.PNCID_NO>
	</cffunction>

	<cffunction name="setPNCID_NO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PNCID_NO = arguments.val>
	</cffunction>

	<cffunction name="getSURNAME_1" output="false" access="public" returntype="any">
		<cfreturn variables.SURNAME_1>
	</cffunction>

	<cffunction name="setSURNAME_1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SURNAME_1 = arguments.val>
	</cffunction>

	<cffunction name="getSURNAME_2" output="false" access="public" returntype="any">
		<cfreturn variables.SURNAME_2>
	</cffunction>

	<cffunction name="setSURNAME_2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SURNAME_2 = arguments.val>
	</cffunction>

	<cffunction name="getFORENAME_1" output="false" access="public" returntype="any">
		<cfreturn variables.FORENAME_1>
	</cffunction>

	<cffunction name="setFORENAME_1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FORENAME_1 = arguments.val>
	</cffunction>

	<cffunction name="getFORENAME_2" output="false" access="public" returntype="any">
		<cfreturn variables.FORENAME_2>
	</cffunction>

	<cffunction name="setFORENAME_2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FORENAME_2 = arguments.val>
	</cffunction>

	<cffunction name="getMAIDEN_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.MAIDEN_NAME>
	</cffunction>

	<cffunction name="setMAIDEN_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MAIDEN_NAME = arguments.val>
	</cffunction>

	<cffunction name="getFAMILIAR_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.FAMILIAR_NAME>
	</cffunction>

	<cffunction name="setFAMILIAR_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FAMILIAR_NAME = arguments.val>
	</cffunction>
  
	<cffunction name="getFULL_NAME" output="false" access="public" returntype="any">
		<cfreturn variables.FULL_NAME>
	</cffunction>

	<cffunction name="setFULL_NAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FULL_NAME = arguments.val>
	</cffunction>  

	<cffunction name="getSEX" output="false" access="public" returntype="any">
		<cfreturn variables.SEX>
	</cffunction>

	<cffunction name="setSEX" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SEX = arguments.val>
	</cffunction>

	<cffunction name="getDATE_OF_BIRTH" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_OF_BIRTH>
	</cffunction>
    
	<cffunction name="getDATE_OF_BIRTH_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_OF_BIRTH,"DD/MM/YYYY")>
	</cffunction>    

	<cffunction name="setDATE_OF_BIRTH" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_OF_BIRTH = arguments.val>
		</cfif>
	</cffunction>
    
	<cffunction name="getDATE_OF_DEATH" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_OF_DEATH>
	</cffunction>
    
	<cffunction name="getDATE_OF_DEATH_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_OF_DEATH,"DD/MM/YYYY")>
	</cffunction>    

	<cffunction name="setDATE_OF_DEATH" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_OF_DEATH = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>    

	<cffunction name="getAge" output="false" access="public" returntype="any">
        <cfset var age="">
		<cfif Len(variables.DATE_OF_BIRTH) GT 0>
		  <cfif Len(variables.DATE_OF_DEATH) GT 0>
		  <cfset age=DateDiff("YYYY",variables.DATE_OF_BIRTH,variables.DATE_OF_DEATH)>
		  <cfelse>
		  <cfset age=DateDiff("YYYY",variables.DATE_OF_BIRTH,now())>  
		  </cfif>
		</cfif>         
        
		<cfreturn age>
	</cffunction>    

	<cffunction name="getCRO" output="false" access="public" returntype="any">
		<cfreturn variables.CRO>
	</cffunction>

	<cffunction name="setCRO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CRO = arguments.val>
	</cffunction>

    <cffunction name="getHANDED" output="false" access="public" returntype="any">
		<cfreturn variables.HANDED>
	</cffunction>

	<cffunction name="setHANDED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.HANDED = arguments.val>
	</cffunction>

	<cffunction name="getNAME_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.NAME_TYPE>
	</cffunction>

	<cffunction name="setNAME_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.NAME_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getTITLE" output="false" access="public" returntype="any">
		<cfreturn variables.TITLE>
	</cffunction>

	<cffunction name="setTITLE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TITLE = arguments.val>
	</cffunction>

	<cffunction name="getETHNICITY_16" output="false" access="public" returntype="any">
		<cfreturn variables.ETHNICITY_16>
	</cffunction>

	<cffunction name="setETHNICITY_16" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ETHNICITY_16 = arguments.val>
	</cffunction>

	<cffunction name="getMARITAL_STATUS" output="false" access="public" returntype="any">
		<cfreturn variables.MARITAL_STATUS>
	</cffunction>

	<cffunction name="setMARITAL_STATUS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MARITAL_STATUS = arguments.val>
	</cffunction>

	<cffunction name="getPLACE_OF_BIRTH" output="false" access="public" returntype="any">
		<cfreturn variables.PLACE_OF_BIRTH>
	</cffunction>

	<cffunction name="setPLACE_OF_BIRTH" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PLACE_OF_BIRTH = arguments.val>
	</cffunction>

	<cffunction name="getHEIGHT_CMS" output="false" access="public" returntype="any">
		<cfreturn variables.HEIGHT_CMS>
	</cffunction>

	<cffunction name="setHEIGHT_CMS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.HEIGHT_CMS = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getHEIGHT_INS" output="false" access="public" returntype="any">
		<cfreturn variables.HEIGHT_INS>
	</cffunction>

	<cffunction name="setHEIGHT_INS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.HEIGHT_INS = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

    <cffunction name="getHEIGHT_TEXT" output="false" access="public" returntype="any">
    
	<cfset var str_Height="">
    <cfset var iFeet="">
    <cfset var iInches="">
    
	<!--- Format the Nominals Height Details if completed --->
	<cfif Len(variables.Height_Ins) GT 0>
	 <cfset iFeet=Int(variables.Height_Ins/12)>
	 <cfset iInches=variables.Height_Ins MOD 12>
	 <cfset str_Height=iFeet&" Ft " & iInches & " In">
	</cfif>
	
	<cfif Len(variables.Height_cms) GT 0>
	 <cfif Len(str_Height) GT 0>
	  <cfset str_Height=str_Height&" / "&variables.height_cms&" cms">
	 </cfif>
	</cfif>
	
	<cfif Len(str_Height) IS 0>
	 <cfset str_height="&nbsp;">
	</cfif>
    
    <cfreturn str_height>
    
    </cffunction>

	<cffunction name="getWEIGHT_KGS" output="false" access="public" returntype="any">
		<cfreturn variables.WEIGHT_KGS>
	</cffunction>

	<cffunction name="setWEIGHT_KGS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.WEIGHT_KGS = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getWEIGHT_LBS" output="false" access="public" returntype="any">
		<cfreturn variables.WEIGHT_LBS>
	</cffunction>

	<cffunction name="setWEIGHT_LBS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.WEIGHT_LBS = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getBUILD" output="false" access="public" returntype="any">
		<cfreturn variables.BUILD>
	</cffunction>
    
	<cffunction name="getWEIGHT_TEXT" output="false" access="public" returntype="any">
        
	<cfset var str_Weight="">
    <cfset var iStone="">
    <cfset var iPounds="">
	<!--- Format the Nominals Weight Details if completed --->
	<cfif Len(variables.Weight_Lbs) GT 0>
	 <cfset iStone=Int(variables.Weight_Lbs/14)>
	 <cfset iPounds=variables.Weight_Lbs MOD 14>
	 <cfset str_Weight=iStone&" St "&iPounds&" Lbs">
	</cfif>
	
	<cfif Len(variables.Weight_Kgs) GT 0>
	 <cfif isDefined("str_Weight")>
	  <cfset str_Weight=str_Weight&" / "&variables.Weight_Kgs&" Kg">
	 <cfelse>
	 <cfset str_Weight=variables.Weight_Kgs&" Kg"> 
	 </cfif>
	</cfif>         
        
		<cfreturn str_Weight>
	</cffunction>    

	<cffunction name="setBUILD" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BUILD = arguments.val>
	</cffunction>

	<cffunction name="getSHOE_SIZE" output="false" access="public" returntype="any">
		<cfreturn variables.SHOE_SIZE>
	</cffunction>

	<cffunction name="setSHOE_SIZE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.SHOE_SIZE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSHOE_UNITS" output="false" access="public" returntype="any">
		<cfreturn variables.SHOE_UNITS>
	</cffunction>

	<cffunction name="setSHOE_UNITS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SHOE_UNITS = arguments.val>
	</cffunction>

	<cffunction name="getACCENT" output="false" access="public" returntype="any">
		<cfreturn variables.ACCENT>
	</cffunction>

	<cffunction name="setACCENT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ACCENT = arguments.val>
	</cffunction>

	<cffunction name="getETHNICITY_6" output="false" access="public" returntype="any">
		<cfreturn variables.ETHNICITY_6>
	</cffunction>

	<cffunction name="setETHNICITY_6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ETHNICITY_6 = arguments.val>
	</cffunction>

	<cffunction name="getOCCUPATION" output="false" access="public" returntype="any">
		<cfreturn variables.OCCUPATION>
	</cffunction>

	<cffunction name="setOCCUPATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OCCUPATION = arguments.val>
	</cffunction>

	<cffunction name="getOCC_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.OCC_CODE>
	</cffunction>

	<cffunction name="setOCC_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OCC_CODE = arguments.val>
	</cffunction>

	<cffunction name="getOCC_CLASS" output="false" access="public" returntype="any">
		<cfreturn variables.OCC_CLASS>
	</cffunction>

	<cffunction name="setOCC_CLASS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OCC_CLASS = arguments.val>
	</cffunction>

	<cffunction name="getPOST_TOWN" output="false" access="public" returntype="any">
		<cfreturn variables.POST_TOWN>
	</cffunction>

	<cffunction name="setPOST_TOWN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.POST_TOWN = arguments.val>
	</cffunction>

	<cffunction name="getOTHER_NAMES_FLAG" output="false" access="public" returntype="any">
		<cfreturn variables.OTHER_NAMES_FLAG>
	</cffunction>

	<cffunction name="setOTHER_NAMES_FLAG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.OTHER_NAMES_FLAG = arguments.val>
	</cffunction>

	<cffunction name="getRISK_MAN_FLAG" output="false" access="public" returntype="any">
		<cfreturn variables.RISK_MAN_FLAG>
	</cffunction>

	<cffunction name="setRISK_MAN_FLAG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RISK_MAN_FLAG = arguments.val>
	</cffunction>
    
	<cffunction name="getRISK_MAN_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.RISK_MAN_TYPE>
	</cffunction>

	<cffunction name="setRISK_MAN_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RISK_MAN_TYPE = arguments.val>
	</cffunction>    
    
	<cffunction name="getSTEP_FLAG" output="false" access="public" returntype="any">
		<cfreturn variables.STEP_FLAG>
	</cffunction>

	<cffunction name="setSTEP_FLAG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.STEP_FLAG = arguments.val>
	</cffunction>    
    
	<cffunction name="getTACAD_FLAG" output="false" access="public" returntype="any">
		<cfreturn variables.TACAD_FLAG>
	</cffunction>

	<cffunction name="setTACAD_FLAG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TACAD_FLAG = arguments.val>
	</cffunction>      
    
	<cffunction name="getCOMP_STATUS" output="false" access="public" returntype="any">
		<cfreturn variables.COMP_STATUS>
	</cffunction>

	<cffunction name="setCOMP_STATUS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.COMP_STATUS = arguments.val>
	</cffunction>      

	<cffunction name="getSUB_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.SUB_TYPE>
	</cffunction>

	<cffunction name="setSUB_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SUB_TYPE = arguments.val>
	</cffunction>

	<cffunction name="getRANK" output="false" access="public" returntype="any">
		<cfreturn variables.RANK>
	</cffunction>

	<cffunction name="setRANK" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RANK = arguments.val>
	</cffunction>

	<cffunction name="getBADGE_NUMBER" output="false" access="public" returntype="any">
		<cfreturn variables.BADGE_NUMBER>
	</cffunction>

	<cffunction name="setBADGE_NUMBER" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BADGE_NUMBER = arguments.val>
	</cffunction>

	<cffunction name="getDECEASED" output="false" access="public" returntype="any">
		<cfreturn variables.DECEASED>
	</cffunction>

	<cffunction name="setDECEASED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DECEASED = arguments.val>
	</cffunction>

	<cffunction name="getCURRENT_WORK_LOCATION" output="false" access="public" returntype="any">
		<cfreturn variables.CURRENT_WORK_LOCATION>
	</cffunction>

	<cffunction name="setCURRENT_WORK_LOCATION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CURRENT_WORK_LOCATION = arguments.val>
	</cffunction>

	<cffunction name="getACCESS_LEVEL" output="false" access="public" returntype="any">
		<cfreturn variables.ACCESS_LEVEL>
	</cffunction>

	<cffunction name="setACCESS_LEVEL" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ACCESS_LEVEL = arguments.val>
	</cffunction>

	<cffunction name="getUSER_ID" output="false" access="public" returntype="any">
		<cfreturn variables.USER_ID>
	</cffunction>

	<cffunction name="setUSER_ID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.USER_ID = arguments.val>
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
    
	<cffunction name="getDISPLAY_FORCE" output="false" access="public" returntype="any">
		<cfreturn variables.DISPLAY_FORCE>
	</cffunction>

	<cffunction name="setDISPLAY_FORCE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DISPLAY_FORCE = arguments.val>
	</cffunction>    
    
	<cffunction name="getSYS_REF" output="false" access="public" returntype="any">
		<cfreturn variables.SYS_REF>
	</cffunction>

	<cffunction name="setSYS_REF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SYS_REF = arguments.val>
	</cffunction>    
    
	<cffunction name="getDOB_ESTIMATE_FLAG" output="false" access="public" returntype="any">
		<cfreturn variables.DOB_ESTIMATE_FLAG>
	</cffunction>
    
	<cffunction name="setRISP_PHOTO_EXISTS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RISP_PHOTO_EXISTS = arguments.val>
	</cffunction>    
    
	<cffunction name="getRISP_PHOTO_EXISTS" output="false" access="public" returntype="any">
		<cfreturn variables.RISP_PHOTO_EXISTS>
	</cffunction>    

	<cffunction name="setDOB_ESTIMATE_FLAG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DOB_ESTIMATE_FLAG = arguments.val>
	</cffunction>        

	<cffunction name="getDOD_ESTIMATE_FLAG" output="false" access="public" returntype="any">
		<cfreturn variables.DOD_ESTIMATE_FLAG>
	</cffunction>

	<cffunction name="setDOD_ESTIMATE_FLAG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DOD_ESTIMATE_FLAG = arguments.val>
	</cffunction> 
    
    <cffunction name="getCOLLECTOR_DIV" output="false" access="public" returntype="any">
		<cfreturn variables.COLLECTOR_DIV>
	</cffunction>

	<cffunction name="setCOLLECTOR_DIV" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.COLLECTOR_DIV = arguments.val>
	</cffunction> 
    
    <cffunction name="getCOLLECTOR_TXT" output="false" access="public" returntype="any">
		<cfreturn variables.COLLECTOR_TXT>
	</cffunction>

	<cffunction name="setCOLLECTOR_TXT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif left(val,1) IS '1' OR left(val,1) IS '2' OR left(val,1) IS '3' OR left(val,1) IS '4'>
		<cfset variables.COLLECTOR_TXT = arguments.val>
		</cfif>
	</cffunction> 

	<cffunction name="getGLASSES_WORN" output="false" access="public" returntype="any">
		<cfreturn variables.GLASSES_WORN>
	</cffunction>

	<cffunction name="setGLASSES_WORN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.GLASSES_WORN = arguments.val>
	</cffunction> 

	<cffunction name="getGLASSES_USED" output="false" access="public" returntype="any">
		<cfreturn variables.GLASSES_USED>
	</cffunction>

	<cffunction name="setGLASSES_USED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.GLASSES_USED = arguments.val>
	</cffunction> 

	<cffunction name="getMOPI_GROUP" output="false" access="public" returntype="any">
		<cfreturn variables.MOPI_GROUP>
	</cffunction>

	<cffunction name="setMOPI_GROUP" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MOPI_GROUP = arguments.val>
	</cffunction> 

	<cffunction name="getLATEST_PHOTO" output="false" access="public" returntype="any">
		<cfreturn variables.LATEST_PHOTO>
	</cffunction>

	<cffunction name="setLATEST_PHOTO" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LATEST_PHOTO = arguments.val>
	</cffunction> 

	<cffunction name="getLATEST_ADDRESS" output="false" access="public" returntype="any">
		<cfreturn variables.LATEST_ADDRESS>
	</cffunction>

	<cffunction name="setLATEST_ADDRESS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LATEST_ADDRESS = arguments.val>
	</cffunction> 

	<cffunction name="getLATEST_LPA" output="false" access="public" returntype="any">
		<cfreturn variables.LATEST_LPA>
	</cffunction>

	<cffunction name="setLATEST_LPA" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LATEST_LPA = arguments.val>
	</cffunction> 

	<cffunction name="getLATEST_GRIDREF" output="false" access="public" returntype="any">
		<cfreturn variables.LATEST_GRIDREF>
	</cffunction>

	<cffunction name="setLATEST_GRIDREF" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LATEST_GRIDREF = arguments.val>
	</cffunction> 

	<cffunction name="getCHILD_CARE_PLAN" output="false" access="public" returntype="any">
		<cfreturn variables.CHILD_CARE_PLAN>
	</cffunction>

	<cffunction name="setCHILD_CARE_PLAN" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.CHILD_CARE_PLAN = arguments.val>
	</cffunction> 

	<cffunction name="getDATE_STARTED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_STARTED>
	</cffunction>
    
	<cffunction name="getDATE_STARTED_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_STARTED,"DD/MM/YYYY")>
	</cffunction>    

	<cffunction name="setDATE_STARTED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_STARTED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>  

	<cffunction name="getDATE_FINISHED" output="false" access="public" returntype="any">
		<cfreturn variables.DATE_FINISHED>
	</cffunction>
    
	<cffunction name="getDATE_FINISHED_TEXT" output="false" access="public" returntype="any">
		<cfreturn DateFormat(variables.DATE_FINISHED,"DD/MM/YYYY")>
	</cffunction>    

	<cffunction name="setDATE_FINISHED" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DATE_FINISHED = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction> 

	<cffunction name="getFS_CODE" output="false" access="public" returntype="any">
		<cfreturn variables.FS_CODE>
	</cffunction>

	<cffunction name="setFS_CODE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FS_CODE = arguments.val>
	</cffunction> 

	<cffunction name="getQUICK_STEP_FLAG" output="false" access="public" returntype="any">
		<cfreturn variables.QUICK_STEP_FLAG>
	</cffunction>

	<cffunction name="setQUICK_STEP_FLAG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.QUICK_STEP_FLAG = arguments.val>
	</cffunction> 

	<cffunction name="getWARNING_SUB_TYPE" output="false" access="public" returntype="any">
		<cfreturn variables.WARNING_SUB_TYPE>
	</cffunction>

	<cffunction name="setWARNING_SUB_TYPE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.WARNING_SUB_TYPE = arguments.val>
	</cffunction> 

	<cffunction name="getWARNINGS" output="false" access="public" returntype="any">
		<cfreturn variables.WARNINGS>
	</cffunction>

	<cffunction name="setWARNINGS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.WARNINGS = arguments.val>
	</cffunction> 

	<cffunction name="getWARNINGS_TEXT" output="false" access="public" returntype="any">
		<cfreturn variables.WARNINGS_TEXT>
	</cffunction>

	<cffunction name="setWARNINGS_TEXT" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.WARNINGS_TEXT = arguments.val>
	</cffunction> 

	<cffunction name="getPHOTOS" output="false" access="public" returntype="any">
		<cfreturn variables.PHOTOS>
	</cffunction>

	<cffunction name="setPHOTOS" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.PHOTOS = arguments.val>
	</cffunction> 

	<cffunction name="getTTL_FLAG" output="false" access="public" returntype="any">
		<cfreturn variables.TTL_FLAG>
	</cffunction>

	<cffunction name="setTTL_FLAG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.TTL_FLAG = arguments.val>
	</cffunction> 

	<cffunction name="getBasicXml" output="false" access="public" returntype="string" hint="returns an xml string of basic nominal details">
		
		<cfset var sXmlNominal="">
		<cfset var sXmlPhoto="">
		<cfset var sXmlPhotoList="">
		<cfset var sXmlThisPhoto="">
		<cfset var sXmlFull="">
		<cfset var iPhoto="">
		
		<cfsavecontent variable="sXmlNominal">
			<nominal>
				<nominalRef>~nominalRef~</nominalRef>
				<fullName><![CDATA[~fullName~]]></fullName>
				<dob>~dob~</dob>
				<noPhotos>~noPhotos~</noPhotos>
				<photos>
					~photos~
				</photos>
			</nominal>
		</cfsavecontent>
		
		<cfsavecontent variable="sXmlPhoto">
			<photo asRef="~asRef~">
				<photoUrl>~photoUrl~</photoUrl>
				<dateTaken>~dateTaken~</dateTaken>
			</photo>
		</cfsavecontent>
		
		<cfset sXmlNominal=Replace(sXmlNominal,"~nominalRef~",getNOMINAL_REF(),"ALL")>
		<cfset sXmlNominal=Replace(sXmlNominal,"~fullName~",getFULL_NAME(),"ALL")>
		<cfset sXmlNominal=Replace(sXmlNominal,"~dob~",getDATE_OF_BIRTH_TEXT(),"ALL")>
		<cfset sXmlNominal=Replace(sXmlNominal,"~noPhotos~",arrayLen(getPHOTOS()),"ALL")>
		
		<cfif arrayLen(getPHOTOS()) GT 0>
		  <cfloop from="1" to="#ArrayLen(getPHOTOS())#" index="iPhoto">
			<cfset sXmlThisPhoto=Duplicate(sXmlPhoto)>
			<cfset sXmlThisPhoto=Replace(sXmlThisPhoto,"~photoUrl~",getPHOTOS()[iPhoto].getPHOTO_URL(),"ALL")>
			<cfset sXmlThisPhoto=Replace(sXmlThisPhoto,"~dateTaken~",getPHOTOS()[iPhoto].getDatePhotoTaken(),"ALL")>
			<cfset sXmlThisPhoto=Replace(sXmlThisPhoto,"~asRef~",getPHOTOS()[iPhoto].getAS_REF(),"ALL")>
		    <cfset sXmlPhotoList &= sXmlThisPhoto>
		  </cfloop>		  
		</cfif> 
		
		<cfset sXmlFull = Replace(sXmlNominal,"~photos~",sXmlPhotoList)>
		
		<cfreturn sXmlFull>
		
	</cffunction>

	<cffunction name="dump" output="false" access="public" returntype="any">
        <cfset var dump="">
        
        <cfoutput>
        <cfsavecontent variable="dump">
         Nominal Ref=#getNOMINAL_REF()#<Br>
         Surname1=#getSURNAME_1()#<Br>
         Surname2=#getSURNAME_2()#<Br>
         Forename1=#getFORENAME_1()#<br>
         Forename2=#getFORENAME_2()#<br>         
         DOB=#getDATE_OF_BIRTH()#<br>
        </cfsavecontent>
        </cfoutput>
        
		<cfreturn dump>
	</cffunction>


</cfcomponent>