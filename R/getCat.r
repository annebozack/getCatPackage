#' Get cat function
#'
#' This function will get a cat for you.
#' @param breed Breed of cat to retrieve. Options are "abyssinian", "aegean", "american bobtail", "american curl", "american shorthair", "american wirehair", "arabian mau", "australian mist", "balinese", "bambino", "bengal", "birman", "bombay", "british longhair", "british shorthair", "burmese", "burmilla", "california spangled", "chantilly-tiffany", "chartreux", "chausie", "cheetoh", "colorpoint shorthair", "cornish rex", "cymric", "cyprus", "devon rex", "donskoy", "dragon li", "egyptian mau", "european burmese", "exotic shorthair", "havana brown", "himalayan", "japanese bobtail", "javanese", "khao manee", "korat", "kurilian", "laperm", "maine coon", "malayan", "manx", "munchkin", "nebelung", "norwegian forest cat", "ocicat", "oriental", "persian", "pixie-bob", "ragamuffin", "ragdoll", "russian blue", "savannah", "scottish fold", "selkirk rex", "siamese", "siberian", "singapura", "snowshoe", "somali", "sphynx", "tonkinese", "toyger".
#' @param description Logical. If TRUE and breed is provided, a description of the breed will be printed.
#' @param cat Logical. If TRUE a cat is retrieved; if FALSE a dog is retrieved.
#' @keywords cats
#' @export
#' @examples
#' getCat()

getCat = function(breed = NULL, description = FALSE, cat = TRUE){
    cat('|\\---/|')
    draw = TRUE
    printWarn = FALSE

    if (cat == TRUE){
        if (is.null(breed)){
            url = 'https://api.thecatapi.com/v1/images/search?api_key=live_S68EsPPyDPH6vJh9SftHhbU3EWhHqVLJuOcXrXOUwCMhj2zauZN294BvpOnhPvHn'
        } else {
            index = httr::GET('https://api.thecatapi.com/v1/breeds')                                                                                                                                       
            index = jsonlite::fromJSON(rawToChar(index$content)) 
            index$name = tolower(index$name)
            breed = tolower(breed)
            if (breed %in% index$name){
                id = index$id[index$name == breed]
                url = paste0('https://api.thecatapi.com/v1/images/search?breed_ids=', id)
            } else {
                printWarn = T
                url = 'https://api.thecatapi.com/v1/images/search?api_key=live_S68EsPPyDPH6vJh9SftHhbU3EWhHqVLJuOcXrXOUwCMhj2zauZN294BvpOnhPvHn'
            }
        }
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
        cat("\n \\_O_/ \n")
    }

    plot(0:1, 0:1, type="n", ann=FALSE, axes=FALSE) 
    ratio = catdata$height/catdata$width
    rasterImage(catimg, 0, 0, 1, ratio)

    invisible(file.remove(catdata$id))

    if (printWarn == T){
        cat('\nBreed not indexed; retrieving another cat instead!')
    }

    if (cat == TRUE & !is.null(breed) & printWarn == FALSE & description == TRUE){
        cat('\n')
        cat(index$description[index$id == id])
    }
}

