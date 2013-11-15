From: David Cohen <david.a.cohen@linux.intel.com>
Date: Fri, 15 Nov 2013 04:43:50 +0000
Subject: Re: [PATCH] gpio: rcar: Support both edge trigger with DT
Message-Id: <5285A686.4000405@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384359983-29178-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384359983-29178-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Simon Horman <horms@verge.net.au>

Hi Laurent,

On 11/13/2013 08:26 AM, Laurent Pinchart wrote:
> Some versions of the R-Car GPIO controller support triggering on both
> edges of the input signal. Whether this capability is supported is
> currently specified in platform data. R-Car GPIO devices instantiated
> from the device tree have the capability turned off even when the
> hardware supports it.
> 
> To fix this, add DT match data support to the driver, initialize both
> edge trigger support from match data and enable both edge trigger in
> r8a7790 and r8a7791 match data.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/gpio/gpio-rcar.c | 56 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 43 insertions(+), 13 deletions(-)
> 
> The patch has been tested on a Lager board. Simon, I've understood that you
> need this to add GPIO keys support to the Lager DT. Would you be able to test
> that ?
> 
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 6038966..68b0940 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -283,7 +283,34 @@ static struct irq_domain_ops gpio_rcar_irq_domain_ops = {
>  	.map	= gpio_rcar_irq_domain_map,
>  };
>  
> -static void gpio_rcar_parse_pdata(struct gpio_rcar_priv *p)
> +struct gpio_rcar_info {
> +	bool has_both_edge_trigger;
> +};
> +
> +static const struct of_device_id gpio_rcar_of_table[] = {
> +	{
> +		.compatible = "renesas,gpio-r8a7790",
> +		.data = (void *)&(const struct gpio_rcar_info) {
> +			.has_both_edge_trigger = true,
> +		},
> +	}, {
> +		.compatible = "renesas,gpio-r8a7791",
> +		.data = (void *)&(const struct gpio_rcar_info) {
> +			.has_both_edge_trigger = true,
> +		},
> +	}, {
> +		.compatible = "renesas,gpio-rcar",
> +		.data = (void *)&(const struct gpio_rcar_info) {
> +			.has_both_edge_trigger = false,
> +		},
> +	}, {
> +		/* Terminator */
> +	},

According to ANSI C, you can't initialize struct with empty { }. You
would need at least one 0 inside.
Despite gcc accepts it, there are some ppl over there trying kernel
with different compilers :)

(Hope I'm not being too nitpicky)

Br, David Cohen
