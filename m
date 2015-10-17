From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Sat, 17 Oct 2015 01:48:23 +0000
Subject: Re: [PATCH v4 2/3] phy: rcar-gen3-usb2: change the mode to OTG on the combined channel
Message-Id: <5621A8D4.40405@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444731726-5328-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1444731726-5328-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1444731726-5328-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

On Tuesday 13 October 2015 03:52 PM, Yoshihiro Shimoda wrote:
> To use the channel 0 of R-Car gen3 as periperal mode, This patch changes
> the mode to OTG instead of HOST. Then, this driver needs to set some
> registers to enable host mode and detects ID pin and VBUS pin at
> phy_init() timing.
> 
> For now, the channel 0 can be used as host mode only.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/phy/phy-rcar-gen3-usb2.c | 126 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 124 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-rcar-gen3-usb2.c b/drivers/phy/phy-rcar-gen3-usb2.c
> index d90dfcf..03d7079 100644
> --- a/drivers/phy/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/phy-rcar-gen3-usb2.c
> @@ -25,6 +25,10 @@
>  #define USB2_USBCTR		0x00c
>  #define USB2_SPD_RSM_TIMSET	0x10c
>  #define USB2_OC_TIMSET		0x110
> +#define USB2_COMMCTRL		0x600
> +#define USB2_VBCTRL		0x60c
> +#define USB2_LINECTRL1		0x610
> +#define USB2_ADPCTRL		0x630
>  
>  /* INT_ENABLE */
>  #define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)
> @@ -42,6 +46,24 @@
>  /* OC_TIMSET */
>  #define USB2_OC_TIMSET_INIT		0x000209ab
>  
> +/* COMMCTRL */
> +#define USB2_COMMCTRL_OTG_PERI		BIT(31)	/* 1 = Peripheral mode */
> +
> +/* VBCTRL */
> +#define USB2_VBCTRL_DRVVBUSSEL		BIT(8)
> +
> +/* LINECTRL1 */
> +#define USB2_LINECTRL1_DPRPD_EN		BIT(19)
> +#define USB2_LINECTRL1_DP_RPD		BIT(18)
> +#define USB2_LINECTRL1_DMRPD_EN		BIT(17)
> +#define USB2_LINECTRL1_DM_RPD		BIT(16)
> +
> +/* ADPCTRL */
> +#define USB2_ADPCTRL_OTGSESSVLD		BIT(20)
> +#define USB2_ADPCTRL_IDDIG		BIT(19)
> +#define USB2_ADPCTRL_IDPULLUP		BIT(5)	/* 1 = ID sampling is enabled */
> +#define USB2_ADPCTRL_DRVVBUS		BIT(4)
> +
>  /******* HSUSB registers (original offset is +0x100) *******/
>  #define HSUSB_LPSTS			0x02
>  #define HSUSB_UGCTRL2			0x84
> @@ -68,6 +90,104 @@ struct rcar_gen3_chan {
>  	spinlock_t lock;
>  };
>  
> +static void rcar_gen3_set_host_mode(struct rcar_gen3_chan *ch, int host)
> +{
> +	void __iomem *usb2_base = ch->usb2.base;
> +	u32 tmp = readl(usb2_base + USB2_COMMCTRL);

It's your preference but I'd like to have something like val instead of tmp.
> +
> +	dev_dbg(&ch->phy->dev, "%s: %08x, %d\n", __func__, tmp, host);

This shoulod be dev_vdbg.
> +	if (host)
> +		tmp &= ~USB2_COMMCTRL_OTG_PERI;
> +	else
> +		tmp |= USB2_COMMCTRL_OTG_PERI;
> +	writel(tmp, usb2_base + USB2_COMMCTRL);
> +}
> +
> +static void rcar_gen3_set_linectrl(struct rcar_gen3_chan *ch, int dp, int dm)
> +{
> +	void __iomem *usb2_base = ch->usb2.base;
> +	u32 tmp = readl(usb2_base + USB2_LINECTRL1);
> +
> +	dev_dbg(&ch->phy->dev, "%s: %08x, %d, %d\n", __func__, tmp, dp, dm);

same here.
> +	tmp &= ~(USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD);
> +	if (dp)
> +		tmp |= USB2_LINECTRL1_DP_RPD;
> +	if (dm)
> +		tmp |= USB2_LINECTRL1_DM_RPD;
> +	writel(tmp, usb2_base + USB2_LINECTRL1);
> +}
> +
> +static void rcar_gen3_enable_vbus_ctrl(struct rcar_gen3_chan *ch, int vbus)
> +{
> +	void __iomem *usb2_base = ch->usb2.base;
> +	u32 tmp = readl(usb2_base + USB2_ADPCTRL);
> +
> +	dev_dbg(&ch->phy->dev, "%s: %08x, %d\n", __func__, tmp, vbus);

here too.
> +	if (vbus)
> +		tmp |= USB2_ADPCTRL_DRVVBUS;
> +	else
> +		tmp &= ~USB2_ADPCTRL_DRVVBUS;
> +	writel(tmp, usb2_base + USB2_ADPCTRL);
> +}
> +
> +static void rcar_gen3_init_for_host(struct rcar_gen3_chan *ch)
> +{
> +	rcar_gen3_set_linectrl(ch, 1, 1);
> +	rcar_gen3_set_host_mode(ch, 1);
> +	rcar_gen3_enable_vbus_ctrl(ch, 1);
> +}
> +
> +static void rcar_gen3_init_for_peri(struct rcar_gen3_chan *ch)
> +{
> +	rcar_gen3_set_linectrl(ch, 0, 1);
> +	rcar_gen3_set_host_mode(ch, 0);
> +	rcar_gen3_enable_vbus_ctrl(ch, 0);
> +}
> +
> +static bool rcar_gen3_check_vbus(struct rcar_gen3_chan *ch)
> +{
> +	return !!(readl(ch->usb2.base + USB2_ADPCTRL) &
> +		  USB2_ADPCTRL_OTGSESSVLD);
> +}
> +
> +static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)
> +{
> +	return !!(readl(ch->usb2.base + USB2_ADPCTRL) & USB2_ADPCTRL_IDDIG);
> +}
> +
> +static void rcar_gen3_device_recognition(struct rcar_gen3_chan *ch)
> +{
> +	bool is_host = true;
> +
> +	if (rcar_gen3_check_id(ch)) {
> +		/* B-device? */
> +		if (rcar_gen3_check_vbus(ch))

This can be rcar_gen3_check_id(ch) && rcar_gen3_check_vbus(ch) no?

Thanks
Kishon
