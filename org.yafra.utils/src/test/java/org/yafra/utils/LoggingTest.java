/**
 * 
 */
package org.yafra.utils;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 * @author mwn
 *
 */
public class LoggingTest {
	
	public Logging logtst;

	/**
	 * @throws java.lang.Exception
	 */
	@Before
	public void setUp() throws Exception {
		logtst = new Logging();
	}

	/**
	 * @throws java.lang.Exception
	 */
	@After
	public void tearDown() throws Exception {
	}

	/**
	 * Test method for {@link org.yafra.utils.Logging#isDebugFlag()}.
	 */
	@Test
	public void testIsDebugFlag() {
		assertFalse("DebugFlag should be false by default", logtst.isDebugFlag());
	}

	/**
	 * Test method for {@link org.yafra.utils.Logging#setDebugFlag(boolean)}.
	 */
	@Test
	public void testSetDebugFlag() {
		logtst.setDebugFlag(true);
		assertTrue("DebugFlag should be now true", logtst.isDebugFlag());
	}

	/**
	 * Test method for {@link org.yafra.utils.Logging#Logging()}.
	 */
	@Test
	public void testLogging() {
	}

	/**
	 * Test method for {@link org.yafra.utils.Logging#logInfo(java.lang.String)}.
	 */
	@Test
	public void testLogInfo() {
		logtst.logInfo("test info log");
	}

	/**
	 * Test method for {@link org.yafra.utils.Logging#logDebug(java.lang.String)}.
	 */
	@Test
	public void testLogDebug() {
		logtst.logDebug("test debug log");
	}

	/**
	 * Test method for {@link org.yafra.utils.Logging#logError(java.lang.String, java.lang.Throwable)}.
	 */
	@Test
	public void testLogError() {
//		logtst.logError("test error log", null);
	}

	/**
	 * Test method for {@link org.yafra.utils.Logging#YafraDebug(java.lang.String, java.lang.String)}.
	 */
	@Test
	public void testYafraDebug() {
		logtst.YafraDebug("test debug message", "stdout");
	}

}
