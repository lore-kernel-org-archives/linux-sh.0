From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Aug 2015 01:42:37 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <20150828014231.GC7357@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 01:01:50PM +0200, Geert Uytterhoeven wrote:
> On Thu, Aug 27, 2015 at 11:24 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
> > +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> > @@ -6,8 +6,12 @@ interface contains.
> >  Required properties:
> >  - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
> >               "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
> > +             "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
> >  - reg: offset and length of (1) the register block and (2) the stream buffer.
> > -- interrupts: interrupt specifier for the sole interrupt.
> > +- interrupts: if the device is a part of R8A7790/R8A7794 SoC
> > +              interrupt specifier for the sole interrupt.
> > +              if the device is a part of R8A7795 SoC
> > +              interrupt specifier for the two interrupts.
> 
> If there are multiple interrupts, you best make them named interrupts,
> i.e. requiring "interrupt-names", too.

Thanks, I will look into that.

> Why are there only 2 interrupts? The datasheet mentions 25, for ch0-ch24.

Thanks for bringing that up. I think it has also come up elsewhere in this
thread. I'd like to focus on addressing it here rather than spreading the
discussion around any further.

My understanding is that on the R-Car Gen3 r8a7795 SoC
the EthernetAVB hardware may function in one of two modes.

1. A mode which is "mostly" compatible with R-Car Gen2
   (e.g. r8a7790, r8a7790).

   In this mode only ch22 and ch24 are used.

   I note that the emac interrupt also appears to be documented for Gen-2.
   Its not clear to me at this time why it isn't appropriate to use it
   on those SoCs.

2. A mode which is new in Gen 3.

   In this mode ch0 - ch24 are used.
   I believe that in this mode there are per DMA queue interrupts.


