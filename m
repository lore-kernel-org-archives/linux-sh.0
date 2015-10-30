From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 30 Oct 2015 15:47:51 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <1457864.DILdaN6aDz@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Monday 26 October 2015 14:50:08 Simon Horman wrote:
> On Fri, Oct 23, 2015 at 03:37:46PM +0300, Laurent Pinchart wrote:
> > On Thursday 15 October 2015 16:59:18 Simon Horman wrote:
> >> On Thu, Oct 15, 2015 at 09:09:13AM +0200, Geert Uytterhoeven wrote:
> >>> On Thu, Oct 15, 2015 at 8:59 AM, Simon Horman wrote:
> >>>> --- /dev/null
> >>>> +++ b/drivers/misc/boot-mode-reg/rcar-gen2.c
> >>>> @@ -0,0 +1,61 @@
> >>>> +/*
> >>>> + * R-Car Gen2 Boot Mode Register Driver
> >>>> 
> >>>> +#define MODEMR 0xe6160060
> >>> 
> >>> Shouldn't this come from DT?
> >> 
> >> If its a property of the SoC then I'm not sure that it needs to as its a
> >> known value for the supported SoCs.
> > 
> > Hypervisors (at least Xen) use DT to initialize memory mappings. I believe
> > we should thus describe the RST IP in DT and create an rcar-rst driver
> > that includes the code from this patch.
> 
> So we would add a binding, say a compat string and a register range.
> That might look like this:
> 
> 	rst: reset-controller@e6160000 {
> 		compatible = "renesas,rst-r8a7795", "syscon";
> 		reg = <0 0xe6160000 0 0x0200>;
> 	};
> 
> The above is copped from Geerts earlier work
> "[PATCH 1/6]  reset: Add renesas,rst DT bindings"
> 
> http://www.spinics.net/lists/linux-sh/msg44800.html:
> 
> Is that binding what we are after?

That's exactly it, except that as we'll have a proper API to retrieve the boot 
mode we won't need the "syscon" compatible string.

> Would the driver do anything beyond what it currently does + using an offset
> to the base of its register range instead of the hardcoded MODEMR value (and
> changes discussed elswhere in this thread, e.g. to use soemthing like
> CLK_OF_DECLARE) ?

It should handle CPU reset in the future, but for now your description is all 
that would need to be implemented.

-- 
Regards,

Laurent Pinchart

