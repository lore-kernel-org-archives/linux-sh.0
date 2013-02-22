From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 22 Feb 2013 12:51:31 +0000
Subject: Re: [PATCH 1/3] serial: sh-sci: Add Device Tree probing
Message-Id: <20130222125131.GB10147@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1361298586-30357-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1361298586-30357-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Bastian,

On Thu, Feb 21, 2013 at 12:11:58PM -0600, Bastian Hecht wrote:
> 2013/2/21 Paul Mundt <lethal@linux-sh.org>:
> > So something along the lines of:
> >         renesas,sci-<port type>
> >
> > with or without a trailing -uart should work fine.
> 
> Ok so I use
> - compatible : Should be "renesas,sci-<port type>-uart", where <port
> type> may be
>   SCI, SCIF, IRDA, SCIFA or SCIFB.
> 
> I will forward the type using the .data field as suggested.
> 
Ok.

> Further I introduce an optional regtype property
> - regtype : Overwrite the register layout. Some hardware versions use
> a non-default register layout. Possible layouts are
>   0 = SCIx_SH2_SCIF_FIFODATA_REGTYPE
>   1 = SCIx_SH3_SCIF_REGTYPE
>   2 = SCIx_SH4_SCIF_REGTYPE
>   3 = SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE
>   4 = SCIx_SH4_SCIF_FIFODATA_REGTYPE
>   5 = SCIx_SH7705_SCIF_REGTYPE
> 
> Are the enum names good or should it be like "0 =  SH hardware version
> 2 SCIF using FIFODATA"?
> 
The enum names should be fine. I admit they aren't the most descriptive,
but they're the best I could come up with on short notice, and any new
SoC implementor should be able to easily figure it out by looking at the
driver.

> Further I'll add the fields
> - scscr : Should contain a bitfield used by the Serial Control Register.
>   b0 = SCSCR_TIE
>   b1 = SCSCR_RIE
>   b2 = SCSCR_TE
>   b3 = SCSCR_RE
>   b4 = SCSCR_REIE
>   b5 = SCSCR_TOIE
>   b6 = SCSCR_CKE1
>   b7 = SCSCR_CKE0
> - scbrr-algo-id : Algorithm ID for the Bit Rate Register
>   1 = ((clk + 16 * bps) / (16 * bps) - 1)
>   2 = ((clk + 16 * bps) / (32 * bps) - 1)
>   3 = (((clk * 2) + 16 * bps) / (16 * bps) - 1)
>   4 = (((clk * 2) + 16 * bps) / (32 * bps) - 1)
>   5 = (((clk * 1000 / 32) / bps) - 1)
> 
Ok.

> What I am unsure about is how to deal with the .flags field. There are
> 28 different possible UPF_* flags. Should I just add
> - ioremap : Set this flag if I/O should be remapped.
> - autoconf : Set if device is capable of auto configuration.
> 
I guess the thing you have to figure out is whether it's sane to support
non-remapped cases for the ARM side or not. On the SH side we can handle
unconditional ioremap, even in the 1:1 case, but traditionally we didn't
use it, so it was always an optional thing.

If it simplifies things for you to say that DT use implies UPF_IOREMAP,
that should be fine. How do other platforms deal with UPF flags?

> > I don't think the two are at odds. We already have an abstraction in
> > place for dealing with this information, and it does need to be
> > provideded by the platform. Hacking it in to the serial driver is not an
> > acceptable solution, simply because you happen to be using the device
> > tree.
> 
> Ok so if this is the philosophy to go, I will throw my idea over board
> to store setup data in the driver.
> 
> > If it's really the case that you can use one or two definitions on all of
> > the boards, then it should be no problem having a tiny .dtsi file with
> > these definitions that you include in the platform's .dts file.
> 
> Ok I get the idea.
> 
> >> If I don't get something wrong, Magnus prefers to use the .data field
> >> of the struct of_device_id to hide SoC specific parts from the
> >> external visible bindings, if there is only 1 legal way to setup the
> >> device. I personally prefer the .data way - but I don't want to be a
> >> 3rd person joining the discussion. I'd prefer a decision. So please
> >> Magnus, comment on this issue. I have no problem going either way.
> >>
> > I don't have any strong opinions on how .data gets used, but we will not
> > be applying anything that adds arbitrary plat_sci_port definitions to the
> > driver, as that is nothing but lazy and shortsighted.
> 
> Uhmm... if you insist keep the "shortsighted", but I would replace the
> laziness with "lack of experience".
> I coded it the way I did because I thought it's the cleanest solution
> - but I'm willing to learn.

I apologize if I seem a bit abrupt over this matter, but it's a road that
we have been down with this driver before, and it's taken years to get
away from that model and in to something more flexible. I don't expect
you to be fully aware of the history, so this wasn't directed at you
specifically so much as just the general approach. Magnus should of
course know better, but that's another matter entirely.

Originally there were only a couple of variants, which meant that the
port definitions were all managed in the driver, this eventually
spiralled out of control with well over 50 variants all with subtle
differences (across roughly double the amount of CPU variations, and half
a dozen diffferent architectures) that pretty much ensured any minor
change would break all over the place, ultimately leaving me to clean it
up (the bulk of this was in 2.4 and later 2.5 after the serial core was
introduced and the driver rewritten). After 10+ years of that, I'm
somewhat less than enthusiastic to begin down the same path again for the
same rationale. Even now, we're still not completely rid of the past
disaster, given that drivers/tty/serial/sh-sci.h still exists, despite
several rewrites.

In any event, I do believe we can come up with a good match for the
driver and the bindings, while keeping complexity to a minimum by virtue
of being able to ignore much of the legacy stuff. It will also be
interesting to see how the pinctrl/pinconf and DMA stuff ties in under
the DT model, but one thing at a time.
