From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 22 Jun 2015 17:38:57 +0000
Subject: Re: [PATCH 1/3] usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS
Message-Id: <55884831.6080409@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434984151-27274-1-git-send-email-phil.edworthy@renesas.com> <1434984151-27274-2-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1434984151-27274-2-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>, Kishon Vijay Abraham I <kishon@ti.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 06/22/2015 05:42 PM, Phil Edworthy wrote:

> These changes allow a PHY driver to trigger a VBUS interrupt and
> to provide the value of VBUS.

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>   drivers/usb/renesas_usbhs/common.h     |  2 ++
>   drivers/usb/renesas_usbhs/mod.c        |  3 +++
>   drivers/usb/renesas_usbhs/mod_gadget.c | 38 ++++++++++++++++++++++++++++++++++
>   3 files changed, 43 insertions(+)

> diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
> index 8c5fc12..94a7aeb 100644
> --- a/drivers/usb/renesas_usbhs/common.h
> +++ b/drivers/usb/renesas_usbhs/common.h
> @@ -255,6 +255,8 @@ struct usbhs_priv {
>   	struct renesas_usbhs_driver_param	dparam;
>
>   	struct delayed_work notify_hotplug_work;
> +	int vbus_is_indirect;

    s/int/bool/.

> +	int vbus_indirect_value;

    Likewise.

>   	struct platform_device *pdev;
>
>   	struct extcon_dev *edev;
[...]
> diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
> index dc2aa32..2cfdb50 100644
> --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
[...]
> @@ -891,6 +895,17 @@ static int usbhsg_gadget_start(struct usb_gadget *gadget,
>   	/* first hook up the driver ... */
>   	gpriv->driver = driver;
>
> +	/* connect to bus through transceiver */
> +	if (!IS_ERR_OR_NULL(gpriv->transceiver)) {
> +		ret = otg_set_peripheral(gpriv->transceiver->otg,
> +					&gpriv->gadget);
> +		if (ret) {
> +			dev_info(dev, "%s: can't bind to transceiver\n",

    dev_err().

[...]
> @@ -994,6 +1028,10 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
>   		goto usbhs_mod_gadget_probe_err_gpriv;
>   	}
>
> +	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
> +	dev_info(dev, "%s transceiver found\n",
> +		 gpriv->transceiver ? "" : "No");

	dev_info(dev, "%stransceiver found\n",
		 gpriv->transceiver ? "" : "no ");

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
