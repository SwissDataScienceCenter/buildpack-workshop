# BuildPacks Tutorial

Repository created by following: https://buildpacks.io/docs/for-buildpack-authors/tutorials/basic-buildpack/01_setup-local-environment/.

## Basic commands

1. Add the builder image `pack config default-builder cnbs/sample-builder:noble` (not needed in devcontainer)
2. Trust the default builder `pack config trusted-builders add cnbs/sample-builder:noble` (not needed in devcontainer)
3. Run `pack build test-node-js-app --clear-cache --path ./node-js-sample-app --buildpack ./node-js-buildpack` to build the image with the Node server using the buildpack
4. Run the image that was built `docker run -ti --rm -p 8080:8080 test-node-js-app`
5. Check that the server works `curl -v http://127.0.0.1:8080`
6. To stop the image `docker stop <container_id>`

## Start hacking

Modify the build script in `node-js-buildpack/bin/build`

Some ideas you can try:
- Detect if there is a requirements.txt in the code, and if so install Python and the packages in a virtual environment.
- Install Python and Jupyterlab in a standalone virtual environment, and run Jupyterlab.
- Install a proxy and Rstudio and run Rstudio.
- (Advanced) We have a Vscodium buildpack written in Go. You can modify and use that as a starting point: https://github.com/SwissDataScienceCenter/vscodium-buildpack.
