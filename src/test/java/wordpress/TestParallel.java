package wordpress;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.Test;
import coreUtility.Reporter;
import org.junit.Before;
import java.util.ArrayList;
import java.util.List;
import static org.junit.Assert.*;

@KarateOptions(tags = {"~@ignore",  "@users", "@debug"})
public class TestParallel {

  @Before
  public void assertServiceUnavailable() {
    if (System.getProperty("serviceunavailable") != null && System.getProperty("serviceunavailable").equals("true")){
      List<String> path = new ArrayList<>();
      path.add("classpath:wordpress/utility/check-service-unavailable.feature");

      Results results = Runner.parallel(null, path, 1, null);

      // API is down!
      if (results.getFailCount() > 0){
        Reporter.generateReport(results.getReportDir(), "firefly-api-test-wordpress-data");
        fail("firefly-api-test-wordpress-data is down!");
      }
    }
  }

  @Test
  public void testParallel() {
    Results results = Runner.parallel(getClass(), 5);
    Reporter.generateReport(results.getReportDir(), "firefly-api-test-wordpress-data");

    // Only in integration environment and gold edition
    if (System.getProperty("karate.env") != null && System.getProperty("cucumber.options") != null) {
      boolean matches = System.getProperty("cucumber.options").matches(".*[^~]@gold.*");

      if ((System.getProperty("karate.env").equals("int") && matches)) {
        assertEquals(results.getErrorMessages(), 0, results.getFailCount());
      }
    }

  }
}
