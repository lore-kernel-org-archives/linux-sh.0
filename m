From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 10 Jul 2013 12:06:45 +0000
Subject: Re: [PATCH 4/4 v2] ARM: shmobile: bockw: add USB Function support
Message-Id: <51DD4E55.4030808@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4f7uoxx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4f7uoxx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 10-07-2013 6:30, Kuninori Morimoto wrote:

> Bock-W USB1 (CN29) can be USB Host/Func by SW98/SW99 settings.
> USB Func will be enabled if CONFIG_USB_RENESAS_USBHS_UDC[_MODULE]
> was selected by this patch

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index a57be8a..afc3fcf 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
[...]
> @@ -162,10 +199,13 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
>   	/* SDHI0 */
>   	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
>   				  "sdhi0", "sdhi0"),
> +	/* USB */
>   	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
>   				  "usb0", "usb0"),
>   	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
>   				  "usb1", "usb1"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7778",
> +				  "usb1", "usb1"),

    Won't it cause conflict with the previous group when both EHCI and 
USB function drivers are enabled?

WBR, Sergei

