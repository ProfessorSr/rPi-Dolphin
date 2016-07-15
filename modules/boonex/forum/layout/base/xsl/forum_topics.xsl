<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">

<xsl:include href="rewrite.xsl" />
<xsl:include href="replace.xsl" />
<xsl:include href="topic.xsl" />

<xsl:template match="urls" />

<xsl:template match="topics">

    <div id="reply_container">&#160;</div>

    <xsl:variable name="menu_links">
        <btn href="javascript:void(0);" onclick="return f.newTopic('{forum/uri}')" icon="{/root/urls/img}btn_icon_new_topic.gif">[L[New Topic]]</btn>
        <xsl:if test="count(cat)">            
            <btn href="{$rw_forum}{forum/uri}{$rw_forum_page}0{$rw_forum_ext}" onclick="" icon="{/root/urls/img}btn_icon_plink.gif">[L[Permalink]]</btn>
            <btn href="{$rw_rss_forum}{forum/uri}{$rw_rss_forum_ext}" onclick="" icon="{/root/urls/img}btn_icon_rss.gif">[L[RSS feed]]</btn>
        </xsl:if>
    </xsl:variable>

    <xsl:call-template name="box">
        <xsl:with-param name="title"><xsl:value-of select="forum/title" disable-output-escaping="yes" /></xsl:with-param>
        <xsl:with-param name="content">

            <xsl:choose>
                <xsl:when test="(pages and pages/@num &lt;= 0) or not(topic)">

                    <div class="bx-def-bc-padding">
                        <div class="forum_centered_msg">
                            [L[No topics]]
                        </div>
                    </div>

                </xsl:when>
                <xsl:otherwise>

                    <div class="bx-def-bc-padding">
                        <table class="forum_table_list">
                            <xsl:apply-templates select="topic" />
                        </table>
                    </div>

                    <xsl:if test="pages/p">
                        <xsl:call-template name="paginate">
                            <xsl:with-param name="pages" select="pages" />
                        </xsl:call-template>
                    </xsl:if>

                </xsl:otherwise>
            </xsl:choose>

        </xsl:with-param>
        <xsl:with-param name="menu" select="exsl:node-set($menu_links)/*" />
    </xsl:call-template>

    <xsl:call-template name="breadcrumbs">
        <xsl:with-param name="link1">
            <a href="{$rw_cat}{cat/uri}{$rw_cat_ext}" onclick="return f.selectForumIndex('{cat/uri}')"><xsl:value-of select="cat/title" disable-output-escaping="yes" /></a>
        </xsl:with-param>
    </xsl:call-template>

</xsl:template>


<xsl:template match="pages/p">

    <xsl:variable name="start" select="../../pages/p[@c=1]/@start" />
    <xsl:variable name="per_page" select="../../pages/@per_page" />        
    <xsl:variable name="num" select="../../pages/@num" />        
    <xsl:variable name="start_last" select="../p[position() = last()]/@start" />
    <xsl:variable name="start_prev" select="../p[@c = 1]/@start - $per_page" />
    <xsl:variable name="start_next" select="../p[@c = 1]/@start + $per_page" />

    <xsl:call-template name="paginate_number">
        <xsl:with-param name="if_first" select="position() = 1" />
        <xsl:with-param name="if_last" select="position() = last()" />
        <xsl:with-param name="link_first" select="concat($rw_forum, ../../forum/uri, $rw_forum_page, '0', $rw_forum_ext)" />
        <xsl:with-param name="onclick_first">return document.f.selectForum ('<xsl:value-of select="../../forum/uri" />', '0')</xsl:with-param>
        <xsl:with-param name="link_prev" select="concat($rw_forum, ../../forum/uri, $rw_forum_page, $start_prev, $rw_forum_ext)" />
        <xsl:with-param name="onclick_prev">return document.f.selectForum ('<xsl:value-of select="../../forum/uri" />', '<xsl:value-of select="$start_prev" />')</xsl:with-param>        
        <xsl:with-param name="link_next" select="concat($rw_forum, ../../forum/uri, $rw_forum_page, $start_next, $rw_forum_ext)" />
        <xsl:with-param name="onclick_next">return document.f.selectForum ('<xsl:value-of select="../../forum/uri" />', '<xsl:value-of select="$start_next" />')</xsl:with-param>
        <xsl:with-param name="link_last" select="concat($rw_forum, ../../forum/uri, $rw_forum_page, $start_last, $rw_forum_ext)" />    
        <xsl:with-param name="onclick_last">return document.f.selectForum ('<xsl:value-of select="../../forum/uri" />', '<xsl:value-of select="$start_last" />')</xsl:with-param>
        <xsl:with-param name="link_curr" select="concat($rw_forum, ../../forum/uri, $rw_forum_page, @start, $rw_forum_ext)" />
        <xsl:with-param name="onclick_curr">return document.f.selectForum ('<xsl:value-of select="../../forum/uri" />', '<xsl:value-of select="@start" />')</xsl:with-param>
        <xsl:with-param name="start" select="$start" />
        <xsl:with-param name="start_last" select="$start_last" />
        <xsl:with-param name="title" select="." />
        <xsl:with-param name="c" select="@c" />
    </xsl:call-template>

</xsl:template>

</xsl:stylesheet>


