#!/bin/sh
#-------------------------------------------------------------------------------
#  Copyright 2012 yafra.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#-------------------------------------------------------------------------------
#
# Author:       Administrator
#
# Purpose:      build rcp client
#------------------------------------------------------------------------

test -d $WORKNODE/apps/yafrarcp || mkdir -p $WORKNODE/apps/yafrarcp

# copy run time libraries used by yafra rcp client
# yafra jars
cp $BASENODE/org.yafra.rcpproduct/target/products/*.zip $WORKNODE/apps/yafrarcp/

