From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 09 Dec 2013 23:25:54 +0000
Subject: Re: [PATCH] pci: pci-rcar-gen2: Add runtime PM support
Message-Id: <20131209232554.GC4699@google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386174815-4647-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386174815-4647-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Dec 04, 2013 at 08:33:35PM +0400, Valentine Barshak wrote:
> If runtime PM is enabled in the kernel config, the PCI clocks
> are not forced on at start-up, and thus, are never enabled.
> Use pm_runtime_get_sync to enable the clocks.
> 
> While at it, use dev_info instead of pr_info since now we have
> the device pointer available in the PCI setup callback.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Applied to my pci/host-rcar branch for v3.14, thanks!

Bjorn

> ---
>  drivers/pci/host/pci-rcar-gen2.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index cbaa5c4..f74228f 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  
>  /* AHB-PCI Bridge PCI communication registers */
> @@ -77,6 +78,7 @@
>  #define RCAR_PCI_NR_CONTROLLERS		3
>  
>  struct rcar_pci_priv {
> +	struct device *dev;
>  	void __iomem *reg;
>  	struct resource io_res;
>  	struct resource mem_res;
> @@ -169,8 +171,11 @@ static int __init rcar_pci_setup(int nr, struct pci_sys_data *sys)
>  	void __iomem *reg = priv->reg;
>  	u32 val;
>  
> +	pm_runtime_enable(priv->dev);
> +	pm_runtime_get_sync(priv->dev);
> +
>  	val = ioread32(reg + RCAR_PCI_UNIT_REV_REG);
> -	pr_info("PCI: bus%u revision %x\n", sys->busnr, val);
> +	dev_info(priv->dev, "PCI: bus%u revision %x\n", sys->busnr, val);
>  
>  	/* Disable Direct Power Down State and assert reset */
>  	val = ioread32(reg + RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
> @@ -301,6 +306,7 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
>  
>  	priv->irq = platform_get_irq(pdev, 0);
>  	priv->reg = reg;
> +	priv->dev = &pdev->dev;
>  
>  	return rcar_pci_add_controller(priv);
>  }
> -- 
> 1.8.3.1
> 
