From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Aug 2011 09:51:40 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 SCIF platform data update
Message-Id: <20110802095140.2794.58795.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add .regtype members to the sh73a0 SCIF platform data.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Tested on AG5EVM, fixes no-console-on-boot issue.

 arch/arm/mach-shmobile/setup-sh73a0.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2011-08-02 18:24:08.000000000 +0900
@@ -43,6 +43,7 @@ static struct plat_sci_port scif0_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { gic_spi(72), gic_spi(72),
 			    gic_spi(72), gic_spi(72) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif0_device = {
@@ -61,6 +62,7 @@ static struct plat_sci_port scif1_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { gic_spi(73), gic_spi(73),
 			    gic_spi(73), gic_spi(73) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif1_device = {
@@ -79,6 +81,7 @@ static struct plat_sci_port scif2_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { gic_spi(74), gic_spi(74),
 			    gic_spi(74), gic_spi(74) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif2_device = {
@@ -97,6 +100,7 @@ static struct plat_sci_port scif3_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { gic_spi(75), gic_spi(75),
 			    gic_spi(75), gic_spi(75) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif3_device = {
@@ -115,6 +119,7 @@ static struct plat_sci_port scif4_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { gic_spi(78), gic_spi(78),
 			    gic_spi(78), gic_spi(78) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif4_device = {
@@ -133,6 +138,7 @@ static struct plat_sci_port scif5_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { gic_spi(79), gic_spi(79),
 			    gic_spi(79), gic_spi(79) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif5_device = {
@@ -151,6 +157,7 @@ static struct plat_sci_port scif6_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { gic_spi(156), gic_spi(156),
 			    gic_spi(156), gic_spi(156) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif6_device = {
@@ -169,6 +176,7 @@ static struct plat_sci_port scif7_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { gic_spi(143), gic_spi(143),
 			    gic_spi(143), gic_spi(143) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif7_device = {
@@ -187,6 +195,7 @@ static struct plat_sci_port scif8_platfo
 	.type		= PORT_SCIFB,
 	.irqs		= { gic_spi(80), gic_spi(80),
 			    gic_spi(80), gic_spi(80) },
+	.regtype	= SCIx_SCIFB_REGTYPE,
 };
 
 static struct platform_device scif8_device = {
