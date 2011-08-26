From: Simon Horman <horms@verge.net.au>
Date: Fri, 26 Aug 2011 09:48:01 +0000
Subject: Re: [PATCH v8 4/4] ARM: shmobile: ag5evm, ap4: Named SDHI IRQ sources
Message-Id: <20110826094801.GC5380@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1314235648-8959-1-git-send-email-horms@verge.net.au>
 <1314235648-8959-5-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108261042450.25272@axis700.grange>
 <20110826091407.GB5380@verge.net.au>
 <Pine.LNX.4.64.1108261121280.25272@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1108261121280.25272@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>

On Fri, Aug 26, 2011 at 11:22:00AM +0200, Guennadi Liakhovetski wrote:
> On Fri, 26 Aug 2011, Simon Horman wrote:
> 
> > On Fri, Aug 26, 2011 at 10:44:16AM +0200, Guennadi Liakhovetski wrote:
> > > On Thu, 25 Aug 2011, Simon Horman wrote:
> > > 
> > > > This allows specific (non-multiplexed) IRQ handlers to be used.
> > > 
> > > Could you also prepare a similar patch for g4evm and ap4evb? No need to 
> > > change this one, just prepare another one, please.
> > 
> > Sure, though I do not have access to those boards to test
> > (as far as I know).
> 
> Ok, I've got an ap4evb, so, I'll prepare that patch myself.

I can give you this to test:


From 18f06d15a1b08861b06727e9a429201b19e4323a Mon Sep 17 00:00:00 2001
From: Simon Horman <horms@verge.net.au>
Date: Fri, 26 Aug 2011 18:44:53 +0900
Subject: [PATCH] ARM: shmobile: ap4evb: Name SDHI IRQ sources

This allows specific (non-multiplexed) IRQ handlers to be used

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 9e0856b..ef5c7ca 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -339,14 +339,17 @@ static struct resource sdhi0_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
+		.name   = SH_MOBILE_SDHI_IRQ_CARD_DETECT,
 		.start	= evt2irq(0x0e00) /* SDHI0_SDHI0I0 */,
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name   = SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x0e20) /* SDHI0_SDHI0I1 */,
 		.flags	= IORESOURCE_IRQ,
 	},
 	[3] = {
+		.name   = SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x0e40) /* SDHI0_SDHI0I2 */,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -380,14 +383,17 @@ static struct resource sdhi1_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
+		SH_MOBILE_SDHI_IRQ_CARD_DETECT,
 		.start	= evt2irq(0x0e80), /* SDHI1_SDHI1I0 */
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name   = SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x0ea0), /* SDHI1_SDHI1I1 */
 		.flags	= IORESOURCE_IRQ,
 	},
 	[3] = {
+		.name   = SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x0ec0), /* SDHI1_SDHI1I2 */
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
1.7.5.4

