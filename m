From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 02 Feb 2015 00:58:53 +0000
Subject: Re: [PATCH 2/3 v2][RFC] ARM: shmobile: r8a7790: add SSIU/DTCP/MLM/SCU reg for Audio DMAC peri peri
Message-Id: <87zj8xf7qu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9v9f13n.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9v9f13n.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > New Audio DMAC peri peri driver requests SSIU/DTCP/MLM/SCU
> > register address.
> 
> Thanks, that's the missing piece I was looking for yesterday ;-)
> 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > v1 -> v2
> >
> >  - new patch
> >
> >  arch/arm/boot/dts/r8a7790.dtsi |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> > index ca22009..9f05f19 100644
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > @@ -373,7 +373,11 @@
> >                 compatible = "renesas,rcar-audmapp";
> >                 #dma-cells = <1>;
> >
> > -               reg = <0 0xec740000 0 0x200>;
> > +               reg = <0 0xec740000 0 0x200>,
> > +                       <0 0xec400000 0 0x10000>, /* SSIU */
> > +                       <0 0xec420000 0 0x4800>,  /* DTCP */
> > +                       <0 0xec320000 0 0x2000>,  /* MLM */
> > +                       <0 0xec300000 0 0x8800>;  /* SCU */
> 
> Please use "reg-names".
> Can we still make the name mandatory for the first range, or do we have
> to support an anonymous first range for backwards compatibility?

If we use "reg-names" for SSIU/DTCP/MLM/SCU, we need to add reg-name for 1st one.
This rcar-audmapp is registered on DTSI, but, noone is using it (because of sound driver).
So, I think we don't need to keep compatibility :P

Best regards
---
Kuninori Morimoto
