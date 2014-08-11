From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Aug 2014 01:27:21 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Add clocks to DTS
Message-Id: <20140811012717.GA25586@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1407399130-14020-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1407399130-14020-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 08, 2014 at 08:15:35PM +0900, Magnus Damm wrote:
> On Thu, Aug 7, 2014 at 5:12 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > Declares the r8a7740 clocks supported by the legacy clock framework,
> > excluding those requiring extensions to the DIV6 driver, as well as
> > the Armadillo800-specific overrides.
> >
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > ---
> >
> > Hi!
> >
> > This one omits the funky DIV6 clocks because the corresponding changes to
> > the clock driver have not been accepted yet.  It should not have any
> > negative impact on legacy support.
> 
> Hi Ulrich and Simon,
> 
> Thanks for your patch and review help. I've now spent some time giving
> a try on top of:
> 
> renesas-devel-v3.16-20140808
> [PATCH] ARM: shmobile: Partial build of pm-rmobile.c for multiplatform
> [PATCH] ARM: shmobile: r8a7740: Multiplatform support
> 
> It seems that a couple of more changes are needed for the DTS and C to
> boot the system, please see the mangled patch below for prototype
> level example code.
> 
> Basically, to be able to boot the SCIF console needs to get clocks
> assigned to it and the CMT needs to go from platform device to DT.
> Actually, most leaf node MSTP clock assignment seems to be missing. I
> maybe wrong, but I suspect some MSTP clock assignment can happen
> before the DIV6 change gets in.
> 
> Ulrich, please work together with Simon to finalize the code! It is of
> course up to you guys to decide how to split it, but perhaps Ulrich
> can handle the clock assignment for the SCIF and other devices while
> Simon gets to covert the CMT and TMU over. I've attached the
> configuration I used to test your patch on top of the two above and
> the local change below, hope it helps!
> 
> After this we need to merge the DTS for legacy and reference board
> support. And build the DTB in case of Multiplatform. Then we should be
> ready to kill of the DT reference C code. Not so far away!

Strange. Some how I missed r8a7740 when I did a sweep to enable timers
via DT. Sorry about that. I'll clean up the below a bit and submit it
as a patchset.

> 
> Cheers,
> 
> / magnus
> 
> --- 0006/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> +++ work/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> 2014-08-08 19:37:07.000000000 +0900
> @@ -191,6 +191,9 @@
>      renesas,mode = <0x05>; /* MD_CK0 | MD_CK2 */
>  };
> 
> +&cmt1 {
> +    status = "ok";
> +};
>  &i2c0 {
>      status = "okay";
>      touchscreen@55 {
> --- 0006/arch/arm/boot/dts/r8a7740.dtsi
> +++ work/arch/arm/boot/dts/r8a7740.dtsi    2014-08-08 19:36:20.000000000 +0900
> @@ -41,6 +41,18 @@
>          interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
>      };
> 
> +    cmt1: timer@e6138000 {
> +        compatible = "renesas,sh-cmt-48";
> +        reg = <0xe6138000 0x170>;
> +        interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&mstp3_clks R8A7740_CLK_CMT1>;
> +        clock-names = "fck";
> +
> +        renesas,channels-mask = <0x3f>;
> +
> +        status = "disabled";
> +    };
> +
>      /* irqpin0: IRQ0 - IRQ7 */
>      irqpin0: irqpin@e6900000 {
>          compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
> @@ -168,6 +180,8 @@
>          compatible = "renesas,scifa-r8a7740", "renesas,scifa";
>          reg = <0xe6c50000 0x100>;
>          interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&mstp2_clks R8A7740_CLK_SCIFA1>;
> +        clock-names = "sci_ick";
>          status = "disabled";
>      };
> 
> --- 0004/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7740.c    2014-08-08
> 19:40:45.000000000 +0900
> @@ -792,8 +792,10 @@ void __init r8a7740_add_early_devices(vo
> 
>  void __init r8a7740_add_standard_devices_dt(void)
>  {
> +#if 0
>      platform_add_devices(r8a7740_devices_dt,
>                  ARRAY_SIZE(r8a7740_devices_dt));
> +#endif
>      of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }


