<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db"
>
    <xsl:output method="xml" encoding="utf-8"/>
    <xsl:include href="para2str.xsl"/>
    <xsl:include href="ends_with.xsl"/>

    <xsl:template match="/db:book">
      <ciods>
        <xsl:apply-templates select="//db:chapter[@xml:id='chapter_A']"/>
      </ciods>
    </xsl:template>

    <xsl:template name="chapter_with_ciod" match="//db:chapter[@xml:id='chapter_A']">
        <xsl:for-each select=".//db:table">
          <xsl:if test="count(db:thead/db:tr/db:th)=4">
              <xsl:call-template name="table_ciod_module_attributes_4_hdr_cols"/>
          </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="table_ciod_module_attributes_4_hdr_cols" match="db:table">
      <xsl:variable name="caption">
        <xsl:value-of select="db:caption/text()"/>
      </xsl:variable>
      <xsl:variable name="is_match">
        <xsl:call-template name="ends-with">
          <xsl:with-param name="s"><xsl:value-of select="$caption"/></xsl:with-param>
          <xsl:with-param name="t"><xsl:value-of select="'IOD Modules'"/></xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$is_match=1">
        <xsl:variable name="id">
          <xsl:value-of select="@xml:id"/>
        </xsl:variable>
        <xsl:variable name="hdr_ie"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[1]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="hdr_module"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[2]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="hdr_reference"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[3]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="hdr_usage"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[4]/db:para"/>
          </xsl:call-template>
        </xsl:variable>

        <ciod_table>
          <id><xsl:value-of select="$id"/></id>
          <caption><xsl:value-of select="$caption"/></caption>
          <items>
            <xsl:choose>
              <xsl:when test="$hdr_ie = 'IE' and 
                              $hdr_module = 'Module' and 
                              $hdr_reference = 'Reference' and 
                              $hdr_usage = 'Usage'">
                <xsl:for-each select=".//db:tr">
                  <xsl:call-template name="table_ciod_module_attributes_4_hdr_cols_row"/>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <error>attribute mismatch</error>
              </xsl:otherwise>
            </xsl:choose>
          </items>
        </ciod_table>
      </xsl:if>
    </xsl:template>

    <xsl:template name="table_ciod_module_attributes_4_hdr_cols_row" match="db:tr">
      <xsl:variable name="nc">
        <xsl:value-of select="count(db:td)"/>
      </xsl:variable>
      <!-- test for number of columns -->
      <xsl:if test="$nc=4">
        <xsl:variable name="ie">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[1]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="module">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[2]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="usage">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[4]/db:para"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="linkend">
          <xsl:value-of select="db:td[3]/db:para//db:xref[1]/@linkend"/>
        </xsl:variable>
        <xsl:variable name="style">
          <xsl:value-of select="db:td[3]/db:para//db:xref[1]/@xrefstyle"/>
        </xsl:variable>
        <ie>
          <name><xsl:value-of select="$ie"/></name>
          <module><xsl:value-of select="$module"/></module>
          <reference>
            <link><xsl:value-of select="$linkend"/></link>
            <style><xsl:value-of select="$style"/></style>
          </reference>
          <usage><xsl:value-of select="$usage"/></usage>
        </ie>
      </xsl:if>
      <xsl:if test="$nc=3">
        <xsl:variable name="module">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[1]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="usage">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[3]/db:para"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="linkend">
          <xsl:value-of select="db:td[2]/db:para//db:xref[1]/@linkend"/>
        </xsl:variable>
        <xsl:variable name="style">
          <xsl:value-of select="db:td[2]/db:para//db:xref[1]/@xrefstyle"/>
        </xsl:variable>
        <ie>
          <name></name>
          <module><xsl:value-of select="$module"/></module>
          <reference>
            <link><xsl:value-of select="$linkend"/></link>
            <style><xsl:value-of select="$style"/></style>
          </reference>
          <usage><xsl:value-of select="$usage"/></usage>
        </ie>
      </xsl:if>
    </xsl:template>
</xsl:stylesheet>
