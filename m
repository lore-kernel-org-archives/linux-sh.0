From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 20 Jun 2014 13:32:14 +0000
Subject: Re: [PATCH/RFC 1/2] spi: sh-msiof: Add DT support to DMA setup
Message-Id: <20140620133214.GM30188@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <1403259638-13774-1-git-send-email-geert+renesas@glider.be>
 <1403259638-13774-2-git-send-email-geert+renesas@glider.be>
 <20140620125259.GL30188@leverpostej>
 <CAMuHMdV97sXuS6JyPTwgv7i73F4fupQkamAyuQfG78SrihoiKQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV97sXuS6JyPTwgv7i73F4fupQkamAyuQfG78SrihoiKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Jun 20, 2014 at 02:18:31PM +0100, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> On Fri, Jun 20, 2014 at 2:52 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Jun 20, 2014 at 11:20:37AM +0100, Geert Uytterhoeven wrote:
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> The format of the DMA specifiers depends on the DT bindings for SHDMA,
> >> which are still under development.
> >>
> >>  Documentation/devicetree/bindings/spi/sh-msiof.txt | 17 +++++++++++++--
> >>  drivers/spi/spi-sh-msiof.c                         | 25 ++++++++++++++++------
> >>  2 files changed, 33 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
> >> index f24baf3b6cc1..fc56e312c0bc 100644
> >> --- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
> >> +++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
> >> @@ -7,7 +7,13 @@ Required properties:
> >>                        Examples with soctypes are:
> >>                        "renesas,msiof-r8a7790" (R-Car H2)
> >>                        "renesas,msiof-r8a7791" (R-Car M2)
> >> -- reg                  : Offset and length of the register set for the device
> >> +- reg                  : A list of offsets and lengths of the register sets for
> >> +                      the device.
> >> +                      If only one register set is present, it is to be used
> >> +                      by both the CPU and the DMA engine.
> >> +                      If two register sets are present, the first is to be
> >> +                      used by the CPU, and the second is to be used by the
> >> +                      DMA engine.
> >
> > I'm missing something here. I'm we're providing the DMA engines through
> > DMA specifiers below, then why do we need the DMA engine address here?
> > Surely they're separate device nodes?
> 
> It's not the DMA engine address, but the second bank of MSIOF addresses.
> 
> The MSIOF has two (identical) sets of register banks: the first one is to
> be accessed by the CPU, the second one (actually only the Transmit FIFO
> and Receive FIFO Data Registers) is to be accessed by the DMA engine.

Ah, I see. Thanks for the clarification.

> > The code update doesn't seem to do anything with the additional reg
> > entry.
> 
> Indeed, as the second bank of registers is already used by spi-sh-msiof.c
> for the non-DT DMA case. Register banks are resources, so they're
> already present in non-DT platform devices.

Ok. That makes sense then.

Cheers,
Mark.
