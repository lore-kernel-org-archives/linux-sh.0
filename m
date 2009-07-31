From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:47:44 +0000
Subject: [PATCH 04/09] sh: Runtime PM pdev hwblk - Solution Engine 7722
Message-Id: <20090731074744.29009.85842.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add hwblk_id to Solution Engine 7722 board specific
on-chip sh7722 platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-se/7722/setup.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 0001/arch/sh/boards/mach-se/7722/setup.c
+++ work/arch/sh/boards/mach-se/7722/setup.c	2009-07-30 15:09:01.000000000 +0900
@@ -22,6 +22,7 @@
 #include <asm/io.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_keysc.h>
+#include <cpu/sh7722.h>
 
 /* Heartbeat */
 static struct heartbeat_data heartbeat_data = {
@@ -137,6 +138,9 @@ static struct platform_device sh_keysc_d
 	.dev	= {
 		.platform_data	= &sh_keysc_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_KEYSC,
+	},
 };
 
 static struct platform_device *se7722_devices[] __initdata = {
