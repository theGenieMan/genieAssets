<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="DSN" required="true" type="String">
                                    
        <cfset variables.dsn=arguments.dsn>
                             
        <cfreturn this />  
    </cffunction> 

	<cffunction name="read" output="false" access="public" returntype="SYSTEM_MESSAGES">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="#variables.dsn#">
			select 	MESSAGE_ID, MESSAGE_TITLE, MESSAGE, STARTDATE, ENDDATE, ADDEDDATE, 
					ADDEDBYUID, ADDEDBYNAME, SYSTEM
			from BROWSER_OWNER.SYSTEM_MESSAGES
			where MESSAGE_ID = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#arguments.id#" />
		</cfquery>

		<cfscript>
			obj = createObject("component", "SYSTEM_MESSAGES").init();
			obj.setMESSAGE_ID(qRead.MESSAGE_ID);
			obj.setMESSAGE_TITLE(qRead.MESSAGE_TITLE);
			obj.setMESSAGE(qRead.MESSAGE);
			obj.setSTARTDATE(qRead.STARTDATE);
			obj.setENDDATE(qRead.ENDDATE);
			obj.setADDEDDATE(qRead.ADDEDDATE);
			obj.setADDEDBYUID(qRead.ADDEDBYUID);
			obj.setADDEDBYNAME(qRead.ADDEDBYNAME);
			obj.setSYSTEM(qRead.SYSTEM);			
			return obj;
		</cfscript>
	</cffunction>



	<cffunction name="create" output="false" access="public">
		<cfargument name="bean" required="true" type="SYSTEM_MESSAGES">
		<cfset var qCreate="">

		<cfset var qGetId="">

		<cfset var local1=arguments.bean.getMESSAGE_TITLE()>
		<cfset var local2=arguments.bean.getMESSAGE()>
		<cfset var local3=arguments.bean.getSTARTDATE()>
		<cfset var local4=arguments.bean.getENDDATE()>
		<cfset var local5=arguments.bean.getADDEDDATE()>
		<cfset var local6=arguments.bean.getADDEDBYUID()>
		<cfset var local7=arguments.bean.getADDEDBYNAME()>

		<cftransaction isolation="read_committed">
			<cfquery name="qCreate" datasource="waredev">
				insert into BROWSER_OWNER.SYSTEM_MESSAGES(MESSAGE_TITLE, MESSAGE, STARTDATE, ENDDATE, ADDEDDATE, ADDEDBYUID, ADDEDBYNAME)
				values (
					<cfqueryparam value="#local1#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local2#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local3#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local3 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local4#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local4 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local5#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local5 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local6#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local7#" cfsqltype="CF_SQL_VARCHAR" />
				)
			</cfquery>

			<!--- If your server has a better way to get the ID that is more reliable, use that instead --->
			<cfquery name="qGetID" datasource="waredev">
				select MESSAGE_ID
				from BROWSER_OWNER.SYSTEM_MESSAGES
				where MESSAGE_TITLE = <cfqueryparam value="#local1#" cfsqltype="CF_SQL_VARCHAR" />
				  and MESSAGE = <cfqueryparam value="#local2#" cfsqltype="CF_SQL_VARCHAR" />
				  and STARTDATE = <cfqueryparam value="#local3#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local3 eq ""), de("yes"), de("no"))#" />
				  and ENDDATE = <cfqueryparam value="#local4#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local4 eq ""), de("yes"), de("no"))#" />
				  and ADDEDDATE = <cfqueryparam value="#local5#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local5 eq ""), de("yes"), de("no"))#" />
				  and ADDEDBYUID = <cfqueryparam value="#local6#" cfsqltype="CF_SQL_VARCHAR" />
				  and ADDEDBYNAME = <cfqueryparam value="#local7#" cfsqltype="CF_SQL_VARCHAR" />
				order by MESSAGE_ID desc
			</cfquery>
		</cftransaction>

		<cfscript>
			arguments.bean.setMESSAGE_ID(qGetID.MESSAGE_ID);
		</cfscript>
		<cfreturn arguments.bean />
	</cffunction>

	<cffunction name="createFromForm" output="false" access="public">
		<cfargument name="addForm" required="true" type="struct">
		<cfset var qCreate="">
		<cfset var qUniqueID="">
		<cfset var startDate="">
		<cfset var endDate="">		

        <cfquery name="qUniqueId" datasource="#variables.dsn#">
		  select browser_owner.message_seq.nextval messageId
	      from dual
		</cfquery>

		<cfset startDate=CreateODBCDateTime(CreateDateTime(ListGetAt(addForm.startDate,3,"/"),ListGetAt(addForm.startDate,2,"/"),ListGetAt(addForm.startDate,1,"/"),ListGetAt(addForm.startTime,1,":"),ListGetAt(addForm.startTime,2,":"),"00"))> 
		<cfset endDate=CreateODBCDateTime(CreateDateTime(ListGetAt(addForm.endDate,3,"/"),ListGetAt(addForm.endDate,2,"/"),ListGetAt(addForm.endDate,1,"/"),ListGetAt(addForm.endTime,1,":"),ListGetAt(addForm.endTime,2,":"),"00"))> 

		<cftransaction isolation="read_committed">
			<cfquery name="qCreate" datasource="#variables.DSN#">
				insert into BROWSER_OWNER.SYSTEM_MESSAGES(MESSAGE_ID,
							                              MESSAGE_TITLE, 
				                              MESSAGE, 
				                              STARTDATE, 
				                              ENDDATE, 
				                              ADDEDDATE, 
				                              ADDEDBYUID, 
				                              ADDEDBYNAME,
				                              SYSTEM 
)
				values (
					<cfqueryparam value="#qUniqueId.messageId#" cfsqltype="CF_SQL_NUMERIC" />,
					<cfqueryparam value="#arguments.addForm.messageTitle#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#arguments.addForm.message#" cfsqltype="CF_SQL_VARCHAR" />,					
					<cfqueryparam value="#startDate#" cfsqltype="CF_SQL_TIMESTAMP" />,
					<cfqueryparam value="#endDate#" cfsqltype="CF_SQL_TIMESTAMP" />,					
					<cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="CF_SQL_TIMESTAMP" />,
					<cfqueryparam value="#arguments.addForm.addedByUid#" cfsqltype="CF_SQL_VARCHAR" />,					
					<cfqueryparam value="#arguments.addForm.addedByName#" cfsqltype="CF_SQL_VARCHAR" />,	
					<cfqueryparam value="#arguments.addForm.system#" cfsqltype="CF_SQL_VARCHAR" />															
				)
			</cfquery>
        </cftransaction>

		<cfreturn qUniqueId.messageId />
	</cffunction>

	<cffunction name="updateFromForm" output="false" access="public">
		<cfargument name="updateForm" required="true" type="struct">
		
		<cfset var qUpdate="">		
		<cfset var startDate="">
		<cfset var endDate="">		

		<cfset startDate=CreateODBCDateTime(CreateDateTime(ListGetAt(updateForm.startDate,3,"/"),ListGetAt(updateForm.startDate,2,"/"),ListGetAt(updateForm.startDate,1,"/"),ListGetAt(updateForm.startTime,1,":"),ListGetAt(updateForm.startTime,2,":"),"00"))> 
		<cfset endDate=CreateODBCDateTime(CreateDateTime(ListGetAt(updateForm.endDate,3,"/"),ListGetAt(updateForm.endDate,2,"/"),ListGetAt(updateForm.endDate,1,"/"),ListGetAt(updateForm.endTime,1,":"),ListGetAt(updateForm.endTime,2,":"),"00"))> 

		<cftransaction isolation="read_committed">
			<cfquery name="qUpdate" datasource="#variables.DSN#">
				update BROWSER_OWNER.SYSTEM_MESSAGES
				SET   MESSAGE_TITLE = <cfqueryparam value="#arguments.updateForm.messageTitle#" cfsqltype="CF_SQL_VARCHAR" />,
				      MESSAGE       = <cfqueryparam value="#arguments.updateForm.message#" cfsqltype="CF_SQL_VARCHAR" />,
				      STARTDATE     = <cfqueryparam value="#startDate#" cfsqltype="CF_SQL_TIMESTAMP" />, 
                      ENDDATE       = <cfqueryparam value="#endDate#" cfsqltype="CF_SQL_TIMESTAMP" />, 
                      ADDEDDATE     = <cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="CF_SQL_TIMESTAMP" />, 
                      ADDEDBYUID    = <cfqueryparam value="#arguments.updateForm.addedByUid#" cfsqltype="CF_SQL_VARCHAR" />, 
                      ADDEDBYNAME   = <cfqueryparam value="#arguments.updateForm.addedByName#" cfsqltype="CF_SQL_VARCHAR" />,
                      SYSTEM        = <cfqueryparam value="#arguments.updateForm.system#" cfsqltype="CF_SQL_VARCHAR" />
				WHERE MESSAGE_ID    = <cfqueryparam value="#arguments.updateForm.messageId#" cfsqltype="CF_SQL_NUMERIC" />
			</cfquery>
        </cftransaction>

		<cfreturn updateForm.messageId />
	</cffunction>

	<cffunction name="update" output="false" access="public">
		<cfargument name="bean" required="true" type="SYSTEM_MESSAGES">
		<cfset var qUpdate="">

		<cfquery name="qUpdate" datasource="waredev" result="status">
			update BROWSER_OWNER.SYSTEM_MESSAGES
			set MESSAGE_TITLE = <cfqueryparam value="#arguments.bean.getMESSAGE_TITLE()#" cfsqltype="CF_SQL_VARCHAR" />,
				MESSAGE = <cfqueryparam value="#arguments.bean.getMESSAGE()#" cfsqltype="CF_SQL_VARCHAR" />,
				STARTDATE = <cfqueryparam value="#arguments.bean.getSTARTDATE()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.bean.getSTARTDATE() eq ""), de("yes"), de("no"))#" />,
				ENDDATE = <cfqueryparam value="#arguments.bean.getENDDATE()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.bean.getENDDATE() eq ""), de("yes"), de("no"))#" />,
				ADDEDDATE = <cfqueryparam value="#arguments.bean.getADDEDDATE()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.bean.getADDEDDATE() eq ""), de("yes"), de("no"))#" />,
				ADDEDBYUID = <cfqueryparam value="#arguments.bean.getADDEDBYUID()#" cfsqltype="CF_SQL_VARCHAR" />,
				ADDEDBYNAME = <cfqueryparam value="#arguments.bean.getADDEDBYNAME()#" cfsqltype="CF_SQL_VARCHAR" />
			where MESSAGE_ID = <cfqueryparam value="#arguments.bean.getMESSAGE_ID()#" cfsqltype="CF_SQL_DECIMAL">
		</cfquery>
		<cfreturn arguments.bean />
	</cffunction>

	<cffunction name="delete" output="false" access="public" returntype="void">
		<cfargument name="deleteIds" required="true" type="string">
		<cfset var qDelete="">

		<cfquery name="qDelete" datasource="#variables.dsn#" result="status">
			delete
			from BROWSER_OWNER.SYSTEM_MESSAGES
			where MESSAGE_ID IN (<cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#arguments.deleteIds#" list="true" />)
		</cfquery>

	</cffunction>

	<cffunction name="getMessageList" output="false" access="public" returntype="query">
		<cfargument name="system" required="false" default="" type="string" hint="id of system required. ie. LIVE, DEV, TRAIN">
		<cfargument name="liveOnly" required="false" default="" type="string" hint="Y for only current messages">		

		<cfset var qList="">

		<cfquery name="qList" datasource="#variables.dsn#" result="status">
			select message_id
			from BROWSER_OWNER.SYSTEM_MESSAGES
			where (1=1)
			<cfif Len(arguments.system) GT 0>
			and SYSTEM=<cfqueryparam value="#arguments.system#" cfsqltype="cf_sql_varchar" />
			</cfif>
			<cfif Len(arguments.liveOnly) GT 0>
			and ((STARTDATE < SYSDATE) AND (ENDDATE > SYSDATE))
			</cfif>			
			order by startdate desc
		</cfquery>
		
		<cfreturn qList>

	</cffunction>

</cfcomponent>