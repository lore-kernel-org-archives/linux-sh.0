From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Aug 2008 01:20:25 +0000
Subject: Re: [RFC] SCI(F) clock source select
Message-Id: <20080813012025.GA11346@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87vdy5zuk2.wl%ysato@users.sourceforge.jp>
In-Reply-To: <87vdy5zuk2.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 12, 2008 at 07:23:57PM -0400, Yoshinori Sato wrote:
> SCI(F) clock source (Internal/External) selection is hard coding now.
> And depend on CPU type.
> 
> But I think it's setting depend on target.
> 
> I hope add clock selection in platform_data.
> 
> Any comments?
> 
> diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
> index 3df2aae..6c0ceff 100644
> --- a/drivers/serial/sh-sci.c
> +++ b/drivers/serial/sh-sci.c
> @@ -82,6 +82,8 @@ struct sci_port {
>  	/* Port clock */
>  	struct clk		*clk;
>  #endif
> +	/* clock source */
> +	int			clock_source;
>  };
>  

We should probably just add an additional flags field to the port type
and platform data and allow internal/external selection based off of
that. Then we can default to the current behaviour, and allow the
platforms that want different behaviour to specifically set a bit.

It's certainly heading in the right direction, though.
