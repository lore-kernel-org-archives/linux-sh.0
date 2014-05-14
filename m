From: Simon Horman <horms@verge.net.au>
Date: Wed, 14 May 2014 23:11:10 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740 dtsi: Remove duplicate interrupt-parent property
Message-Id: <20140514231109.GC29233@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1400078472-4630-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1400078472-4630-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 14, 2014 at 04:44:02PM +0200, Laurent Pinchart wrote:
> On Wednesday 14 May 2014 16:41:12 Geert Uytterhoeven wrote:
> > Caused by interaction between commit
> > 08ec67b50db7ca8c9077e67ca23850cdc5bfc716 ("ARM: shmobile: r8a7740 dtsi:
> > Add Ethernet support") and commit 9ff254adc1e32db46000a33b8ecbc4d7047672be
> > ("ARM: shmobile: dts: Move interrupt-parent property to root node").
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> > Can this still be folded into the latter commit?
> 
> I'll let Simon decide, I'm fine with both.

I would prefer to take this as in incremental change as
* It seems to reduce the scope for error on my part and;
* It avoids rebasing branches that I have already pushed

As such I have queued up this patch with Laurent's Ack.

> 
> >  arch/arm/boot/dts/r8a7740.dtsi |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> > index ce7a0b29ae7c..55d29f4d2ed6 100644
> > --- a/arch/arm/boot/dts/r8a7740.dtsi
> > +++ b/arch/arm/boot/dts/r8a7740.dtsi
> > @@ -124,7 +124,6 @@
> >  		compatible = "renesas,gether-r8a7740";
> >  		reg = <0xe9a00000 0x800>,
> >  		      <0xe9a01800 0x800>;
> > -		interrupt-parent = <&gic>;
> >  		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
> >  		/* clocks = <&mstp3_clks R8A7740_CLK_GETHER>; */
> >  		phy-mode = "mii";
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
