From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 07 Jan 2013 22:27:34 +0000
Subject: Re: [PATCH 3/9] ARM: shmobile: r8a7740: Add pin control device in device tree
Message-Id: <1597854.7tlxY6Dl9J@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1357260060-32164-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357260060-32164-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Friday 04 January 2013 17:10:05 Guennadi Liakhovetski wrote:
> Hi Laurent
> 
> Thanks for patches!
> 
> On Fri, 4 Jan 2013, Laurent Pinchart wrote:
> > Add a pfc node in the r8a7740 device tree.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  arch/arm/boot/dts/r8a7740.dtsi |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7740.dtsi
> > b/arch/arm/boot/dts/r8a7740.dtsi index 798fa35..9586d66 100644
> > --- a/arch/arm/boot/dts/r8a7740.dtsi
> > +++ b/arch/arm/boot/dts/r8a7740.dtsi
> > @@ -18,4 +18,10 @@
> >  			compatible = "arm,cortex-a9";
> >  		};
> >  	};
> > +
> > +	gpio: pfc@e6050000 {
> > +		compatible = "renesas,pfc-r8a7740";
> > +		reg = <0xe6050000 0x8000>,
> > +		      <0xe605800c 0x20>;
> 
> isn't
> 
> +		#gpio-cells = <2>;
> 
> missing here?

Oops, indeed. And gpio-controller; as well. I'll add both. Thanks for the 
report.

> > +	};
> > 
> >  };

-- 
Regards,

Laurent Pinchart

