From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Mar 2013 05:31:20 +0000
Subject: Re: [PATCH v3] ARM: shmobile: add gic_iid macro for ICCIAR / interrupt ID
Message-Id: <20130305053118.GE22698@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjysenqb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjysenqb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 01, 2013 at 06:41:56PM +0900, Simon Horman wrote:
> On Mon, Feb 25, 2013 at 01:39:44AM -0800, Kuninori Morimoto wrote:
> > R-Car H1 datasheet GIC number is indicating
> > GIC ICCIAR / interrupt ID number, not SPI number,
> > but current marzen board code is using gic_spi() with
> > un-understandable calculation.
> > 
> > This patch adds new gic_iid() macro which means
> > ICCIAR / interrupt ID, and used the number
> > currently written on datasheet.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Thanks, applied to the boards3 branch of the renesas tree
> and thus included in its next branch and queued up for v3.10.
> 
> > ---
> > v2 -> v3
> > 
> >  - add simple explain on gic_iid()
> > 
> >  arch/arm/mach-shmobile/board-marzen.c      |   12 ++++++------
> >  arch/arm/mach-shmobile/include/mach/irqs.h |    1 +
> >  2 files changed, 7 insertions(+), 6 deletions(-)

I have split this patch into two to allow soc patches to
use this macro without depending on a boards branch (currently
boards3 depends on soc3 but not the other way around).

These shenanigans is courtesy of arm-soc's requirement for separate
board and soc branches.

The patch which modifies arch/arm/mach-shmobile/include/mach/irqs.h
retains the changelog above.

The patch which modifies arch/arm/mach-shmobile/board-marzen.c
has a new subject as shown below.

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

ARM: shmobile: marzen: Use gic_iid macro for ICCIAR / interrupt ID

ARM: shmobile: add gic_iid macro for ICCIAR / interrupt ID
enabled to use gic_iid macro.
This patch exchange current GIC interrupt setting
from gic_spi() to gic_iid()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[ horms+renesas@verge.net.au: Split irq.h portion into a separate patch ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index fec49eb..9c602f6 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -67,7 +67,7 @@ static struct resource smsc911x_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= gic_spi(28), /* IRQ 1 */
+		.start		= gic_iid(0x3c), /* IRQ 1 */
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -97,7 +97,7 @@ static struct resource sdhi0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(104),
+		.start	= gic_iid(0x88),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -215,7 +215,7 @@ static struct resource ehci0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(44),
+		.start	= gic_iid(0x4c),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -239,7 +239,7 @@ static struct resource ehci1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(45),
+		.start	= gic_iid(0x4d),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -269,7 +269,7 @@ static struct resource ohci0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(44),
+		.start	= gic_iid(0x4c),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -293,7 +293,7 @@ static struct resource ohci1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(45),
+		.start	= gic_iid(0x4d),
 		.flags	= IORESOURCE_IRQ,
 	},
 };

