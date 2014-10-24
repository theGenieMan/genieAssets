<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2004/07/xpath-functions" xmlns:xdt="http://www.w3.org/2004/07/xpath-datatypes">
	<xsl:template match="/.">
		<xsl:variable name="SID" select="WARNT/CORE_DETAILS/SYSTEM_NAME"	/>
		<xsl:variable name="forcename" select="WARNT/CORE_DETAILS/FORCE_NAME"	/>
		<xsl:variable name="forceid"	select="WARNT/CORE_DETAILS/FORCE"	/>
		<html>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
			<meta http-equiv="pragma" content="nocache"/>
			<link href="..\StyleSheets\Flintsweb.css" type="text/css" rel="stylesheet"/>
			<head>
			<script>
			function ShowMess()
			{
				alert('This warrant has not been executed according to the <xsl:value-of select="$SID"/>.  Further enquiries maybe necessary to confirm the status of this warrant before acting on this information.');
			}
			</script>
			</head>
			<body style=" margin:2px; padding: 2px;" scroll="no" ondragstart="return false" >
				<xsl:if test="WARNT/WAR_DETAILS/WAR_DETAIL/WAR_STATUS='LIVE'">
					<!--<xsl:attribute name="onload">
						ShowMess();
					</xsl:attribute>-->
				</xsl:if>
				<table class="small" border="1" width="95%">
					<tbody>
						<xsl:for-each select="WARNT/WAR_DETAILS/WAR_DETAIL">
							<tr class="tabLab">
								<td>Warrant No.</td>
								<td>Year</td>
								<td>Date Registered</td>
								<td rowspan="4" align="center">
								<img height="60px" width="40px">
								<xsl:attribute name="src">
									..\heLpers\getcrest.aspx?FORCE=<xsl:value-of select="$forceid"/>
								</xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="$forcename"/></xsl:attribute>
								</img></td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:value-of select="ASU_WARRANT_SEQ"/>
								</td>
								<td>
									<xsl:value-of select="ASU_WARRANT_YEAR"/>
								</td>
								<td>
									<xsl:value-of select="DATE_REGISTERED"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td>Managing OCU</td>
								<td>Registering OCU</td>
								<td>Type</td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:value-of select="MANAGING_DIVISION"/>
								</td>
								<td>
									<xsl:value-of select="REGISTERING_DIVISION"/>
								</td>
								<td>
									<xsl:value-of select="WARRANT_TYPE"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td>Days to Dispose</td>
								<td/>
								<td colspan="2">Date of Disposal</td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:value-of select="DAYS_TO_DISPOSE"/>
								</td>
								<td/>
								<td>
									<xsl:value-of select="DATE_OF_DISPOSAL"/>
								</td>
							</tr>
							<tr>
								<td class="tabLab">Status</td>
								<td class="tabField" colspan="3">
									<xsl:if test="WAR_STATUS='LIVE'">
										<table width="100%" cellpadding="0" cellspacing="0"><tr><td width="5%">
										<img height="15" width="15" src="..\images\redbull.gif" onclick="ShowMess();" alt="Warning"/></td><td width="90%"><marquee style="color:red"><b>!!!! LIVE !!!! Please check <xsl:value-of select="$SID"/>	 to confirm !!!! LIVE !!!!</b></marquee></td><td width="5%">
										<img height="15" width="15" src="..\images\redbull.gif" onclick="ShowMess();" alt="Warning"/></td></tr></table>
									</xsl:if>
									<xsl:if test="WAR_STATUS!='LIVE'">
										<xsl:value-of select="WAR_STATUS"/>
									</xsl:if>
								</td>
							</tr>
							<tr>
								<td class="tabLab">Executed by</td>
								<td class="tabField" colspan="3">
									<xsl:value-of select="EXECUTED_BY"/>
								</td>
							</tr>
							<tr>
								<td class="tabLab">Issuing court</td>
								<td class="tabField" colspan="3">
									<xsl:value-of select="ISSUING_COURT"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td>Fine Amount.</td>
								<td>Amount Paid.</td>
								<td colspan="2"	>Backed for bail</td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:value-of select="FINE_AMOUNT"/>
								</td>
								<td>
									<xsl:value-of select="AMOUNT_PAID"/>
								</td>
								<td colspan="2"	>
									<xsl:value-of select="BACKED_FOR_BAIL"/>
								</td>
							</tr>
							<tr>
								<td class="tabLab">Court Warrant No.</td>
								<td class="tabField" colspan="3">
									<xsl:value-of select="COURT_WARRANT_NO"/>
								</td>
							</tr>
							<tr>
								<td class="tabLab" colspan="4">Person details</td>
							</tr>
							<tr>
								<td class="tabLab">Name</td>
								<td class="tabField" colspan="3">
									<xsl:value-of select="SURNAME"/>,<xsl:value-of select="FORENAMES"/>,<xsl:value-of select="DOB"/>
								</td>
							</tr>
							<tr>
								<td class="tabLab">CRO No.</td>
								<td class="tabField" colspan="3">
									<xsl:value-of select="CRO_NUMBER"/>
								</td>
							</tr>
						</xsl:for-each>
						<tr>
							<th colspan="4">Addresses</th>
						</tr>
						<tr>
							<td colspan="4">
								<div class="PrintDivNotesLonger">
									<table class="small" border="1" width="95%">
										<tbody>
											<tr class="tabLab">
												<td>No</td>
												<td>Type</td>
												<td>Address</td>
											</tr>
											<xsl:for-each select="WARNT/WAR_ADDRESSES/WAR_ADDRESS">
												<tr>
													<td>
														<xsl:value-of select="ADDRESS_NO"/>
													</td>
													<td>
														<xsl:value-of select="ADD_TYPE"/>
													</td>
													<td>
														<a target="_top">
															<xsl:attribute name="href">
													../Searches/FLINTSSEARCH.ASPX?TYPE%3dAS%26STREET%3d<xsl:value-of select="translate(ADD2,',','')"/>%26NUMBER%3d<xsl:value-of select="translate(ADD1,',',' ')"/>%26TOWN%3d<xsl:value-of select="translate(TOWN,',',' ')"/>%26TCHANDLE%3DTRUE%26TCFORMNAME%3dfrmADD%26ID%3dNS2
													</xsl:attribute>
															<xsl:value-of select="translate(ADD1,',',' ')"/>,<xsl:value-of select="translate(ADD2,',',' ')"/>,<xsl:value-of select="translate(DISTRICT,',',' ')"/>,<xsl:value-of select="translate(TOWN,',',' ')"/>,<xsl:value-of select="translate(COUNTY,',',' ')"/>,<xsl:value-of select="translate(POSTCODE,',',' ')"/>
														</a>
													</td>
												</tr>
											</xsl:for-each>
										</tbody>
									</table>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
