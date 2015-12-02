From: Simon Horman <horms@verge.net.au>
Date: Wed, 02 Dec 2015 00:54:02 +0000
Subject: Re: [PATCH] dmaengine: usb-dmac: Document SoC specific bindings
Message-Id: <20151202005402.GM27457@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1448331641-21758-1-git-send-email-horms+renesas@verge.net.au>
 <20151124201655.GA23437@rob-hp-laptop>
 <20151125002032.GF20596@verge.net.au>
 <20151201064726.GJ16260@verge.net.au>
 <CAMuHMdWF25z0m09QxbFyLDJZ6gZt-fscsi=2H3Ss3GZbVbS1Eg@mail.gmail.com>
In-Reply-To: <CAMuHMdWF25z0m09QxbFyLDJZ6gZt-fscsi=2H3Ss3GZbVbS1Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Tue, Dec 01, 2015 at 09:33:09AM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 1, 2015 at 7:47 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Nov 25, 2015 at 09:20:32AM +0900, Simon Horman wrote:
> >> On Tue, Nov 24, 2015 at 02:16:55PM -0600, Rob Herring wrote:
> >> > On Tue, Nov 24, 2015 at 11:20:41AM +0900, Simon Horman wrote:
> >> > > In general Renesas hardware is not documented to the extent where the
> >> > > relationship between IP blocks on different SoCs can be assumed although
> >> > > they may appear to operate the same way. Furthermore the documentation
> >> > > typically does not specify a version for individual IP blocks. For these
> >> > > reasons a convention of using the SoC name in place of a version and
> >> > > providing SoC-specific compat strings has been adopted.
> >> > >
> >> > > Although not universally liked this convention is used in the bindings for
> >> > > most drivers for Renesas hardware. The purpose of this patch is to
> >> > > update the Renesas USB DMA Controller driver to follow this convention.
> >> > >
> >> > > Cc: devicetree@vger.kernel.org
> >> > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >> > >
> >> > > ---
> >> > > * r8a7792 (R-Car V2H) is omitted as my reading of the documentation
> >> > >   is that Renesas USB-DMAC does not exist on that SoC
> >> > > * r8a7795 (R-Car H2) is omitted as its unclear to me on the compatibility
> >> > >   of USB-DMAC that SoC
> >> > >
> >> > > * Once this has been merged I intend to provide follow-up patches
> >> > >   to use these new compat strings in the relevant dtsi files.
> >> > > ---
> >> > >  Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt | 9 +++++++--
> >> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> >> > >
> >> > > diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
> >> > > index 040f365954cc..3bb624e10615 100644
> >> > > --- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
> >> > > +++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
> >> > > @@ -1,7 +1,12 @@
> >> > >  * Renesas USB DMA Controller Device Tree bindings
> >> > >
> >> > >  Required Properties:
> >> > > -- compatible: must contain "renesas,usb-dmac"
> >> > > +- compatible: "renesas,usb-dmac-<soctype>", "renesas,usb-dmac" as fallback.
> >> > > +       Examples with soctypes are:
> >> > > +         - "renesas,usb-dmac-r8a7790" (R-Car H2)
> >> > > +         - "renesas,usb-dmac-r8a7791" (R-Car M2-W)
> >> > > +         - "renesas,usb-dmac-r8a7793" (R-Car M2-N)
> >> > > +         - "renesas,usb-dmac-r8a7794" (R-Car E2)
> >> >
> >> > Weren't you changing the order of SoC and block names on new bindings?
> >>
> >> Could you clarify what the desired order is?
> >> My intention is for these bindings to use the preferred order.
> >
> > ping
> 
> Not speaking for Rob, but I think he means e.g. "renesas,r8a7790-usb-dmac".

Thanks. Reviewing previous emails I see that now.
I will see about making it so.
