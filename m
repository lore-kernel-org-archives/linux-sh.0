From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 16 Jun 2015 02:01:19 +0000
Subject: [PATCH] i2c-tools: enable static use of libi2c
Message-Id: <1434420079-3029-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

When debugging embedded systems, it is often nice to simply TFTP the
desired i2ctool to the target without the hazzle of dealing with shared
libs. Using -static is overkill, too, so let's add a switch which will
only link functions from libi2c statically.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Makefile        | 2 ++
 tools/Module.mk | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 252a126..6d36f2f 100644
--- a/Makefile
+++ b/Makefile
@@ -33,6 +33,8 @@ CFLAGS		+= -Wall
 SOCFLAGS	:= -fpic -D_REENTRANT $(CFLAGS)
 
 BUILD_STATIC_LIB ?= 1
+# Uncomment to use static libi2c
+#USE_STATIC_LIB := 1
 
 KERNELVERSION	:= $(shell uname -r)
 
diff --git a/tools/Module.mk b/tools/Module.mk
index d14bb0c..8efddbb 100644
--- a/tools/Module.mk
+++ b/tools/Module.mk
@@ -12,7 +12,11 @@ TOOLS_DIR	:= tools
 TOOLS_CFLAGS	:= -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
 		   -Wcast-align -Wwrite-strings -Wnested-externs -Winline \
 		   -W -Wundef -Wmissing-prototypes -Iinclude
+ifeq ($(USE_STATIC_LIB),1)
+TOOLS_LDFLAGS	:= $(LIB_DIR)/$(LIB_STLIBNAME)
+else
 TOOLS_LDFLAGS	:= -Llib -li2c
+endif
 
 TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
 
-- 
2.1.4

