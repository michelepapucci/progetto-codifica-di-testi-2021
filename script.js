$(function(){
    /* Rendo invisibili tutti i div contenenti immagini + info e poi rendo visibile solo quello selezionato, che deduco
    * dall'id del pulsante.
    */
    $(".c_toggler").on('click', function(){
        $(".c_holder").removeClass("visible");
        $("#c" + this.id).addClass("visible");
        $(".c_toggler").removeClass("active");
        $(this).addClass("active");
    });

    /* Rendo invisibili sia il fronte e il retro e poi rendo visibile solo la parte selezionata che deduco
     * dalla parte finale dell'id del radio.
     */
    $("input[type=radio]").on('change', function(){
        let this_id = $(this).attr('id').split("_")
        $("#" + this_id[1] + "r").removeClass('visible');
        $("#" + this_id[1] + "f").removeClass('visible');
        $("#" + this_id[1] + this_id[2]).addClass('visible');

        // Sopra per le immagini e sotto per i testi a destra.

        $("#i_" + this_id[1] + "r").removeClass('visible');
        $("#i_" + this_id[1] + "f").removeClass('visible');
        $("#i_" + this_id[1] + this_id[2]).addClass('visible');

        $("canvas").removeClass('visible');
        $("#can_" + this_id[1] + this_id[2]).addClass('visible');
        adaptCanvas($("#can_" + this_id[1] + this_id[2]), "#" + this_id[1] + this_id[2] )
    });

    function drawPoly(ctx, ulx, uly, lrx, lry, ratio) {
        ctx.strokeStyle="#FF0000";
        ctx.strokeRect(ulx*ratio,uly*ratio,Math.abs(ulx-lrx)*ratio,Math.abs(uly-lry)*ratio);
    }

    function adaptCanvas(j_canvas, img_id){
        j_canvas.offset($(img_id).offset());
        j_canvas[0].height = $(img_id)[0].height;
        j_canvas[0].width = $(img_id)[0].width;
        conversionRatio = j_canvas[0].height / $(img_id)[0].naturalHeight;
        ctx = j_canvas[0].getContext('2d');
        drawPoly(ctx,96, 3, 764, 985, conversionRatio);
    }

    function adaptAllCanvas(){
        $("canvas").each(function(){
            let img_id = '#' + $(this).attr('id').split('_')[1]
            $(this).css({position: 'absolute'})
            adaptCanvas($(this), img_id)
        });
    }

    adaptAllCanvas();

    $(window).on('resize', function(){
        adaptAllCanvas()
    });

});