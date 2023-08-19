<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:db="http://docbook.org/ns/docbook"
>
    <xsl:template name="para2str">
        <xsl:param name="para"/>
        <xsl:variable name="str">
            <xsl:variable name="emphasis" select="$para/db:emphasis"/>
            <xsl:choose>
                <xsl:when test="$emphasis">
                    <xsl:value-of select="$emphasis/text()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$para/text()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="translate($str,'&#x200b;&#xad;','')"/>
    </xsl:template>
</xsl:stylesheet>