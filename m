From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 03 Feb 2010 07:05:13 +0000
Subject: Re: [PATCH 2/3 v3] sh: fix Transfer Size calculation in both DMA
Message-Id: <4B692029.8020508@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002011958290.4617@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002011958290.4617@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Guennadi Liakhovetski wrote:
> Both the original arch/sh/drivers/dma/dma-sh.c and the new SH dmaengine drivers
> do not take into account bits 3:2 of the Transfer Size field in the CHCR
> register, besides, bit-field defines set bit 2, but the mask only passes bits
> 1:0 through. TS_16BLK and TS_32BLK macros are bogus too. This patch fixes all
> these issues for sh7722 and sh7724, other CPUs stay unchanged and might need to
> be fixed too.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v2 -> v3:
> 1. Also fix sh3, compile-tested for hp6xx_defconfig
> 2. Rename CHCR_TS01_* to CHCR_TS_LOW_* and CHCR_TS23_* to CHCR_TS_HIGH_*
> 
> This should be the last "fix compile-breakage" revision, sorry for a 
> patch-flood
> 
>  arch/sh/drivers/dma/dma-sh.c           |    5 +-

This bit collides with 9d56dd3b "sh: Mass ctrl_in/outX to 
__raw_read/writeX conversion." in Paul's tree.  I'm fine with these 
going through the sh tree with my acked-by modulo that minor nit with 
the dma_list_mutex comment in 3/3.

--
Dan

