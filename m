From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Jan 2012 07:27:49 +0000
Subject: [PATCH v4 2/6] sh: add a resource name for shdma
Message-Id: <4F0D39F5.90208@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v4:
  - use defination macros for IRQ resource

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    3 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    6 ++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   16 ++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |    2 ++
 6 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 278a0e5..8d9c809 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -147,18 +147,21 @@ static struct resource sh7722_dmae_resources[] = {
 	},
 	{
 		/* DMA error IRQ */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 78,
 		.end	= 78,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-3 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 48,
 		.end	= 51,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 4-5 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 76,
 		.end	= 77,
 		.flags	= IORESOURCE_IRQ,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index a37dd72..f657054 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -215,18 +215,21 @@ static struct resource sh7724_dmae0_resources[] = {
 	},
 	{
 		/* DMA error IRQ */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 78,
 		.end	= 78,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-3 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 48,
 		.end	= 51,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 4-5 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 76,
 		.end	= 77,
 		.flags	= IORESOURCE_IRQ,
@@ -249,18 +252,21 @@ static struct resource sh7724_dmae1_resources[] = {
 	},
 	{
 		/* DMA error IRQ */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 74,
 		.end	= 74,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-3 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 40,
 		.end	= 43,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 4-5 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 72,
 		.end	= 73,
 		.flags	= IORESOURCE_IRQ,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 0555929..cf2667a 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -465,6 +465,7 @@ static struct resource sh7757_dmae0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 34,
 		.end	= 34,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
@@ -487,54 +488,63 @@ static struct resource sh7757_dmae1_resources[] = {
 	},
 	{
 		/* DMA error */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 34,
 		.end	= 34,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
 	},
 	{
 		/* IRQ for channels 4 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 46,
 		.end	= 46,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
 	},
 	{
 		/* IRQ for channels 5 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 46,
 		.end	= 46,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
 	},
 	{
 		/* IRQ for channels 6 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 88,
 		.end	= 88,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
 	},
 	{
 		/* IRQ for channels 7 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 88,
 		.end	= 88,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
 	},
 	{
 		/* IRQ for channels 8 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 88,
 		.end	= 88,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
 	},
 	{
 		/* IRQ for channels 9 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 88,
 		.end	= 88,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
 	},
 	{
 		/* IRQ for channels 10 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 88,
 		.end	= 88,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
 	},
 	{
 		/* IRQ for channels 11 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 88,
 		.end	= 88,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
@@ -557,18 +567,21 @@ static struct resource sh7757_dmae2_resources[] = {
 	},
 	{
 		/* DMA error */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 323,
 		.end	= 323,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 12 to 16 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 272,
 		.end	= 276,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channel 17 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 279,
 		.end	= 279,
 		.flags	= IORESOURCE_IRQ,
@@ -591,18 +604,21 @@ static struct resource sh7757_dmae3_resources[] = {
 	},
 	{
 		/* DMA error */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 324,
 		.end	= 324,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 18 to 22 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 280,
 		.end	= 284,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channel 23 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= 288,
 		.end	= 288,
 		.flags	= IORESOURCE_IRQ,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index 3d4d207..cd8d1e9 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -322,6 +322,7 @@ static struct resource sh7780_dmae0_resources[] = {
 	},
 	{
 		/* Real DMA error IRQ is 38, and channel IRQs are 34-37, 44-45 */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 34,
 		.end	= 34,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
@@ -338,6 +339,7 @@ static struct resource sh7780_dmae1_resources[] = {
 	/* DMAC1 has no DMARS */
 	{
 		/* Real DMA error IRQ is 38, and channel IRQs are 46-47, 92-95 */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 46,
 		.end	= 46,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index b29e634..1cdb9ec 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -376,6 +376,7 @@ static struct resource sh7785_dmae0_resources[] = {
 	},
 	{
 		/* Real DMA error IRQ is 39, and channel IRQs are 33-38 */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 33,
 		.end	= 33,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
@@ -392,6 +393,7 @@ static struct resource sh7785_dmae1_resources[] = {
 	/* DMAC1 has no DMARS */
 	{
 		/* Real DMA error IRQ is 58, and channel IRQs are 52-57 */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= 52,
 		.end	= 52,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index dd5e709..6025d26 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -519,11 +519,13 @@ static struct resource dmac0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	}, {
 		/* DMA error IRQ */
+		.name	= SH_DMA_IRQ_ERROR,
 		.start	= evt2irq(0x5c0),
 		.end	= evt2irq(0x5c0),
 		.flags	= IORESOURCE_IRQ,
 	}, {
 		/* IRQ for channels 0-5 */
+		.name	= SH_DMA_IRQ_CHANNEL,
 		.start	= evt2irq(0x500),
 		.end	= evt2irq(0x5a0),
 		.flags	= IORESOURCE_IRQ,
-- 
1.7.1
