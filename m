From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 10 Jul 2013 11:54:06 +0000
Subject: Re: [PATCH 1/4 v2] ARM: shmobile: r8a7778: add usb phy power control function
Message-Id: <51DD4B5E.5030007@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vc4jup1i.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vc4jup1i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 10-07-2013 6:28, Kuninori Morimoto wrote:

> USB phy initialisation function is needed from not only
> USB Host but also USB Function too.
> This patch adds usb phy common control function.

> Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
[...]

> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 08e9fb3..99dd715 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -109,29 +109,46 @@ void __init r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata)
>   					  pdata, sizeof(*pdata));
>   }
>
> -/* USB */
> -static struct usb_phy *phy;
> +static int r8a7778_usb_phy_power(bool enable)
> +{
> +	static struct usb_phy *phy = NULL;
> +	int ret = 0;
> +
> +	if (!phy)
> +		phy = usb_get_phy(USB_PHY_TYPE_USB2);
> +
> +	if (IS_ERR(phy)) {
> +		pr_err("it doesn't have usb phy driver\n");
> +		return PTR_ERR(phy);
> +	}
> +
> +	if (enable)
> +		ret = usb_phy_init(phy);
> +	else
> +		usb_phy_shutdown(phy);
>
> +	return ret;
> +}
> +
> +/* USB */
>   static int usb_power_on(struct platform_device *pdev)
>   {
> -	if (IS_ERR(phy))
> -		return PTR_ERR(phy);
> +	int ret = r8a7778_usb_phy_power(1);

    s/1/true/.

> +
> +	if (ret)
> +		return ret;
>
>   	pm_runtime_enable(&pdev->dev);
>   	pm_runtime_get_sync(&pdev->dev);
>
> -	usb_phy_init(phy);
> -
>   	return 0;
>   }
>
>   static void usb_power_off(struct platform_device *pdev)
>   {
> -	if (IS_ERR(phy))
> +	if (r8a7778_usb_phy_power(0))

    s/0/false/.

WBR, Sergei

