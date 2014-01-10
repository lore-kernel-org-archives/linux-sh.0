From: Simon Horman <horms@verge.net.au>
Date: Fri, 10 Jan 2014 01:23:36 +0000
Subject: Re: [PATCH] ARM: shmobile: clk_get() returns error code on failure
Message-Id: <20140110012336.GB11905@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389281623-10253-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389281623-10253-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 09, 2014 at 06:42:38PM +0100, Laurent Pinchart wrote:
> Hi Ben,
> 
> Thank you for the patch.
> 
> On Thursday 09 January 2014 15:33:43 Ben Dooks wrote:
> > The lager_add_standard_devices() function calls clk_get() but then fails
> > to check that it returns an error pointer instead of NULL on failure.
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Do you plan to submit a similar patch for board-koelsch-reference.c ? I don't 
> mind doing it.

Hi Ben,

does this fix a problem that you have obvserved in practice.
If so it might be worth trying to get it included as a fix
for v3.14 rather than queueing it up for v3.15.

Regardless, as it is a fix of sorts, could you please include some
information along the following lines in the changelog:

----
This problem has been present since xyz was added by
deadbeef0123456789f ("ARM: shmobile: lager: something goes here")
in v3.1X-rcY.
----

Thanks

> 
> > ---
> >  arch/arm/mach-shmobile/board-lager-reference.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-lager-reference.c
> > b/arch/arm/mach-shmobile/board-lager-reference.c index a6e271d..dc8d76b
> > 100644
> > --- a/arch/arm/mach-shmobile/board-lager-reference.c
> > +++ b/arch/arm/mach-shmobile/board-lager-reference.c
> > @@ -44,14 +44,14 @@ static void __init lager_add_standard_devices(void)
> > 
> >  	for (i = 0; i < ARRAY_SIZE(scif_names); ++i) {
> >  		clk = clk_get(NULL, scif_names[i]);
> > -		if (clk) {
> > +		if (!IS_ERR(clk)) {
> >  			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
> >  			clk_put(clk);
> >  		}
> >  	}
> > 
> >  	clk = clk_get(NULL, "cmt0");
> > -	if (clk) {
> > +	if (!IS_ERR(clk)) {
> >  		clk_register_clkdev(clk, NULL, "sh_cmt.0");
> >  		clk_put(clk);
> >  	}
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
