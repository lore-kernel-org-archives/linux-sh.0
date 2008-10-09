From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Oct 2008 09:41:34 +0000
Subject: [PATCH] sh: reduce Migo-R smc91x overruns
Message-Id: <20081009094134.6468.88563.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Improve Migo-R ethernet performance by reducing smc91x overruns.
This is done by enabling SMC91X_NOWAIT and optimizing CS4 setup.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c |    6 ++++--
 arch/sh/include/asm/migor.h       |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

--- 0004/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-10-09 16:53:01.000000000 +0900
@@ -37,7 +37,7 @@
  */
 
 static struct smc91x_platdata smc91x_info = {
-	.flags = SMC91X_USE_16BIT,
+	.flags = SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
 
 static struct resource smc91x_eth_resources[] = {
@@ -463,8 +463,10 @@ static int __init migor_devices_setup(vo
 	gpio_direction_output(GPIO_PTJ5, 1);
 	gpio_export(GPIO_PTJ5, 0);
 
-	/* SMC91C111 */
+	/* SMC91C111 - Enable IRQ0, Setup CS4 for 16-bit fast access */
 	gpio_request(GPIO_FN_IRQ0, NULL);
+	ctrl_outl(0x00003400, BSC_CS4BCR);
+	ctrl_outl(0x00110080, BSC_CS4WCR);
 
 	/* KEYSC */
 	clk_always_enable("mstp214"); /* KEYSC */
--- 0001/arch/sh/include/asm/migor.h
+++ work/arch/sh/include/asm/migor.h	2008-10-09 16:44:46.000000000 +0900
@@ -52,7 +52,9 @@
 #define PORT_HIZCRB 0xa405015a
 #define PORT_HIZCRC 0xa405015c
 
+#define BSC_CS4BCR 0xfec10010
 #define BSC_CS6ABCR 0xfec1001c
+#define BSC_CS4WCR 0xfec10030
 
 #include <video/sh_mobile_lcdc.h>
 
