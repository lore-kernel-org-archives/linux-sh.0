From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 13 Apr 2012 03:14:02 +0000
Subject: [PATCH 3/4] sh: sh3: Change the specification method of IRQ to SCIx_IRQ_MUXED
Message-Id: <1334286843-3297-3-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Some SCIF devices specify the same IRQ. We can use SCIx_IRQ_MUXED for this.
And change use to evt2irq(), without specifying the value of IRQ directly.
This is correction to the SH3 series.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh3/setup-sh7705.c |    4 ++--
 arch/sh/kernel/cpu/sh3/setup-sh770x.c |    6 +++---
 arch/sh/kernel/cpu/sh3/setup-sh7710.c |    4 ++--
 arch/sh/kernel/cpu/sh3/setup-sh7720.c |    4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
index 2309618..97416a5 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -75,7 +75,7 @@ static struct plat_sci_port scif0_platform_data = {
 			  SCSCR_RE  | SCSCR_CKE1 | SCSCR_CKE0,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIF,
-	.irqs		= { 56, 56, 56 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x900)),
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
 };
@@ -94,7 +94,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_TIE | SCSCR_RIE | SCSCR_TE | SCSCR_RE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIF,
-	.irqs		= { 52, 52, 52 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x880)),
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 3f3d5fe..50f95a3 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -114,7 +114,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_TE | SCSCR_RE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCI,
-	.irqs		= { 23, 23, 23, 0 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x4E0)),
 	.ops		= &sh770x_sci_port_ops,
 	.regshift	= 1,
 };
@@ -135,7 +135,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_TE | SCSCR_RE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 56, 56, 56, 56 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x900)),
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH3_SCIF_REGTYPE,
 };
@@ -157,7 +157,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_TE | SCSCR_RE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_IRDA,
-	.irqs		= { 52, 52, 52, 52 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x880)),
 	.ops		= &sh770x_sci_port_ops,
 	.regshift	= 1,
 };
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7710.c b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
index 78f6b01..7ef2487 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
@@ -103,7 +103,7 @@ static struct plat_sci_port scif0_platform_data = {
 			  SCSCR_CKE1 | SCSCR_CKE0,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 52, 52, 52, 52 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x880)),
 };
 
 static struct platform_device scif0_device = {
@@ -121,7 +121,7 @@ static struct plat_sci_port scif1_platform_data = {
 			  SCSCR_CKE1 | SCSCR_CKE0,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs           = { 56, 56, 56, 56 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x900)),
 };
 
 static struct platform_device scif1_device = {
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7720.c b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
index 9492034..b255748 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
@@ -55,7 +55,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIF,
-	.irqs		= { 80, 80, 80, 80 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xC00)),
 	.ops		= &sh7720_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
 };
@@ -74,7 +74,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIF,
-	.irqs           = { 81, 81, 81, 81 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xC20)),
 	.ops		= &sh7720_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
 };
-- 
1.7.9.1

