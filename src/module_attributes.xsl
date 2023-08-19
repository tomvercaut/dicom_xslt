<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db"
>
    <xsl:output method="xml" encoding="utf-8"/>
    <xsl:include href="para2str.xsl"/>
    <xsl:include href="ends_with.xsl"/>

    <xsl:template match="/db:book">
      <module_attributes>
        <xsl:apply-templates select="//db:chapter[@xml:id!='chapter_5']"/>
      </module_attributes>
    </xsl:template>

    <xsl:template name="chapter_with_modules" match="//db:chapter">
        <xsl:for-each select=".//db:table">
          <xsl:if test="count(db:thead/db:tr/db:th)=3">
              <xsl:call-template name="table_module_attributes_3_hdr_cols"/>
          </xsl:if>
          <xsl:if test="count(db:thead/db:tr/db:th)=4">
              <xsl:call-template name="table_module_attributes_4_hdr_cols"/>
          </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="table_module_attributes_3_hdr_cols" match="db:table">
      <xsl:variable name="caption">
        <xsl:value-of select="db:caption/text()"/>
      </xsl:variable>
      <xsl:variable name="is_match">
        <xsl:call-template name="ends-with">
          <xsl:with-param name="s"><xsl:value-of select="$caption"/></xsl:with-param>
          <xsl:with-param name="t"><xsl:value-of select="'Module Attributes'"/></xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$is_match=1">
        <xsl:variable name="id">
          <xsl:value-of select="@xml:id"/>
        </xsl:variable>
        <xsl:variable name="hdr_attr_name"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[1]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="hdr_tag"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[2]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="hdr_desc"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[3]/db:para"/>
          </xsl:call-template>
        </xsl:variable>

        <module_attributes_table>
          <id><xsl:value-of select="$id"/></id>
          <caption><xsl:value-of select="$caption"/></caption>
          <items>
            <xsl:choose>
              <xsl:when test="$hdr_attr_name = 'Attribute Name' and 
                              $hdr_tag = 'Tag' and 
                              $hdr_desc = 'Attribute Description'">
                <xsl:for-each select=".//db:tr">
                  <xsl:call-template name="table_module_attributes_3_hdr_cols_row"/>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <error>attribute mismatch</error>
              </xsl:otherwise>
            </xsl:choose>
          </items>
        </module_attributes_table>
      </xsl:if>
    </xsl:template>

    <xsl:template name="table_module_attributes_4_hdr_cols" match="db:table">
      <xsl:variable name="caption">
        <xsl:value-of select="db:caption/text()"/>
      </xsl:variable>
      <xsl:variable name="is_match">
        <xsl:call-template name="ends-with">
          <xsl:with-param name="s"><xsl:value-of select="$caption"/></xsl:with-param>
          <xsl:with-param name="t"><xsl:value-of select="'Module Attributes'"/></xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$is_match=1">
        <xsl:variable name="id">
          <xsl:value-of select="@xml:id"/>
        </xsl:variable>
        <xsl:variable name="hdr_attr_name"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[1]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="hdr_tag"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[2]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="hdr_type"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[3]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="hdr_desc"> 
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:thead/db:tr/db:th[4]/db:para"/>
          </xsl:call-template>
        </xsl:variable>

        <module_attributes_table>
          <id><xsl:value-of select="$id"/></id>
          <caption><xsl:value-of select="$caption"/></caption>
          <items>
            <xsl:choose>
              <xsl:when test="$hdr_attr_name = 'Attribute Name' and 
                              $hdr_tag = 'Tag' and 
                              $hdr_type = 'Type' and 
                              $hdr_desc = 'Attribute Description'">
                <xsl:for-each select=".//db:tr">
                  <xsl:call-template name="table_module_attributes_4_hdr_cols_row"/>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <error>attribute mismatch</error>
              </xsl:otherwise>
            </xsl:choose>
          </items>
        </module_attributes_table>
      </xsl:if>
    </xsl:template>

   <xsl:template name="table_module_attributes_3_hdr_cols_row" match="db:tr">
      <xsl:variable name="nc">
        <xsl:value-of select="count(db:td)"/>
      </xsl:variable>
      <!-- test for number of columns -->
      <xsl:if test="$nc=3">
        <xsl:variable name="name">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[1]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="tag">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[2]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="desc">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[3]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <item>
          <name><xsl:value-of select="$name"/></name>
          <tag><xsl:value-of select="$tag"/></tag>
          <!-- <description><xsl:value-of select="$desc"/></description> -->
        </item>
      </xsl:if>
      <xsl:if test="$nc=2">
        <xsl:choose>
          <xsl:when test="db:td[1]/db:para//db:xref and contains(db:td[1]/db:para, 'Include')">
            <xsl:variable name="para_c0">
              <xsl:value-of select="db:td[1]/db:para"/>
            </xsl:variable>
            <xsl:variable name="xref_c0">
              <xsl:value-of select="db:td[1]/db:para//db:xref[1]"/>
            </xsl:variable>
            <xsl:variable name="linkend">
              <xsl:value-of select="db:td[1]/db:para//db:xref[1]/@linkend"/>
            </xsl:variable>
            <xsl:variable name="style">
              <xsl:value-of select="db:td[1]/db:para//db:xref[1]/@xrefstyle"/>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="$para_c0">
                <include>
                  <text><xsl:value-of select="normalize-space($para_c0)"/></text>
                  <reference>
                    <link><xsl:value-of select="$linkend"/></link>
                    <style><xsl:value-of select="$style"/></style>
                  </reference>
                </include>
              </xsl:when>
              <xsl:otherwise>
                <error>
                  Attribute table with 3 columns, row has two columns: expected an xref on the first column.
                </error>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
        </xsl:choose>
      </xsl:if>
    </xsl:template>
 
    <xsl:template name="table_module_attributes_4_hdr_cols_row" match="db:tr">
      <xsl:variable name="nc">
        <xsl:value-of select="count(db:td)"/>
      </xsl:variable>
      <!-- test for number of columns -->
      <xsl:if test="$nc=4">
        <xsl:variable name="name">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[1]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="tag">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[2]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="type">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[3]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="desc">
          <xsl:call-template name="para2str">
            <xsl:with-param name="para" select="db:td[4]/db:para"/>
          </xsl:call-template>
        </xsl:variable>
        <item>
          <name><xsl:value-of select="$name"/></name>
          <tag><xsl:value-of select="$tag"/></tag>
          <type><xsl:value-of select="$type"/></type>
          <!-- <description><xsl:value-of select="$desc"/></description> -->
        </item>
      </xsl:if>
      <xsl:if test="$nc=2">
        <xsl:choose>
          <xsl:when test="db:td[1]/db:para//db:xref and contains(db:td[1]/db:para, 'Include')">
            <xsl:variable name="para_c0">
              <xsl:value-of select="db:td[1]/db:para"/>
            </xsl:variable>
            <xsl:variable name="xref_c0">
              <xsl:value-of select="db:td[1]/db:para//db:xref[1]"/>
            </xsl:variable>
            <xsl:variable name="linkend">
              <xsl:value-of select="db:td[1]/db:para//db:xref[1]/@linkend"/>
            </xsl:variable>
            <xsl:variable name="style">
              <xsl:value-of select="db:td[1]/db:para//db:xref[1]/@xrefstyle"/>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="$para_c0">
                <include>
                  <text><xsl:value-of select="normalize-space($para_c0)"/></text>
                  <reference>
                    <link><xsl:value-of select="$linkend"/></link>
                    <style><xsl:value-of select="$style"/></style>
                  </reference>
                </include>
              </xsl:when>
              <xsl:otherwise>
                <error>
                  Attribute table with 4 columns, row has two columns: expected an xref on the first column.
                </error>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
        </xsl:choose>
      </xsl:if>
    </xsl:template>
</xsl:stylesheet>
