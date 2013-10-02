From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 00:18:58 +0000
Subject: Re: [PATCH 5/6] arm: shmobile: lager: Add internal PCI support
Message-Id: <8761tg1q4w.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-6-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-6-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine

> This adds internal PCI/USB host support to Lager board.
> There are 3 internal PCI bus controllers with only a EHCI/OHCI
> device present on each one. This gives us 3 USB host channels.
> Channel 0 is shared with the USBHS function module.
> Channel 2 is shared with the USBSS (XHCI) device.
> 
> Currently no channel configuration is supported,
> and the default settings are assumed:
> Channel 0 - USBHS
> Channel 1 - PCI/USB host
> Channel 2 - PCI/USB host
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
(snip)
>  	/* USB0 */
> -	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7790",
> +	PIN_MAP_MUX_GROUP_DEFAULT(LAGER_USB0_DEVNAME, "pfc-r8a7790",
>  				  "usb0", "usb0"),

I found definition of "LAGER_USB0_DEVNAME" on [6/6] patch,
but [5/6] patch is using it.

Best regards
---
Kuninori Morimoto
