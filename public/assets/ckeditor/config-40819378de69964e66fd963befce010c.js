if(typeof(CKEDITOR) != 'undefined')
{
    CKEDITOR.editorConfig = function(config) {
        config.toolbar = [
            { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'RemoveFormat' ] },
            { name: 'links', items: [ 'Link'] },
            { name: 'insert', items: [ 'Image'] },
//            '/',
            { name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
            { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
        ];    }
} else{
    console.log("ckeditor not loaded")
}
;
