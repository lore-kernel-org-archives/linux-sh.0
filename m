From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 01 Mar 2012 03:00:53 +0000
Subject: Re: [PATCH 1/3] usb: ehci-sh: Add PHY init function with platform data
Message-Id: <4F4EE665.6010707@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330569162-9485-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1330569162-9485-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

2012/03/01 11:32, Nobuhiro Iwamatsu wrote:
> In devices using ehci-sh, initialization of the PHY may be necessary.
> This adds platform data to ehci-sh and provide function to initialize PHY.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> CC: Shimoda, Yoshihiro <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/host/ehci-sh.c  |   12 ++++++++++++
>  include/linux/usb/ehci-sh.h |   29 +++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 0 deletions(-)
>  create mode 100644 include/linux/usb/ehci-sh.h
> 
> diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
> index 9d9cf47..787b07e 100644
> --- a/drivers/usb/host/ehci-sh.c
> +++ b/drivers/usb/host/ehci-sh.c
> @@ -11,6 +11,7 @@
>   */
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/usb/ehci-sh.h>
>  
>  struct ehci_sh_priv {
>  	struct clk *iclk, *fclk;
> @@ -100,6 +101,7 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
>  	const struct hc_driver *driver = &ehci_sh_hc_driver;
>  	struct resource *res;
>  	struct ehci_sh_priv *priv;
> +	struct ehci_sh_platdata *pdata;
>  	struct usb_hcd *hcd;
>  	int irq, ret;
>  
> @@ -124,6 +126,13 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
>  		goto fail_create_hcd;
>  	}
>  
> +	if (pdev->dev.platform_data = NULL) {
> +		dev_err(&pdev->dev, "no platform data\n");
> +		ret = -ENODEV;
> +		goto fail_create_hcd;
> +	}
> +	pdata = pdev->dev.platform_data;
> +
>  	/* initialize hcd */
>  	hcd = usb_create_hcd(&ehci_sh_hc_driver, &pdev->dev,
>  			     dev_name(&pdev->dev));
> @@ -168,6 +177,9 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
>  	clk_enable(priv->fclk);
>  	clk_enable(priv->iclk);
>  
> +	if (pdata->phy_init)
> +		pdata->phy_init(pdata->clkmode);

The clkmode is only used by the phy_init(). So, I think that we can remove the
clkmode. (In other words, the ehci-sh doesn't use the clkmode actually.)

And then, According to your other 2 patches, the current platforms don't
use the phy_init(). So, if a platform_device doesn't have the platform_data,
it is better for ehci-sh to ignore the parameter, I think.

Best regards,
Yoshihiro Shimoda
