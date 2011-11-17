From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Nov 2011 05:39:41 +0000
Subject: Re: [PATCH 1/3] sh: sh7724: use runtime PM implementation, common with arm/mach-shmobile
Message-Id: <20111117053940.GA30555@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1111161306190.1100@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1111161306190.1100@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 16, 2011 at 01:35:42PM +0100, Guennadi Liakhovetski wrote:
> @@ -195,61 +198,64 @@ static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
>  				      fclkbcr_parent, ARRAY_SIZE(fclkbcr_parent), 6, 2),
>  };
>  
> +#define MSTP(_parent, _reg, _bit, _flags) \
> +  SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
> +
>  static struct clk mstp_clks[HWBLK_NR] = {
> -	SH_HWBLK_CLK(HWBLK_TLB, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),

..

> +	[HWBLK_TLB] = MSTP(&div4_clks[DIV4_I],	   MSTPCR0, 31, CLK_ENABLE_ON_INIT),

No, I'm not interested in wrappers to wrappers. Just use SH_CLK_MSTP32
directly. If you're adhering to 80 character lines you can just do some
additional formatting where necessary.

Other then that it's a good start. I assume once these are tidied up
you'll be sending patches to strip out the hwblk stuff as well as the
shmobile runtime PM implementation completely?
