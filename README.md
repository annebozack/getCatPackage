# getCatPackage

Get a cat!

To install the get cat package:

```
devtools::install_github("annebozack/getCatPackage")
library(getCatPackage)
```

### Get a random cat sampled from https://thecatapi.com/

```
getCat()
```

![cat](https://raw.githubusercontent.com/annebozack/images/master/getCat.gif)


### Advanced options


Request a breed and description.

```
getCat(breed = 'manx', description = T)
```

![cat](https://raw.githubusercontent.com/annebozack/images/master/getCatOpt.gif)

Don't get a cat.

```
getCat(cat = F)
```

![cat](https://raw.githubusercontent.com/annebozack/images/master/getDog.gif)