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
<%@page import = "javax.servlet.http.HttpUtils.*" %> 
<%
    String sCurrentUrl = request.getRequestURI();
    String sSpecificationVersion = System.getProperty("java.specification.version");
    if (sSpecificationVersion.compareTo("1.10") == 0) {
        out.print("<html><head><title>informator for Tomcat</title>" 
            + "<meta http-equiv=\"Refresh\" content=\"0; url=" + sCurrentUrl.replace("index.jsp", "") + "index10.jsp\">"
            + "</head><body>...</body></html>");
    } else {
        response.setContentType("application/json");
        out.print(buildInformator(application.getMajorVersion(), application.getMinorVersion(), application.getServerInfo()));
    }
%>