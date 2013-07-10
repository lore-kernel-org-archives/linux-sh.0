From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 10 Jul 2013 12:02:15 +0000
Subject: Re: [PATCH 3/4 v2] RM: shmobile: r8a7778: add r8a7778_add_usb_func_device()
Message-Id: <51DD4D47.8050109@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87siznuozu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87siznuozu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 10-07-2013 6:29, Kuninori Morimoto wrote:

> This patch adds USB Function (= renesas_usbhs) driver support.
> r8a7778_add_usb_phy_device()  should be called from .init_machine,
> r8a7778_add_usb_func_device() should be called from .init_late
> when platform use it.

> This r8a7778_add_usb_func_device() will fill
> renesas_usbhs_platform_info::platform_callback.get_id and
> renesas_usbhs_platform_info::platform_callback.power_ctrl
> if these callbacks were NULL, since these don't depend
> on platform basically.

> Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 9ea1e25..b059ccd 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -153,6 +153,7 @@ static void usb_power_off(struct platform_device *pdev)
>   	pm_runtime_disable(&pdev->dev);
>   }
>
> +/* USB HOST */

    s/HOST/Host/ to at least be consistent with the later comment.

>   static int ehci_init_internal_buffer(struct usb_hcd *hcd)
>   {
>   	/*
> @@ -211,6 +212,44 @@ void __init r8a7778_add_usb_host_device(void)
>   	platform_device_register_full(&ohci_info);
>   }
>
> +/* USB Func */

WBR, Sergei

