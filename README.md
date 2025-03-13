# BuildPacks Tutorial

Repository created by following: https://buildpacks.io/docs/for-buildpack-authors/tutorials/basic-buildpack/01_setup-local-environment/.

## Basic commands

1. Add the builder image to use `make configure` (not needed in devcontainer)
2. Run `make build` to build the image with the Node server using the buildpack
3. Run the image that was built `make run`
4. Check that the server works `curl -v http://127.0.0.1:8080`
5. To stop the image `docker stop <container_id>`

## Start hacking

Modify the build script in `node-js-buildpack/bin/build`

Some ideas you can try:
- Detect if there is a requirements.txt in the code, and if so install Python and the packages in a virtual environment.
- Install Python and Jupyterlab in a standalone virtual environment, and run Jupyterlab.
- Install a proxy and Rstudio and run Rstudio.
- (Advanced) We have a Vscodium buildpack written in Go. You can modify and use that as a starting point: https://github.com/SwissDataScienceCenter/vscodium-buildpack.

## How to make this work on Renku

For running Jupyterlab or something similar on Renku you can make use of environment
variables that Renku injects into the session when the session is created.

There are:

- `RENKU_BASE_URL`: the full URL that you can use to navigate to the session
- `RENKU_BASE_URL_PATH`: just the path from the `BASE_URL`
- `RENKU_MOUNT_DIR`: the directory where the volume for the session is mounted
- `RENKU_SESSION`: set to `1` if inside a renku session
- `RENKU_SESSION_IP`: the IP the server should listen on (i.e. `0.0.0.0`)
- `RENKU_SESSION_PORT`: the port the server should listen on (i.e. `8888`)
- `RENKU_WORKING_DIR`: the working directory (usually a child or same as the mount directory)

## How to run something on Renku

- If your buildpack has a frontend already (i.e. Vscodium, Jupyterlab, Rstudio) and you are using the environment variables mentioned above then you should be able to use the image built with the `make build` command in Renku.

- If your buildpack does not have a frontend you can add the Vscodium buildpack we have published. To do this modify the pack command as follows: `make build_with_ui`.

Once you have build the image with the `make build` or `make build_with_ui` command, you can log into docker with `docker login` and re-tag and push the image.

Finally, you can create a session launcher in Renku. You should be able to omit the command and arguments from the session launcher configuration.

Example Renku project with a custom session launcher from the image created by running `make build_with_ui`.
https://renkulab.io/v2/projects/tasko.olevski/cloud-native-buildpack-workshop
