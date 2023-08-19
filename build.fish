#! /usr/bin/env fish

function transform_dicom_part -a output_xml input_xml xsl
  xsltproc -o $output_xml $xsl $input_xml
  if test $status -ne 0
    echo "Something went wrong while running xsltproc"
  end
  xmllint --format --output $output_xml $output_xml
  if test $status -ne 0
    echo "Something went wrong while running xmllint"
  end
end

function download_deps -a part
  if not test -d docbook
    mkdir docbook
  end

  if not test -d docbook/$part
    mkdir docbook/$part
  end

  if not test -e docbook/$part/$part.xml
    wget -O docbook/$part/$part.xml -c http://dicom.nema.org/medical/dicom/current/source/docbook/$part/$part.xml
  end
end

if not test -d build
  mkdir build
end

rm -f build/*.xml

download_deps part03
download_deps part06
transform_dicom_part build/registry.xml docbook/part06/part06.xml src/data_dictionary.xsl
transform_dicom_part build/macros.xml docbook/part03/part03.xml src/macro_attributes.xsl
transform_dicom_part build/modules.xml docbook/part03/part03.xml src/module_attributes.xsl
transform_dicom_part build/ciod_modules.xml docbook/part03/part03.xml src/ciod_modules.xsl
