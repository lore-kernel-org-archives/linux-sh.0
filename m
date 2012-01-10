From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Jan 2012 05:20:58 +0000
Subject: [PATCH v2 1/3] sh: add a resource name for shdma
Message-Id: <4F0BCABA.3070101@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - This patch is the first version, but I named v2
  - for a modification of shdma driver

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |    7 ++++---
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |    2 +-
 6 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 278a0e5..27af277 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -146,7 +146,7 @@ static struct resource sh7722_dmae_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		/* DMA error IRQ */
+		.name	= "error_irq",
 		.start	= 78,
 		.end	= 78,
 		.flags	= IORESOURCE_IRQ,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index a37dd72..8d8a551 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -214,7 +214,7 @@ static struct resource sh7724_dmae0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		/* DMA error IRQ */
+		.name	= "error_irq",
 		.start	= 78,
 		.end	= 78,
 		.flags	= IORESOURCE_IRQ,
@@ -248,7 +248,7 @@ static struct resource sh7724_dmae1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		/* DMA error IRQ */
+		.name	= "error_irq",
 		.start	= 74,
 		.end	= 74,
 		.flags	= IORESOURCE_IRQ,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 0555929..a7b2da6 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -465,6 +465,7 @@ static struct resource sh7757_dmae0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
+		.name	= "error_irq",
 		.start	= 34,
 		.end	= 34,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
@@ -486,7 +487,7 @@ static struct resource sh7757_dmae1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		/* DMA error */
+		.name	= "error_irq",
 		.start	= 34,
 		.end	= 34,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
@@ -556,7 +557,7 @@ static struct resource sh7757_dmae2_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		/* DMA error */
+		.name	= "error_irq",
 		.start	= 323,
 		.end	= 323,
 		.flags	= IORESOURCE_IRQ,
@@ -590,7 +591,7 @@ static struct resource sh7757_dmae3_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		/* DMA error */
+		.name	= "error_irq",
 		.start	= 324,
 		.end	= 324,
 		.flags	= IORESOURCE_IRQ,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index 3d4d207..d431b00 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -322,6 +322,7 @@ static struct resource sh7780_dmae0_resources[] = {
 	},
 	{
 		/* Real DMA error IRQ is 38, and channel IRQs are 34-37, 44-45 */
+		.name	= "error_irq",
 		.start	= 34,
 		.end	= 34,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
@@ -338,6 +339,7 @@ static struct resource sh7780_dmae1_resources[] = {
 	/* DMAC1 has no DMARS */
 	{
 		/* Real DMA error IRQ is 38, and channel IRQs are 46-47, 92-95 */
+		.name	= "error_irq",
 		.start	= 46,
 		.end	= 46,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index b29e634..81588ef 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -376,6 +376,7 @@ static struct resource sh7785_dmae0_resources[] = {
 	},
 	{
 		/* Real DMA error IRQ is 39, and channel IRQs are 33-38 */
+		.name	= "error_irq",
 		.start	= 33,
 		.end	= 33,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
@@ -392,6 +393,7 @@ static struct resource sh7785_dmae1_resources[] = {
 	/* DMAC1 has no DMARS */
 	{
 		/* Real DMA error IRQ is 58, and channel IRQs are 52-57 */
+		.name	= "error_irq",
 		.start	= 52,
 		.end	= 52,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index dd5e709..599022d 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -518,7 +518,7 @@ static struct resource dmac0_resources[] = {
 		.end	= 0xfe00900b,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		/* DMA error IRQ */
+		.name	= "error_irq",
 		.start	= evt2irq(0x5c0),
 		.end	= evt2irq(0x5c0),
 		.flags	= IORESOURCE_IRQ,
-- 
1.7.1
