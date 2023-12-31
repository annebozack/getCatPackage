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

![catOpt](https://raw.githubusercontent.com/annebozack/images/master/getCatOpt.gif)


### Danger zone

Don't get a cat.

```
getCat(cat = F)
```

![dog](https://raw.githubusercontent.com/annebozack/images/master/getDog.gif)