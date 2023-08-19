<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db"
>

    <xsl:output method="xml" encoding="utf-8"/>
    <xsl:include href="para2str.xsl"/>

    <xsl:template match="/db:book">
      <registry>
        <xsl:apply-templates select="//db:chapter[@xml:id='chapter_6']"/>
      </registry>
    </xsl:template>

    <xsl:template name="chapter_6" match="//db:chapter[@xml:id='chapter_6']">
        <!--        <xsl:value-of select="db:title"/>-->
        <xsl:apply-templates select="//db:table[@xml:id='table_6-1']"/>
    </xsl:template>

    <xsl:template name="table_6-1" match="//db:table[@xml:id='table_6-1']">
        <xsl:if test="db:caption='Registry of DICOM Data Elements'">
            <xsl:if test="count(db:thead/db:tr/db:th)=6">
              <data_elements>
                <xsl:apply-templates select="db:tbody/db:tr"/>
              </data_elements>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template name="table_rows" match="db:tr">
        <xsl:variable name="tag">
            <xsl:call-template name="para2str">
                <xsl:with-param name="para" select="db:td[1]/db:para"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="name">
            <xsl:call-template name="para2str">
                <xsl:with-param name="para" select="db:td[2]/db:para"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="keyword">
            <xsl:call-template name="para2str">
                <xsl:with-param name="para" select="db:td[3]/db:para"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="vr">
            <xsl:call-template name="para2str">
                <xsl:with-param name="para" select="db:td[4]/db:para"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="vm">
            <xsl:call-template name="para2str">
                <xsl:with-param name="para" select="db:td[5]/db:para"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="retired">
            <xsl:choose>
                <xsl:when test="db:td[6]/db:para/db:emphasis">true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <element>
          <tag><xsl:value-of select="$tag"/></tag>
          <name><xsl:value-of select="$name"/></name>
          <keyword><xsl:value-of select="$keyword"/></keyword>
          <vr><xsl:value-of select="$vr"/></vr>
          <vm><xsl:value-of select="$vm"/></vm>
          <retired><xsl:value-of select="$retired"/></retired>
        </element>
    </xsl:template>
</xsl:stylesheet>
