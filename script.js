$(function() {

    /* Rendo invisibili tutti i div contenenti immagini + info e poi rendo visibile solo quello selezionato, che deduco
    * dall'id del pulsante.
    */
    $(".c_toggler").on('click', function() {
        $(".c_holder").removeClass("visible");
        $("#c" + this.id).addClass("visible");
        $(".c_toggler").removeClass("active");
        $(this).addClass("active");
        $("#r_c" + this.id + "_f").prop("checked", true).change();
    });

    /* Rendo invisibili sia il fronte e il retro e poi rendo visibile solo la parte selezionata che deduco
     * dalla parte finale dell'id del radio.
     */
    $("input[type=radio]").on('change', function() {
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
        adaptCanvas($("#can_" + this_id[1] + this_id[2]), "#" + this_id[1] + this_id[2])
    });

    function drawRect(ctx, ulx, uly, lrx, lry, ratio) {
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
        ctx.strokeStyle = "#00FF00";
        ctx.strokeRect(ulx * ratio, uly * ratio, Math.abs(ulx - lrx) * ratio, Math.abs(uly - lry) * ratio);
    }

    function drawPoly(ctx, point_list, ratio) {
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
        ctx.strokeStyle = "#00FF00";
        ctx.beginPath();
        let first = true;
        for(let point of point_list) {
            if(point != "") {
                if(first) {
                    point = point.split(',');
                    ctx.moveTo(point[0] * ratio, point[1] * ratio);
                    first = false;
                } else {
                    point = point.split(',');
                    ctx.lineTo(point[0] * ratio, point[1] * ratio);
                }
            }
        }
        ctx.closePath();
        ctx.stroke();
    }

    function adaptCanvas(j_canvas, img_id) {
        j_canvas.offset($(img_id).offset());
        j_canvas[0].height = $(img_id)[0].height;
        j_canvas[0].width = $(img_id)[0].width;
        j_canvas[0].getContext('2d').clearRect(0, 0, j_canvas[0].width, j_canvas[0].height);
    }

    function adaptAllCanvas() {
        $("canvas").each(function() {
            let img_id = '#' + $(this).attr('id').split('_')[1]
            $(this).css({position: 'absolute'})
            adaptCanvas($(this), img_id)
        });
    }

    $(window).on('resize', function() {
        adaptAllCanvas()
    });

    $('.stamp').on('mouseover', function() {

        let this_id = ($(this).attr('id').split('_'))
        this_id = this_id[0];
        let j_canvas = $('#can_' + this_id);
        console.log('#can_' + this_id);
        ctx = j_canvas[0].getContext('2d');
        let img_id = '#' + this_id
        let conversionRatio = j_canvas[0].height / $(img_id)[0].naturalHeight;
        span = $(this).children('span');
        if(span.attr('data-ulx')) {
            drawRect(ctx, span.attr('data-ulx'), span.attr('data-uly'), span.attr('data-lrx'), span.attr('data-lry'), conversionRatio);
        } else if(span.attr('data-points')) {
            let data_points = span.attr('data-points').split(' ');
            drawPoly(ctx, data_points, conversionRatio);
        }

        $(this).on('mouseout', function() {
            ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
        });
    })

    adaptAllCanvas();

});