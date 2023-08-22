function TransformDicomStandard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $OutputXmlPath,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Xsl,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $InputXmlPath
    )
        
    process {
        xsltproc -o $OutputXmlPath $Xsl $InputXmlPath
        xmllint --format --output $OutputXmlPath $OutputXmlPath
    }
}

function DownloadDeps {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Part
    )
    
    begin {
        
    }
    
    process {
        if (!(Test-Path -Path "build/docbook")) {
            mkdir "build/docbook"
        }
        if (!(Test-Path -Path "build/docbook/$Part")) {
            mkdir "build/docbook/$Part"
        }
        if (!(Test-Path -Path "build/docbook/$Part/$Part.xml")) {
            Invoke-WebRequest -Uri "http://dicom.nema.org/medical/dicom/current/source/docbook/$Part/$Part.xml" -OutFile "build/docbook/$Part/$Part.xml"
        }
    }
    
    end {
        
    }
}

if (!(Test-Path -Path "build")) {
    mkdir "build"
}

Remove-Item -Path "build/*.xml"

DownloadDeps -Part "part03"
DownloadDeps -Part "part06"

TransformDicomStandard -OutputXmlPath "build/registry.xml" -Xsl "src/data_dictionary.xsl" -InputXmlPath "build/docbook/part06/part06.xml"
TransformDicomStandard -OutputXmlPath "build/macros.xml" -Xsl "src/macro_attributes.xsl" -InputXmlPath "build/docbook/part03/part03.xml"
TransformDicomStandard -OutputXmlPath "build/modules.xml" -Xsl "src/module_attributes.xsl" -InputXmlPath "build/docbook/part03/part03.xml"
TransformDicomStandard -OutputXmlPath "build/ciod_modules.xml" -Xsl "src/ciod_modules.xsl" -InputXmlPath "build/docbook/part03/part03.xml"
