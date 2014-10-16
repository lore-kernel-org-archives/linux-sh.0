From: Andriy Skulysh <askulysh@gmail.com>
Date: Thu, 16 Oct 2014 18:46:50 +0000
Subject: [PATCH] sh: fix sh770x SCIF memory regions
Message-Id: <CACuQN4CtNGL25d8790u+7KjDbrYjAZvJ8xjM2ggGdYkJ_EkFZw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: fix sh770x SCIF memory regions

Resources scif1_resources & scif2_resources overlap.
Actual SCIF region size is 0x10.

This is regression from:

Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date:   Fri Dec 6 10:59:48 2013 +0100
sh: Declare SCIF register base and IRQ as resources

Signed-off-by: Andriy Skulysh <askulysh@gmail.com>

diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index ff1465c..5acf89c 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -118,7 +118,7 @@ static struct plat_sci_port scif0_platform_data = {
 };

 static struct resource scif0_resources[] = {
-    DEFINE_RES_MEM(0xfffffe80, 0x100),
+    DEFINE_RES_MEM(0xfffffe80, 0x10),
     DEFINE_RES_IRQ(evt2irq(0x4e0)),
 };

@@ -143,7 +143,7 @@ static struct plat_sci_port scif1_platform_data = {
 };

 static struct resource scif1_resources[] = {
-    DEFINE_RES_MEM(0xa4000150, 0x100),
+    DEFINE_RES_MEM(0xa4000150, 0x10),
     DEFINE_RES_IRQ(evt2irq(0x900)),
 };

@@ -169,7 +169,7 @@ static struct plat_sci_port scif2_platform_data = {
 };

 static struct resource scif2_resources[] = {
-    DEFINE_RES_MEM(0xa4000140, 0x100),
+    DEFINE_RES_MEM(0xa4000140, 0x10),
     DEFINE_RES_IRQ(evt2irq(0x880)),
 };
