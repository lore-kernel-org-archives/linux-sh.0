From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 02 Jul 2015 11:16:40 +0000
Subject: Re: [PATCH v2] usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS
Message-Id: <55951D98.7050003@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435822602-22685-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1435822602-22685-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Ulrich Hecht <ulrich.hecht@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 7/2/2015 10:36 AM, Phil Edworthy wrote:

> These changes allow a PHY driver to trigger a VBUS interrupt and
> to provide the value of VBUS.

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

[...]

> diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
> index dc2aa32..51b63f9 100644
> --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
[...]
> @@ -947,12 +966,27 @@ static int usbhsg_set_selfpowered(struct usb_gadget *gadget, int is_self)
>   	return 0;
>   }
>
> +static int usbhsg_vbus_session(struct usb_gadget *gadget, int is_active)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
> +	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
> +	struct platform_device *pdev = usbhs_priv_to_pdev(priv);
> +
> +	priv->vbus_is_indirect = 1;

    s/1/true/.

> +	priv->vbus_indirect_value = !!is_active;
> +
> +	renesas_usbhs_call_notify_hotplug(pdev);
> +
> +	return 0;
> +}
> +
[...]
> @@ -994,6 +1028,10 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
>   		goto usbhs_mod_gadget_probe_err_gpriv;
>   	}
>
> +	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
> +	dev_info(dev, "%s transceiver found\n",
> +		 gpriv->transceiver ? "" : "No");

    Hm, I told you to make this message cleaner, and you haven't. :-(

[...]

WBR, Sergei

