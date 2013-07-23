From: Simon Horman <horms@verge.net.au>
Date: Tue, 23 Jul 2013 01:29:47 +0000
Subject: Re: [PATCH v3 07/15] DMA: shdma: add sh73a0 DMAC data to the device ID table
Message-Id: <20130723012946.GF16481@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1374251374-30186-1-git-send-email-g.liakhovetski@gmx.de>
 <1374251374-30186-8-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1307201326110.3716@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307201326110.3716@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Sat, Jul 20, 2013 at 01:28:48PM +0200, Guennadi Liakhovetski wrote:
> This configuration data will be re-used, when DMAC DT support is added to
> sh73a0, DMAC platform data in setup-sh73a0.c will be removed.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> v3: also add an of_device_id entry for sh73a0.

Please don't post an update for just one patch in a series.
Please repost the entire series, even if only one patch is changed.

> 
>  drivers/dma/sh/Kconfig        |    4 +
>  drivers/dma/sh/Makefile       |    1 +
>  drivers/dma/sh/shdma-sh73a0.c |  181 +++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sh/shdma.h        |    7 ++
>  drivers/dma/sh/shdmac.c       |    2 +
>  5 files changed, 195 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/dma/sh/shdma-sh73a0.c
