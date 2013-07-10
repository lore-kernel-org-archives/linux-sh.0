From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 10 Jul 2013 11:58:14 +0000
Subject: Re: [PATCH 2/4 v2] ARM: shmobile: r8a7778: add r8a7778_add_usb_host_device()
Message-Id: <51DD4C56.9050108@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txk3up0q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txk3up0q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 10-07-2013 6:28, Kuninori Morimoto wrote:

> The USB host driver was registered in compulsorily
> on current r8a7778 SoC code.
> But it should be decided on platform, not SoC.
> This patch adds r8a7778_add_usb_host_device() for it.

> Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[...]
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 99dd715..9ea1e25 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -205,6 +205,12 @@ static struct platform_device_info hci##_info __initdata = {	\
>   USB_PLATFORM_INFO(ehci);
>   USB_PLATFORM_INFO(ohci);
>
> +void __init r8a7778_add_usb_host_device(void)

    s/device/devices/.

> +{
> +	platform_device_register_full(&ehci_info);
> +	platform_device_register_full(&ohci_info);
> +}
> +
>   /* Ether */
>   static struct resource ether_resources[] __initdata = {
>   	DEFINE_RES_MEM(0xfde00000, 0x400),

    Will you do the same change to Marzen/R8A7779?

WBR, Sergei

