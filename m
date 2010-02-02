From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 02 Feb 2010 23:59:15 +0000
Subject: Re: [PATCH 2/3 v3] sh: fix Transfer Size calculation in both DMA
Message-Id: <4B68BC53.9020700@intel.com>
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

Is this fix targeted at 2.6.33/stable or the next merge window?

