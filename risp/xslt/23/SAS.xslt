<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2004/07/xpath-functions" xmlns:xdt="http://www.w3.org/2004/07/xpath-datatypes">
	<xsl:include href="d:\genie_assets\risp\xslt\23\hyperlinks.xslt"/>
	<xsl:include href="d:\genie_assets\risp\xslt\23\PrintPage.xslt"/>
	<xsl:template match="/">
		<xsl:variable name="forcename" select="//SAS/CORE_DETAILS/FORCE_NAME"/>
		<xsl:variable name="forceid" select="//SAS/CORE_DETAILS/FORCE"/>
	    <h3 align="center"><xsl:value-of select="//CORE_DETAILS/SYSTEM_NAME"/></h3>				
				<table class="small" border="1" width="95%">
					<tbody>
						<xsl:for-each select="//SAS/SAS_DETAILS/SAS_DETAIL">
							<tr class="tabLab">
								<td>Ref No</td>
								<td>Date</td>
								<td rowspan="4" align="center">
									<img width="150px" height="150px">
										<xsl:attribute name="src">/genie_assets/risp/images/<xsl:value-of select="//SAS/CORE_DETAILS/FORCE"/>/repcrest.gif</xsl:attribute>
									</img>
								</td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:value-of select="REF_NO"/>
								</td>
								<td>
									<xsl:value-of select="DATE_TIME"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td>Stop Type</td>
								<td>Officer</td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:value-of select="STOP_TYPE"/>
								</td>
								<td>
									<xsl:value-of select="concat(RANK,' ',COLLAR_NO,' ',SAS_OFFICER)"/>
									<!--<xsl:value-of select="COLLAR_NO"/>
									<xsl:value-of select="SAS_OFFICER"/>-->
								</td>
							</tr>
							<tr class="tabLab">
								<td>Location</td>
								<td colspan="4">
									<xsl:call-template name="ADDRESS_HYPERLINK">
										<xsl:with-param name="premise_name" select="PREMISE_NAME"/>
										<xsl:with-param name="number" select="LOW_HOUSE_NUMBER"/>
										<xsl:with-param name="street" select="STREET_NAME"/>
										<xsl:with-param name="town" select="POST_TOWN_NAME"/>
										<xsl:with-param name="post_code" select="POSTCODE"/>
									</xsl:call-template>
								</td>
							</tr>
							<xsl:if test="CAR_VRM != ' '">
								<tr class="tabLab">
									<td>Vehicle</td>
									<td colspan="4">
										<xsl:call-template name="VEHICLE_HYPERLINK">
											<xsl:with-param name="vrm" select="CAR_VRM"/>
											<xsl:with-param name="make" select="CAR_MAKE"/>
											<xsl:with-param name="model" select="CAR_MODEL"/>
											<xsl:with-param name="color" select="CAR_COLOURS"/>
										</xsl:call-template>
									</td>
								</tr></xsl:if>
								<xsl:if test="OTHER_INFO != ''">
									<tr>
										<td class="tabLAb">Notes</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="PrintDivNotesLong">
												<xsl:value-of select="OTHER_INFO"/>
											</div>
										</td>
									</tr>
								</xsl:if>
						</xsl:for-each>
						<tr>
							<th colspan="5">People Involved</th>
						</tr>
						<tr>
							<td colspan="5">
								<div class="PrintDivNotesLonger" style="height:120">
									<table class="small" border="1" width="95%">
										<tbody>
											<tr class="tabLab">
												<td>Name</td>
												<td>Address</td>
												<td>Outcome</td>
											</tr>
											<xsl:for-each select="//SAS/SAS_PEOPLE/SAS_PERSON">
												<tr>
													<td>
														<xsl:call-template name="NAME_HYPERLINK">
															<xsl:with-param name="surname" select="SURNAME"/>
															<xsl:with-param name="forenames" select="FORENAMES"/>
															<xsl:with-param name="dob" select="DOB"/>
														</xsl:call-template>
													</td>
													<td>
														<xsl:call-template name="ADDRESS_HYPERLINK">
															<xsl:with-param name="premise_name" select="PREMISE_NAME"/>
															<xsl:with-param name="number" select="LOW_HOUSE_NUMBER"/>
															<xsl:with-param name="street" select="STREET_NAME"/>
															<xsl:with-param name="town" select="POST_TOWN_NAME"/>
															<xsl:with-param name="post_code" select="POSTCODE"/>
														</xsl:call-template>
													</td>
													<td>
														<xsl:value-of select="ARRESTED"/>
													</td>
												</tr>
											</xsl:for-each>
										</tbody>
									</table>
								</div>
							</td>
						</tr>
						<xsl:if test="count(//SAS/SAS_DESCRIPTIONS/SAS_DESCRIPTION) > 0">
						<tr>
							<th colspan="5">Description</th>
						</tr>
						<tr>
							<td colspan="5">
								<div class="PrintDivNotesLonger" style="height:100"	>
									<table class="small" border="1" width="95%">
										<tbody>
											<xsl:for-each select="//SAS/SAS_DESCRIPTIONS/SAS_DESCRIPTION">
												<tr>
													<td width="25%"	 class="tabLab">Height</td>
													<td><xsl:value-of select="HEIGHT"/></td>
												</tr>
												<tr>
													<td class="tabLab">Hair</td>
													<td><xsl:value-of select="HAIR"/></td>
												</tr>
												<tr>
													<td class="tabLab">Build</td>
													<td><xsl:value-of select="BUILD"/></td>
												</tr>
												<tr>
													<td class="tabLab">Scars or Tattoos</td>
													<td><xsl:value-of select="SCAR_TATTOO"/></td>
												</tr>
												<tr>
													<td class="tabLab">Sex</td>
													<td><xsl:value-of select="SEX"/></td>
												</tr>
												<tr>
													<td class="tabLab">Eye colour</td>
													<td><xsl:value-of select="EYE_COLOUR"/></td>
												</tr>
											</xsl:for-each>
										</tbody>
									</table>
								</div>
							</td>
						</tr>
						</xsl:if>
					</tbody>
				</table>
	</xsl:template>
</xsl:stylesheet>
