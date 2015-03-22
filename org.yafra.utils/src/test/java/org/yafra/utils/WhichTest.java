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
public class WhichTest {
	
	public WhichUser UserID;

	/**
	 * @throws java.lang.Exception
	 */
	@Before
	public void setUp() throws Exception {
		UserID = new WhichUser();
	}

	/**
	 * @throws java.lang.Exception
	 */
	@After
	public void tearDown() throws Exception {
	}

	/**
	 * Test method for {@link org.yafra.utils.WhichUser#getEnvUser()}.
	 */
	@Test
	public void testGetEnvUser() {
		String username = UserID.getEnvUser();
		assertNotNull("user from environment should be set", username);
	}

	/**
	 * Test method for {@link org.yafra.utils.WhichUser#getUser()}.
	 */
	@Test
	public void testGetUser() {
		String username = UserID.getUser();
		assertNotNull("user from system should be set", username);
	}

	/**
	 * Test method for {@link org.yafra.utils.WhichUser#getUser()}.
	 */
	@Test
	public void testIsIdentical() {
		assertNotNull("users from environment and system should be equal - boolean return - not null", UserID.isIdentical());
	}

	/**
	 * Test method for {@link org.yafra.utils.WhichOS#getOsName()}.
	 */
	@Test
	public void testGetOsName() {
		String osname = System.getProperty("os.name"); // just for debug purposes to compare names
		assertNotNull("getOsName should return string", org.yafra.utils.WhichOS.getOsName());
		assertEquals("osname should be equal", osname, org.yafra.utils.WhichOS.getOsName());
		assertNotNull("isWindows should return true or false", org.yafra.utils.WhichOS.isWindows());
		assertNotNull("isUnix should return true or false", org.yafra.utils.WhichOS.isUnix());
	}

}
