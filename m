From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 12 Feb 2015 09:41:36 +0000
Subject: Re: [PATCH v2 0/6] Renesas R-Car DMAC fixes
Message-Id: <20150212092936.GK21387@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422576013-7846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422576013-7846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 30, 2015 at 02:00:07AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> Here are a couple of fixes for the rcar-dmac driver. They're based on the next
> branch of the dmaengine tree.
> 
> The first four patches fix driver bugs, while the last two work around two
> hardware issues. Patch 5 works around a documented errata, while patch 6
> handles a data corruption issue that was noticed during test but not yet
> confirmed to be a hardware bug by Renesas. When more information about the
> issue will be available a better fix could possibly be developed.
> 
> The patches are available at
> 
> 	git://linuxtv.org/pinchartl/fbdev.git dma/upstream
> 
> Vinod, is there still time for a v3.20 pull request ?
Since this is fixes I was trying to merge them before I send to Linus in next
few days, but this fails to apply for me :(

I have merged everything into my for-linus which will be sent to him. Or you can
send later and we can get this into fixes

-- 
~Vinod

> 
> Changes since v1:
> 
> - Don't needlessly replace spin_lock by spin_lock_irqsave in IRQ handlers
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> 
> Laurent Pinchart (6):
>   dmaengine: rcar-dmac: Fix uninitialized variable usage
>   dmaengine: rcar-dmac: Fix spinlock issues in interrupt
>   dmaengine: rcar-dmac: Fix oops due to unintialized list in error ISR
>   dmaengine: rcar-dmac: Allocate hardware descriptors with DMAC device
>   dmaengine: rcar-dmac: Work around descriptor mode IOMMU errata
>   dmaengine: rcar-dmac: Disable channel 0 when using IOMMU
> 
>  drivers/dma/sh/rcar-dmac.c | 137 ++++++++++++++++++++++++++-------------------
>  1 file changed, 80 insertions(+), 57 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
