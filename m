From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 25 Nov 2010 07:29:57 +0000
Subject: Re: [PATCH 0/5 v2] MMC: DMA for SH MMCIF
Message-Id: <20101125072957.GF3270@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>

On Wed, Nov 24, 2010 at 11:05:08AM +0100, Guennadi Liakhovetski wrote:
> This patch series slightly cleans up the sh_mmcif MMC driver and adds a 
> DMA capability to it. One of the patches is not directly related, but is 
> required for a proper DMA functionality. V2 limits the number of request 
> segments, instead of raising the number of DMA descriptors in shdma.c. 
> This drops one patch from this series and modifies one further patch, the 
> rest remain unchanged.
> 
Looks better! All applied, thanks.
