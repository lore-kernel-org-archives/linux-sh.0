From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 31 Aug 2010 09:27:53 +0000
Subject: [PATCH] ARM: mach-shmobile: Use evt2irq() for sh7372 DMAC
Message-Id: <20100831092753.14892.19054.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use evt2irq() for DMAC resources on sh7372.

This makes the code easier to read and also
allows adjusting the INTC base offset without
breaking platform data.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7372.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2010-08-31 16:03:53.000000000 +0900
@@ -419,14 +419,14 @@ static struct resource sh7372_dmae0_reso
 	},
 	{
 		/* DMA error IRQ */
-		.start	= 246,
-		.end	= 246,
+		.start	= evt2irq(0x20c0),
+		.end	= evt2irq(0x20c0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-5 */
-		.start	= 240,
-		.end	= 245,
+		.start	= evt2irq(0x2000),
+		.end	= evt2irq(0x20a0),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -447,14 +447,14 @@ static struct resource sh7372_dmae1_reso
 	},
 	{
 		/* DMA error IRQ */
-		.start	= 254,
-		.end	= 254,
+		.start	= evt2irq(0x21c0),
+		.end	= evt2irq(0x21c0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-5 */
-		.start	= 248,
-		.end	= 253,
+		.start	= evt2irq(0x2100),
+		.end	= evt2irq(0x21a0),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -475,14 +475,14 @@ static struct resource sh7372_dmae2_reso
 	},
 	{
 		/* DMA error IRQ */
-		.start	= 262,
-		.end	= 262,
+		.start	= evt2irq(0x22c0),
+		.end	= evt2irq(0x22c0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-5 */
-		.start	= 256,
-		.end	= 261,
+		.start	= evt2irq(0x2200),
+		.end	= evt2irq(0x22a0),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
