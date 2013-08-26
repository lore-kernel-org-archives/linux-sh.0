From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 26 Aug 2013 10:43:06 +0000
Subject: Re: [PATCH 0/3] DMA: shdma: several stylistic improvements and support for new SoCs
Message-Id: <Pine.LNX.4.64.1308261136430.1767@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307021738500.1965@axis700.grange>
 <20130825073525.GD8091@intel.com>
In-Reply-To: <20130825073525.GD8091@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Vinod,

Thanks for applying the patches!

On Sun, 25 Aug 2013, Vinod Koul wrote:

> On Tue, Jul 02, 2013 at 05:45:49PM +0200, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > The first two patches in this small series improve driver internals a bit 
> > by using preferred APIs, the 3rd patch adds support for new DMAC versions, 
> > present on AG5, APE6, H2.
> Applied, thanks
> 
> Although the patch 1 didnt apply for me :( I have manually remove a hunk, I dont
> which tree yoy genertaed this agaisnt!

I'm not sure why it didn't apply for you. AFAICS, you mean this hunk:

diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index c7950be..3083d62 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c

[snip]

@@ -909,17 +881,12 @@ static int sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
 	struct dma_device *dma_dev = &shdev->shdma_dev.dma_dev;
-	struct resource *res;
-	int errirq = platform_get_irq(pdev, 0);
 
 	dma_async_device_unregister(dma_dev);
 
 	/* Is a NOP if this controller isn't registered with of-dma */
 	of_dma_controller_free(pdev->dev.of_node);
 
-	if (errirq > 0)
-		free_irq(errirq, shdev);
-
 	spin_lock_irq(&sh_dmae_lock);
 	list_del_rcu(&shdev->node);
 	spin_unlock_irq(&sh_dmae_lock);

It didn't apply, because it is based on top of "DMA: shdma: also support 
single top-level DMAC DT nodes" which has been dropped for now in favour 
of keeping a multiplexer node compulsory for shdma for now, sorry. But 
just dropping it isn't right too. With managed error IRQ allocation 
calling free_irq() on clean up path is wrong. I'll post an incremental 
patch asap.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
