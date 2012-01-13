From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 13 Jan 2012 08:35:00 +0000
Subject: Re: [PATCH v4 6/6] dmaengine: shdma: add support for SUDMAC
Message-Id: <Pine.LNX.4.64.1201130920430.29680@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0D3A10.7000708@renesas.com>
In-Reply-To: <4F0D3A10.7000708@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 13 Jan 2012, Paul Mundt wrote:

> On Thu, Jan 12, 2012 at 05:29:06PM +0100, Guennadi Liakhovetski wrote:
> > As for either converting both error and channel IRQs to named resources in 
> > one or separate patches - I don't have a strong preference there either, 
> > so, I can live with v3 too:-) Actually, there's a slight problem with 
> > using named IRQs for channels: since we can have several resources with 
> > channel IRQ ranges or with single IRQs per device, we cannot use 
> > platform_get_resource_byname() for all of them - only for the first one, 
> > which kind of makes this effort of converting all channel IRQ resources to 
> > named ones - pointless...
> > 
> Can you point to an example on the platform data side that you're
> thinking about?

E.g. arch/sh/kernel/cpu/sh4a/setup-sh7724.c::sh7724_dmae0_resources, dmae1 
is similar, same for sh7722.

> The IRQ range thing doesn't strike me as being inherently
> unsupportable by way of _byname(),

Hm, you don't mean adding extra names for each such case?...

> but you are correct that _byname()
> assumes one matching resource and doesn't support iterating (although we
> could presumably extend the API for this if necessary).

That would be a good option, yes. But whether it's worth it for this one 
case...

> > Now, what concerns this patch. It is hard for me to judge, since I don't 
> > have an sh7757 datasheet, but from the patch and from your comment "The 
> > SUDMAC's registers are imcompatible with SH DMAC" I really begin to doubt, 
> > whether it makes sense to combine them in one driver. AFAICS, the hardware 
> > handling is indeed completely different. The only things, that you reuse 
> > in the driver, are the dmaengine API implementation, which is pretty 
> > standard, and the transfer descriptor list management, which is indeed a 
> > bit tricky. My suggestion would be to split the current shdma.c driver 
> > into two parts - hardware specific and the logic, and reuse the latter for 
> > your new sudmac driver, which would then become a separate file. I'd have 
> > to think a bit, what's the best way to do this: either
> > 
> > 1. keep the main part of the driver with the logic as now, extracting 
> > hardware-specific parts in a separate file and linking respective 
> > functions to the main module via function pointers in an operations 
> > struct, or
> > 
> > 2. extract only the most essential and complicated logic functions into a 
> > helper library and use it for both shdma and sudmac drivers.
> > 
> > What do you think? I'd need some time to think about this and come up with 
> > a patch.
> > 
> Yes, I agree that this is probably the best way to go. The SUDMAC
> layering on top of the shdma driver is pretty nasty, as it's largely
> bypassing all of the hardware-specific bits anyways, suggesting that it
> is really better off being split out.
> 
> My initial concern was whether breaking it out would make sense or not
> given that we don't know what other DMACs will end up looking like, but
> it looks like the SUDMAC case already does a good enough job of bypassing
> all of the SH DMAC hardware bits that we more or less need a full
> abstraction for the hardware side already, making the point moot.
> 
> Splitting out the logic functions in to a helper library looks to be the
> cleanest way forward. The SUDMAC bits aren't going to make it in for 3.3
> anyways, so we do have some time/wiggle room to get this done
> cleanly/properly for 3.4.

Yeah... A library would probably be cleaner, but hardware-specific 
callbacks, like OHCI and some other drivers do it, is likely easier:-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
