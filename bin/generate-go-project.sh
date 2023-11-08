#!/usr/bin/env bash
##############################################################################
# generate-go-project
# -----------
# Generates a .gitattribute, .gitignore, LICENSE, README.md, Makefile,
# Dockerfile and main.go file.
#
# Usage:
#       generate-go-project
# :authors: Jess Frazelle
# :date: 1 January 2018
# :version: 0.0.1
##############################################################################

set -e
set -o pipefail

PROJECT_NAME="$(basename "$(pwd)")"
PROJECT_DIR="$(basename "$(dirname "$(pwd)")")"
PROJECT="${PROJECT_DIR}/${PROJECT_NAME}"

if [[ "$PROJECT_DIR" == "djamseed" ]]; then
	OWNER="Djamseed Khodabocus"
fi

# Generate the LICENSE file.
license(){
	year=$(date +"%Y")
	license_file="LICENSE"

	echo "Writing $license_file"

	cat <<-EOF > "$license_file"
	The MIT License (MIT)

	Copyright (c) $year $OWNER

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
	EOF
}

# Generate the README.md file,
readme(){
  readme_file = "README.md"
  echo "Writing $readme_file"

  cat <<-EOF > "$readme_file"
  # $PROJECT_NAME

  [![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

  Short description of less than 120 characters (match Github's description if hosted on Github).
  Optionally a long description that covers the main reason for building this project.

  ## Table of Contents

  - [Security](#security)
  - [Background](#background)
  - [Install](#install)
  - [Usage](#usage)
  - [API](#api)
  - [Contributing](#contributing)
  - [License](#license)

  ## Security
  Optional if it is important to highlight security concerns.

  ## Background
  Cover motivations behind this project.

  ## Install
  \`\`\`console
		$ go get github.com/${PROJECT_DIR}/${PROJECT_NAME}
	\`\`\`

  ## Usage
  \`\`\`console
	\`\`\`

  ## API
  Describe public interfaces and objects

  ## Contributing
  See [the contributing file](CONTRIBUTING.md)!

  ## License
  [MIT © $OWNER](LICENSE)
  EOF
}

editorconfig(){
  editorconfig_file = ".editorconfig"
  echo "Writing $editorconfig_file"
  cat <<-EOF > "$editorconfig_file"
    root = true

    [*]
    charset = utf-8
    end_of_line = lf
    indent_size = 2
    indent_style = space
    insert_final_newline = true
    trim_trailing_whitespace = true

    [{Makefile,go.mod,go.sum,*.go}]
    indent_size = 4
    indent_style = tab

    [*.md]
    indent_size = 4
    trim_trailing_whitespace = false

    [Dockerfile]
    indent_size = 4

  EOF
}

main(){
	echo "Generating project files for ${PROJECT_NAME}..."

	files=( ".editorconfig" ".gitignore" ".gitattributes" "Makefile" "Dockerfile" "main.go" )
	for file in "${files[@]}"; do
		touch "$file"
	done

	license
	editorconfig
	readme
}

main
