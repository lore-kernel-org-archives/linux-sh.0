From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 02 Sep 2013 14:02:01 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo: fixup ether pinctrol naming
Message-Id: <52249A59.5090904@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 09/02/2013 07:33 AM, Kuninori Morimoto wrote:

> e5c9b4cd665106d9b5397114ea81a53059410b6a
> (sh_eth: get R8A7740 support out of #ifdef)
> exchanged sh-eth driver name to r8a7740-gether,
> but, eva_pinctrl_map[] didn't follow it.
> This patch fixes it.

    You're too quick to blame my patch. It was just merged in the same 
timeframe of 3.11-rc1 with the Armadillo800EVA GEther PFC support but thru the 
different (net-next.git) tree, so it couldn't have done this change because in 
that tree the code you're modifying wasn't present; likewise, in the 
renesas.git, the network patches weren't seen and accounted for (although they 
could have been in principle). I'd therefore like to see more fair and 
complete changelog. :-)

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/board-armadillo800eva.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index c5be60d..33f219e 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -1069,9 +1069,9 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
>   	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.1", "pfc-r8a7740",
>   				  "fsib_mclk_in", "fsib"),
>   	/* GETHER */
> -	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7740-gether", "pfc-r8a7740",
>   				  "gether_mii", "gether"),
> -	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7740-gether", "pfc-r8a7740",
>   				  "gether_int", "gether"),
>   	/* HDMI */
>   	PIN_MAP_MUX_GROUP_DEFAULT("sh-mobile-hdmi", "pfc-r8a7740",

WBR, Sergei

