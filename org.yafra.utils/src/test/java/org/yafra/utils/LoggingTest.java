/*****************************************************************
 * Copyright 2015 yafra.org
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * 
 */
package org.yafra.utils;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * @author mwn
 *
 */
public class LoggingTest {
	
	public Logging logtst;
	private static final String dev = "stdout";

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
		logtst.setDebugFlag(false);
		assertFalse("DebugFlag should be now false", logtst.isDebugFlag());
		logtst.setDebugFlag(true);
		assertTrue("DebugFlag should be now true", logtst.isDebugFlag());
		logtst.YafraDebug("\norg.yafra.tests - start off with first debug message", dev);
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
		logtst.logError("test error log", null);
	}

	/**
	 * Test method for {@link org.yafra.utils.Logging#YafraDebug(java.lang.String, java.lang.String)}.
	 */
	@Test
	public void testYafraDebug() {
		logtst.YafraDebug("test debug message", "stdout");
	}

}
