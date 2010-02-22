From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 22 Feb 2010 10:15:12 +0000
Subject: Re: [PATCH v2] sh: sh7724: Update FSI/SPU2 clock
Message-Id: <20100222101511.GB1417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ueikd6dnr.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ueikd6dnr.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 22, 2010 at 02:18:10PM +0900, Kuninori Morimoto wrote:
> diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
> index 858ecb2..674bc3c 100644
> --- a/arch/sh/boards/mach-se/7724/setup.c
> +++ b/arch/sh/boards/mach-se/7724/setup.c
> @@ -595,7 +595,7 @@ arch_initcall(arch_setup);
>  static int __init devices_setup(void)
>  {
>  	u16 sw = ctrl_inw(SW4140); /* select camera, monitor */
> -	struct clk *fsia_clk;
> +	struct clk *clk;
>  
>  	/* register board specific self-refresh code */
>  	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,

I've applied this by hand this time, but in the future please make sure
that your patch applies cleanly to the current tree, not whatever
arbitrary version you happen to be using.
