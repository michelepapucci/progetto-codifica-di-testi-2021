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

    });
});