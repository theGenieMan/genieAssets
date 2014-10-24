<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2004/07/xpath-functions" xmlns:xdt="http://www.w3.org/2004/07/xpath-datatypes">
	<xsl:include href="d:\genie_assets\risp\xslt\20\hyperlinks.xslt"/>
	<xsl:include href="d:\genie_assets\risp\xslt\20\PrintPage.xslt"/>
	<xsl:template match="/">
	<h3 align="center"><xsl:value-of select="//CORE_DETAILS/SYSTEM_NAME"/></h3>	
				<table class="small" border="1" width="95%">
					<tbody>
						<xsl:for-each select="//PUBDIS/VP1_DETAILS/VP1_DETAIL">
							<tr class="tabLab">
								<td colspan="2">Offence</td>
							</tr>
							<tr class="tabField">
								<td colspan="2">
									<xsl:value-of select="VFLF_WORDING"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td colspan="2">Notice Issued</td>
							</tr>
							<tr class="tabField">
								<td colspan="2">
									<xsl:value-of select="VFNG_NAME"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td colspan="2">Location</td>
							</tr>
							<tr class="tabField">
								<td colspan="2">
									<xsl:value-of select="VFLO_DESC1"/>,<xsl:value-of select="VFLO_DESC2"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td>Notice type</td>
								<td>Date Issued</td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:value-of select="VFNT_NAME"/>
								</td>
								<td>
									<xsl:value-of select="VFN_ISSUE_DATE"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td>Notice state</td>
								<td>Date Recorded</td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:value-of select="VFN_STATE"/>
								</td>
								<td>
									<xsl:value-of select="VFN_OFFENCE_DATE"/>
								</td>
							</tr>
							<tr class="tabLab">
								<td>Notice status</td>
								<td>Time Issued</td>
							</tr>
							<tr class="tabField">
								<td>
									<xsl:value-of select="VFN_STATUS"/>
								</td>
								<td>
									<xsl:value-of select="TIME"/>
								</td>
							</tr>
						</xsl:for-each>
						<tr>
							<th colspan="3">People</th>
						</tr>
						<tr>
							<td colspan="3">
								<div class="PrintDivNotesLonger">
									<table class="small" border="1" width="95%">
										<tbody>
											<tr class="tabLab">
												<td>Name</td>
												<td>Address</td>
											</tr>
											<xsl:for-each select="//PUBDIS/VP1_PEOPLE/VP1_PERSON">
												<tr class="tabField">
													<td>
														<xsl:call-template name="NAME_HYPERLINK">
														<xsl:with-param name="surname" select="VFPN_SURNAME"/>
														<xsl:with-param name="forenames" select="VFPN_FORENAMES"/>
														<xsl:with-param name="dob" select="VFPN_DOB"/>
														</xsl:call-template>
													</td>
													<td>
															<xsl:value-of select="VFAD_LINE1"/><xsl:if test="VFAD_LINE2 != ' '">,<xsl:value-of select="VFAD_LINE2"/></xsl:if><xsl:if test="VFAD_LINE3 != ' '">,<xsl:value-of select="VFAD_LINE3"/></xsl:if><xsl:if test="VFAD_LINE4 != ' '">,<xsl:value-of select="VFAD_LINE4"/></xsl:if><xsl:if test="VFAD_LINE5 != ' '">,<xsl:value-of select="VFAD_LINE5"/></xsl:if><xsl:if test="VFAD_POST_CODE != ' '">,<xsl:value-of select="VFAD_POST_CODE"/></xsl:if>
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
				<xsl:call-template name="PrintPage">
					<xsl:with-param name="dom" select="./."/>
				</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
