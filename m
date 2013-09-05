From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Sep 2013 05:56:25 +0000
Subject: Re: [PATCH 3/5 v2] ARM: shmobile: bockw: enable global use of FPGA
Message-Id: <20130905055624.GE14960@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2p0vnph.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2p0vnph.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 26, 2013 at 01:52:23AM -0700, Kuninori Morimoto wrote:
> This patch enables global use of FPGA,
> since it will be used from many devices.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up for v3.13.

There was a bit of diff-noise, please make sure I have applied it
correctly. The patch I applied is below:

From f11841a2fdd7332713ebb99e72f578ffcaf60784 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Aug 2013 01:52:23 -0700
Subject: [PATCH] ARM: shmobile: bockw: enable global use of FPGA

This patch enables global use of FPGA,
since it will be used from many devices.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index d555464..2cac3c7 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -33,6 +33,10 @@
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
 
+#define FPGA	0x18200000
+#define IRQ0MR	0x30
+static void __iomem *fpga;
+
 /*
  *	CN9(Upper side) SCIF/RCAN selection
  *
@@ -170,8 +174,6 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 				  "sdhi0", "sdhi0"),
 };
 
-#define FPGA	0x18200000
-#define IRQ0MR	0x30
 #define PFC	0xfffc0000
 #define PUPR4	0x110
 static void __init bockw_init(void)
@@ -196,8 +198,8 @@ static void __init bockw_init(void)
 	r8a7778_pinmux_init();
 
 	/* for SMSC */
-	base = ioremap_nocache(FPGA, SZ_1M);
-	if (base) {
+	fpga = ioremap_nocache(FPGA, SZ_1M);
+	if (fpga) {
 		/*
 		 * CAUTION
 		 *
@@ -205,10 +207,9 @@ static void __init bockw_init(void)
 		 * it should be cared in the future
 		 * Now, it is assuming IRQ0 was used only from SMSC.
 		 */
-		u16 val = ioread16(base + IRQ0MR);
+		u16 val = ioread16(fpga + IRQ0MR);
 		val &= ~(1 << 4); /* enable SMSC911x */
-		iowrite16(val, base + IRQ0MR);
-		iounmap(base);
+		iowrite16(val, fpga + IRQ0MR);
 
 		regulator_register_fixed(0, dummy_supplies,
 					 ARRAY_SIZE(dummy_supplies));
-- 
1.8.4

