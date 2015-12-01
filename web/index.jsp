<%-- 
    Document   : index
    Created on : Dec 1, 2015, 3:09:31 AM
    Author     : Daniel Popiniuc <danielpopiniuc@gmail.com>

    The MIT License (MIT)

    Copyright (c) 2015 Daniel Popiniuc

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
<%@page import="java.util.ArrayList" %>
<%!
    public static String buildInformatorTomcat(Integer sServerletMajor, Integer sServletMinor, String sTomcatVersion) {
        ArrayList<String> listElement = new ArrayList<String>();
        listElement.add("\"" + "CATALINA_BASE" + "\": \"" + System.getProperty("catalina.base").replace("\\", "\\\\") + "\"");
        listElement.add("\"" + "CATALINA_HOME" + "\": \"" + System.getProperty("catalina.home").replace("\\", "\\\\") + "\""); 
        listElement.add("\"" + "JAVA_HOME" + "\": \"" + System.getProperty("java.home").replace("\\", "\\\\") + "\""); 
        listElement.add("\"" + "Java Runtime Version" + "\": \"" + System.getProperty("java.runtime.version").replace("\\", "\\\\") + "\""); 
        listElement.add("\"" + "Java Specification Version" + "\": \"" + System.getProperty("java.specification.version").replace("\\", "\\\\") + "\""); 
        listElement.add("\"" + "Java Version" + "\": \"" + System.getProperty("java.version").replace("\\", "\\\\") + "\""); 
        listElement.add("\"" + "Java VM Name" + "\": \"" + System.getProperty("java.vm.name").replace("\\", "\\\\") + "\""); 
        listElement.add("\"" + "Java VM Specification Name" + "\": \"" + System.getProperty("java.vm.specification.name").replace("\\", "\\\\") + "\""); 
        listElement.add("\"" + "Java VM Version" + "\": \"" + System.getProperty("java.vm.version").replace("\\", "\\\\") + "\""); 
        listElement.add("\"" + "Java Vendor" + "\": \"" + System.getProperty("java.vendor").replace("\\", "\\\\") + "\""); 
        listElement.add("\"" + "Java Version" + "\": \"" + System.getProperty("java.version") + "\""); 
        listElement.add("\"" + "JavaBridge version" + "\": \"" + "---" + "\"");
        listElement.add("\"" + "JavaBridge-PHP Version" + "\": \"" + "---" + "\""); 
        listElement.add("\"" + "JavaBridge-Zend Engine Version" + "\": \"" + "---" + "\""); 
        listElement.add("\"" + "JSP version" + "\": \"" + JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() + "\""); 
        listElement.add("\"" + "Operating system architecture" + "\": \"" + System.getProperty("os.arch") + "\""); 
        listElement.add("\"" + "Operating system name" + "\": \"" + System.getProperty("os.name") + "\""); 
        listElement.add("\"" + "Operating system version" + "\": \"" + System.getProperty("os.version") + "\""); 
        listElement.add("\"" + "Servlet version" + "\": \"" + sServerletMajor + "." + sServletMinor + "\""); 
        listElement.add("\"" + "Temporary Folder" + "\": \"" + System.getProperty("java.io.tmpdir").replace("\\", "\\\\") + "\""); 
        listElement.add("\"" + "Tomcat Version" + "\": \"" + sTomcatVersion + "\""); 
        listElement.add("\"" + "User account name" + "\": \"" + System.getProperty("user.name") + "\""); 
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
%>
<%= buildInformatorTomcat(application.getMajorVersion(), application.getMinorVersion(), application.getServerInfo()) %>