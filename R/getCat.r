#' Get cat function
#'
#' This function will get a cat for you.
#' @param cat Logical. If true a cat is generated; if false a dog is generated.
#' @keywords cats
#' @export
#' @examples
#' getCat()

getCat = function(cat = TRUE){
    cat('|\\---/|')
    draw = TRUE

    if (cat == TRUE){
        url = 'https://api.thecatapi.com/v1/images/search'
    } else {
        url = 'https://api.thedogapi.com/v1/images/search'
    }

    while(draw){
        catjson = httr::GET(url)
        catdata = jsonlite::fromJSON(rawToChar(catjson$content))

        type = stringr::str_sub(catdata$url, start = length(catdata$url) - 4)

        if (type == 'gif'){
            draw = T
        } else {
            draw = F
        }
    }
    cat("\n| o_o |")

    download.file(catdata$url,catdata$id, mode = 'wb', quiet=TRUE)

    if (type == 'jpg'){
        catimg = jpeg::readJPEG(catdata$id, native = T)
    } else {
        catimg = png::readPNG(catdata$id, native = T)
    }
    if (cat == TRUE){
        cat("\n \\_^_/ ")
    } else {
        cat("\n \\_O_/ ")
    }

    plot(0:1, 0:1, type="n", ann=FALSE, axes=FALSE) 
    ratio = catdata$height/catdata$width
    rasterImage(catimg, 0, 0, 1, ratio)

    invisible(file.remove(catdata$id))
}

