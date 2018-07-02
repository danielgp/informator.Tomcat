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
<%@page contentType="application/json" pageEncoding="utf-8"%>
<%@page import = "java.io.File" %>
<%@page import = "java.util.ArrayList" %>
<%@page import = "java.util.Enumeration" %>
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
            for (int i = 0; i < listOfFiles.length; i++) {
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
    public static String buildInformatorTomcatApplication(Integer sServerletMajor, Integer sServletMinor, String sTomcatVersion) {
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
        for (int i = 0; i < listCommonLoader.size(); i++) {
            if (listCommonLoader.get(i).contains("JasperReports.lib")) { // this is a convention of included folder
                sJasperReportsFolder = listCommonLoader.get(i).replace("\"", "").substring(0, (listCommonLoader.get(i).length() - 7));
            }
        }
        listElement.add(buildJsonLabelAndValueArrayListOfFileFromFolder("JasperReports libraries", sJasperReportsFolder));
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
    public static String buildInformatorJava() {
        ArrayList<String> listElement = new ArrayList<>();
        listElement.add(buildJsonLabelAndFolderString("Boot Library Path", System.getProperty("sun.boot.library.path")));
        listElement.add(buildJsonLabelAndValueString("Class Version", System.getProperty("java.class.version")));
        listElement.add(buildJsonLabelAndFolderString("Home", System.getProperty("java.home")));
        listElement.add(buildJsonLabelAndFolderString("IO Temporary Folder", System.getProperty("java.io.tmpdir")));
        listElement.add(buildJsonLabelAndFolderString("IO Unicode Encoding", System.getProperty("sun.io.unicode.encoding")));
        listElement.add(buildJsonLabelAndFolderString("JDK Debug", System.getProperty("jdk.debug")));
        listElement.add(buildJsonLabelAndFolderString("JDK TLS E[hemeral DH Key Size", System.getProperty("jdk.tls.ephemeralDHKeySize")));
        listElement.add(buildJsonLabelAndFolderString("Logging Config File", System.getProperty("java.util.logging.config.file")));
        listElement.add(buildJsonLabelAndFolderString("Logging Manager", System.getProperty("java.util.logging.manager")));
        listElement.add(buildJsonLabelAndValueString("Runtime Name", System.getProperty("java.runtime.name")));
        listElement.add(buildJsonLabelAndValueString("Runtime Version", System.getProperty("java.runtime.version")));
        listElement.add(buildJsonLabelAndValueString("Specification Name", System.getProperty("java.specification.name")));
        listElement.add(buildJsonLabelAndValueString("Specification Vendor", System.getProperty("java.specification.vendor")));
        listElement.add(buildJsonLabelAndValueString("Specification Version", System.getProperty("java.specification.version")));
        listElement.add(buildJsonLabelAndFolderString("Temporary Folder", System.getProperty("java.io.tmpdir")));
        listElement.add(buildJsonLabelAndValueString("VM Info", System.getProperty("java.vm.info")));
        listElement.add(buildJsonLabelAndValueString("VM Name", System.getProperty("java.vm.name")));
        listElement.add(buildJsonLabelAndValueString("VM Specification Name", System.getProperty("java.vm.specification.name")));
        listElement.add(buildJsonLabelAndValueString("VM Specification Vendor", System.getProperty("java.vm.specification.vendor")));
        listElement.add(buildJsonLabelAndValueString("VM Specification Version", System.getProperty("java.vm.specification.version")));
        listElement.add(buildJsonLabelAndValueString("VM Vendor", System.getProperty("java.vm.vendor")));
        listElement.add(buildJsonLabelAndValueString("VM Version", System.getProperty("java.vm.version")));
        listElement.add(buildJsonLabelAndValueString("Vendor", System.getProperty("java.vendor")));
        listElement.add(buildJsonLabelAndValueString("Vendor Url", System.getProperty("java.vendor.url")));
        listElement.add(buildJsonLabelAndValueString("Vendor Url Bugs", System.getProperty("java.vendor.url.bug")));
        listElement.add(buildJsonLabelAndValueString("Vendor Version", System.getProperty("java.vendor.version")));
        listElement.add(buildJsonLabelAndValueString("Version Date", System.getProperty("java.version.date")));
        listElement.add(buildJsonLabelAndValueString("Version", System.getProperty("java.version")));
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
    public static String buildInformatorOpeartingSystem() {
        ArrayList<String> listElement = new ArrayList<>();
        listElement.add(buildJsonLabelAndValueString("Architecture", System.getProperty("os.arch")));
        listElement.add(buildJsonLabelAndValueString("Architecture Data Model", System.getProperty("sun.arch.data.model")));
        listElement.add(buildJsonLabelAndValueString("Desktop", System.getProperty("sun.desktop")));
        listElement.add(buildJsonLabelAndValueString("File Encoding", System.getProperty("file.encoding")));
        listElement.add(buildJsonLabelAndValueString("File Encoding Package", System.getProperty("file.encoding.pkg")));
        listElement.add(buildJsonLabelAndFolderString("File Separator", System.getProperty("file.separator")));
        listElement.add(buildJsonLabelAndValueString("Name", System.getProperty("os.name")));
        listElement.add(buildJsonLabelAndValueString("Path Separator", System.getProperty("path.separator")));
        listElement.add(buildJsonLabelAndValueString("Standard Error Encoding", System.getProperty("sun.stderr.encoding")));
        listElement.add(buildJsonLabelAndValueString("Standard Out Encoding", System.getProperty("sun.stdout.encoding")));
        listElement.add(buildJsonLabelAndValueString("Version", System.getProperty("os.version")));
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
    public static String buildInformatorUser() {
        ArrayList<String> listElement = new ArrayList<>();
        listElement.add(buildJsonLabelAndValueString("Account Name", System.getProperty("user.name")));
        listElement.add(buildJsonLabelAndValueString("Country Format", System.getProperty("user.country.format")));
        listElement.add(buildJsonLabelAndValueString("Country", System.getProperty("user.country")));
        listElement.add(buildJsonLabelAndFolderString("Home Folder", System.getProperty("user.home")));
        listElement.add(buildJsonLabelAndValueString("Language Format", System.getProperty("user.language.format")));
        listElement.add(buildJsonLabelAndValueString("Language", System.getProperty("user.language")));
        listElement.add(buildJsonLabelAndValueString("Time Zone", System.getProperty("user.timezone")));
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
    public static String buildInformator(Integer sServerletMajor, Integer sServletMinor, String sTomcatVersion) {
        String sReturn = "\"Application\": " + buildInformatorTomcatApplication(sServerletMajor, sServletMinor, sTomcatVersion)
            + ", "
            + "\"Jasper Reports\": " + buildInformatorJasperReports()
            + ", "
            + "\"Java\": " + buildInformatorJava()
            + ", "
            + "\"Operating System\": " + buildInformatorOpeartingSystem()
            + ", "
            + "\"User\": " + buildInformatorUser();
        return "{ " + sReturn + " }";
    }
%>
<%= buildInformator(application.getMajorVersion(), application.getMinorVersion(), application.getServerInfo()) %>
