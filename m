From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Feb 2013 09:39:44 +0000
Subject: [PATCH v3] ARM: shmobile: add gic_iid macro for ICCIAR / interrupt ID
Message-Id: <87zjysenqb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

R-Car H1 datasheet GIC number is indicating
GIC ICCIAR / interrupt ID number, not SPI number,
but current marzen board code is using gic_spi() with
un-understandable calculation.

This patch adds new gic_iid() macro which means
ICCIAR / interrupt ID, and used the number
currently written on datasheet.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - add simple explain on gic_iid()

 arch/arm/mach-shmobile/board-marzen.c      |   12 ++++++------
 arch/arm/mach-shmobile/include/mach/irqs.h |    1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index cdcb799..2338d4b 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -66,7 +66,7 @@ static struct resource smsc911x_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= gic_spi(28), /* IRQ 1 */
+		.start		= gic_iid(0x3c), /* IRQ 1 */
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -96,7 +96,7 @@ static struct resource sdhi0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(104),
+		.start	= gic_iid(0x88),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -214,7 +214,7 @@ static struct resource ehci0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(44),
+		.start	= gic_iid(0x4c),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -238,7 +238,7 @@ static struct resource ehci1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(45),
+		.start	= gic_iid(0x4d),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -268,7 +268,7 @@ static struct resource ohci0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(44),
+		.start	= gic_iid(0x4c),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -292,7 +292,7 @@ static struct resource ohci1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(45),
+		.start	= gic_iid(0x4d),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
index 06a5da3..992ed21 100644
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ b/arch/arm/mach-shmobile/include/mach/irqs.h
@@ -5,6 +5,7 @@
 
 /* GIC */
 #define gic_spi(nr)		((nr) + 32)
+#define gic_iid(nr)		(nr) /* ICCIAR / interrupt ID */
 
 /* INTCS */
 #define INTCS_VECT_BASE		0x3400
-- 
1.7.9.5

