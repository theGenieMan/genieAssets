<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="geniePastePath" required="true" type="String">
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
        <cfset variables.geniePastePath=arguments.geniePastePath>   
                   
        <cfreturn this />  
    </cffunction>   

	<cffunction name="read" output="false" access="public" returntype="releases">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	off.PNC_ID, SURNAME, FORENAMES, DOB, GENDER, PREL_IND, 
					JT_IND, NOMINAL_REF, PRISONER_NO, DIARY_DATE, ESTABLISHMENT, REL_TYPE, OFFENCES, 
					REC_ADDRESS, DISC_ADDRESS, COMMITAL_COURT, SENTENCETYPE
			from OMS_OWNER.OMS_OFFENDERS off, OMS_OWNER.OMS_PRISONER_RELEASES rel
			where off.PNC_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getPNC_ID()#" />
			<cfif Len(obj.getDIARY_DATE()) GT 0>
			and rel.DIARY_DATE=to_date('#DateFormat(obj.getDIARY_DATE(),'DD/MM/YYYY')#','DD/MM/YYYY')
			</cfif>
            and rel.PNC_ID=off.PNC_ID
		</cfquery>

		<cfscript>
			obj.setPNC_ID(qRead.PNC_ID);
			obj.setSURNAME(qRead.SURNAME);
			obj.setFORENAMES(qRead.FORENAMES);
			obj.setDOB(qRead.DOB);
			obj.setGENDER(qRead.GENDER);
			obj.setPREL_IND(qRead.PREL_IND);
			obj.setJT_IND(qRead.JT_IND);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setPRISONER_NO(qRead.PRISONER_NO);
			obj.setDIARY_DATE(qRead.DIARY_DATE);
			obj.setESTABLISHMENT(qRead.ESTABLISHMENT);
			obj.setREL_TYPE(qRead.REL_TYPE);
			obj.setOFFENCES(qRead.OFFENCES);
			obj.setREC_ADDRESS(qRead.REC_ADDRESS);
			obj.setDISC_ADDRESS(qRead.DISC_ADDRESS);
			obj.setCOMMITAL_COURT(qRead.COMMITAL_COURT);	
			obj.setSENTENCETYPE(qRead.SENTENCETYPE);			
			return obj;
		</cfscript>
	</cffunction>

	<cffunction name="readCurrentPrisonerRelease" output="false" access="public" returntype="releases">
		<cfargument name="nominalRef" required="true">
		<cfset var qRelease="">
        <cfset var release=CreateObject("component","genieObj.nominal.releases")>

        <cftry>
		<cfquery name="qRelease" datasource="#variables.warehouseDSN#">
			SELECT rel.*, off.*
			FROM   oms_owner.OMS_PRISONER_RELEASES rel, oms_owner.OMS_OFFENDERS off
			WHERE  rel.PNC_ID=off.PNC_ID
			AND    off.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			AND    TRUNC(rel.DIARY_DATE) >= TO_DATE('#DateFormat(DateAdd("d","-13",now()),'DD-MMM-YYYY')#','DD-MON-YYYY')
			--                                 AND TO_DATE('#DateFormat(DateAdd("d","30",now()),'DD-MMM-YYYY')#','DD-MON-YYYY')
		</cfquery>
        
        <cfif qRelease.RecordCount GT 0>
            
          <cfset release.setPNC_ID(qRelease.PNC_ID)>
          <cfset release.setDIARY_DATE(qRelease.DIARY_DATE)>		
          <cfset release=read(release)>
        </cfif>
         
		<cfcatch type="any">
		  <cfreturn release>
        </cfcatch>
        </cftry>
        <cfreturn release>
		
	</cffunction> 

</cfcomponent>