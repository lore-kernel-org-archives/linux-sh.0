From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 May 2014 16:51:55 +0000
Subject: Re: [PATCH v4 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <4177905.uz7GAq4rkR@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1685365.IsdPNfeJeA"
List-Id: <linux-sh.vger.kernel.org>
References: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart1685365.IsdPNfeJeA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Simon,

On Thursday 24 April 2014 09:21:40 Simon Horman wrote:
> On Wed, Apr 23, 2014 at 01:09:22PM +0200, Laurent Pinchart wrote:
> > On Wednesday 23 April 2014 11:06:32 Simon Horman wrote:
> > > On Tue, Apr 22, 2014 at 12:50:41PM +0200, Laurent Pinchart wrote:
> > > > Hello,
> > > > 
> > > > This patch set switches all Renesas platforms to the new style CMT,
> > > > MTU2 and TMU device platform data. All patches have been previously
> > > > posted as part of the "[PATCH v3 00/52] Renesas CMT and TMU cleanups"
> > > > and "[PATCH 00/22] SH MTU2 DT support" patch series.
> > > > 
> > > > This new version just rebases the patches on top of the clockevents
> > > > branch that contains the latest driver cleanups, found at
> > > > 
> > > > 	git://git.linaro.org/people/daniel.lezcano/linux.git
> > > > 	clockevents/cmt-mtu2-tmu-cleanups>
> > > > 
> > > > Simon, could you please pull that branch in your tree and apply this
> > > > series on top of it ? Furthermore, as I have other pending patches for
> > > > the driver side, could you do so in a separate topic branch that
> > > > Daniel could merge into his tree ?
> > > 
> > > With this series applied Bock-W fails to boot both using Legacy-C and
> > > DT-reference, and mackerel fails to boot (using Legacy-C).
> > > In each case the boot hangs and I gave up after waiting two minutes.
> > > 
> > > I have supplied boot logs below.
> > > I have used the defconfig for each board, tweaking
> > > the result to allow booting DT-reference as appropriate.
> > 
> > I've debugged the issue on Mackerel, I had "just" used evt2irq instead of
> > intcs_evt2irq for the TMU resources :-/ I'll resubmit this series with the
> > problem fixed.
> > 
> > I've also found another issue in the sh_cmt driver that would break
> > bisection and have submitted a fix for that separately.
> > 
> > I don't have access to a Bock-W board, could you assist me debugging the
> > issue there ? In particular I'd like to first make sure that the patch
> > that breaks the kernel is "ARM: shmobile: r8a7778: Switch to new style
> > TMU device". If that's correct I'll ask you to please test a debugging
> > patch. Another option would be to give me remote access to a Bock-W board
> > if that's possible.
>
> Of course I am happy to help.
> 
> I reverted "ARM: shmobile: r8a7778: Switch to new style TMU device" and
> the Bock-W once again boots, both using legacy-C and DT-reference.
> 
> With regards to debugging, I think that if this becomes a drawn-out process
> then it will be easiest for both of us if I give you remote-access. But
> as that requires some re-arrangement of things on my side perhaps it would
> be easiest if you sent me a debug patch for now.

I've attached a debugging patch to this e-mail. Could you please boot the 
BockW board with that patch applied before (working) and after (broken) 
applying "ARM: shmobile: r8a7778: Switch to new style TMU device" and provide 
me with the two boot logs ?

-- 
Regards,

Laurent Pinchart

--nextPart1685365.IsdPNfeJeA
Content-Disposition: attachment; filename="tmu-debug.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="tmu-debug.patch"

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 4ba2c0f..7a09c22 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/sh_clk.h>
 #include <linux/sh_timer.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -92,10 +93,12 @@ static inline unsigned long sh_tmu_read(struct sh_tmu_channel *ch, int reg_nr)
 	if (reg_nr == TSTR) {
 		switch (ch->tmu->model) {
 		case SH_TMU_LEGACY:
+			dev_err(&ch->tmu->pdev->dev, "ch%u: reading TSTR @%p\n", ch->index, ch->tmu->mapbase);
 			return ioread8(ch->tmu->mapbase);
 		case SH_TMU_SH3:
 			return ioread8(ch->tmu->mapbase + 2);
 		case SH_TMU:
+			dev_err(&ch->tmu->pdev->dev, "ch%u: reading TSTR @%p\n", ch->index, ch->tmu->mapbase + 4);
 			return ioread8(ch->tmu->mapbase + 4);
 		}
 	}
@@ -116,10 +119,12 @@ static inline void sh_tmu_write(struct sh_tmu_channel *ch, int reg_nr,
 	if (reg_nr == TSTR) {
 		switch (ch->tmu->model) {
 		case SH_TMU_LEGACY:
+			dev_err(&ch->tmu->pdev->dev, "ch%u: reading TSTR @%p\n", ch->index, ch->tmu->mapbase);
 			return iowrite8(value, ch->tmu->mapbase);
 		case SH_TMU_SH3:
 			return iowrite8(value, ch->tmu->mapbase + 2);
 		case SH_TMU:
+			dev_err(&ch->tmu->pdev->dev, "ch%u: writing TSTR @%p\n", ch->index, ch->tmu->mapbase + 4);
 			return iowrite8(value, ch->tmu->mapbase + 4);
 		}
 	}
@@ -170,6 +175,7 @@ static int __sh_tmu_enable(struct sh_tmu_channel *ch)
 
 	/* configure channel to parent clock / 4, irq off */
 	ch->rate = clk_get_rate(ch->tmu->clk) / 4;
+	dev_err(&ch->tmu->pdev->dev, "ch%u: clock rate is %lu\n", ch->index, ch->rate);
 	sh_tmu_write(ch, TCR, TCR_TPSC_CLK4);
 
 	/* enable channel */
@@ -443,6 +449,8 @@ static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
 
 	clockevents_config_and_register(ced, 1, 0x300, 0xffffffff);
 
+	dev_info(&ch->tmu->pdev->dev, "ch%u: requesting IRQ %u for clock event device\n",
+		 ch->index, ch->irq);
 	ret = request_irq(ch->irq, sh_tmu_interrupt,
 			  IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
 			  dev_name(&ch->tmu->pdev->dev), ch);
@@ -498,6 +506,9 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch, unsigned int index,
 			ch->base = tmu->mapbase + 8 + ch->index * 12;
 	}
 
+	dev_info(&tmu->pdev->dev, "ch%u: base %p\n",
+		 ch->index, ch->base);
+
 	ch->irq = platform_get_irq(tmu->pdev, ch->index);
 	if (ch->irq < 0) {
 		dev_err(&tmu->pdev->dev, "ch%u: failed to get irq\n",
@@ -526,6 +537,9 @@ static int sh_tmu_map_memory(struct sh_tmu_device *tmu)
 	if (tmu->mapbase == NULL)
 		return -ENXIO;
 
+	dev_info(&tmu->pdev->dev, "phys base 0x%08x virt base %p size %u\n",
+		res->start, tmu->mapbase, resource_size(res));
+
 	/*
 	 * In legacy platform device configuration (with one device per channel)
 	 * the resource points to the channel base address.
@@ -571,6 +585,7 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 		return PTR_ERR(tmu->clk);
 	}
 
+	dev_err(&tmu->pdev->dev, "MSTP clock %u @%p\n", tmu->clk->enable_bit, tmu->clk->enable_reg);
 	ret = clk_prepare(tmu->clk);
 	if (ret < 0)
 		goto err_clk_put;

--nextPart1685365.IsdPNfeJeA--

