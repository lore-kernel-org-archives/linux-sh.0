From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 08:18:35 +0000
Subject: Re: [PATCH v3 4/5] ARM: shmobile: r8a7790: don't use external clock for SCIFs
Message-Id: <20130612081835.GA16184@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370015825-29383-5-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1370015825-29383-5-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 11, 2013 at 04:51:37PM +0900, Simon Horman wrote:
> On Fri, May 31, 2013 at 05:57:04PM +0200, Ulrich Hecht wrote:
> > This is an external component and may or may not be there, while the
> > internal clock always works.
> 
> Thanks, I have queued this up in the soc2 branch.
> My current plan is to let that branch sit in next for a few
> days and then send a pull-request for it to be included in v3.11.

I have moved it to the sh-sci branch to satisfy dependencies
without rebasing soc2.

> 
> > 
> > Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> > ---
> >  arch/arm/mach-shmobile/setup-r8a7790.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
> > index 5b7a770..a380bdc 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> > @@ -96,7 +96,7 @@ void __init r8a7790_pinmux_init(void)
> >  [index] = {						\
> >  	SCIF_COMMON(PORT_SCIF, baseaddr, irq),		\
> >  	.scbrr_algo_id	= SCBRR_ALGO_2,			\
> > -	.scscr = SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
> > +	.scscr = SCSCR_RE | SCSCR_TE,	\
> >  }
> >  
> >  #define HSCIF_DATA(index, baseaddr, irq)		\
> > -- 
> > 1.7.10.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
