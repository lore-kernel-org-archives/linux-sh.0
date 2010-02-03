From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Feb 2010 00:16:20 +0000
Subject: Re: [PATCH 2/3 v3] sh: fix Transfer Size calculation in both DMA
Message-Id: <Pine.LNX.4.64.1002030110430.6324@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002011958290.4617@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002011958290.4617@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 2 Feb 2010, Dan Williams wrote:

> Guennadi Liakhovetski wrote:
> > Both the original arch/sh/drivers/dma/dma-sh.c and the new SH dmaengine
> > drivers
> > do not take into account bits 3:2 of the Transfer Size field in the CHCR
> > register, besides, bit-field defines set bit 2, but the mask only passes
> > bits
> > 1:0 through. TS_16BLK and TS_32BLK macros are bogus too. This patch fixes
> > all
> > these issues for sh7722 and sh7724, other CPUs stay unchanged and might need
> > to
> > be fixed too.
> 
> Is this fix targeted at 2.6.33/stable or the next merge window?

This patch is a part of the "DMA-slave for SH" patch series, and it is 
number 2 in it, and as such it will not apply without #1, which is clearly 
directed for the next window. Even though this patch fixes real bugs in an 
existing driver, this is no recent regression, so, probably, the world can 
survive a few more weeks with it. If we think these bugs are too important 
to be ignored, we'd have to back-port this patch to the current kernel...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
