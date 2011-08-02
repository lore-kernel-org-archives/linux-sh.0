From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Aug 2011 09:48:01 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7377 SCIF platform data update
Message-Id: <20110802094801.2677.3249.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add .regtype members to the sh7377 SCIF platform data.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7377.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-sh7377.c
+++ work/arch/arm/mach-shmobile/setup-sh7377.c	2011-08-02 18:35:11.000000000 +0900
@@ -42,6 +42,7 @@ static struct plat_sci_port scif0_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc00), evt2irq(0xc00),
 			    evt2irq(0xc00), evt2irq(0xc00) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif0_device = {
@@ -61,6 +62,7 @@ static struct plat_sci_port scif1_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc20), evt2irq(0xc20),
 			    evt2irq(0xc20), evt2irq(0xc20) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif1_device = {
@@ -80,6 +82,7 @@ static struct plat_sci_port scif2_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc40), evt2irq(0xc40),
 			    evt2irq(0xc40), evt2irq(0xc40) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif2_device = {
@@ -99,6 +102,7 @@ static struct plat_sci_port scif3_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc60), evt2irq(0xc60),
 			    evt2irq(0xc60), evt2irq(0xc60) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif3_device = {
@@ -118,6 +122,7 @@ static struct plat_sci_port scif4_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xd20), evt2irq(0xd20),
 			    evt2irq(0xd20), evt2irq(0xd20) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif4_device = {
@@ -137,6 +142,7 @@ static struct plat_sci_port scif5_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xd40), evt2irq(0xd40),
 			    evt2irq(0xd40), evt2irq(0xd40) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif5_device = {
@@ -156,6 +162,7 @@ static struct plat_sci_port scif6_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { intcs_evt2irq(0x1a80), intcs_evt2irq(0x1a80),
 			    intcs_evt2irq(0x1a80), intcs_evt2irq(0x1a80) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif6_device = {
@@ -175,6 +182,7 @@ static struct plat_sci_port scif7_platfo
 	.type		= PORT_SCIFB,
 	.irqs		= { evt2irq(0xd60), evt2irq(0xd60),
 			    evt2irq(0xd60), evt2irq(0xd60) },
+	.regtype	= SCIx_SCIFB_REGTYPE,
 };
 
 static struct platform_device scif7_device = {
