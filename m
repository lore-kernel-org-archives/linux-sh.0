From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Aug 2011 09:46:39 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7367 SCIF platform data update
Message-Id: <20110802094639.2671.15167.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add .regtype members to the sh7367 SCIF platform data.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7367.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-sh7367.c
+++ work/arch/arm/mach-shmobile/setup-sh7367.c	2011-08-02 18:30:34.000000000 +0900
@@ -41,6 +41,7 @@ static struct plat_sci_port scif0_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc00), evt2irq(0xc00),
 			    evt2irq(0xc00), evt2irq(0xc00) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif0_device = {
@@ -60,6 +61,7 @@ static struct plat_sci_port scif1_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc20), evt2irq(0xc20),
 			    evt2irq(0xc20), evt2irq(0xc20) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif1_device = {
@@ -79,6 +81,7 @@ static struct plat_sci_port scif2_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc40), evt2irq(0xc40),
 			    evt2irq(0xc40), evt2irq(0xc40) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif2_device = {
@@ -98,6 +101,7 @@ static struct plat_sci_port scif3_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc60), evt2irq(0xc60),
 			    evt2irq(0xc60), evt2irq(0xc60) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif3_device = {
@@ -117,6 +121,7 @@ static struct plat_sci_port scif4_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xd20), evt2irq(0xd20),
 			    evt2irq(0xd20), evt2irq(0xd20) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif4_device = {
@@ -136,6 +141,7 @@ static struct plat_sci_port scif5_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xd40), evt2irq(0xd40),
 			    evt2irq(0xd40), evt2irq(0xd40) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif5_device = {
@@ -155,6 +161,7 @@ static struct plat_sci_port scif6_platfo
 	.type		= PORT_SCIFB,
 	.irqs		= { evt2irq(0xd60), evt2irq(0xd60),
 			    evt2irq(0xd60), evt2irq(0xd60) },
+	.regtype	= SCIx_SCIFB_REGTYPE,
 };
 
 static struct platform_device scif6_device = {
