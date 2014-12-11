From: Simon Horman <horms@verge.net.au>
Date: Thu, 11 Dec 2014 00:30:57 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: Add IPMMU-SGX clock to device tree
Message-Id: <20141211003057.GA513@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418098882-5317-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdW7htFTeaPaL+yJ3giW0oFLch_D7W9wVw7bJR95+3b_4Q@mail.gmail.com>
 <20141210002740.GF9690@verge.net.au>
In-Reply-To: <20141210002740.GF9690@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 10, 2014 at 09:27:40AM +0900, Simon Horman wrote:
> On Tue, Dec 09, 2014 at 09:59:12AM +0100, Geert Uytterhoeven wrote:
> > On Tue, Dec 9, 2014 at 5:21 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > > From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > >
> > > Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > > [horms: resolved conflicts]
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Looks OK to me...
> > 
> > > ---
> > >
> > > Based on the renesas-devel-20141209-v3.18 tag of my renesas tree
> > >
> > > * Update by Simon Horman
> > >   - Use SGX rather than GP in clock name to reflect datasheet
> > > ---
> > >  arch/arm/boot/dts/r8a7791.dtsi            | 8 +++++---
> > >  include/dt-bindings/clock/r8a7791-clock.h | 1 +
> > >  2 files changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> > > index 958a69b..78d6371 100644
> > > --- a/arch/arm/boot/dts/r8a7791.dtsi
> > > +++ b/arch/arm/boot/dts/r8a7791.dtsi
> > > @@ -1154,15 +1154,17 @@
> > >                 mstp8_clks: mstp8_clks@e6150990 {
> > >                         compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
> > >                         reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> > > -                       clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>, <&zs_clk>,
> > > -                                <&zs_clk>;
> > > +                       clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>,
> > > +                                <&zs_clk>, <&zs_clk>;
> > 
> > ... but I couldn't find the parent clock in the documentation.
> 
> I believe we can trust Kataoka-san, but I can confirm the parent clock
> with hip if you like.

I have decided to queue up this patch for v3.20.
