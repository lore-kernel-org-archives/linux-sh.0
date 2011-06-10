From: Simon Horman <horms@verge.net.au>
Date: Fri, 10 Jun 2011 02:23:31 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 divide-by-zero FSIDIV fix
Message-Id: <20110610022325.GB643@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609064913.2219.62039.sendpatchset@t400s>
In-Reply-To: <20110609064913.2219.62039.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 09, 2011 at 03:49:13PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the sh7372 FSIDIV clock code to bail out
> with -EINVAL in case of rate is zero.
> 
> Without this fix divide-by-zero is triggering
> on sh7372 platforms during system wide resume
> of Suspend-to-RAM.

Hi Magnus,

I'm unsure that I understand how rate ends up being
zero in the situation you describe.

> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/clock-sh7372.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- 0001/arch/arm/mach-shmobile/clock-sh7372.c
> +++ work/arch/arm/mach-shmobile/clock-sh7372.c	2011-06-09 15:45:41.000000000 +0900
> @@ -460,6 +460,9 @@ static int fsidiv_set_rate(struct clk *c
>  {
>  	int idx;
>  
> +	if (!rate)
> +		return -EINVAL;
> +
>  	idx = (clk->parent->rate / rate) & 0xffff;
>  	if (idx < 2)
>  		return -EINVAL;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
