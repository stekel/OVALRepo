#!/bin/bash

cat platforms.json | jq '.RESULTS.platforms | keys[]' | while read platform; do
platform=`sed -e 's/^"//' -e 's/"$//' <<<"$platform"`
platform_filename=`sed -e 's/ /_/g' <<<"$platform"`
echo "Build OVAL Definitions Files for $platform"
if [ ! -z "$platform" ]; then
  cat classes.json | jq '.RESULTS.class | keys[]' | while read class; do
    class=`sed -e 's/^"//' -e 's/"$//' <<<"$class"`
    if [ ! -z "$class" ]; then
        echo "python ./scripts/build_oval_definitions_file.py --outfile=\"./output-files/5.10/$class/$platform_filename.xml\" --max_schema_version=5.10 --platform=\"$platform\" --class=$class"
        python3 ./scripts/build_oval_definitions_file.py --outfile="./output-files/5.10/$class/$platform_filename.xml" --max_schema_version=5.10 --platform="$platform" --class=$class > /dev/null
        python3 ./scripts/build_oval_definitions_file.py --outfile="./output-files/5.11.1/$class/$platform_filename.xml" --max_schema_version=5.11.1 --platform="$platform" --class=$class > /dev/null
        python3 ./scripts/build_oval_definitions_file.py --outfile="./output-files/5.11.2/$class/$platform_filename.xml" --max_schema_version=5.11.2 --platform="$platform" --class=$class > /dev/null
    fi
  done
fi
done
