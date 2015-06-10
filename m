From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 10 Jun 2015 16:53:22 +0000
Subject: Re: [PATCH] TESTCASE: of: OOPS when disabling node via OF_DYNAMIC
Message-Id: <20150610165322.576FDC408EA@trevor.secretlab.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <1427814771-30335-1-git-send-email-wsa@the-dreams.de>
	<83B5C458-8D49-4EF6-9F4A-6C0E2579AB9F@konsulko.com>
	<20150607111632.CC7A4C410F0@trevor.secretlab.ca>
	<2309597.bA1dyPGh92@avalon>
In-Reply-To: <2309597.bA1dyPGh92@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 09 Jun 2015 19:50:26 +0300
, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 wrote:
> Hi Grant,
> 
> On Sunday 07 June 2015 12:16:32 Grant Likely wrote:
> > On Wed, 22 Apr 2015 15:30:28 +0300, Pantelis Antoniou wrote:
> > > > On Apr 14, 2015, at 16:27 , Wolfram Sang <wsa@the-dreams.de> wrote:
> > > > 
> > > > Hi Pantelis,
> > > > 
> > > > thanks for your prompt reply. Unfortunately, I had to wait until I could
> > > > access the test system again.
> > > 
> > > [snip]
> > > 
> > > Sorry for the non-prompt reply; but just for kicks, can you try the
> > > attached patch?
> > > 
> > > I have a hunch this might be the problem.
> > > 
> > > Regards
> > > 
> > > â Pantelis
> > 
> > I played around with this some today. If I'm reading it correctly, the
> > following patch reproduces the same problem:
> > 
> > (continued below patch)
> > ---
> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > index 18016341d5a9..0a27b38c3041 100644
> > --- a/drivers/of/unittest.c
> > +++ b/drivers/of/unittest.c
> > @@ -753,6 +753,11 @@ static void __init of_unittest_match_node(void)
> >  	}
> >  }
> > 
> > +static struct resource test_bus_res = {
> > +	.start = 0xfffffff8,
> > +	.end = 0xfffffff9,
> > +	.flags = IORESOURCE_MEM,
> > +};
> >  static const struct platform_device_info test_bus_info = {
> >  	.name = "unittest-bus",
> >  };
> > @@ -795,6 +800,7 @@ static void __init of_unittest_platform_populate(void)
> >  	if (rc)
> >  		return;
> >  	test_bus->dev.of_node = np;
> > +	platform_device_add_resources(test_bus, &test_bus_res, 1);
> > 
> >  	of_platform_populate(np, match, NULL, &test_bus->dev);
> >  	for_each_child_of_node(np, child) {
> > 
> > ---
> > 
> > I think the fixup patch boils down to the following. It's hard to tell
> > because it combines refactoring with the bug fix. Do I have it correct?
> > If so, I'd rather commit the simple fix which can be committed now for
> > v4.1, and the refactoring can be pushed for v4.2
> 
> The patch below looks equivalent to Pantelis' patch if we remove the 
> refactoring, but I don't immediately see how r->parent can be NULL in 
> platform_device_del() if type is equal to IORESOURCE_MEM or IORESOURCE_IO, as 
> platform_device_add() will have called insert_resource() in those cases, which 
> should set the resource parent pointer. I must be missing something as the 
> patch fixes Wolfram's issue, so an explanation in the commit message would be 
> welcome.

of_platform_populate() adds platform devices via of_device_add().
of_device_add() doesn't add the resources because there are platforms
that break due to nodes with overlapping resources.

g.
