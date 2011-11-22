From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 22 Nov 2011 06:15:57 +0000
Subject: [PATCH] ARM: mach-shmobile: Kota2 PINT fix
Message-Id: <20111122061557.30983.75780.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Support PINT on sh73a0 and Kota2 using INTC PINT macros.

With this patch applied the Kota2 ethernet is handled
through one of the chained sh73a0 PINT interrupt controllers.

sh73a0 PINT support is included in 3.2-rc but the Kota2 board
code does not make use of this shared code base without this
patch. Without this patch kota2 on-board ethernet is broken.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kota2.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2011-11-14 17:08:42.000000000 +0900
@@ -55,7 +55,7 @@ static struct resource smsc9220_resource
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= gic_spi(33), /* PINTA2 @ PORT144 */
+		.start		= SH73A0_PINT0_IRQ(2), /* PINTA2 */
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -310,18 +310,6 @@ static void __init kota2_map_io(void)
 	shmobile_setup_console();
 }
 
-#define PINTER0A	0xe69000a0
-#define PINTCR0A	0xe69000b0
-
-void __init kota2_init_irq(void)
-{
-	sh73a0_init_irq();
-
-	/* setup PINT: enable PINTA2 as active low */
-	__raw_writel(1 << 29, PINTER0A);
-	__raw_writew(2 << 10, PINTCR0A);
-}
-
 static void __init kota2_init(void)
 {
 	sh73a0_pinmux_init();
@@ -440,7 +428,7 @@ struct sys_timer kota2_timer = {
 
 MACHINE_START(KOTA2, "kota2")
 	.map_io		= kota2_map_io,
-	.init_irq	= kota2_init_irq,
+	.init_irq	= sh73a0_init_irq,
 	.handle_irq	= shmobile_handle_irq_gic,
 	.init_machine	= kota2_init,
 	.timer		= &kota2_timer,
