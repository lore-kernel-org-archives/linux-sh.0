From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jan 2012 14:34:21 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: specify CHCLR registers on SH7372
Message-Id: <Pine.LNX.4.64.1201041533370.30506@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201041528570.30506@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201041528570.30506@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Magnus Damm <magnus.damm@gmail.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/setup-sh7372.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 2380389..83dc940 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -445,31 +445,39 @@ static const struct sh_dmae_slave_config sh7372_dmae_slaves[] = {
 	},
 };
 
+#define SH7372_CHCLR 0x220
+
 static const struct sh_dmae_channel sh7372_dmae_channels[] = {
 	{
 		.offset = 0,
 		.dmars = 0,
 		.dmars_bit = 0,
+		.chclr_offset = SH7372_CHCLR + 0,
 	}, {
 		.offset = 0x10,
 		.dmars = 0,
 		.dmars_bit = 8,
+		.chclr_offset = SH7372_CHCLR + 0x10,
 	}, {
 		.offset = 0x20,
 		.dmars = 4,
 		.dmars_bit = 0,
+		.chclr_offset = SH7372_CHCLR + 0x20,
 	}, {
 		.offset = 0x30,
 		.dmars = 4,
 		.dmars_bit = 8,
+		.chclr_offset = SH7372_CHCLR + 0x30,
 	}, {
 		.offset = 0x50,
 		.dmars = 8,
 		.dmars_bit = 0,
+		.chclr_offset = SH7372_CHCLR + 0x50,
 	}, {
 		.offset = 0x60,
 		.dmars = 8,
 		.dmars_bit = 8,
+		.chclr_offset = SH7372_CHCLR + 0x60,
 	}
 };
 
@@ -487,6 +495,7 @@ static struct sh_dmae_pdata dma_platform_data = {
 	.ts_shift	= ts_shift,
 	.ts_shift_num	= ARRAY_SIZE(ts_shift),
 	.dmaor_init	= DMAOR_DME,
+	.chclr_present	= 1,
 };
 
 /* Resource order important! */
@@ -494,7 +503,7 @@ static struct resource sh7372_dmae0_resources[] = {
 	{
 		/* Channel registers and DMAOR */
 		.start	= 0xfe008020,
-		.end	= 0xfe00808f,
+		.end	= 0xfe00828f,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
@@ -522,7 +531,7 @@ static struct resource sh7372_dmae1_resources[] = {
 	{
 		/* Channel registers and DMAOR */
 		.start	= 0xfe018020,
-		.end	= 0xfe01808f,
+		.end	= 0xfe01828f,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
@@ -550,7 +559,7 @@ static struct resource sh7372_dmae2_resources[] = {
 	{
 		/* Channel registers and DMAOR */
 		.start	= 0xfe028020,
-		.end	= 0xfe02808f,
+		.end	= 0xfe02828f,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-- 
1.7.2.5

