From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 20 Nov 2013 21:09:28 +0000
Subject: Re: [PATCH 6/9] pci: rcar-gen2: enable clock
Message-Id: <528D2508.8090603@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384969086-8920-7-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1384969086-8920-7-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/20/2013 09:38 PM, Ulrich Hecht wrote:
> Makes the PCI host controllers come alive.
>

This is not needed if you use CCLKDEV_DEV_ID in patch 7/9

Thanks,
Val.

> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> ---
>   drivers/pci/host/pci-rcar-gen2.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index cbaa5c4..568ff8e 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -9,6 +9,7 @@
>    * published by the Free Software Foundation.
>    */
>
> +#include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/init.h>
>   #include <linux/interrupt.h>
> @@ -77,6 +78,7 @@
>   #define RCAR_PCI_NR_CONTROLLERS		3
>
>   struct rcar_pci_priv {
> +	struct clk *clk;
>   	void __iomem *reg;
>   	struct resource io_res;
>   	struct resource mem_res;
> @@ -169,6 +171,9 @@ static int __init rcar_pci_setup(int nr, struct pci_sys_data *sys)
>   	void __iomem *reg = priv->reg;
>   	u32 val;
>
> +	clk_prepare_enable(priv->clk);
> +	udelay(4);
> +
>   	val = ioread32(reg + RCAR_PCI_UNIT_REV_REG);
>   	pr_info("PCI: bus%u revision %x\n", sys->busnr, val);
>
> @@ -273,6 +278,7 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
>   	struct resource *cfg_res, *mem_res;
>   	struct rcar_pci_priv *priv;
>   	void __iomem *reg;
> +	struct clk *clk;
>
>   	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	reg = devm_ioremap_resource(&pdev->dev, cfg_res);
> @@ -288,6 +294,12 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
>   	if (!priv)
>   		return -ENOMEM;
>
> +	clk = devm_clk_get(&pdev->dev, "usbpci");
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "Can't get clock\n");
> +		return PTR_ERR(clk);
> +	}
> +
>   	priv->mem_res = *mem_res;
>   	/*
>   	 * The controller does not support/use port I/O,
> @@ -302,6 +314,8 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
>   	priv->irq = platform_get_irq(pdev, 0);
>   	priv->reg = reg;
>
> +	priv->clk = clk;
> +
>   	return rcar_pci_add_controller(priv);
>   }
>
>

