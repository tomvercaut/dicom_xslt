# DICOM-XSLT

A set of [XSLT] files to transform parts of the [DICOM] standard (in [DocBook] format) into seperate [XML] files.

In the [DICOM] standard, a set of attributes and modules define the format for communication and storage of medical images and related data.
Transforming all this information into a less convoluted XML structure facilitates processing of this data in other programming languages.
To enable the latter, a set of [XSLT] files has been created.


## Components

* [data_dictionary.xsl](src/data_dictionary.xsl): Extract the DICOM data elements registry from part 06
* [ciod_modules.xsl](src/ciod_modules.xsl): Extract Composite Information Object Definition (CIOD) modules tables from part 03
* [module_attributes.xsl](src/module_attributes.xsl): Extract module attribute tables from part 03
* [macro_attributes.xsl](src/macro_attributes.xsl): Extract macro attribute tables from part 03
* [ends_with.xsl](src/ends_with.xsl): Check if a string ends with a given suffix
* [para2str.xsl](src/para2str.xsl): Extract the text from a para element or from an emphasis element within a para element

## Building

To automate the building of the seperate [XML] files from the different [DICOM] standard parts, a [Fish] script is provided. If you don't have [Fish] installed, you can run the commands manually in a terminal.

```fish
./build.fish
```

The script will download the latest [XML] files of part03 and part06 respectively into docbook/part03 or docbook/part06, if the [XML] files don't exist.

### Dependencies

- To download the [XML] files, the script uses [wget]. If this application is not yet installed on your system, 
it can often be installed using the package manager of your favorite Linux/Unix distribution or build from source.
- To apply the [XSLT] stylesheets to the [XML] documents, a commandline tool `xsltproc` is used. This application is part of `libxslt`. 


## Output

### Data dictionary

```xml
<registry>
  <data_elements>
    <tag>(gggg,eeee)</tag>        <!-- DICOM tag with a 16 bit hexadecimal value of the group and element number -->
    <name>Tag Name</name>         <!-- Name of the DICOM tag -->
    <keyword>TagKeyWord</keyword> <!-- Name of the DICOM tag without spaces -->
    <vr>CS</vr>                   <!-- Value Representation -->
    <vm>2-n</vr>                  <!-- Value Multiplicity -->
    <retired>true</retired>       <!-- true if the DICOM tag is retired -->
  </data_elements>
  ...
</registry>
```

### CIOD

```xml
<ciods>
  <ciod_table>
    <id>table_A.2-1</id>                                       <!-- Unique identifier of the table (often used by xref elements to refer to other tables in the document.) -->
    <caption>Computed Radiography Image IOD Modules</caption>  <!-- Table caption
    <items>
      <ie>                                                     <!-- Information Entity -->
        <name>Patient</name>                                   <!-- Name of the IE -->
        <module>Patient</module>                               <!-- Name of the Module -->
        <reference>                                            <!-- Internal reference to another section or table. -->
          <link>sect_C.7.1.1</link>                            <!-- Link to the section or table -->
          <style>select: labelnumber</style>                   <!-- Which item or attribute to select or view -->
        </reference>
        <usage>M</usage>                                       <!-- Usage requirements of the IE in the module -->
      </ie>
      <ie>
        <name/>                                                <!-- If the name is empty, the remaining elements should be appended to the previous one -->
        <module>Clinical Trial Subject</module>                <!-- Name of the Module -->
        <reference>                                            <!-- Internal reference to another section or table. -->
          <link>sect_C.7.1.3</link>                            <!-- Link to the section or table -->
          <style>select: labelnumber</style>                   <!-- Which item or attribute to select or view -->
        </reference>
        <usage>U</usage>                                       <!-- Usage requirements of the IE in the module -->
      </ie>
      ...  
    </items>
    ... 
  </ciod_table>
  ...
</ciods> 
```

### Module attributes

```xml
<module_attributes>
  <module_attributes_table>                                   <!-- Table with module attributes -->
    <id>table_C.2-3</id>                                      <!-- Unique identifier of the table -->
    <caption>Patient Demographic Module Attributes</caption>  <!-- Table caption -->
    <items>
      <item>                                                  <!-- Module attribute item -->
        <name>Patient's Age</name>                            <!-- Module attribute name -->
        <tag>(0010,1010)</tag>                                <!-- Module attribute tag -->
      </item>
      <include>                                               <!-- Include another table with module or macro attributes -->
        <text>&gt;Include</text>                              <!-- Plain text of the first column without any text replacement for xref node(s) -->
        <reference>                                           <!-- Internal reference to another section or table. -->
          <link>table_8.8-1</link>                            <!-- Link to the section or table -->
          <style>select: label quotedtitle</style>            <!-- Which item or attribute to select or view -->
        </reference>
      </include>
      ...
    </items>
    ...
  </module_attributes_table>
  ...
<module_attributes>
```

### Macro attributes

```xml
<macro_attributes>
  <macro_attributes_table>                                     <!-- Table with macro attributes -->
    <id>table_10-1</id>                                        <!-- Unique identifier of the table -->
    <caption>Person Identification Macro Attributes</caption>  <!-- Table caption -->
    <items>
      <item>                                                   <!-- Macro attribute item -->
        <name>Person Identification Code Sequence</name>       <!-- Macro attribute name -->
        <tag>(0040,1101)</tag>                                 <!-- Macro attribute tag -->
        <type>1</type>                                         <!-- Defines if an attribute is required or optional -->
      </item>
      <include>                                                <!-- Include another table with macro attributes -->
        <text>&gt;Include</text>                               <!-- Plain text of the first column without any text replacement for xref node(s) -->
        <reference>                                            <!-- Internal reference to another section or table. -->
          <link>table_8.8-1</link>                             <!-- Link to the section or table -->
          <style>select: label quotedtitle</style>             <!-- Which item or attribute to select or view -->
        </reference>
      </include>
      ...
    </items>
    ...
  </macro_attributes_table>
  ...
</macro_attributes>
```

## License

Licensed under either of

- Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or <http://www.apache.org/licenses/LICENSE-2.0>)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or <http://opensource.org/licenses/MIT>) at your option.

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the work by you, as defined in the Apache-2.0 license, shall be dual licensed as above, without any additional terms or conditions.

[XSLT]: https://www.w3.org/TR/xslt/
[DICOM]: https://www.dicomstandard.org
[DocBook]: https://docbook.org/
[XML]: https://www.w3.org/TR/xml-entity-names/
[Fish]: https://fishshell.com/
[wget]: https://www.gnu.org/software/wget/
[xsltproc]: https://gitlab.gnome.org/GNOME/libxslt

