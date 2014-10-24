<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2004/07/xpath-functions" xmlns:xdt="http://www.w3.org/2004/07/xpath-datatypes">
	<xsl:include href="d:\genie_assets\risp\xslt\30\hyperlinks.xslt"/>
	<xsl:include href="d:\genie_assets\risp\xslt\30\PrintPage.xslt"/>
	<xsl:template match="/">
		<xsl:variable name="resid" select="generate-id(.)"/>
		<table class="small" border="1" width="90%">
			<tbody>
				<xsl:for-each select="//CRIME_HEADER">
					<tr class="tabLab">
						<td rowspan="4"  width="20%">
							<img width="80px" height="40px">
								<xsl:attribute name="src">/genie_assets/risp/images/<xsl:value-of select="//CORE_DETAILS/FORCE"/>/repcrest.gif</xsl:attribute>
							</img>
						</td>
					</tr>
					<tr>
						<td  width="40%" class="tabLab">
							Crime Number
						</td>
						<td  width="40%" class="tabLab">Date Commited</td>
					</tr>
					<tr>
						<td >
							<xsl:value-of select="CRIME_NUMBER"/>
						</td>
						<TD>
							<xsl:value-of select="DATE_FIRST_COMMITED"/>
						</TD>
					</tr>
					<tr>
						<td class="tabLab">
							Offence Type
						</td>
						<td><xsl:value-of select="CRIME_CAT"/></td>
					</tr>
					<tr>
						<td colspan="3">
							<b>Location:</b>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div class="PrintDivNotes">
								<xsl:value-of select="LOCATION"/>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<b>MO:</b>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div class="PrintDivNotesLong">
								<xsl:value-of select="MO_NOTES"/>
							</div>
						</td>
					</tr>
				</xsl:for-each>
				</tbody>
				</table>
				<div class="PrintDivNotesLonger" style="background-color:silver;height:250px;widht:90%">
				Links to crime:
		<table class="small" border="1" width="90%">
			<xsl:for-each select="//CRIME_LINK">
				<tr>
					<td><xsl:value-of select="ASSOCIATION"/></td>
					<td colspan="2">
					<xsl:choose>
						<xsl:when test="LINKS/LINK/ASSOC_TYPE='Crime'">
							Crime Reference : <xsl:value-of select="LINKS/LINK/CRN"/>
						</xsl:when>
						<xsl:when test="LINKS/LINK/ASSOC_TYPE='Nominal'">
							<table class="small">
									<tr>
										<td class="tabLab">Nominal</td>
									</tr>
									<tr>
										<td>
											<xsl:call-template name="NAME_HYPERLINK">
												<xsl:with-param name="surname" select="LINKS/LINK/SURNAME"/>
												<xsl:with-param name="forenames" select="LINKS/LINK/FORENAME"/>
												<xsl:with-param name="dob" select="LINKS/LINK/DOB"/>
											</xsl:call-template>
										</td>
									</tr>
									<xsl:if test="LINKS/LINK/CRO!=''">
									<tr>
										<td class="tabLab">CRO : <xsl:value-of select="LINKS/LINK/CRO"/></td>
									</tr>
									</xsl:if>
									<xsl:if test="LINKS/LINK/NOTES!=''">
									<tr>
										<td class="tabLab">Notes:</td>
									</tr>
									<tr>
										<td class="PrintDivNotes"><xsl:value-of select="LINKS/LINK/NOTES"/></td>
									</tr>
									</xsl:if>
									<xsl:if test="LINKS/LINK/WARNING!=''">
									<tr>
										<td class="tabLab">Warning<xsl:value-of select="LINKS/LINK/WARNING"/></td>
									</tr>
									</xsl:if>
							</table>
						</xsl:when>
						<xsl:when test="LINKS/LINK/ASSOC_TYPE='Address'">
							<table class="small">
									<td colspan="2">
									<xsl:call-template name="ADDRESS_HYPERLINK">
										<xsl:with-param name="premise_name" select="LINKS/LINK/PREMISE_NAME"/>
										<xsl:with-param name="number" select="LINKS/LINK/PREMISE_NO"/>
										<xsl:with-param name="street" select="LINKS/LINK/STREET"/>
										<xsl:with-param name="post_code" select="LINKS/LINK/POSTCODE"/>
									</xsl:call-template>
								</td>
									<xsl:if test="LINKS/LINK/NOTES!=''">
									<tr>
										<td class="tabLab">Notes:</td>
									</tr>
									<tr>
										<td class="PrintDivNotes"><xsl:value-of select="LINKS/LINK/NOTES"/></td>
									</tr>
									</xsl:if>
									<xsl:if test="LINKS/LINK/WARNING!=''">
									<tr>
										<td class="tabLab">Warning<xsl:value-of select="LINKS/LINK/WARNING"/></td>
									</tr>
									</xsl:if>
							</table>
							</xsl:when>
							<xsl:when test="LINKS/LINK/ASSOC_TYPE='Organisation'">
							<table class="small">
									<tr>
										<td class="tabLab">Name:</td>
										<td><xsl:value-of select="LINKS/LINK/ORG_NAME"/></td>
									</tr>
									<tr>
										<td class="tabLab">Name:</td>
										<td><xsl:value-of select="LINKS/LINK/ORG_TEXT"/></td>
									</tr>
									<xsl:if test="LINKS/LINK/NOTES!=''">
									<tr>
										<td class="tabLab">Notes:</td>
									</tr>
									<tr>
										<td class="PrintDivNotes"><xsl:value-of select="LINKS/LINK/NOTES"/></td>
									</tr>
									</xsl:if>
									<xsl:if test="LINKS/LINK/WARNING!=''">
									<tr>
										<td class="tabLab">Warning<xsl:value-of select="LINKS/LINK/WARNING"/></td>
									</tr>
									</xsl:if>
							</table>
						</xsl:when>
						<xsl:otherwise>Unknown link</xsl:otherwise>
					</xsl:choose>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		</div>
		<!--
		<xsl:call-template name="PrintPage">
			<xsl:with-param name="DomId" select="$resid"/>		
			<xsl:with-param name="dom" select="./."/>
		</xsl:call-template>-->
	</xsl:template>
</xsl:stylesheet>
