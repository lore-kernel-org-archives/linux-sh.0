From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Sep 2015 08:09:07 +0000
Subject: Re: [PATCH/RFC v2 3/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <20150911080906.GB2835@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1441936996-18437-4-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1441936996-18437-4-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 11, 2015 at 09:25:54AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Sep 11, 2015 at 4:03 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> > @@ -41,6 +41,11 @@
> >                 renesas,groups = "scif2_data_a";
> >                 renesas,function = "scif2";
> >         };
> > +
> > +       avb_pins: avb {
> > +               renesas,groups = "avb_mdc";
> > +               renesas,function = "avb";
> > +       };
> 
> This is not in pfc-r8a7795.c. I believe you using CONFIG_PINCTRL=n with
> the bootloader settings?

With regards to the settings: It looks like CONFIG_PINCTRL and
CONFIG_PINCTRL_PFC_R8A7795 were both enabled for my most recent test.
A bit curious.

Regardless, I agree that the above is missing from pfc-r8a7795.c.
I can take a look at creating a PFC patch unless someone else wants to.
