From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Sep 2014 23:55:43 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: switch from scif to scifa
Message-Id: <20140917235542.GB600@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 17, 2014 at 05:40:07PM +0300, Laurent Pinchart wrote:
> Hi Wolfram,
> 
> On Tuesday 16 September 2014 18:10:37 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > SCIF and SCIFA can be plexed onto the same wires on Lager board. The
> > datasheet also describes the wires as SCIFA. So, to make use of the
> > bigger FIFOs switch to SCIFA instead.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> > 
> > Currently, I use this patch to check if the DMA RX issue is the same on SCIF
> > and SCIFA (yes, it is). However, I still think it makes sense to use the
> > bigger FIFOs. I will check this next week with Bastian's FIFO patches.
> > Until then, I send this as RFC to collect opinions speaking for/against
> > this change.
> 
> I have nothing against this change, but I believe the aliases should now be 
> serial0 and serial1 to match the legacy code (OK, that's a lame excuse, we all 
> know that I just want to change the aliases ;-)).

Thanks Laurent, I think its probably time we had that conversation again.
But I think that change can be done (or not ^) separately to this change.

As it is, I think this patch is just a little too late for v3.18.
I'll see about queuing it up for v3.19 in the not to distant future.

> >  arch/arm/boot/dts/r8a7790-lager.dts | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
> > b/arch/arm/boot/dts/r8a7790-lager.dts index 84dcafa7179b..782f0aa938b3
> > 100644
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -19,8 +19,8 @@
> >  	compatible = "renesas,lager", "renesas,r8a7790";
> > 
> >  	aliases {
> > -		serial6 = &scif0;
> > -		serial7 = &scif1;
> > +		serial6 = &scifa0;
> > +		serial7 = &scifa1;
> >  	};
> > 
> >  	chosen {
> > @@ -159,9 +159,9 @@
> >  		renesas,function = "du";
> >  	};
> > 
> > -	scif0_pins: serial0 {
> > -		renesas,groups = "scif0_data";
> > -		renesas,function = "scif0";
> > +	scifa0_pins: serial0 {
> > +		renesas,groups = "scifa0_data";
> > +		renesas,function = "scifa0";
> >  	};
> > 
> >  	ether_pins: ether {
> > @@ -174,9 +174,9 @@
> >  		renesas,function = "intc";
> >  	};
> > 
> > -	scif1_pins: serial1 {
> > -		renesas,groups = "scif1_data";
> > -		renesas,function = "scif1";
> > +	scifa1_pins: serial1 {
> > +		renesas,groups = "scifa1_data";
> > +		renesas,function = "scifa1";
> >  	};
> > 
> >  	sdhi0_pins: sd0 {
> > @@ -308,15 +308,15 @@
> >  	};
> >  };
> > 
> > -&scif0 {
> > -	pinctrl-0 = <&scif0_pins>;
> > +&scifa0 {
> > +	pinctrl-0 = <&scifa0_pins>;
> >  	pinctrl-names = "default";
> > 
> >  	status = "okay";
> >  };
> > 
> > -&scif1 {
> > -	pinctrl-0 = <&scif1_pins>;
> > +&scifa1 {
> > +	pinctrl-0 = <&scifa1_pins>;
> >  	pinctrl-names = "default";
> > 
> >  	status = "okay";
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
