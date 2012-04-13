From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 13 Apr 2012 03:14:03 +0000
Subject: [PATCH 4/4] sh: sh2: Change the specification method of IRQ to SCIx_IRQ_MUXED
Message-Id: <1334286843-3297-4-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Some SCIF devices specify the same IRQ. We can use SCIx_IRQ_MUXED for this.
This is correction to the SH2/SH2A series.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |    6 +++---
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |    2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |   16 ++++++++--------
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |    8 ++++----
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |    8 ++++----
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
index 0f8befc..e0b740c 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -65,7 +65,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 88, 88, 88, 88 },
+	.irqs		= SCIx_IRQ_MUXED(88),
 };
 
 static struct platform_device scif0_device = {
@@ -82,7 +82,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 92, 92, 92, 92 },
+	.irqs		= SCIx_IRQ_MUXED(92),
 };
 
 static struct platform_device scif1_device = {
@@ -99,7 +99,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 96, 96, 96, 96 },
+	.irqs		= SCIx_IRQ_MUXED(96),
 };
 
 static struct platform_device scif2_device = {
diff --git a/arch/sh/kernel/cpu/sh2a/setup-mxg.c b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
index 949bf2b..f7f1cf2 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
@@ -204,7 +204,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 220, 220, 220, 220 },
+	.irqs		= SCIx_IRQ_MUXED(220),
 };
 
 static struct platform_device scif0_device = {
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
index 9df558d..7b84785 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
@@ -183,7 +183,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 180, 180, 180, 180 }
+	.irqs		= SCIx_IRQ_MUXED(180),
 };
 
 static struct platform_device scif0_device = {
@@ -200,7 +200,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 184, 184, 184, 184 }
+	.irqs		= SCIx_IRQ_MUXED(184),
 };
 
 static struct platform_device scif1_device = {
@@ -217,7 +217,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 188, 188, 188, 188 }
+	.irqs		= SCIx_IRQ_MUXED(188),
 };
 
 static struct platform_device scif2_device = {
@@ -234,7 +234,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 192, 192, 192, 192 }
+	.irqs		= SCIx_IRQ_MUXED(192),
 };
 
 static struct platform_device scif3_device = {
@@ -251,7 +251,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 196, 196, 196, 196 }
+	.irqs		= SCIx_IRQ_MUXED(196),
 };
 
 static struct platform_device scif4_device = {
@@ -268,7 +268,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 200, 200, 200, 200 }
+	.irqs		= SCIx_IRQ_MUXED(200),
 };
 
 static struct platform_device scif5_device = {
@@ -285,7 +285,7 @@ static struct plat_sci_port scif6_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 204, 204, 204, 204 }
+	.irqs		= SCIx_IRQ_MUXED(204),
 };
 
 static struct platform_device scif6_device = {
@@ -302,7 +302,7 @@ static struct plat_sci_port scif7_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 208, 208, 208, 208 }
+	.irqs		= SCIx_IRQ_MUXED(208),
 };
 
 static struct platform_device scif7_device = {
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
index 0bd744f..bfc33f6 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -180,7 +180,7 @@ static struct plat_sci_port scif0_platform_data = {
 			  SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		=  { 192, 192, 192, 192 },
+	.irqs		= SCIx_IRQ_MUXED(192),
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -199,7 +199,7 @@ static struct plat_sci_port scif1_platform_data = {
 			  SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		=  { 196, 196, 196, 196 },
+	.irqs		= SCIx_IRQ_MUXED(196),
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -218,7 +218,7 @@ static struct plat_sci_port scif2_platform_data = {
 			  SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		=  { 200, 200, 200, 200 },
+	.irqs		= SCIx_IRQ_MUXED(200),
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -237,7 +237,7 @@ static struct plat_sci_port scif3_platform_data = {
 			  SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		=  { 204, 204, 204, 204 },
+	.irqs		= SCIx_IRQ_MUXED(204),
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
 
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
index 5d14f84..a501074 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
@@ -139,7 +139,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 240, 240, 240, 240 },
+	.irqs		= SCIx_IRQ_MUXED(240),
 };
 
 static struct platform_device scif0_device = {
@@ -156,7 +156,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 244, 244, 244, 244 },
+	.irqs		= SCIx_IRQ_MUXED(244),
 };
 
 static struct platform_device scif1_device = {
@@ -173,7 +173,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 248, 248, 248, 248 },
+	.irqs		= SCIx_IRQ_MUXED(248),
 };
 
 static struct platform_device scif2_device = {
@@ -190,7 +190,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 252, 252, 252, 252 },
+	.irqs		= SCIx_IRQ_MUXED(252),
 };
 
 static struct platform_device scif3_device = {
-- 
1.7.9.1

