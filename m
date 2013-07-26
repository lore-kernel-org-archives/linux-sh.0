From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Jul 2013 22:38:58 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: bockw: add SDHI0 support
Message-Id: <51F2FA82.2050802@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878v4henwe.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878v4henwe.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/17/2013 09:17 AM, Kuninori Morimoto wrote:

> This patch is directly accessing to PUPR4 register which can
> control SDHI0 CD/WP pin pull-up setting.
> It should be replaced in the future.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/board-bockw.c |   29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)

> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index 4d65715..2b6103e 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
[...]
>   static const struct pinctrl_map bockw_pinctrl_map[] = {
>   	/* SCIF0 */
>   	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
>   				  "scif0_data_a", "scif0"),
>   	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
>   				  "scif0_ctrl", "scif0"),
> +	/* SDHI0 */
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
> +				  "sdhi0", "sdhi0"),
>   };

    These SDHI0 data above don't match drivers/pinctrl/sh-pfc/pfc-r8a7778.c 
and cause this message:

sh-pfc pfc-r8a7778: invalid group "sdhi0" for function "sdhi0"

    I'm not sure but maybe because of this SD card can't be detected.

WBR, Sergei

