From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 01 Sep 2014 13:22:55 +0000
Subject: Re: [PATCH] usb: renesas_usbhs: fix driver dependencies
Message-Id: <5404732F.4000203@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8246169.KgpDT6Hn5J@amdc1032>
In-Reply-To: <8246169.KgpDT6Hn5J@amdc1032>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 9/1/2014 5:14 PM, Bartlomiej Zolnierkiewicz wrote:

> Renesas USBHS controller support should be available only on
> Renesas ARM SoCs and SuperH architecture.

> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> ---
>   drivers/usb/renesas_usbhs/Kconfig |    1 +
>   1 file changed, 1 insertion(+)

> Index: b/drivers/usb/renesas_usbhs/Kconfig
> =================================> --- a/drivers/usb/renesas_usbhs/Kconfig	2014-07-30 14:31:51.883523522 +0200
> +++ b/drivers/usb/renesas_usbhs/Kconfig	2014-09-01 14:25:42.028512490 +0200
> @@ -5,6 +5,7 @@
>   config USB_RENESAS_USBHS
>   	tristate 'Renesas USBHS controller'
>   	depends on USB_GADGET
> +	depends on ARCH_SHMOBILE || ARCH_SH || COMPILE_TEST

    Again, I think you meant SUPERH here, not ARCH_SH.

WBR, Sergei

