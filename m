From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 14 Dec 2010 16:07:53 +0000
Subject: Re: [PATCH 0/3] handle unaligned buffers, when using TMIO-MMC with
Message-Id: <Pine.LNX.4.64.1012141704330.8500@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Hi Ian

It's been 3 weeks... Have you had a chance to look at these and previous 
my tmio patches? Any comments or are they ok to go?

Thanks
Guennadi

On Tue, 23 Nov 2010, Guennadi Liakhovetski wrote:

> While testing SDIO on SuperH with TMIO and DMA, it turned out, that 
> buffers, submitted to the driver can be arbitrarily aligned, and this is 
> not handled by the tmio driver. This patch series fixes this issue.
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
