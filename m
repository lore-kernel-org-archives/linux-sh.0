From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Jan 2016 12:09:44 +0000
Subject: Re: [PATCH 2/4] ARM64: renesas: r8a7795: Add VSP instances
Message-Id: <CAMuHMdWyciDm=UWMCm-QqqyUM7=dnnabdL4-1ym=cDriwqSi8Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450336895-4279-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1450336895-4279-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Sun, Dec 27, 2015 at 9:20 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 22 December 2015 14:43:34 Geert Uytterhoeven wrote:
>> On Thu, Dec 17, 2015 at 8:21 AM, Laurent Pinchart wrote:
>> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> > b/arch/arm64/boot/dts/renesas/r8a7795.dtsi index
>> > 9ce6a5ea6629..47f97ffc6c8b 100644
>> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> > @@ -775,5 +775,119 @@
>> >                         clocks = <&cpg CPG_MOD 915>;
>> >                         status = "disabled";
>> >                 };
>> > +
>> > +               vspbc: vsp@fe920000 {
>> > +                       compatible = "renesas,vsp2";
>> > +                       reg = <0 0xfe920000 0 0x8000>;
>> > +                       interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
>> > +                       clocks = <&cpg CPG_MOD 624>;
>>
>> No "power-domains = <&cpg_clocks>;"?
>> Each vsp device node corresponds nicely to one vsp module, and the driver
>> doesn't care at all about the clock, except for (explicit) PM of the vsp
>> modules.
>>
>> That would allow to simplify vsp1_device_get(), vsp1_pm_suspend(), and
>> vsp1_pm_resume(), and get rid of vsp1_device_put() in favor of
>> pm_runtime_put().
>
> I'm all for simplification :-) I'll try to find time to move the driver to
> runtime PM. What will happen if the power domain is specified in DT but the

Thanks!

> driver doesn't use runtime PM yet ?

The device will be added to the PM Domain, but the PM Domain will not be
turned on, and the gpd_dev_ops.start() callback will never be called for the
device. You need to call pm_runtime_enable() and pm_runtime_get_sync() to
do that.

The CPG/MSSR PM Domain is a Clock Domain, so the driver can choose to manage
the device's modulo clock itself instead of relying on the gpd_dev_ops.start()
callback. But if a VSP IP core ever ends up in an SoC with a hardware Power
Domain[*], the hardware Power Domain may not be managed correctly.
Unlike for clocks, you cannot escape proper Runtime PM when dealing with
hardware Power Domains ;-)

Note that the vsp nodes in r8a7790.dtsi and r8a7791.dtsi already have
power-domains properties.

[*] Is VSP1 in R-Mobile APE6, which has hardware Power Domains) compatible
    with VSP1 in R-Car Gen2?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
