From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 11 Jul 2013 11:46:37 +0000
Subject: Re: [PATCH 11/11] ARM: shmobile: bockw: add USB Function support
Message-Id: <51DE9B1D.6070000@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877ggxfqbr.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877ggxfqbr.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 11-07-2013 12:34, Kuninori Morimoto wrote:

> Bock-W USB1 (CN29) can be USB Host/Func by SW98/SW99 settings.
> USB Func will be enabled if CONFIG_USB_RENESAS_USBHS_UDC[_MODULE]
> was selected on this patch

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/board-bockw.c   |   80 ++++++++++++++++++++++++++++++--
>   arch/arm/mach-shmobile/clock-r8a7778.c |    1 +
>   2 files changed, 78 insertions(+), 3 deletions(-)

> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index 8978f61..a005fba 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
[...]
> @@ -62,6 +63,16 @@
>    * SW19	(MMC)	1 pin
>    */
> > @@ -276,6 +345,11 @@ static void __init bockw_init(void)
>   	}
>   }
>
> +static void __init bockw_init_late(void)
> +{

     You're not registering USB host devices now at all. NAK.

> +	ADD_USB_FUNC_DEVICE_IF_POSSIBLE;
> +}
> +

WBR, Sergei

