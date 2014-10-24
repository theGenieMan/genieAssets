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

	<cffunction name="read" output="false" access="public" returntype="jTrack">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	PNC_ID, PPO_START, OWNER_CJA, OWNER_BCU, OWNER_CDRP, PPO_IND, 
					PPO_END, PPO_OWNER, FORCE_STATION, ADDRESS_1, ADDRESS_2, 
					ADDRESS_3, ADDRESS_4, ADDRESS_5, POST_CODE
			from OMS_OWNER.OMS_JTRACK
			where PNC_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getPNC_ID()#" />
		</cfquery>

		<cfscript>
			obj.setPNC_ID(qRead.PNC_ID);
			obj.setPPO_START(qRead.PPO_START);
			obj.setOWNER_CJA(qRead.OWNER_CJA);
			obj.setOWNER_BCU(qRead.OWNER_BCU);
			obj.setOWNER_CDRP(qRead.OWNER_CDRP);
			obj.setPPO_IND(qRead.PPO_IND);
			obj.setPPO_END(qRead.PPO_END);
			obj.setPPO_OWNER(qRead.PPO_OWNER);
			obj.setFORCE_STATION(qRead.FORCE_STATION);
			obj.setADDRESS_1(qRead.ADDRESS_1);
			obj.setADDRESS_2(qRead.ADDRESS_2);
			obj.setADDRESS_3(qRead.ADDRESS_3);
			obj.setADDRESS_4(qRead.ADDRESS_4);
			obj.setADDRESS_5(qRead.ADDRESS_5);
			obj.setPOST_CODE(qRead.POST_CODE);
			return obj;
		</cfscript>
	</cffunction>
	
	<cffunction name="readIsPPO" output="false" access="public" returntype="jTrack">
		<cfargument name="pncId" required="true">
		<cfset var qIsPPo="">
        <cfset var ppo=CreateObject("component","genieObj.nominal.jTrack")>
        
		<cftry> 
        <cfif Len(arguments.pncId) GT 2>

		<cfquery name="qIsPPO" datasource="#variables.warehouseDSN#">
			SELECT *
			FROM   oms_owner.OMS_JTRACK
			WHERE  PNC_ID= <cfqueryparam value="#Right(arguments.pncId,Len(arguments.pncId)-2)#" cfsqltype="cf_sql_varchar">
			AND    (PPO_START <= sysdate AND sysdate <= PPO_END)
		</cfquery>
        
        <cfif qIsPPo.RecordCount GT 0>
            
          <cfset ppo.setPNC_ID(qIsPPO.PNC_ID)>
          <cfset ppo=read(ppo)>
        </cfif>
        
        </cfif>
		
		<cfcatch type="any">
		 <cfreturn ppo>
		</cfcatch>
		</cftry>

        <cfreturn ppo>
		
	</cffunction> 	

</cfcomponent>