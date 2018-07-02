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
<%@page import = "java.util.ArrayList" %>
<%@page import = "java.util.Enumeration" %>
<%@page import = "java.util.Collections" %>
<%@page import = "java.util.Properties" %>
<%!
    public static String buildTest() {
        ArrayList<String> listElement = new ArrayList<>();
        Properties p = System.getProperties();
        Enumeration keys = p.keys();
        while (keys.hasMoreElements()) {
            String key = (String)keys.nextElement();
            String value = (String)p.get(key);
            listElement.add("\"" + key + "\": " + value.replace("\"", "\\\\").replace("/", "\\\\") + "<br/>");
        }
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return sReturn;
    }
%>
<%= buildTest() %>
