From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 03:31:44 +0000
Subject: Re: [PATCH 3/3] arm: shmobile: lager: Add USBHS support
Message-Id: <87a9ikxwtf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-4-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-4-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine

> This adds USBHS PHY and registers USBHS device if the driver is enabled.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
(snip)
> +/* USBHS */
> +#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
> +static const struct resource usbhs_resources[] __initconst = {
> +	DEFINE_RES_MEM(0xe6590000, 0x100),
> +	DEFINE_RES_IRQ(gic_spi(107)),
> +};

Why it needs #if IS_ENABLED() ?
I guess nothing happen if renesas_usbhs driver
registered without CONFIG_USB_RENESAS_USBHS_UDC.
But am I misunderstanding ?
