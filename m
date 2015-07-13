From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 13 Jul 2015 08:31:41 +0000
Subject: RE: [PATCH/RFC 3/3] dmaengine: sudmac: Add missing address widths and directions
Message-Id: <SG2PR06MB0919C330C8734058E4E6FFFBD89C0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436529553-30571-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436529553-30571-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert-san,

Thank you for the patch!

> Sent: Friday, July 10, 2015 8:59 PM
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Shimoda-san, are these correct?

Unfortunately, the buswitdh of SUDMAC is 1 only.

> It seems the SUDMAC (used in sh7757 only) was never wired up in
> mainline?

This is correct.
I'm not sure. But, I guess the SUDMAC is not used on new SoCs in the future.

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/dma/sh/sudmac.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
> index 31e681230e1894f2..7c4066503ce335f7 100644
> --- a/drivers/dma/sh/sudmac.c
> +++ b/drivers/dma/sh/sudmac.c
> @@ -331,6 +331,8 @@ static const struct shdma_ops sudmac_shdma_ops = {
> 
>  static int sudmac_probe(struct platform_device *pdev)
>  {
> +	const enum dma_slave_buswidth widths = DMA_SLAVE_BUSWIDTH_1_BYTE |
> +		DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	struct sudmac_pdata *pdata = dev_get_platdata(&pdev->dev);
>  	int err, i;
>  	struct sudmac_device *su_dev;
> @@ -361,6 +363,9 @@ static int sudmac_probe(struct platform_device *pdev)
>  		return PTR_ERR(su_dev->chan_reg);
> 
>  	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +	dma_dev->src_addr_widths = widths;
> +	dma_dev->dst_addr_widths = widths;
> +	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
>  	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> 
>  	su_dev->shdma_dev.ops = &sudmac_shdma_ops;
> --
> 1.9.1

