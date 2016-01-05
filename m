From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Jan 2016 21:29:55 +0000
Subject: Re: [PATCH v2 03/13] ARM: shmobile: r8a7793: add R-Car sound support to device tree
Message-Id: <20160105212954.GC5126@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1451946468-20499-1-git-send-email-horms+renesas@verge.net.au>
 <1451946468-20499-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVbExt45=sqXN-=F5sTH_v_j36Ahg-Ni=ZdVf8Fb_gLpA@mail.gmail.com>
In-Reply-To: <CAMuHMdVbExt45=sqXN-=F5sTH_v_j36Ahg-Ni=ZdVf8Fb_gLpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 05, 2016 at 10:16:04AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Jan 4, 2016 at 11:27 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Instantiate R-Car sound node in r8a7793 device tree.
> > This only supports PIO transfers.
> >
> > Based on similar work for the r8a7791 by Kuninori Morimoto.
> >
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > ---
> > v2
> > * Added audmapp
> 
> Really??
> 
> > ---
> >  arch/arm/boot/dts/r8a7793.dtsi | 83 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> > index fa8a0d772d51..90959a925edd 100644
> > --- a/arch/arm/boot/dts/r8a7793.dtsi
> > +++ b/arch/arm/boot/dts/r8a7793.dtsi
> > @@ -1101,4 +1101,87 @@
> >                 #iommu-cells = <1>;
> >                 status = "disabled";
> >         };
> > +
> > +       rcar_sound: sound@ec500000 {
> > +               /*
> > +                * #sound-dai-cells is required
> > +                *
> > +                * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
> > +                * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
> > +                */
> > +               compatible =  "renesas,rcar_sound-r8a7793", "renesas,rcar_sound-gen2";
> > +               reg =   <0 0xec500000 0 0x1000>, /* SCU */
> > +                       <0 0xec5a0000 0 0x100>,  /* ADG */
> > +                       <0 0xec540000 0 0x1000>, /* SSIU */
> > +                       <0 0xec541000 0 0x280>;  /* SSI */
> > +               reg-names = "scu", "adg", "ssiu", "ssi";
> 
> No "audmapp"...

Sorry about that, audmapp is added by another patch
"ARM: shmobile: r8a7793: enable Audio DMAC peri peri via sound driver".
