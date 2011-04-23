package SystemOverview::Plugin;

use strict;

sub _header_source {
    my ( $cb, $app, $tmpl ) = @_;
    my $user = $app->user;
    return unless $user;
    my $perms = $user->permissions;
    return unless $perms;
    my $insert = '';
    if ( $perms->can_view_log ) {
        $insert .= <<'MTML';
        <li><a href="<$mt:var name="mt_url"$>?__mode=list&amp;_type=log" title="<__trans phrase="View Activity Log">"><__trans phrase="View Activity Log"></a></li>
MTML
    }
    if ( $perms->can_manage_plugins ) {
        $insert .= <<'MTML';
        <li><a href="<$mt:var name="mt_url"$>?__mode=cfg_plugins" title="<__trans phrase="Plugin Settings">"><__trans phrase="Plugin Settings"></a></li>
MTML
    }
    if ( $perms->can_edit_templates ) {
        $insert .= <<'MTML';
        <li><a href="<$mt:var name="mt_url"$>?__mode=list_template" title="<__trans phrase="Global Templates">"><__trans phrase="Global Templates"></a></li>
MTML
    }
    if ( $user->is_superuser ) {
        $insert .= <<'MTML';
        <li><a href="<$mt:var name="mt_url"$>?__mode=list&amp;_type=author&amp;blog_id=0" title="<__trans phrase="Manage Users">"><__trans phrase="Manage Users"></a></li>
        <li><a href="<$mt:var name="mt_url"$>?__mode=search_replace" title="<__trans phrase="Search &amp; Replace">"><__trans phrase="Search &amp; Replace"></a></li>
        <li><a href="<$mt:var name="mt_url"$>?__mode=cfg_system_general" title="<__trans phrase="General Settings">"><__trans phrase="General Settings"></a></li>
        <li><a href="<$mt:var name="mt_url"$>?__mode=list&amp;_type=website&amp;blog_id=0" title="<__trans phrase="Manage Website">"><__trans phrase="Manage Website"></a></li>
MTML
        if ( MT->component( 'Commercial' ) ) {
        $insert .= <<'MTML';
        <__trans_section component="Commercial">
        <li><a href="<$mt:var name="mt_url"$>?__mode=list&amp;_type=field" title="<__trans phrase="Custom Fields">"><__trans phrase="Custom Fields"></a></li>
        </__trans_section>
MTML
        $insert .= <<'MTML';
        <li><a href="<$mt:var name="mt_url"$>?__mode=tools" title="<__trans phrase="System Information">"><__trans phrase="System Information"></a></li>
MTML

        }
    }
    if ( $insert ) {
        my $pointer = quotemeta( '<li id="user">' );
        my $insert_head = <<'MTML';
        <li id="extended_system_menu" class="extended_menu"><a href="<$mt:var name="mt_url"$>?__mode=dashboard&amp;blog_id=0" id="extended_system_menu" class="extended_system_menu"><__trans_section component="SystemOverview"><__trans phrase="System Overview"></__trans_section></a>
        <ul id="extended_system_menu_ul" class="extended_menu_ul">
MTML
        my $insert_footer = <<'MTML';
        </li></ul>
        <script type="text/javascript" src="<$mt:var name="static_uri"$>plugins/SystemOverview/js/menu.js?v=<mt:var name="mt_version_id" escape="URL">"></script>
MTML
        $$tmpl =~ s/($pointer)/$insert_head$insert$insert_footer$1/si;
        my $css = 'style_51.css';
        if ( MT->version_id =~ /^5\.0/ ) {
            $css = 'style.css';
        }
        $pointer = quotemeta( '<mt:var name="html_head">' );
        $insert = <<MTML;
        <link rel="stylesheet" href="<\$mt:var name="static_uri"\$>plugins/SystemOverview/css/$css?v=<mt:var name="mt_version_id" escape="url">" type="text/css" />
MTML
        $$tmpl =~ s/($pointer)/$insert$1/si;
    }
}

1;