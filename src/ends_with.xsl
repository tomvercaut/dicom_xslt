<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template name="ends-with">
        <xsl:param name="s"/>
        <xsl:param name="t"/>
        <xsl:variable name="end">
          <xsl:value-of select="substring($s, string-length($s) - string-length($t) + 1)"/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$t=$end">
            1
          </xsl:when>
          <xsl:otherwise>
            0
          </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
