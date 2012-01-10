From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Jan 2012 05:21:31 +0000
Subject: [PATCH] arm: mach-shmobile: add a resource name for shdma
Message-Id: <4F0BCADB.8010709@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch depends on the following patch:
   - dmaengine: shdma: modify the DMAC Address Error registration

 arch/arm/mach-shmobile/setup-sh7372.c |    6 +++---
 arch/arm/mach-shmobile/setup-sh73a0.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 2380389..dad4d09 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -504,7 +504,7 @@ static struct resource sh7372_dmae0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		/* DMA error IRQ */
+		.name	= "error_irq",
 		.start	= evt2irq(0x20c0),
 		.end	= evt2irq(0x20c0),
 		.flags	= IORESOURCE_IRQ,
@@ -532,7 +532,7 @@ static struct resource sh7372_dmae1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		/* DMA error IRQ */
+		.name	= "error_irq",
 		.start	= evt2irq(0x21c0),
 		.end	= evt2irq(0x21c0),
 		.flags	= IORESOURCE_IRQ,
@@ -560,7 +560,7 @@ static struct resource sh7372_dmae2_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		/* DMA error IRQ */
+		.name	= "error_irq",
 		.start	= evt2irq(0x22c0),
 		.end	= evt2irq(0x22c0),
 		.flags	= IORESOURCE_IRQ,
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index e46821c..20e71e5 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -607,7 +607,7 @@ static struct resource sh73a0_dmae_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	{
-		/* DMA error IRQ */
+		.name	= "error_irq",
 		.start  = gic_spi(129),
 		.end    = gic_spi(129),
 		.flags  = IORESOURCE_IRQ,
-- 
1.7.1
