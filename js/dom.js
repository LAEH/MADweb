dom = {
    divTo: function($destination, stringClasses) {
        var $div = $('<div>', {
            class: stringClasses
        });
        return $div.appendTo($destination);
    },

    icnTo: function($destination, stringClasses) {
        var $div = $('<i>', {
            class: stringClasses
        });
        return $div.appendTo($destination);
    },


    txtTo: function($destination, stringClasses, text) {
        var $div = $('<i>', {
            class: stringClasses
        });
        $div.html(text)
        return $div.appendTo($destination);
    },


    imgTo: function($destination, imgurl, cberror) {
        var imageObject = new Image();

        if (!imgurl.match(/^http/)) {
            imgurl = '/img/' + imgurl;
        }

        imageObject.onload = function() {
            $destination.css({
                'background-image': 'url(' + imgurl + ')'
            });
        };

        imageObject.onerror = function() {
            if(cberror) cberror();
        };
        imageObject.src = imgurl;
    },
};
