#' Get cat function
#'
#' This function will get a cat for you.
#' @keywords cats
#' @export
#' @examples
#' getCat()

getCat = function(){
    cat('|\\---/|')
    draw = T

    while(draw){
        catjson = httr::GET('https://api.thecatapi.com/v1/images/search')
        catdata = jsonlite::fromJSON(rawToChar(catjson$content))

        type = stringr::str_sub(catdata$url, start = length(catdata$url) - 4)

        if (type == 'gif'){
            draw = T
        } else {
            draw = F
        }
    }
    cat("\n| o_o |")

    download.file(catdata$url,catdata$id, mode = 'wb', quiet=T)

    if (type == 'jpg'){
        cat = jpeg::readJPEG(catdata$id, native = T)
    } else {
        cat = png::readPNG(catdata$id, native = T)
    }
    cat("\n \\_^_/ ")

    plot(0:1, 0:1, type="n", ann=FALSE, axes=FALSE) 
    ratio = catdata$height/catdata$width
    rasterImage(cat, 0, 0, 1, ratio)

    file.remove(catdata$id)
}

