From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 28 Jul 2014 20:19:37 +0000
Subject: Re: [PATCH v2] sh-pfc: r8a7791: add CAN pin groups
Message-Id: <53D6B059.6050300@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407020058.17369.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407020058.17369.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 07/02/2014 12:58 AM, Sergei Shtylyov wrote:

> Add CAN0/1 data/clock pin groups to R8A7791 PFC driver.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git' repo.

> Changes in version 2:
> - fixed CAN_CLK_C pin mapping;
> - renamed can[01]_{clk|data}_a_*[] to can[01]_{clk|data}_*[];

    As it turned out, this rename wasn't enough...

> - added pin name comments to can*_pins[] initializers.

>   drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  167 +++++++++++++++++++++++++++++++++++
>   1 file changed, 167 insertions(+)

> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> =================================> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
[...]
> @@ -4367,6 +4508,30 @@ static const char * const audio_clk_grou
>   	"audio_clkout",
>   };
>
> +static const char * const can0_groups[] = {
> +	"can0_data_a",

    Crap, forgot to fix this to "can0_data"... :-(

> +	"can0_data_b",
> +	"can0_data_c",
> +	"can0_data_d",
> +	"can0_data_e",
> +	"can0_data_f",
> +	"can_clk_a",
> +	"can_clk_b",
> +	"can_clk_c",
> +	"can_clk_d",
> +};
> +
> +static const char * const can1_groups[] = {
> +	"can1_data_a",

    And this one too... :-(

> +	"can1_data_b",
> +	"can1_data_c",
> +	"can1_data_d",
> +	"can_clk_a",
> +	"can_clk_b",
> +	"can_clk_c",
> +	"can_clk_d",
> +};
> +

    Now that the patch is merged, I assume I'll have to send a fix...

WBR, Sergei

