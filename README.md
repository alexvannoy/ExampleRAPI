# ExampleRAPI
This is primarily an R repo that holds a tiny R web-app to be used in my Kubernetes learning experience. However, it should also function as a passable template for other R web services.

#test.bat
## build
Running `test build` will build the image `r-webapp:dev` that houses the web-app.

## run-bash
Running `test run-bash` will build the image `r-webapp:dev` with a bash entrypoint to help debug internal issues

## test web-app
Running `test web-app` will build the image `run-r-webapp` that runs the web app on `localhost:8080`. The actual route is set to `localhost:8080/api` but that's set in the run_app.R function when the `add_swagger_ui()` path is assigned.

# buildme.sh
A dummy script that builds and pushes the docker image to my docker repository. First note that this abuses my locally cached creds. I'm on a windows box, so I'm not having to deal with the Linux PAT crap yet. I wrote this specifically to abuse later in a cluster where I pull the docker image from a public registry (mine).

# Use Cases
- Fork this repo
- Add whatever functions and stuff you need in `/R/`
- Add any endpoint handlers to `/R/run_app`
- Change the name of the package if you want, but that changes in a lot of places, so good luck.

