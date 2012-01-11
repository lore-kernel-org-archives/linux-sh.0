From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Jan 2012 07:27:58 +0000
Subject: [PATCH v4 3/6] arm: mach-shmobile: add a resource name for shdma
Message-Id: <4F0D39FE.1090900@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v4:
  - use defination macros for IRQ resource

 arch/arm/mach-shmobile/setup-sh7372.c |    8 ++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 2380389..4f74e32 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -505,12 +505,14 @@ static struct resource sh7372_dmae0_resources[] = {
 	},
 	{
 		/* DMA error IRQ */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= evt2irq(0x20c0),
 		.end	= evt2irq(0x20c0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-5 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= evt2irq(0x2000),
 		.end	= evt2irq(0x20a0),
 		.flags	= IORESOURCE_IRQ,
@@ -533,12 +535,14 @@ static struct resource sh7372_dmae1_resources[] = {
 	},
 	{
 		/* DMA error IRQ */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= evt2irq(0x21c0),
 		.end	= evt2irq(0x21c0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-5 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= evt2irq(0x2100),
 		.end	= evt2irq(0x21a0),
 		.flags	= IORESOURCE_IRQ,
@@ -561,12 +565,14 @@ static struct resource sh7372_dmae2_resources[] = {
 	},
 	{
 		/* DMA error IRQ */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= evt2irq(0x22c0),
 		.end	= evt2irq(0x22c0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-5 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= evt2irq(0x2200),
 		.end	= evt2irq(0x22a0),
 		.flags	= IORESOURCE_IRQ,
@@ -670,6 +676,7 @@ static struct resource sh7372_usb_dmae0_resources[] = {
 	},
 	{
 		/* IRQ for channels */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= evt2irq(0x0a00),
 		.end	= evt2irq(0x0a00),
 		.flags	= IORESOURCE_IRQ,
@@ -731,6 +738,7 @@ static struct resource sh7372_usb_dmae1_resources[] = {
 	},
 	{
 		/* IRQ for channels */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= evt2irq(0x1d00),
 		.end	= evt2irq(0x1d00),
 		.flags	= IORESOURCE_IRQ,
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index e46821c..5d701ac 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -608,12 +608,14 @@ static struct resource sh73a0_dmae_resources[] = {
 	},
 	{
 		/* DMA error IRQ */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start  = gic_spi(129),
 		.end    = gic_spi(129),
 		.flags  = IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-19 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start  = gic_spi(109),
 		.end    = gic_spi(128),
 		.flags  = IORESOURCE_IRQ,
-- 
1.7.1
