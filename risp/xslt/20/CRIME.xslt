<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2004/07/xpath-functions" xmlns:xdt="http://www.w3.org/2004/07/xpath-datatypes">
	<xsl:include href="d:\genie_assets\risp\xslt\20\hyperlinks.xslt"/>
	<xsl:include href="d:\genie_assets\risp\xslt\20\PrintPage.xslt"/>
	<xsl:template match="/">
				<xsl:variable name="resid" select="generate-id(.)"/>
				<h3 align="center"><xsl:value-of select="//CORE_DETAILS/SYSTEM_NAME"/></h3>	
				<table class="small" border="1" width="90%">
					<tbody>
						<xsl:for-each select="//CRIME_HEADER">
							<tr class="tabLab">
								<td rowspan="6" width="5%">
									<img width="80px" height="80px">
										<xsl:attribute name="src">/genie_assets/risp/images/<xsl:value-of select="ORG_CODE"/>/repcrest.gif</xsl:attribute>
									</img>
								</td>
								<td width="40%">Crime Ref No</td>
								<td width="40%">Detected</td>
							</tr>
							<tr class="tabField">
								<td>
									<b><xsl:value-of select="CRIME_NUMBER"/></b>
								</td>
								<td>
									<xsl:value-of select="DETECTED"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td>Date From</td>
								<td>Date To</td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:call-template name="FORMAT_DATE">
										<xsl:with-param name="indate" select="DATE_FIRST_COMMITED"/>
									</xsl:call-template>&#160;<xsl:value-of select="TIME_FIRST_COMMITED"/>
								</td>
								<td>
									<xsl:call-template name="FORMAT_DATE">
										<xsl:with-param name="indate" select="DATE_LAST_COMMITED"/>
									</xsl:call-template>&#160;<xsl:value-of select="TIME_LAST_COMMITED"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td width="33%">Date Cleared Up</td>
								<td width="33%">Last Updated</td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:call-template name="FORMAT_DATE">
										<xsl:with-param name="indate" select="DATE_CLEARED_UP"/>
									</xsl:call-template>&#160;
								</td>
								<td>
									<xsl:call-template name="FORMAT_DATE">
										<xsl:with-param name="indate" select="LAST_UPDATE"/>
									</xsl:call-template>&#160;
								</td>
							</tr>
							<tr>
								<td class="tabLab">Offence</td>
								<td colspan="2" class="tabField">
									<xsl:value-of select="OFFENCE"/>
								</td>
							</tr>
							<tr>
								<td class="tabLab">Location</td>
								<td class="tabField" colspan="2">
									<xsl:call-template name="ADDRESS_HYPERLINK">
										<xsl:with-param name="premise_name" select="LOCN_NAME"/>
										<xsl:with-param name="number" select="LOCN_NUMBER"/>
										<xsl:with-param name="street" select="LOCN_STREET"/>
										<xsl:with-param name="town" select="LOCN_TOWN"/>
										<xsl:with-param name="post_code" select="LOCN_POSTCODE"/>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td class="tabLab" valign="top">MO</td>
								<td colspan="2" class="tabField">
									<xsl:value-of select="MO_NOTES"/>
								</td>
							</tr>
							<xsl:if test="../../CRIME_DESCRIPTIONS/CRIME_DESCRIPTION!=''">
							<tr>
								<td class="tabLab">Description</td>
								<td colspan="2" class="tabField">
									<xsl:value-of select="../../CRIME_DESCRIPTIONS/CRIME_DESCRIPTION"/>
								</td>
							</tr>
							</xsl:if>
						</xsl:for-each>
					</tbody>
				</table>

					
					<h3>Persons Involved</h3>
						<table class="small" border="1" width="90%">
							<tbody>
								<tr class="tabLab">
									<td>Name</td>
									<td>Address</td>
									<td>Role</td>
								</tr>
								<xsl:for-each select="//CRIME_PERSON">
									<tr>
										<td>
										  <b>
											<xsl:if test="BADGE_NUMBER='N/A'">
											<xsl:call-template name="NAME_HYPERLINK">
												<xsl:with-param name="surname" select="SURNAME"/>
												<xsl:with-param name="forenames" select="FORENAME"/>
												<xsl:with-param name="dob" select="DATE_OF_BIRTH"/>
											</xsl:call-template>
											</xsl:if>
											<xsl:if test="BADGE_NUMBER!='N/A'">
												<xsl:value-of select="BADGE_NUMBER"/>,<xsl:value-of select="SURNAME"/>,<xsl:value-of select="FORENAME"/>
											</xsl:if>
									          </b>
										</td>
										<td>
											<xsl:if test="BADGE_NUMBER='N/A'">
											<xsl:call-template name="ADDRESS_HYPERLINK">
												<xsl:with-param name="premise_name" select="PREMISE_NAME"/>
												<xsl:with-param name="number" select="LOW_HOUSE_NUMBER"/>
												<xsl:with-param name="street" select="STREET_NAME"/>
												<xsl:with-param name="town" select="POST_TOWN_NAME"/>
												<xsl:with-param name="post_code" select="POSTCODE"/>
											</xsl:call-template>
											</xsl:if>	
											<xsl:if test="BADGE_NUMBER!='N/A'">
												police employee
											</xsl:if>	
										</td>
										<td>
											<xsl:value-of select="ROLE_TYPE"/>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					
					<xsl:if test="count(//CRIME_UOD) > 0">
						<h3>Descriptions</h3>
							<table class="small" border="1" width="90%">
								<tbody>
									<tr class="tabLab">
										<td>Sex</td>
										<td>Ethnicity</td>
										<td>Height</td>
										<td>Build</td>
										<td>Hair</td>
										<td>Fac. Hair</td>
										<td>Accent</td>
										<td>Clothing</td>
									</tr>
									<xsl:for-each select="//CRIME_UOD">
										<tr>
											<td>
												<xsl:value-of select="SEX"/>
											</td>
											<td>
												<xsl:value-of select="DSP_ETHNICITY"/>
											</td>
											<td>
												<xsl:value-of select="HEIGHT"/>
											</td>
											<td>
												<xsl:value-of select="DSP_BUILD"/>
											</td>
											<td>
												<xsl:value-of select="DSP_HAIRCOLOUR"/>
											</td>
											<td>
												<xsl:value-of select="DSP_FACIALHAIR"/>
											</td>
											<td>
												<xsl:value-of select="DSP_ACCENT"/>
											</td>
											<td>
												<xsl:value-of select="CLOTHING"/>
											</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
					</xsl:if>
					<xsl:if test="count(//CRIME_PROPERTY) > 0">
						<h3>Property</h3>
							<table class="small" border="1" width="90%">
								<tbody>
									<tr class="tabLab">
										<td>Type</td>
										<td>Status</td>
										<td>Description</td>
										<td>Value</td>
									</tr>
									<xsl:for-each select="//CRIME_PROPERTY">
										<tr>
											<td>
												<xsl:value-of select="CAT_DESC"/>
											</td>
											<td>
												<xsl:value-of select="STATUS"/>
											</td>
											<td>
												<xsl:value-of select="DETAIL_LINE"/>
												<xsl:if test="NOTES!=''">
													<div class="PrintDivNotes">
														<xsl:value-of select="NOTES"/>
													</div>
												</xsl:if>
											</td>
											<td>
												<xsl:value-of select="PROPERTY_VALUE"/>
											</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
					</xsl:if>
					
					<xsl:if test="count(//CRIME_INTEREST) > 0">
						<h3>Special Interest Markers</h3>
							<table class="small" border="1" width="90%">
								<tbody>
									<tr class="tabLab">
										<td>Marker</td>
										<td>Description</td>
										<td>Date Created</td>
									</tr>
									<xsl:for-each select="//CRIME_INTEREST">
										<tr>
											<td>
												<xsl:value-of select="MARKER"/>
											</td>
											<td>
												<xsl:value-of select="DESCRIPTION"/>
											</td>
											<td>
												<xsl:value-of select="DATE_CREATED"/>
											</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
					</xsl:if>					
			    
                <!--
				<xsl:call-template name="PrintPage">
					<xsl:with-param name="DomId" select="$resid"/>		
					<xsl:with-param name="dom" select="./."/>
				</xsl:call-template>
				-->
	</xsl:template>
</xsl:stylesheet>
