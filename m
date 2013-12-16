From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 16 Dec 2013 13:35:32 +0000
Subject: Re: [PATCH 5/6][RFC] ARM: shmobile: lager: add SDHI0/2 support
Message-Id: <52AF01A4.4010308@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738lt1jsf.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738lt1jsf.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 16-12-2013 8:50, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> SDHI0 (CN8) needs JP/SW settings

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/board-lager.c |   64 ++++++++++++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)

> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index f20c10a..e3122a8 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
[...]
> @@ -299,6 +342,20 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
>   				  "du_sync_1", "du"),
>   	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
>   				  "du_clk_out_0", "du"),
> +	/* SDHI */

    SDHI0?

> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7790",
> +				  "sdhi0_data4", "sdhi0"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7790",
> +				  "sdhi0_ctrl", "sdhi0"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7790",
> +				  "sdhi0_cd", "sdhi0"),
> +	/* SDHI2 */
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-r8a7790",
> +				  "sdhi2_data4", "sdhi2"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-r8a7790",
> +				  "sdhi2_ctrl", "sdhi2"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-r8a7790",
> +				  "sdhi2_cd", "sdhi2"),

WBR, Sergei

