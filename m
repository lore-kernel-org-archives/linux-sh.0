From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 25 Jun 2013 10:55:45 +0000
Subject: Re: [PATCH 0/2] dma: shdma: two cosmetic fixes
Message-Id: <20130625104345.GM23141@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533034-23511-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1370533034-23511-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 06, 2013 at 05:37:12PM +0200, Guennadi Liakhovetski wrote:
> This is a re-send of two earlier submitted patches, now split in smaller 
> and logically grouped series.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> 
> Guennadi Liakhovetski (2):
>   DMA: shdma: (cosmetic) don't re-calculate a pointer
>   DMA: shdma: shdma_chan_filter() has to be in shdma-base.h
Both applied thanks

--
~Vinod
> 
>  drivers/dma/sh/shdma.c     |    2 +-
>  include/linux/sh_dma.h     |    2 --
>  include/linux/shdma-base.h |    1 +
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> -- 
> 1.7.2.5
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/

-- 
