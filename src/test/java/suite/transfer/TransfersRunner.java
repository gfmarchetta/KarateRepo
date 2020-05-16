package suite.transfer;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import junit.framework.Assert;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;


class TransfersRunner {
    @Test
    public void testParallel() {
        final Results results = Runner.path("classpath:suite\\transfer").tags("@desa").parallel(3);
        generateReport(results.getReportDir());
        Assert.assertEquals(results.getErrorMessages(), 0, results.getFailCount());
    }

    public static void generateReport(final String karateOutputPath) {
        final Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        final ArrayList jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        final Configuration config = new Configuration(new File("target"), "demo");
        final ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config); reportBuilder.generateReports();
    }

}
