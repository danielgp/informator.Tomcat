/*
 * The MIT License
 *
 * Copyright 2018 Daniel Popiniuc
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package helpingJSON;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author Daniel Popiniuc
 */
public class helpingFunctions {
    public String buildJsonFromThreeLists(ArrayList<String> listAvailablePropertiesKey, ArrayList<String> listAvailablePropertiesValue, ArrayList<String> listAvailablePropertiesType) {
        ArrayList<String> listElement = new ArrayList<>();
        Integer intListAvailablePropertiesKeySize = listAvailablePropertiesKey.size();
        for (int i = 0; i < intListAvailablePropertiesKeySize; i++) {
            String crtPropertyValue = listAvailablePropertiesValue.get(i);
            if (getSystemPropertyOrEmptyIfNull(crtPropertyValue).compareTo("---") != 0) {
                switch(listAvailablePropertiesType.get(i)) {
                    case "buildJsonLabelAndValueString":
                        listElement.add(buildJsonLabelAndValueString(listAvailablePropertiesKey.get(i), crtPropertyValue));
                        break;
                    case "buildJsonLabelAndFolderString":
                        listElement.add(buildJsonLabelAndFolderString(listAvailablePropertiesKey.get(i), crtPropertyValue));
                        break;
                }
            }
        }
        Collections.sort(listElement);
        String sReturn = String.join(", ", listElement);
        return "{ " + sReturn + " }";
    }
    public String buildJsonLabelAndFolderString(String strInputStringLabel, String strInputStringFolder) {
        return "\"" + strInputStringLabel + "\" : \"" + strInputStringFolder.replace("\\", "\\\\") + "\"";
    }
    public String buildJsonLabelAndValueArrayListOfFileFromFolder(String strInputStringLabel, String inputFolderName) {
        return "\"" + strInputStringLabel + "\" : [" + listOfFilesWithinFolderReccursive(inputFolderName) + "]";
    }
    public String buildJsonLabelAndValueString(String strInputStringLabel, String strInputStringValue) {
        return "\"" + strInputStringLabel + "\" : \"" + strInputStringValue.replaceAll("\"", "") + "\"";
    }
    public String buildJsonLabelAndValueStringToArray(String strInputStringLabel, String inputString) {
        return "\"" + strInputStringLabel + "\" : [" + explodeAndSort(inputString, ",") + "]";
    }
    public String buildJsonLabelAndValueStringToArraySpecial(String strInputStringLabel, String inputString) {
        String outputString = inputString.replace("\"", "").replace("/", "\\\\");
        String outputStringInterpreted1 = outputString.replace("${catalina.base}", "${catalina.base} => " 
                + System.getProperty("catalina.base").replace("\\", "\\\\"));
        String outputStringInterpreted2 = outputStringInterpreted1.replace("${catalina.home}", "${catalina.home} => " 
                + System.getProperty("catalina.home").replace("\\", "\\\\"));
        return "\"" + strInputStringLabel + "\" : [" + explodeAndSort(outputStringInterpreted2, ",") + "]";
    }
    public String explodeAndSort(String inputString, String inputSeparator) {
        ArrayList<String> listCommonLoader = new ArrayList<>();
        Collections.addAll(listCommonLoader, inputString.split("\\s*" + inputSeparator + "\\s*"));
        Collections.sort(listCommonLoader);
        return "\"" + String.join("\", \"", listCommonLoader) + "\"";
    }
    public String getJasperReportsLibrariesFolder() {
        String sJasperReportsFolder = "/";
        ArrayList<String> listCommonLoader = new ArrayList<>();
        Collections.addAll(listCommonLoader, System.getProperty("common.loader").split("\\s*,\\s*"));
        Integer intListCommonLoaderSize = listCommonLoader.size();
        for (int i = 0; i < intListCommonLoaderSize; i++) {
            if (listCommonLoader.get(i).contains("JasperReports.lib")) { // this is a convention of included folder
                sJasperReportsFolder = listCommonLoader.get(i).replace("\"", "").substring(0, (listCommonLoader.get(i).length() - 7));
            }
        }
        return sJasperReportsFolder;
    }
    private String getSystemPropertyOrEmptyIfNull(String strInputSystemPropertyLabel) {
        if (System.getProperty(strInputSystemPropertyLabel) == null) {
            return "---";
        }
        return System.getProperty(strInputSystemPropertyLabel);
    }
    public String listOfFilesWithinFolderReccursive(String inputFolder) {
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
}
