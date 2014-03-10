From: Joe Perches <joe@perches.com>
Date: Mon, 10 Mar 2014 01:47:02 +0000
Subject: Re: [PATCH v2][RESENT] dma: add R-Car Audio DMAC peri peri driver
Message-Id: <1394416022.30791.7.camel@joe-AO722>
List-Id: <linux-sh.vger.kernel.org>
References: <878uu6gle8.wl%kuninori.morimoto.gx@gmail.com>
	 <874n36supd.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874n36supd.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, dmaengine@vger.kernel.org

On Sun, 2014-03-09 at 18:34 -0700, Kuninori Morimoto wrote:
> Add support Audio DMAC peri peri driver
> for Renesas R-Car Gen2 SoC, using 'shdma-base'
> DMA driver framework.

Trivial notes:

> diff --git a/drivers/dma/sh/rcar-audmapp.c b/drivers/dma/sh/rcar-audmapp.c
[]
> +static int audmapp_chan_probe(struct platform_device *pdev,
> +			      struct audmapp_device *audev, int id)
> +{
[]
> +	auchan = devm_kzalloc(dev, sizeof(struct audmapp_chan), GFP_KERNEL);
> +	if (!auchan) {
> +		dev_err(dev, "No free memory for allocating dma channels!\n");

Unnecessary OOM as the alloc has a generic OOM
and a dump_stack()

[]
> +static int audmapp_probe(struct platform_device *pdev)
> +{
[]
> +	audev = devm_kzalloc(&pdev->dev, sizeof(struct audmapp_device),
> +			     GFP_KERNEL);
> +	if (!audev) {
> +		dev_err(&pdev->dev, "Not enough memory\n");

here too


