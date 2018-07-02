<%-- 
    Document   : index
    Created on : Dec 1, 2015, 3:09:31 AM
    Author     : Daniel Popiniuc <danielpopiniuc@gmail.com>

    The MIT License (MIT)

    Copyright (c) 2015-2016 Daniel Popiniuc

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
        ArrayList<String> listCommonLoader = new ArrayList<String>();
        Collections.addAll(listCommonLoader, inputString.split("\\s*" + inputSeparator + "\\s*"));
        Collections.sort(listCommonLoader);
        return "\"" + String.join("\", \"", listCommonLoader) + "\"";
    }
    public static String listOfFilesWithinFolderReccursive(String inputFolder) {
        ArrayList<String> listOfJustFiles = new ArrayList<String>();
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
    public static String buildInformatorTomcat(Integer sServerletMajor, Integer sServletMinor, String sTomcatVersion) {
        ArrayList<String> listElement = new ArrayList<String>();
        listElement.add(buildJsonLabelAndValueString("Application", sTomcatVersion));
        listElement.add(buildJsonLabelAndValueString("Application Name", sTomcatVersion.split("/")[0]));
        listElement.add(buildJsonLabelAndValueString("Application Version", sTomcatVersion.split("/")[1]));
        listElement.add(buildJsonLabelAndFolderString("Catalina Base", System.getProperty("catalina.base")));
        listElement.add(buildJsonLabelAndFolderString("Catalina Home", System.getProperty("catalina.home")));
        listElement.add(buildJsonLabelAndValueStringToArraySpecial("Common Loader", System.getProperty("common.loader")));
        listElement.add(buildJsonLabelAndValueString("JSP Version", JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion()));
        listElement.add(buildJsonLabelAndValueArrayListOfFileFromFolder("JasperReports libraries", "C:/www/App/Tomcat/JasperReports.lib/"));
        listElement.add(buildJsonLabelAndValueString("Java Class Version", System.getProperty("java.class.version")));
        /* endorsed dir are no longer supported starting with Java 9 onwards */
        listElement.add(buildJsonLabelAndFolderString("Java Home", System.getProperty("java.home")));
        listElement.add(buildJsonLabelAndFolderString("Java IO Temp Dir", System.getProperty("java.io.tmpdir")));
        listElement.add(buildJsonLabelAndFolderString("Java Logging Config File", System.getProperty("java.util.logging.config.file")));
        listElement.add(buildJsonLabelAndFolderString("Java Logging Manager", System.getProperty("java.util.logging.manager")));
        listElement.add(buildJsonLabelAndValueString("Java Runtime Name", System.getProperty("java.runtime.name")));
        listElement.add(buildJsonLabelAndValueString("Java Runtime Version", System.getProperty("java.runtime.version")));
        listElement.add(buildJsonLabelAndValueString("Java Specification Name", System.getProperty("java.specification.name")));
        listElement.add(buildJsonLabelAndValueString("Java Specification Vendor", System.getProperty("java.specification.vendor")));
        listElement.add(buildJsonLabelAndValueString("Java Specification Version", System.getProperty("java.specification.version")));
        listElement.add(buildJsonLabelAndValueString("Java VM Info", System.getProperty("java.vm.info")));
        listElement.add(buildJsonLabelAndValueString("Java VM Name", System.getProperty("java.vm.name")));
        listElement.add(buildJsonLabelAndValueString("Java VM Specification Name", System.getProperty("java.vm.specification.name")));
        listElement.add(buildJsonLabelAndValueString("Java VM Vendor", System.getProperty("java.vm.vendor")));
        listElement.add(buildJsonLabelAndValueString("Java VM Version", System.getProperty("java.vm.version")));
        listElement.add(buildJsonLabelAndValueString("Java Vendor", System.getProperty("java.vendor")));
        listElement.add(buildJsonLabelAndValueString("Java Version", System.getProperty("java.version")));
        listElement.add(buildJsonLabelAndValueString("Operating System Architecture", System.getProperty("os.arch")));
        listElement.add(buildJsonLabelAndValueString("Operating System Name", System.getProperty("os.name")));
        listElement.add(buildJsonLabelAndValueString("Operating System Version", System.getProperty("os.version")));
        listElement.add(buildJsonLabelAndValueStringToArray("Package Access", System.getProperty("package.access")));
        listElement.add(buildJsonLabelAndValueStringToArray("Package Definition", System.getProperty("package.definition")));
        listElement.add(buildJsonLabelAndValueString("Servlet Version", sServerletMajor + "." + sServletMinor));
        listElement.add(buildJsonLabelAndFolderString("Temporary Folder", System.getProperty("java.io.tmpdir")));
        listElement.add(buildJsonLabelAndValueStringToArray("Tomcat Standard Jar Skip Filter", System.getProperty("tomcat.util.scan.StandardJarScanFilter.jarsToSkip")));
        listElement.add(buildJsonLabelAndValueStringToArray("Tomcat Standard Jar Scan Filter", System.getProperty("tomcat.util.scan.StandardJarScanFilter.jarsToScan")));
        listElement.add(buildJsonLabelAndValueString("User Account Name", System.getProperty("user.name")));
        listElement.add(buildJsonLabelAndValueString("User Country", System.getProperty("user.country")));
        listElement.add(buildJsonLabelAndValueString("User Language", System.getProperty("user.language")));
        listElement.add(buildJsonLabelAndFolderString("User Home Folder", System.getProperty("user.home")));
        listElement.add(buildJsonLabelAndValueString("User Time Zone", System.getProperty("user.timezone")));
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
%>
<%= buildInformatorTomcat(application.getMajorVersion(), application.getMinorVersion(), application.getServerInfo()) %>
