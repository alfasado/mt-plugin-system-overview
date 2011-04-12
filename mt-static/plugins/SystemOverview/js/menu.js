jQuery(function() {
    jQuery( '#extended_system_menu' ).hover(
        function() { jQuery( '#extended_system_menu ul' ).css( 'display','block' ); },
        function() { jQuery( '#extended_system_menu ul' ).css( 'display','none' ); }
    );
});
