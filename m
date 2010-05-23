From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sun, 23 May 2010 16:39:17 +0000
Subject: [PATCH 3/4] ARM: mach-shmobile: SH7372 has 6 SCIFA and 1 SCIFB ports
Message-Id: <Pine.LNX.4.64.1005231833300.3571@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005231820190.3571@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005231820190.3571@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

The current SH7372 setup code registers 7 SCIF ports, which is wrong.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

no change

 arch/arm/mach-shmobile/setup-sh7372.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 0a834d3..cc040a8 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -256,7 +256,7 @@ static struct platform_device dma2_device = {
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs		= { 80, 80, 80, 80 },
 };
 
@@ -271,7 +271,7 @@ static struct platform_device scif0_device = {
 static struct plat_sci_port scif1_platform_data = {
 	.mapbase	= 0xe6c50000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs           = { 81, 81, 81, 81 },
 };
 
@@ -286,7 +286,7 @@ static struct platform_device scif1_device = {
 static struct plat_sci_port scif2_platform_data = {
 	.mapbase	= 0xe6c60000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs           = { 82, 82, 82, 82 },
 };
 
@@ -301,7 +301,7 @@ static struct platform_device scif2_device = {
 static struct plat_sci_port scif3_platform_data = {
 	.mapbase	= 0xe6c70000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs           = { 83, 83, 83, 83 },
 };
 
@@ -316,7 +316,7 @@ static struct platform_device scif3_device = {
 static struct plat_sci_port scif4_platform_data = {
 	.mapbase	= 0xe6c80000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs           = { 89, 89, 89, 89 },
 };
 
@@ -331,7 +331,7 @@ static struct platform_device scif4_device = {
 static struct plat_sci_port scif5_platform_data = {
 	.mapbase	= 0xe6cb0000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs           = { 90, 90, 90, 90 },
 };
 
@@ -346,7 +346,7 @@ static struct platform_device scif5_device = {
 static struct plat_sci_port scif6_platform_data = {
 	.mapbase	= 0xe6c30000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFB,
 	.irqs           = { 91, 91, 91, 91 },
 };
 
-- 
1.6.2.4

