#!/usr/bin/env bash
##############################################################################
# cleanup-non-running-images
# -----------
# Removes all the docker images that are not associated with a running container.
#
# :authors: Jess Frazelle, @jessfraz
# :date: 15 May 2016
# :version: 0.0.1
##############################################################################

set -e
set -o pipefail

main(){
	mapfile -t images < <(docker images -q --no-trunc)
	for c in $(docker ps -aq); do
		image=$(docker inspect --format '{{.Image}}' "$c")
		images=( "${images[@]/$image}" )
	done

	docker rmi -f "${images[@]}" 2>&1 || true
}

main
