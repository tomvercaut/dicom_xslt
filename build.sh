#! /usr/bin/env bash

transform_dicom_part() {
  # arg1: output_xml
  # arg2: input_xml
  # arg3: xsl file
  xsltproc -o "$1" "$3" "$2"
  status=$?
  if [ $status -ne 0 ]; then
    echo "Something went wrong while running xsltproc"
  fi
  xmllint --format --output "$1" "$1"
  status=$?
  if [ $status -ne 0 ]; then
    echo "Something went wrong while running xmllint"
  fi
}

download_deps() {
  # arg1: DICOM part
  if [ ! -d build ]; then
    mkdir build
  fi
  if [ ! -d build/docbook ]; then
    mkdir build/docbook
  fi
  if [ ! -d "build/docbook/$1" ]; then
    mkdir "build/docbook/$1"
  fi
  if [ ! -e "build/docbook/$1/$1.xml" ]; then
    wget -O "build/docbook/$1/$1.xml" -c http://dicom.nema.org/medical/dicom/current/source/docbook/$1/$1.xml
  fi
}

VALID_ARGS=$(getopt -o k --long keep -- "$@")
if [[ $? -ne 0 ]]; then
  echo "Unable to parse all arguments."
  exit 1;
fi

keep=0
eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
    -k | --keep)
      keep=1
      shift
      ;;
    --) shift;
      break
      ;;
  esac
done

if [ ! -d build ]; then
  mkdir build
fi

rm -f build/*.xml

download_deps part03
download_deps part06
transform_dicom_part build/registry.xml build/docbook/part06/part06.xml src/data_dictionary.xsl
transform_dicom_part build/macros.xml build/docbook/part03/part03.xml src/macro_attributes.xsl
transform_dicom_part build/modules.xml build/docbook/part03/part03.xml src/module_attributes.xsl
transform_dicom_part build/ciod_modules.xml build/docbook/part03/part03.xml src/ciod_modules.xsl

if [ $keep = 0 ]; then
  rm -rf build/docbook
fi