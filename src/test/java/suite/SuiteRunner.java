package suite;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;

import com.intuit.karate.junit5.Karate;

import org.apache.commons.io.FileUtils;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class SuiteRunner {
    
    // this will run all *.feature files that exist in sub-directories
    // see https://github.com/intuit/karate#naming-conventions   
    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }

	public static void generateReport(final String karateOutputPath) {
	    final Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
	    final ArrayList jsonPaths = new ArrayList(jsonFiles.size());
	    jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
	    final Configuration config = new Configuration(new File("target"), "demo");
	    final ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config); reportBuilder.generateReports();
	}
    
}
