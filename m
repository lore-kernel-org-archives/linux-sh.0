From: Simon Horman <horms@verge.net.au>
Date: Thu, 08 Aug 2013 00:24:19 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: r8a7779: Add DU support
Message-Id: <20130808002417.GA7540@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 08, 2013 at 02:42:55AM +0400, Sergei Shtylyov wrote:
> On 08/08/2013 02:19 AM, Laurent Pinchart wrote:
> 
> >>>Add a function to register the DU device with board-specific platform
> >>>data. The DU device is named rcar-du-r8a7779, fix the clock entry
> >>>accordingly.
> 
> >>>Signed-off-by: Laurent Pinchart
> >>><laurent.pinchart+renesas@ideasonboard.com>
> 
> >>[...]
> 
> >>>diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h
> >>>b/arch/arm/mach-shmobile/include/mach/r8a7779.h index f08d6ec..83c47a2
> >>>100644
> >>>--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
> >>>+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
> >>>@@ -6,6 +6,7 @@
> >>>   #include <linux/sh_eth.h>
> >>>
> >>>   struct platform_device;
> >>>+struct rcar_du_platform_data;
> >>>
> >>>   struct r8a7779_pm_ch {
> >>>   	unsigned long chan_offs;
> >>>@@ -31,6 +32,7 @@ extern void r8a7779_earlytimer_init(void);
> >>>   extern void r8a7779_add_early_devices(void);
> >>>   extern void r8a7779_add_standard_devices(void);
> >>>   extern void r8a7779_add_standard_devices_dt(void);
> >>>+extern void r8a7779_add_du_device(struct rcar_du_platform_data *pdata);
> >>>   extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
> >>>   extern void r8a7779_init_late(void);
> >>>   extern void r8a7779_clock_init(void);
> >>>diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c
> >>>b/arch/arm/mach-shmobile/setup-r8a7779.c index 6a99333..c587fc9 100644
> >>>--- a/arch/arm/mach-shmobile/setup-r8a7779.c
> >>>+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> >>>@@ -27,6 +27,7 @@
> >>>   #include <linux/of_platform.h>
> >>>   #include <linux/platform_data/gpio-rcar.h>
> >>>   #include <linux/platform_data/irq-renesas-intc-irqpin.h>
> >>>+#include <linux/platform_data/rcar-du.h>
> >>
> >>Why not just include it in the r8a7779.h?
> 
> >Because not all users of r8a7779.h needs the rcar-du.h header. Including the
> >header only where it is needed speeds up compilation.
> 
>    I'm afraid the most important users (setup-* and board-*) need
> it. Anyway, Simon/Magnus will most probably ask you to remove the
> header change and rework the patch according to their taste.

At the risk of being inconsistent with feedback for previous patches:
I have no strong opinion on this at this time. Though personally I would
have just added the #include in r8a7779.h.
