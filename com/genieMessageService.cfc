
<cfcomponent name="genieMessageService" output="false">

	<cffunction name="init" access="public" output="false" returntype="genieMessageService">
		<cfargument name="DSN" type="string" required="true" />
				
		<cfset variables.DSN = arguments.DSN />
		<cfset variables.messageDAO = CreateObject("component","messages.SYSTEM_MESSAGESDAO").init(dsn=variables.DSN) />
		
		<cfset variables.version="1.0">
		<cfset variables.dateServiceStarted=now()>
		
		<cfreturn this/>
	</cffunction>
 
    <cffunction name="getServiceVersion" access="remote" returntype="any" output="false" hint="I get service version date">

     <cfreturn variables.version>
     
    </cffunction>      
	
    <cffunction name="getDateServiceStarted" access="remote" returntype="any" output="false" hint="I get the date the service started">

     <cfreturn variables.dateServiceStarted>
     
    </cffunction> 

    <cffunction name="getMessages" access="remote" returntype="any" output="false" hint="I get the messages">
		<cfargument name="system" required="false" default="" type="string" hint="id of system required. ie. LIVE, DEV, TRAIN">
		<cfargument name="liveOnly" required="false" default="" type="string" hint="Y for only current messages">		

        <cfset var qListMessages=variables.messageDAO.getMessageList(system=arguments.system,liveOnly=arguments.liveOnly)>
		<cfset var arrMessages=ArrayNew(1)>
		
		<cfloop query="qListMessages">
		   <cfset arrayAppend(arrMessages,variables.messageDAO.read(id=MESSAGE_ID))>
		</cfloop>
		
		<cfreturn arrMessages>
	
	</cffunction>

    <cffunction name="getMessage" access="remote" returntype="any" output="false" hint="I get a certain message">
		<cfargument name="messageId" required="false" default="" type="string" hint="messageId to get">				
		
		<cfreturn variables.messageDAO.read(Id=arguments.messageId)>
	
	</cffunction>

    <cffunction name="addMessage" access="remote" returntype="any" output="false" hint="Add a new system message, requires form data to be passed in">
     <cfargument name="addForm" required="true" type="Struct" hint="Form of data to add">
 
     <cfset var addMessage="">
	
	 <cfset addMessage=validateMessage(addForm)>
	 
		 <cfif addMessage.valid>

		    <cfset addMessage.Id=variables.messageDAO.createFromForm(addForm)>

		 </cfif>

     <cfreturn addMessage>
     
    </cffunction> 

    <cffunction name="updateMessage" access="remote" returntype="any" output="false" hint="Updates a new system message, requires form data to be passed in">
     <cfargument name="updateForm" required="true" type="Struct" hint="Form of data to update">
 
     <cfset var updMessage="">
	
	 <cfset updMessage=validateMessage(updateForm)>
	 
		 <cfif updMessage.valid>

		    <cfset updMessage.Id=variables.messageDAO.updateFromForm(updateForm)>

		 </cfif>

     <cfreturn updMessage>
     
    </cffunction> 
	
    <cffunction name="validateMessage" access="private" returntype="any" output="false" hint="validates the new message">
     <cfargument name="addForm" required="true" type="Struct" hint="Form of data to add">	
	
	 <cfset var validation=StructNew()>
	 <cfset var str_DateValid="">
	 <cfset var str_TimeValid="">	 
	 <cfset var Validation_CFCs=CreateObject("component","applications.cfc.validation")>
	 
	 <cfset validation.valid=true>
	 <cfset validation.errors="">
	 
		<cfif Len(message) IS 0>
			<cfset validation.valid="NO">
		    <cfset validation.errors=ListAppend(validation.errors,"You must enter a message","|")>	
 	    </cfif>
		
		<cfif Len(messageTitle) IS 0>
			<cfset validation.valid="NO">
		    <cfset validation.errors=ListAppend(validation.errors,"You must enter a message title","|")>	
		</cfif>
		
		<cfif Len(system) IS 0>
			<cfset validation.valid="NO">
		    <cfset validation.errors=ListAppend(validation.errors,"You must select a system","|")>	
		</cfif>		
				
		<cfif Len(startDate) GT 0>
			 <cfset str_DateValid=Validation_CFCs.checkDate(startDate)>
				
		    <cfif str_DateValid IS "NO">
		   	  <cfset str_Valid="NO">
			   <cfset validation.errors=ListAppend(validation.errors,"You must enter a valid start date","|")>	 
		 	 </cfif>
		 <cfelse>
		  <cfset str_Valid="NO">
			   <cfset validation.errors=ListAppend(validation.errors,"You must enter a start date","|")> 
		 </cfif>
		 
		<cfif Len(startTime) GT 0>
			<cfset str_TimeValid=Validation_CFCs.checkTime(startTime)>
				
		    <cfif str_TimeValid IS "NO">
		   	  <cfset str_Valid="NO">
			   <cfset validation.errors=ListAppend(validation.errors,"You must enter a valid start time (HH:mm)","|")>	 
		 	 </cfif>
		 <cfelse>
		  <cfset str_Valid="NO">
			   <cfset validation.errors=ListAppend(validation.errors,"You must enter a valid start time (HH:mm)","|")> 
		 </cfif>		 
		
		<cfif Len(endDate) GT 0>
			 <cfset str_DateValid=Validation_CFCs.checkDate(endDate)>
				
		    <cfif str_DateValid IS "NO">
		   	  <cfset str_Valid="NO">
			   <cfset validation.errors=ListAppend(validation.errors,"You must enter a valid end date","|")>	 
		 	 </cfif>
		 <cfelse>
		  <cfset str_Valid="NO">
			   <cfset validation.errors=ListAppend(validation.errors,"You must enter an end date","|")> 
		 </cfif>
		 
		<cfif Len(endTime) GT 0>
			<cfset str_TimeValid=Validation_CFCs.checkTime(startTime)>
				
		    <cfif str_TimeValid IS "NO">
		   	  <cfset str_Valid="NO">
			   <cfset validation.errors=ListAppend(validation.errors,"You must enter a valid end time (HH:mm)","|")>	 
		 	 </cfif>
		 <cfelse>
		  <cfset str_Valid="NO">
			   <cfset validation.errors=ListAppend(validation.errors,"You must enter a valid end time (HH:mm)","|")> 
		 </cfif>	 
		 
		<cfreturn validation> 
	
	</cffunction>		

    <cffunction name="delMessage" access="remote" returntype="any" output="false" hint="Delete a message, list of admin ids comma seperated to be supplied">
     <cfargument name="chkDel" required="true" type="string" hint="comma seperated list of ids to delete">
 
     <cfset var delMessage="">
	 
	 <cfset delMessage=validateDeleteMessage(arguments.chkDel)>
	 
		 <cfif delMessage.valid>

		    <cfset variables.messageDAO.delete(arguments.chkDel)>
		    
		 </cfif>

     <cfreturn delMessage>
     
    </cffunction>
	
    <cffunction name="validateDeleteMessage" access="private" returntype="any" output="false" hint="validates a delete">
     <cfargument name="messageIds" required="true" type="String" hint="comma seperated list of ids to delete">	
	
	 <cfset var validation=StructNew()>
	 
	 <cfset validation.valid=true>
	 <cfset validation.errors="">
	 
		<cfif ListLen(arguments.messageIds) IS 0>
			<cfset validation.valid="NO">
		    <cfset validation.errors=ListAppend(validation.errors,"You must select some messages to be deleted","|")>	
 	    </cfif>
		 
		<cfreturn validation> 
	
	</cffunction>		

</cfcomponent>
