From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 22 Feb 2010 10:22:50 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: ap4evb: Add LED support
Message-Id: <20100222102250.GA4356@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u8wal629z.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u8wal629z.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 22, 2010 at 06:20:39PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-ap4evb.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index 41bc248..4714cad 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -197,6 +197,20 @@ static void __init ap4evb_init(void)
>  	gpio_request(GPIO_FN_CS5A,	NULL);
>  	gpio_request(GPIO_FN_IRQ6_39,	NULL);
>  
> +	/* enable LED 1 - 4 */
> +	gpio_request(GPIO_PORT185, NULL);

[snip]

On Mon, Feb 22, 2010 at 06:30:12PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-ap4evb.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index 4714cad..d9a46d0 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -211,6 +211,20 @@ static void __init ap4evb_init(void)
>  	gpio_export(GPIO_PORT187, 0);
>  	gpio_export(GPIO_PORT188, 0);
>  
> +	/* enable Debug switch (S6) */
> +	gpio_request(GPIO_PORT32, NULL);

[snip]

Both applied, thanks.
