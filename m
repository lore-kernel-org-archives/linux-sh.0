From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 30 Sep 2013 15:25:41 +0000
Subject: Re: [PATCH 1/6] clocksource: em_sti: convert to clk_prepare/unprepare
Message-Id: <1504961.3u9y73MgII@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <52410F86.4040301@renesas.com> <20130924130924.61d4ecedf3d4fca5952d55fc@ops.dti.ne.jp>
In-Reply-To: <20130924130924.61d4ecedf3d4fca5952d55fc-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Yoshii-san,

Thank you for the patch.

On Tuesday 24 September 2013 13:09:24 takasi-y@ops.dti.ne.jp wrote:
> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> 
> Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> migrate to the common clock framework.
> 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/clocksource/em_sti.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
> index 3a5909c..9d17083 100644
> --- a/drivers/clocksource/em_sti.c
> +++ b/drivers/clocksource/em_sti.c
> @@ -78,7 +78,7 @@ static int em_sti_enable(struct em_sti_priv *p)
>  	int ret;
> 
>  	/* enable clock */
> -	ret = clk_enable(p->clk);
> +	ret = clk_prepare_enable(p->clk);
>  	if (ret) {
>  		dev_err(&p->pdev->dev, "cannot enable clock\n");
>  		return ret;
> @@ -107,7 +107,7 @@ static void em_sti_disable(struct em_sti_priv *p)
>  	em_sti_write(p, STI_INTENCLR, 3);
> 
>  	/* stop clock */
> -	clk_disable(p->clk);
> +	clk_disable_unprepare(p->clk);
>  }
> 
>  static cycle_t em_sti_count(struct em_sti_priv *p)
-- 
Regards,

Laurent Pinchart

