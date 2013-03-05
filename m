From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Mar 2013 03:18:52 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: fixup INDTx address
Message-Id: <20130305031850.GN16128@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[ Cc: Linus Walleij ]

Hi Linus, Hi Paul, Hi Laurent,

I'm a little unsure how everyone would like to handle
drivers/pinctrl/sh-pfc/ updates.

I'm happy to create a pfc branch and send pull requests to Linus.
Or for Paul to handle things. Or for Laurent to handle things.
Or for other suggestions.

To confuse things, I believe there are a batch of PFC changes that
will make sense to take through the arm-soc tree due to dependencies.


Morimoto-san,

could you comment on how critical this change is.
Does anything in 3.9-rc1 depend on it?

On Mon, Mar 04, 2013 at 12:45:39AM -0800, Kuninori Morimoto wrote:
> INDTn address is 0xFFC4x000C. 0xFFC4x0008 is OUTDTn
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> index 13feaa0..cb97fb6 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> @@ -2585,13 +2585,13 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
>  };
>  
>  static struct pinmux_data_reg pinmux_data_regs[] = {
> -	{ PINMUX_DATA_REG("INDT0", 0xffc40008, 32) { GP_INDT(0) } },
> -	{ PINMUX_DATA_REG("INDT1", 0xffc41008, 32) { GP_INDT(1) } },
> -	{ PINMUX_DATA_REG("INDT2", 0xffc42008, 32) { GP_INDT(2) } },
> -	{ PINMUX_DATA_REG("INDT3", 0xffc43008, 32) { GP_INDT(3) } },
> -	{ PINMUX_DATA_REG("INDT4", 0xffc44008, 32) { GP_INDT(4) } },
> -	{ PINMUX_DATA_REG("INDT5", 0xffc45008, 32) { GP_INDT(5) } },
> -	{ PINMUX_DATA_REG("INDT6", 0xffc46008, 32) {
> +	{ PINMUX_DATA_REG("INDT0", 0xffc4000c, 32) { GP_INDT(0) } },
> +	{ PINMUX_DATA_REG("INDT1", 0xffc4100c, 32) { GP_INDT(1) } },
> +	{ PINMUX_DATA_REG("INDT2", 0xffc4200c, 32) { GP_INDT(2) } },
> +	{ PINMUX_DATA_REG("INDT3", 0xffc4300c, 32) { GP_INDT(3) } },
> +	{ PINMUX_DATA_REG("INDT4", 0xffc4400c, 32) { GP_INDT(4) } },
> +	{ PINMUX_DATA_REG("INDT5", 0xffc4500c, 32) { GP_INDT(5) } },
> +	{ PINMUX_DATA_REG("INDT6", 0xffc4600c, 32) {
>  		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
>  		0, 0, 0, 0, 0, 0, 0, GP_6_8_DATA,
>  		GP_6_7_DATA, GP_6_6_DATA, GP_6_5_DATA, GP_6_4_DATA,
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
