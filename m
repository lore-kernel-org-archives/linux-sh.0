From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 07 Jan 2011 02:58:16 +0000
Subject: [PATCH 3/5] sh: Move init_landisk_IRQ to header file
Message-Id: <1294369335-4064-3-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/boards/mach-landisk/setup.c                |    2 --
 arch/sh/include/mach-landisk/mach/iodata_landisk.h |    4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-landisk/setup.c
index 50337acc..c693121 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -21,8 +21,6 @@
 #include <mach-landisk/mach/iodata_landisk.h>
 #include <asm/io.h>
 
-void init_landisk_IRQ(void);
-
 static void landisk_power_off(void)
 {
         __raw_writeb(0x01, PA_SHUTDOWN);
diff --git a/arch/sh/include/mach-landisk/mach/iodata_landisk.h b/arch/sh/include/mach-landisk/mach/iodata_landisk.h
index 8b40485..f432773 100644
--- a/arch/sh/include/mach-landisk/mach/iodata_landisk.h
+++ b/arch/sh/include/mach-landisk/mach/iodata_landisk.h
@@ -2,7 +2,7 @@
 #define __ASM_SH_IODATA_LANDISK_H
 
 /*
- * linux/include/asm-sh/landisk/iodata_landisk.h
+ * arch/sh/include/mach-landisk/mach/iodata_landisk.h
  *
  * Copyright (C) 2000  Atom Create Engineering Co., Ltd.
  *
@@ -35,6 +35,8 @@
 #define IRQ_BUTTON	12		/* USL-5P Button IRQ */
 #define IRQ_FAULT	13		/* USL-5P Fault  IRQ */
 
+void init_landisk_IRQ(void);
+
 #define __IO_PREFIX landisk
 #include <asm/io_generic.h>
 
-- 
1.7.2.3

