From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 27 Apr 2010 10:38:07 +0000
Subject: Re: [PATCH 0/8] add DMA support to tmio_mmc, using dmaengine API,
Message-Id: <Pine.LNX.4.64.1004271233010.4879@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

Hi Ian

On Wed, 21 Apr 2010, Guennadi Liakhovetski wrote:

> This patch series adds DMA support to the tmio_mmc SD/MMC host driver, 
> using the dmaengine API. So far this is only used on SuperH platforms, 
> will also be supported on ARM shmobile boards, both use the sh_mobile_sdhi 
> MFD driver. Other TMIO MFD implementations are unaffected. The patch 
> transparently falls back to PIO if no DMA is configured by the MFD driver, 
> or if DMA initialisation or execution fail.

Do you think you'd be able to comment on this patch-series? Maybe you 
could give your initial opinion about the way I chose to integrate DMA 
into tmio_mmc.c: do you agree with it? Or would you prefer it to depend on 
a config-option? Maybe put it in a separate tmio_dma.c file? I'd then 
submit a v2 of the series, which you could then review in detail.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
