From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 05 Aug 2014 17:08:17 +0000
Subject: Re: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC hardware descriptor list support)
Message-Id: <20140805165617.GB8181@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <18522523.T2zy7HfoJ2@avalon>
 <20140801170744.GD8181@intel.com>
 <1621896.RqTTnmY7rK@avalon>
In-Reply-To: <1621896.RqTTnmY7rK@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Mon, Aug 04, 2014 at 06:50:17PM +0200, Laurent Pinchart wrote:
 
> The question was why is there a dma_async_issue_pending() operation at all ? 
> Why can't dmaengine_submit() triggers the transfer start ? The only 
> explanation is a small comment in dmaengine.h that states
> 
>  * This allows drivers to push copies to HW in batches,
>  * reducing MMIO writes where possible.
> 
> I don't think that's applicable for DMA slave transfers. Is it still 
> applicable for anything else ?
why not?

If your hw supports sg-lists and say length of 8 and you prepare two
descriptors for lengths of 3 and 5. While in issue pending what prevents you
from submiiting them in one shot to hardware while still getting interrupt.

I know designware and intel-dma do support that. It is different point that
drivers don't

-- 
~Vinod
