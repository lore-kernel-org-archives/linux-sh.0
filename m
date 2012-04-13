From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 13 Apr 2012 03:14:00 +0000
Subject: [PATCH 1/4] sh: sh4a: Change the specification method of IRQ to SCIx_IRQ_MUXED
Message-Id: <1334286843-3297-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Some SCIF devices specify the same IRQ. We can use SCIx_IRQ_MUXED for this.
And change use to evt2irq(), without specifying the value of IRQ directly.
This is correction to the SH4A series.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |    8 ++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    6 +++---
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    6 +++---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   12 ++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |    6 +++---
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |    6 +++---
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |   20 ++++++++++----------
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   12 ++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   10 +++++-----
 10 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
index 1b88483..476f474 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
@@ -22,7 +22,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 80, 80, 80, 80 },
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0xC00)),
 };
 
 static struct platform_device scif0_device = {
@@ -39,7 +39,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 81, 81, 81, 81 },
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0xC20)),
 };
 
 static struct platform_device scif1_device = {
@@ -56,7 +56,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 82, 82, 82, 82 },
+	.irq            = SCIx_IRQ_MUXED(evt2irq(0xC40)),
 };
 
 static struct platform_device scif2_device = {
@@ -73,7 +73,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 83, 83, 83, 83 },
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0xC60)),
 };
 
 static struct platform_device scif3_device = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index 8777386..20f9e36 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -25,7 +25,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 80, 80, 80, 80 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xC00)),
 };
 
 static struct platform_device scif0_device = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 8420d4b..34b2ee5 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -182,7 +182,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 80, 80, 80, 80 },
+	.irqs			= SCIx_IRQ_MUXED(evt2irq(0xC00)),
 	.ops		= &sh7722_sci_port_ops,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
@@ -201,7 +201,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 81, 81, 81, 81 },
+	.irqs			= SCIx_IRQ_MUXED(evt2irq(0xC20)),
 	.ops		= &sh7722_sci_port_ops,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
@@ -220,7 +220,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 82, 82, 82, 82 },
+	.irqs			= SCIx_IRQ_MUXED(evt2irq(0xC40)),
 	.ops		= &sh7722_sci_port_ops,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index a188c9e..3c1da7e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -28,7 +28,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 80, 80, 80, 80 },
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0xC00)),
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
 
@@ -47,7 +47,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 81, 81, 81, 81 },
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0xC20)),
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
 
@@ -66,7 +66,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 82, 82, 82, 82 },
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0xC40)),
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 4c671cf..20623ba 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -295,7 +295,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 80, 80, 80, 80 },
+	.irqs			= SCIx_IRQ_MUXED(evt2irq(0xC00)),
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
 
@@ -314,7 +314,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 81, 81, 81, 81 },
+	.irqs			= SCIx_IRQ_MUXED(evt2irq(0xC20)),
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
 
@@ -333,7 +333,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irqs           = { 82, 82, 82, 82 },
+	.irqs			= SCIx_IRQ_MUXED(evt2irq(0xC40)),
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
 
@@ -352,7 +352,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_3,
 	.type           = PORT_SCIFA,
-	.irqs           = { 56, 56, 56, 56 },
+	.irqs			= SCIx_IRQ_MUXED(evt2irq(0x900)),
 };
 
 static struct platform_device scif3_device = {
@@ -370,7 +370,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_3,
 	.type           = PORT_SCIFA,
-	.irqs           = { 88, 88, 88, 88 },
+	.irqs			= SCIx_IRQ_MUXED(evt2irq(0xD00)),
 };
 
 static struct platform_device scif4_device = {
@@ -388,7 +388,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_3,
 	.type           = PORT_SCIFA,
-	.irqs           = { 109, 109, 109, 109 },
+	.irqs			= SCIx_IRQ_MUXED(evt2irq(0xFA0)),
 };
 
 static struct platform_device scif5_device = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index c8836cf..fe45e4c 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -28,7 +28,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 40, 40, 40, 40 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x700)),
 };
 
 static struct platform_device scif2_device = {
@@ -45,7 +45,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 76, 76, 76, 76 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xB80)),
 };
 
 static struct platform_device scif3_device = {
@@ -62,7 +62,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 104, 104, 104, 104 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xF00)),
 };
 
 static struct platform_device scif4_device = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index 0011351..197e4c9 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -22,7 +22,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 40, 40, 40, 40 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x700)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -40,7 +40,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 76, 76, 76, 76 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xB80)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -58,7 +58,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 104, 104, 104, 104 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xF00)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
index 2c6aa22..46ea870 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
@@ -20,7 +20,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 61, 61, 61, 61 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x9A0)),
 };
 
 static struct platform_device scif0_device = {
@@ -37,7 +37,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 62, 62, 62, 62 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x9C0)),
 };
 
 static struct platform_device scif1_device = {
@@ -54,7 +54,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 63, 63, 63, 63 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x9E0)),
 };
 
 static struct platform_device scif2_device = {
@@ -71,7 +71,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 64, 64, 64, 64 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xA00)),
 };
 
 static struct platform_device scif3_device = {
@@ -88,7 +88,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 65, 65, 65, 65 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xA20)),
 };
 
 static struct platform_device scif4_device = {
@@ -105,7 +105,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 66, 66, 66, 66 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xA40)),
 };
 
 static struct platform_device scif5_device = {
@@ -122,7 +122,7 @@ static struct plat_sci_port scif6_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 67, 67, 67, 67 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xA60)),
 };
 
 static struct platform_device scif6_device = {
@@ -139,7 +139,7 @@ static struct plat_sci_port scif7_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 68, 68, 68, 68 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xA80)),
 };
 
 static struct platform_device scif7_device = {
@@ -156,7 +156,7 @@ static struct plat_sci_port scif8_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 69, 69, 69, 69 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xAA0)),
 };
 
 static struct platform_device scif8_device = {
@@ -173,7 +173,7 @@ static struct plat_sci_port scif9_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 70, 70, 70, 70 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xAC0)),
 };
 
 static struct platform_device scif9_device = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index 81588ef..304339f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -24,7 +24,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 40, 40, 40, 40 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x700)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -42,7 +42,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 44, 44, 44, 44 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x780)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -60,7 +60,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 60, 60, 60, 60 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x980)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -78,7 +78,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 61, 61, 61, 61 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x9A0)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -96,7 +96,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 62, 62, 62, 62 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x9C0)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -114,7 +114,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 63, 63, 63, 63 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x9E0)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 599022d..9befe2d 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -53,7 +53,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 44, 44, 44, 44 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x780)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -71,7 +71,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 50, 50, 50, 50 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x840)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -89,7 +89,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 51, 51, 51, 51 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x860)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -107,7 +107,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 52, 52, 52, 52 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x880)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -125,7 +125,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_1,
 	.type		= PORT_SCIF,
-	.irqs		= { 53, 53, 53, 53 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x8A0)),
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
-- 
1.7.9.1

