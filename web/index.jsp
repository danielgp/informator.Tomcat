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

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>

<%@page import="helpingJSON.helpingFunctions"%>

<%!
    public String buildInformatorApplication(Integer sServerletMajor, Integer sServletMinor, String sTomcatVersion) {
        helpingFunctions fnJson = new helpingFunctions();
        ArrayList<String> listElement = new ArrayList<>();
        listElement.add(fnJson.buildJsonLabelAndFolderString("Catalina Base", System.getProperty("catalina.base")));
        listElement.add(fnJson.buildJsonLabelAndFolderString("Catalina Home", System.getProperty("catalina.home")));
        listElement.add(fnJson.buildJsonLabelAndValueStringToArraySpecial("Common Loader", System.getProperty("common.loader")));
        listElement.add(fnJson.buildJsonLabelAndValueString("Full Name and Version", sTomcatVersion));
        listElement.add(fnJson.buildJsonLabelAndValueString("JSP Version", JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion()));
        listElement.add(fnJson.buildJsonLabelAndValueString("Name", sTomcatVersion.split("/")[0]));
        listElement.add(fnJson.buildJsonLabelAndValueStringToArray("Package Access", System.getProperty("package.access")));
        listElement.add(fnJson.buildJsonLabelAndValueStringToArray("Package Definition", System.getProperty("package.definition")));
        listElement.add(fnJson.buildJsonLabelAndValueString("Servlet Version", sServerletMajor + "." + sServletMinor));
        listElement.add(fnJson.buildJsonLabelAndValueStringToArray("Standard Jar Skip Filter", System.getProperty("tomcat.util.scan.StandardJarScanFilter.jarsToSkip")));
        listElement.add(fnJson.buildJsonLabelAndValueStringToArray("Standard Jar Scan Filter", System.getProperty("tomcat.util.scan.StandardJarScanFilter.jarsToScan")));
        listElement.add(fnJson.buildJsonLabelAndValueString("Version", sTomcatVersion.split("/")[1]));
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
    public String buildInformatorJasperReports() {
        helpingFunctions fnJson = new helpingFunctions();
        ArrayList<String> listElement = new ArrayList<>();
        listElement.add(fnJson.buildJsonLabelAndValueArrayListOfFileFromFolder("JasperReports libraries", fnJson.getJasperReportsLibrariesFolder()));
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
        helpingFunctions fnJson = new helpingFunctions();
        return fnJson.buildJsonFromThreeLists(listAvailablePropertiesKey, listAvailablePropertiesValue, listAvailablePropertiesType);
    }
    public static String buildInformatorJavaVM() {
        helpingFunctions fnJson = new helpingFunctions();
        ArrayList<String> listElement = new ArrayList<>();
        listElement.add(fnJson.buildJsonLabelAndValueString("VM Info", System.getProperty("java.vm.info")));
        listElement.add(fnJson.buildJsonLabelAndValueString("VM Name", System.getProperty("java.vm.name")));
        listElement.add(fnJson.buildJsonLabelAndValueString("VM Specification Name", System.getProperty("java.vm.specification.name")));
        listElement.add(fnJson.buildJsonLabelAndValueString("VM Specification Vendor", System.getProperty("java.vm.specification.vendor")));
        listElement.add(fnJson.buildJsonLabelAndValueString("VM Specification Version", System.getProperty("java.vm.specification.version")));
        listElement.add(fnJson.buildJsonLabelAndValueString("VM Vendor", System.getProperty("java.vm.vendor")));
        listElement.add(fnJson.buildJsonLabelAndValueString("VM Version", System.getProperty("java.vm.version")));
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
        helpingFunctions fnJson = new helpingFunctions();
        return fnJson.buildJsonFromThreeLists(listAvailablePropertiesKey, listAvailablePropertiesValue, listAvailablePropertiesType);
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
        helpingFunctions fnJson = new helpingFunctions();
        return fnJson.buildJsonFromThreeLists(listAvailablePropertiesKey, listAvailablePropertiesValue, listAvailablePropertiesType);
    }
    public String buildInformator(Integer sServerletMajor, Integer sServletMinor, String sTomcatVersion) {
        String sReturn = "" 
            + "\"Application\": " + buildInformatorApplication(sServerletMajor, sServletMinor, sTomcatVersion)
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
