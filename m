From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 03 Oct 2011 14:16:47 +0000
Subject: [PATCH] sh: Fix serial for SH7203
Message-Id: <1317651407-6155-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
Note: Not tested on SH2703 as I don't have a board. However I have tested
this on an SH7264 board which uses the same serial hardware.

 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   16 ++++++++++++----
 drivers/tty/serial/sh-sci.c            |   19 +++++++++++++++++++
 include/linux/serial_sci.h             |    1 +
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
index a43124e..0bd744f 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -176,10 +176,12 @@ static DECLARE_INTC_DESC(intc_desc, "sh7203", vectors, groups,
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xfffe8000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
 	.irqs		=  { 192, 192, 192, 192 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
 
 static struct platform_device scif0_device = {
@@ -193,10 +195,12 @@ static struct platform_device scif0_device = {
 static struct plat_sci_port scif1_platform_data = {
 	.mapbase	= 0xfffe8800,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
 	.irqs		=  { 196, 196, 196, 196 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
 
 static struct platform_device scif1_device = {
@@ -210,10 +214,12 @@ static struct platform_device scif1_device = {
 static struct plat_sci_port scif2_platform_data = {
 	.mapbase	= 0xfffe9000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
 	.irqs		=  { 200, 200, 200, 200 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
 
 static struct platform_device scif2_device = {
@@ -227,10 +233,12 @@ static struct platform_device scif2_device = {
 static struct plat_sci_port scif3_platform_data = {
 	.mapbase	= 0xfffe9800,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
 	.irqs		=  { 204, 204, 204, 204 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
 
 static struct platform_device scif3_device = {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 18e6342..ca21052 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -207,6 +207,25 @@ static struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 	},
 
 	/*
+	 * Common SH-2(A) SCIF definitions for ports with FIFO data
+	 * count registers.
+	 */
+	[SCIx_SH2_SCIF_FIFODATA_REGTYPE] = {
+		[SCSMR]		= { 0x00, 16 },
+		[SCBRR]		= { 0x04,  8 },
+		[SCSCR]		= { 0x08, 16 },
+		[SCxTDR]	= { 0x0c,  8 },
+		[SCxSR]		= { 0x10, 16 },
+		[SCxRDR]	= { 0x14,  8 },
+		[SCFCR]		= { 0x18, 16 },
+		[SCFDR]		= { 0x1c, 16 },
+		[SCTFDR]	= sci_reg_invalid,
+		[SCRFDR]	= sci_reg_invalid,
+		[SCSPTR]	= { 0x20, 16 },
+		[SCLSR]		= { 0x24, 16 },
+	},
+
+	/*
 	 * Common SH-3 SCIF definitions.
 	 */
 	[SCIx_SH3_SCIF_REGTYPE] = {
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 8bffe9a..5f3939c 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -67,6 +67,7 @@ enum {
 	SCIx_IRDA_REGTYPE,
 	SCIx_SCIFA_REGTYPE,
 	SCIx_SCIFB_REGTYPE,
+	SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 	SCIx_SH3_SCIF_REGTYPE,
 	SCIx_SH4_SCIF_REGTYPE,
 	SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
-- 
1.7.0.4

