<%-- 
    Document   : index
    Created on : Dec 1, 2015, 3:09:31 AM
    Author     : Daniel Popiniuc <danielpopiniuc@gmail.com>

    The MIT License (MIT)

    Copyright (c) 2015 - 2018 Daniel Popiniuc

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

--%>

<%@page import = "java.io.File" %>
<%@page import = "java.util.ArrayList" %>
<%@page import = "java.util.Collections" %>

<%!
    public static String explodeAndSort(String inputString, String inputSeparator) {
        ArrayList<String> listCommonLoader = new ArrayList<>();
        Collections.addAll(listCommonLoader, inputString.split("\\s*" + inputSeparator + "\\s*"));
        Collections.sort(listCommonLoader);
        return "\"" + String.join("\", \"", listCommonLoader) + "\"";
    }
    public static String listOfFilesWithinFolderReccursive(String inputFolder) {
        ArrayList<String> listOfJustFiles = new ArrayList<>();
        File[] listOfFiles  = new File(inputFolder).listFiles();
        if (listOfFiles == null) {
            listOfJustFiles.add("directory " + inputFolder + " does not exist (check your configuration or adjust folder value");
        } else {
            Integer intListOfFiles = listOfFiles.length;
            for (int i = 0; i < intListOfFiles; i++) {
                if (listOfFiles[i].isFile()) {
                    listOfJustFiles.add(listOfFiles[i].getName());
                } else if (listOfFiles[i].isDirectory()) {
                    listOfFilesWithinFolderReccursive(listOfFiles[i].getAbsolutePath());
                }
            }
            Collections.sort(listOfJustFiles);
        }
        return "\"" + String.join("\", \"", listOfJustFiles) + "\"";
    }
    public static String buildJsonLabelAndFolderString(String strInputStringLabel, String strInputStringFolder) {
        return "\"" + strInputStringLabel + "\" : \"" + strInputStringFolder.replace("\\", "\\\\") + "\"";
    }
    public static String buildJsonLabelAndValueString(String strInputStringLabel, String strInputStringValue) {
        return "\"" + strInputStringLabel + "\" : \"" + strInputStringValue.replaceAll("\"", "") + "\"";
    }
    public static String buildJsonLabelAndValueStringToArray(String strInputStringLabel, String inputString) {
        return "\"" + strInputStringLabel + "\" : [" + explodeAndSort(inputString, ",") + "]";
    }
    public static String buildJsonLabelAndValueArrayListOfFileFromFolder(String strInputStringLabel, String inputFolderName) {
        return "\"" + strInputStringLabel + "\" : [" + listOfFilesWithinFolderReccursive(inputFolderName) + "]";
    }
    public static String buildJsonLabelAndValueStringToArraySpecial(String strInputStringLabel, String inputString) {
        String outputString = inputString.replace("\"", "").replace("/", "\\\\");
        String outputStringInterpreted1 = outputString.replace("${catalina.base}", "${catalina.base} => " + System.getProperty("catalina.base").replace("\\", "\\\\"));
        String outputStringInterpreted2 = outputStringInterpreted1.replace("${catalina.home}", "${catalina.home} => " + System.getProperty("catalina.home").replace("\\", "\\\\"));
        return "\"" + strInputStringLabel + "\" : [" + explodeAndSort(outputStringInterpreted2, ",") + "]";
    }
    public static String buildInformatorApplication(Integer sServerletMajor, Integer sServletMinor, String sTomcatVersion) {
        ArrayList<String> listElement = new ArrayList<>();
        listElement.add(buildJsonLabelAndFolderString("Catalina Base", System.getProperty("catalina.base")));
        listElement.add(buildJsonLabelAndFolderString("Catalina Home", System.getProperty("catalina.home")));
        listElement.add(buildJsonLabelAndValueStringToArraySpecial("Common Loader", System.getProperty("common.loader")));
        listElement.add(buildJsonLabelAndValueString("Full Name and Version", sTomcatVersion));
        listElement.add(buildJsonLabelAndValueString("JSP Version", JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion()));
        listElement.add(buildJsonLabelAndValueString("Name", sTomcatVersion.split("/")[0]));
        listElement.add(buildJsonLabelAndValueStringToArray("Package Access", System.getProperty("package.access")));
        listElement.add(buildJsonLabelAndValueStringToArray("Package Definition", System.getProperty("package.definition")));
        listElement.add(buildJsonLabelAndValueString("Servlet Version", sServerletMajor + "." + sServletMinor));
        listElement.add(buildJsonLabelAndValueStringToArray("Standard Jar Skip Filter", System.getProperty("tomcat.util.scan.StandardJarScanFilter.jarsToSkip")));
        listElement.add(buildJsonLabelAndValueStringToArray("Standard Jar Scan Filter", System.getProperty("tomcat.util.scan.StandardJarScanFilter.jarsToScan")));
        listElement.add(buildJsonLabelAndValueString("Version", sTomcatVersion.split("/")[1]));
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
    public static String buildInformatorJasperReports() {
        ArrayList<String> listElement = new ArrayList<>();
        String sOperatingSystem = System.getProperty("sun.desktop");
        ArrayList<String> listCommonLoader = new ArrayList<>();
        Collections.addAll(listCommonLoader, System.getProperty("common.loader").split("\\s*,\\s*"));
        Collections.sort(listCommonLoader);
        String sJasperReportsFolder = "/";
        Integer intListCommonLoaderSize = listCommonLoader.size();
        for (int i = 0; i < intListCommonLoaderSize; i++) {
            if (listCommonLoader.get(i).contains("JasperReports.lib")) { // this is a convention of included folder
                sJasperReportsFolder = listCommonLoader.get(i).replace("\"", "").substring(0, (listCommonLoader.get(i).length() - 7));
            }
        }
        listElement.add(buildJsonLabelAndValueArrayListOfFileFromFolder("JasperReports libraries", sJasperReportsFolder));
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
    public static String buildJsonFromThreeLists(ArrayList<String> listAvailablePropertiesKey, ArrayList<String> listAvailablePropertiesValue, ArrayList<String> listAvailablePropertiesType) {
        ArrayList<String> listElement = new ArrayList<>();
        Integer intListAvailablePropertiesKeySize = listAvailablePropertiesKey.size();
        for (int i = 0; i < intListAvailablePropertiesKeySize; i++) {
            switch(listAvailablePropertiesType.get(i)) {
                case "buildJsonLabelAndValueString":
                    listElement.add(buildJsonLabelAndValueString(listAvailablePropertiesKey.get(i), System.getProperty(listAvailablePropertiesValue.get(i))));
                    break;
                case "buildJsonLabelAndFolderString":
                    listElement.add(buildJsonLabelAndFolderString(listAvailablePropertiesKey.get(i), System.getProperty(listAvailablePropertiesValue.get(i))));
                    break;
            }
        }
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
    public static String buildInformatorJava() {
        ArrayList<String> listAvailablePropertiesKey = new ArrayList<>();
            ArrayList<String> listAvailablePropertiesValue = new ArrayList<>();
                ArrayList<String> listAvailablePropertiesType = new ArrayList<>();
        listAvailablePropertiesKey.add("Boot Library Path");
            listAvailablePropertiesValue.add("sun.boot.library.path");
                listAvailablePropertiesType.add("buildJsonLabelAndFolderString");
        listAvailablePropertiesKey.add("Class Version");
            listAvailablePropertiesValue.add("java.class.version");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Home");
            listAvailablePropertiesValue.add("java.home");
                listAvailablePropertiesType.add("buildJsonLabelAndFolderString");
        listAvailablePropertiesKey.add("IO Temporary Folder");
            listAvailablePropertiesValue.add("java.io.tmpdir");
                listAvailablePropertiesType.add("buildJsonLabelAndFolderString");
        listAvailablePropertiesKey.add("IO Unicode Encoding");
            listAvailablePropertiesValue.add("sun.io.unicode.encoding");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Logging Config File");
            listAvailablePropertiesValue.add("java.util.logging.config.file");
                listAvailablePropertiesType.add("buildJsonLabelAndFolderString");
        listAvailablePropertiesKey.add("Logging Manager");
            listAvailablePropertiesValue.add("java.util.logging.manager");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Runtime Name");
            listAvailablePropertiesValue.add("java.runtime.name");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Runtime Version");
            listAvailablePropertiesValue.add("java.runtime.version");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Specification Name");
            listAvailablePropertiesValue.add("java.specification.name");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Specification Vendor");
            listAvailablePropertiesValue.add("java.specification.vendor");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Specification Version");
            listAvailablePropertiesValue.add("java.specification.version");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Temporary Folder");
            listAvailablePropertiesValue.add("java.io.tmpdir");
                listAvailablePropertiesType.add("buildJsonLabelAndFolderString");
        listAvailablePropertiesKey.add("Vendor");
            listAvailablePropertiesValue.add("java.vendor");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Vendor Url");
            listAvailablePropertiesValue.add("java.vendor.url");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Vendor Url Bugs");
            listAvailablePropertiesValue.add("java.vendor.url.bug");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Version");
            listAvailablePropertiesValue.add("java.version");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        String sSpecificationVersion = System.getProperty("java.specification.version");
        if (sSpecificationVersion.compareTo("10") == 0) {
            listAvailablePropertiesKey.add("JDK Debug");
                listAvailablePropertiesValue.add("jdk.debug");
                    listAvailablePropertiesType.add("buildJsonLabelAndValueString");
            listAvailablePropertiesKey.add("JDK TLS Ephemeral DH Key Size");
                listAvailablePropertiesValue.add("jdk.tls.ephemeralDHKeySize");
                    listAvailablePropertiesType.add("buildJsonLabelAndValueString");
            listAvailablePropertiesKey.add("Vendor Version");
                listAvailablePropertiesValue.add("java.vendor.version");
                    listAvailablePropertiesType.add("buildJsonLabelAndValueString");
            listAvailablePropertiesKey.add("Version Date");
                listAvailablePropertiesValue.add("java.version.date");
                    listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        }
        return buildJsonFromThreeLists(listAvailablePropertiesKey, listAvailablePropertiesValue, listAvailablePropertiesType);
    }
    public static String buildInformatorJavaVM() {
        ArrayList<String> listElement = new ArrayList<>();
        listElement.add(buildJsonLabelAndValueString("VM Info", System.getProperty("java.vm.info")));
        listElement.add(buildJsonLabelAndValueString("VM Name", System.getProperty("java.vm.name")));
        listElement.add(buildJsonLabelAndValueString("VM Specification Name", System.getProperty("java.vm.specification.name")));
        listElement.add(buildJsonLabelAndValueString("VM Specification Vendor", System.getProperty("java.vm.specification.vendor")));
        listElement.add(buildJsonLabelAndValueString("VM Specification Version", System.getProperty("java.vm.specification.version")));
        listElement.add(buildJsonLabelAndValueString("VM Vendor", System.getProperty("java.vm.vendor")));
        listElement.add(buildJsonLabelAndValueString("VM Version", System.getProperty("java.vm.version")));
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
    public static String buildInformatorOpeartingSystem() {
        ArrayList<String> listAvailablePropertiesKey = new ArrayList<>();
            ArrayList<String> listAvailablePropertiesValue = new ArrayList<>();
                ArrayList<String> listAvailablePropertiesType = new ArrayList<>();
        listAvailablePropertiesKey.add("Architecture");
            listAvailablePropertiesValue.add("os.arch");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Architecture Data Model");
            listAvailablePropertiesValue.add("sun.arch.data.model");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Desktop");
            listAvailablePropertiesValue.add("sun.desktop");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("File Encoding");
            listAvailablePropertiesValue.add("file.encoding");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("File Encoding Package");
            listAvailablePropertiesValue.add("file.encoding.pkg");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("File Separator");
            listAvailablePropertiesValue.add("file.separator");
                listAvailablePropertiesType.add("buildJsonLabelAndFolderString");
        listAvailablePropertiesKey.add("Name");
            listAvailablePropertiesValue.add("os.name");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Patch Level");
            listAvailablePropertiesValue.add("sun.os.patch.level");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Path Separator");
            listAvailablePropertiesValue.add("path.separator");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Version");
            listAvailablePropertiesValue.add("os.version");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        String sSpecificationVersion = System.getProperty("java.specification.version");
        if (sSpecificationVersion.compareTo("10") == 0) {
            listAvailablePropertiesKey.add("Standard Error Encoding");
                listAvailablePropertiesValue.add("sun.stderr.encoding");
                    listAvailablePropertiesType.add("buildJsonLabelAndValueString");
            listAvailablePropertiesKey.add("Standard Out Encoding");
                listAvailablePropertiesValue.add("sun.stdout.encoding");
                    listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        }
        return buildJsonFromThreeLists(listAvailablePropertiesKey, listAvailablePropertiesValue, listAvailablePropertiesType);
    }
    public static String buildInformatorUser() {
        ArrayList<String> listAvailablePropertiesKey = new ArrayList<>();
            ArrayList<String> listAvailablePropertiesValue = new ArrayList<>();
                ArrayList<String> listAvailablePropertiesType = new ArrayList<>();
        listAvailablePropertiesKey.add("Account Name");
            listAvailablePropertiesValue.add("user.name");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Country");
            listAvailablePropertiesValue.add("user.country");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Home Folder");
            listAvailablePropertiesValue.add("user.home");
                listAvailablePropertiesType.add("buildJsonLabelAndFolderString");
        listAvailablePropertiesKey.add("Language");
            listAvailablePropertiesValue.add("user.language");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        listAvailablePropertiesKey.add("Time Zone");
            listAvailablePropertiesValue.add("user.timezone");
                listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        String sSpecificationVersion = System.getProperty("java.specification.version");
        if (sSpecificationVersion.compareTo("10") == 0) {
            listAvailablePropertiesKey.add("Country Format");
                listAvailablePropertiesValue.add("user.country.format");
                    listAvailablePropertiesType.add("buildJsonLabelAndValueString");
            listAvailablePropertiesKey.add("Language Format");
                listAvailablePropertiesValue.add("user.language.format");
                    listAvailablePropertiesType.add("buildJsonLabelAndValueString");
        }
        return buildJsonFromThreeLists(listAvailablePropertiesKey, listAvailablePropertiesValue, listAvailablePropertiesType);
    }
    public static String buildInformator(Integer sServerletMajor, Integer sServletMinor, String sTomcatVersion) {
        String sReturn = "\"Application\": " + buildInformatorApplication(sServerletMajor, sServletMinor, sTomcatVersion)
            + ", "
            + "\"Jasper Reports\": " + buildInformatorJasperReports()
            + ", "
            + "\"Java\": " + buildInformatorJava()
            + ", "
            + "\"Java VM\": " + buildInformatorJavaVM()
            + ", "
            + "\"Operating System\": " + buildInformatorOpeartingSystem()
            + ", "
            + "\"User\": " + buildInformatorUser();
        return "{ " + sReturn + " }";
    }
%>
<%@page contentType="application/json" pageEncoding="utf-8"%>
<%= buildInformator(application.getMajorVersion(), application.getMinorVersion(), application.getServerInfo()) %>
