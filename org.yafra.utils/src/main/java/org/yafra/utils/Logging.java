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
* logging utilities - facilities to debug and log in yafra applications
*/
package org.yafra.utils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author mwn
 * 
 */
public class Logging
{
	private Log logger;

	private boolean DebugFlag = false;
	public boolean isDebugFlag() {return DebugFlag;}
	public void setDebugFlag(boolean debugFlag) {DebugFlag = debugFlag;}

	/*
	 * init logging facility
	 */
	public Logging()
		{
		logger = LogFactory.getLog("org.yafra");
		}

	/**
	 * Log the specified information.
	 * 
	 * @param message
	 *           a human-readable message, localized to the current locale
	 */
	public void logInfo(String message)
		{
		logger.info(message);
		}

	/**
	 * Debug log the specified information.
	 * 
	 * @param message
	 *           a human-readable message, localized to the current locale
	 */
	public void logDebug(String message)
		{
		logger.debug(message);
		}

	/**
	 * Log the specified error.
	 * 
	 * @param exception
	 *           a low-level exception
	 */
	public void logError(String message, Throwable exception)
		{
		logger.error(message, exception);
		}

	/**
	 * Plain logging to stderr or stdout
	 * 
	 * @param message
	 *           string with a message of the log entry
	 */
	public void YafraDebug(String message, String type)
		{
		if (DebugFlag == true)
			{
			if (type.equals("stdout"))
				System.out.println(message);
			else
				System.err.println(message);
			}
		}
}
