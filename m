From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 08:59:54 +0000
Subject: [PATCH 01/06] sh: sh7343 scif configuration update
Message-Id: <20081204085954.25773.21765.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Fix interrupt values for the first sh7343 SCIF port and
update the configuration to include the remaining 3 ones.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- 0009/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-12-03 17:42:35.000000000 +0900
@@ -150,7 +150,22 @@ static struct plat_sci_port sci_platform
 		.mapbase	= 0xffe00000,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.type		= PORT_SCIF,
-		.irqs		= { 80, 81, 83, 82 },
+		.irqs		= { 80, 80, 80, 80 },
+	}, {
+		.mapbase	= 0xffe10000,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 81, 81, 81, 81 },
+	}, {
+		.mapbase	= 0xffe20000,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 82, 82, 82, 82 },
+	}, {
+		.mapbase	= 0xffe30000,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 83, 83, 83, 83 },
 	}, {
 		.flags = 0,
 	}
@@ -199,7 +214,7 @@ enum {
 	MMC_ERR, MMC_TRAN, MMC_FSTAT, MMC_FRDY,
 	DMAC4, DMAC5, DMAC_DADERR,
 	KEYSC,
-	SCIF, SCIF1, SCIF2, SCIF3, SCIF4,
+	SCIF, SCIF1, SCIF2, SCIF3,
 	SIOF0, SIOF1, SIO,
 	FLCTL_FLSTEI, FLCTL_FLENDI, FLCTL_FLTREQ0I, FLCTL_FLTREQ1I,
 	I2C0_ALI, I2C0_TACKI, I2C0_WAITI, I2C0_DTEI,
