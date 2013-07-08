From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Jul 2013 10:46:25 +0000
Subject: Re: [PATCH/RFC v2 4/4] ARM: shmobile: APE6EVM-reference: add ethernet support
Message-Id: <Pine.LNX.4.64.1307081237000.19819@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1373038006-19973-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373038006-19973-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent

On Mon, 8 Jul 2013, Laurent Pinchart wrote:

> Hi Magnus and Guennadi,
> 
> On Monday 08 July 2013 12:44:26 Magnus Damm wrote:
> > Hi Guennadi,
> > 
> > [CC Laurent]
> > 
> > On Sat, Jul 6, 2013 at 12:26 AM, Guennadi Liakhovetski wrote:
> > > Add SMSC9220 support to APE6EVM-reference. Since pinctrl configuration is
> > > not yet available in DT, temporarily add pin configuration in C. Similarly
> > > PHY reset has to be done in C.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > ---
> > > 
> > > Marked "RFC," because it configures pinmux and requests a GPIO in C. If
> > > undesired this patch can just be left out until DT pinctrl configuration
> > > is available on mach-shmobile.
> > > 
> > >  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   21 +++++++++++++++++
> > >  arch/arm/mach-shmobile/board-ape6evm-reference.c |    6 ++++++
> > >  2 files changed, 27 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> > > b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts index aa84b09..ea386fe
> > > 100644
> > > --- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> > > +++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> > > @@ -24,11 +24,32 @@
> > >                 reg = <0 0x40000000 0 0x40000000>;
> > >         };
> > > 
> > > +       ape6evm_fixed_3v3: fixedregulator@0 {
> > > +               compatible = "regulator-fixed";
> > > +               regulator-name = "3V3";
> > > +               regulator-min-microvolt = <3300000>;
> > > +               regulator-max-microvolt = <3300000>;
> > > +               regulator-always-on;
> > > +       };
> > > +
> > > 
> > >         lbsc {
> > >         
> > >                 compatible = "simple-bus";
> > >                 #address-cells = <1>;
> > >                 #size-cells = <1>;
> > >                 ranges = <0 0 0 0x80000000>;
> > > 
> > > +
> > > +               ethernet@8000000 {
> > > +                       compatible = "smsc,lan9118", "smsc,lan9115";
> > > +                       reg = <0x08000000 0x1000>;
> > > +                       interrupt-parent = <&irqc1>;
> > > +                       interrupts = <8 0x4>;
> > > +                       phy-mode = "mii";
> > > +                       reg-io-width = <4>;
> > > +                       smsc,irq-active-high;
> > > +                       smsc,irq-push-pull;
> > > +                       vdd33a-supply = <&ape6evm_fixed_3v3>;
> > > +                       vddvario-supply = <&ape6evm_fixed_3v3>;
> > > +               };
> > > 
> > >         };
> > >  
> > >  };
> > > 
> > > diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c
> > > b/arch/arm/mach-shmobile/board-ape6evm-reference.c index ee9f75d..909c1bc
> > > 100644
> > > --- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
> > > +++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
> > > @@ -32,6 +32,9 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] > > > {
> > >         /* SCIFA0 console */
> > >         PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
> > >                                   "scifa0_data", "scifa0"),
> > > +       /* SMSC */
> > > +       PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a73a4",
> > > +                                 "irqc_irq40", "irqc"),
> > >  };
> > >  
> > >  static void __init ape6evm_add_standard_devices(void)
> > > @@ -57,6 +60,9 @@ static void __init ape6evm_add_standard_devices(void)
> > >         r8a73a4_add_aux_devices_dt();
> > >         of_platform_populate(NULL, of_default_bus_match_table, NULL,
> > >         NULL);
> > >         r8a73a4_add_cpufreq_device_dt();
> > > +
> > > +       /* LAN9220 ethernet */
> > > +       gpio_request_one(270, GPIOF_OUT_INIT_HIGH, NULL); /* smsc9220
> > > RESET */
> >
> > Can you please collaborate with Laurent to figure out how to handle
> > this RESET signal in DT-only?
> 
> In a nutshell, we need to 
> 
> - add reset_gpio and reset_polarity fields (name may vary) to struct 
> smsc911x_platform_config (include/linux/smsc911x.h)
> 
> - add a reset-gpios property to the smsc911x DT bindings 
> (Documentation/devicetree/bindings/net/smsc911x.txt)

been there, done that (for sh_eth):

http://thread.gmane.org/gmane.linux.ports.sh.devel/18859

It didn't go anywhere. My current status is - I have no idea what 
networking people assume is the right way to reset ethernet phys.

Thanks
Guennadi

> 
> - update the smsc911x to register the GPIO if specified in platform data or DT
> 
> - rebase this patch to use the reset-gpios property
> 
> The first three item can be squashed in a single patch.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
