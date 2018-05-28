## Asset Component Model 

This asset is used to manipulate source code feature selections and customize builds.


### Transformations

We have the following transformations to manipulate our build product through a Configuration Knowledge file.

 - select("compName") -> used to include a component to build
 - remove("compName") -> used to remove a component from build
 - define("tagName")  -> used to include tags in our build
