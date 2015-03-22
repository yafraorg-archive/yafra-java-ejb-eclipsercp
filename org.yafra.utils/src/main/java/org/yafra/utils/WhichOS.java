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
 * org.yafra.utils
 * check which operating system is running
 * $Id: WhichOS.java,v 1.2 2009-10-24 18:36:56 mwn Exp $
 */
package org.yafra.utils;

/**
 * @author mwn
 * 
 */
public final class WhichOS
{
	private static String OS = null;

	public final static String getOsName()
		{
		if (OS == null)
			{
			OS = System.getProperty("os.name");
			}
		return OS;
		}

	public final static boolean isWindows()
		{
		return getOsName().startsWith("Windows");
		}

	public final static boolean isUnix() // and so on
		{
		return getOsName().startsWith("Linux");
		}

}
