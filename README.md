# XBackBone Docker on ARM64

This was built in order to use XBackBone with Oracle Free Tier's ARM64 instances. Unfortunately, the original upstream images are all AMD64 based. I have gone thrlough and updated references to software to latest versions where applicable, change references, as well as saved copies of binaries as is from the source in the event references no longer exist.

All images are built directly against an ARM instance, as buildx and QEMU have an issue with some Go binaries in Actions. These images work as drop in replacements from [Pe46dro's built image](https://github.com/Pe46dro/XBackBone-docker).

# How to use this image

You can use the following command to start the container and map the ports to the host:

```console
$ docker run -p 80:80 \
    -e APP_NAME=XBackBone \
    -e URL=http:\/\/127.0.0.1 \
    --name xbb \
    nowaidavid/xbackbone-docker-arm64:latest
```

## Container shell access
Nginx erver log is available through Docker's container log:

```console
$ docker logs xbb
```

## Environment Variables
When you start this image, you can adjust the configuration by passing one or more environment variables on the `docker run` command line.

### `APP_NAME`
This will specify the app name, if none is provided the default is `XBackBone`
`-e APP_NAME=XBackBone`

### `URL`
This will specify the app url, slashes need to be escaped like follow
`-e URL=http:\/\/127.0.0.1`

### `GENERATE_RELEASE=TRUE` *dev-only*
If set, this environment variable will generate a release zip and will place it on `srv/xbb/storage`

## Build Args Variables
When you build the image yourself, you can adjust the version using the `--build-arg variable=value` parameter on the `docker build` command line.

### `XBACKBONE_VERSION`
You can specify the tag from [XBackBone](https://github.com/SergiX44/XBackBone/releases) release and download the desired one

## Where to Store Data
### Available mount point
*	/app/storage
*	/app/resources/database
*	/app/logs
*	/app/config _(to keep config files - **Docker container only**)_

### Permissions
The folder on host system need to have both **UID** and **GID** *1000*

### PHP Customization 

You can specify eg. `php.memory_limit=256M` as dynamic env variable which will set `memory_limit = 256M` as php setting.
Refer to [webdevops documentation](https://dockerfile.readthedocs.io/en/latest/content/DockerImages/dockerfiles/php-nginx.html#php-ini-variables) for more details

| Environment variable                  	| Description                             	| Default   	 	 	|
|---------------------------------------	|-----------------------------------------	|-----------	 	 	|
| `php.{setting-key}`                   	| Sets the `{setting-key}` as php setting 	| 	 	 	 	|
| `PHP_DATE_TIMEZONE`                   	| `date.timezone`                         	| `UTC` 	 	 	|
| `PHP_DISPLAY_ERRORS`                  	| `display_errors`                        	| `0` 	 	 	 	|
| `PHP_MEMORY_LIMIT`                    	| `memory_limit`                          	| `512M` 	 	 	|
| `PHP_MAX_EXECUTION_TIME`              	| `max_execution_time`                    	| `300` 	 	 	|
| `PHP_POST_MAX_SIZE`                   	| `post_max_size`                         	| `50M` 	 	 	|
| `PHP_UPLOAD_MAX_FILESIZE`             	| `upload_max_filesize`                   	| `50M` 	 	 	|
| `PHP_OPCACHE_MEMORY_CONSUMPTION`      	| `opcache.memory_consumption`            	| `256` 	 	 	|
| `PHP_OPCACHE_MAX_ACCELERATED_FILES`   	| `opcache.max_accelerated_files`         	| `7963` 	 	 	|
| `PHP_OPCACHE_VALIDATE_TIMESTAMPS`     	| `opcache.validate_timestamps`           	| `default` 	 	 	|
| `PHP_OPCACHE_REVALIDATE_FREQ`         	| `opcache.revalidate_freq`               	| `default` 	 	 	|
| `PHP_OPCACHE_INTERNED_STRINGS_BUFFER` 	| `opcache.interned_strings_buffer`       	| `16` 	 	 	 	|
| ``FPM_PROCESS_MAX``       	        	| ``process.max``                             	| ``distribution default`` 	|
| ``FPM_PM_MAX_CHILDREN``     		      	| ``pm.max_children``                    	| ``distribution default`` 	|
| ``FPM_PM_START_SERVERS``      	    	| ``pm.start_servers``                      	| ``distribution default`` 	|
| ``FPM_PM_MIN_SPARE_SERVERS``      		| ``pm.min_spare_servers``               	| ``distribution default`` 	|
| ``FPM_PM_MAX_SPARE_SERVERS``      		| ``pm.max_spare_servers``               	| ``distribution default`` 	|
| ``FPM_PROCESS_IDLE_TIMEOUT``      		| ``pm.process_idle_timeout``                 	| ``distribution default`` 	|
| ``FPM_MAX_REQUESTS``              		| ``pm.max_requests``                          	| ``distribution default`` 	|
| ``FPM_REQUEST_TERMINATE_TIMEOUT`` 		| ``request_terminate_timeout``                	| ``distribution default`` 	|
| ``FPM_RLIMIT_FILES``              		| ``rlimit_files``                             	| ``distribution default`` 	|
| ``FPM_RLIMIT_CORE``               		| ``rlimit_core``                           	| ``distribution default`` 	|
