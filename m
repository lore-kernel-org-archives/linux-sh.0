From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Nov 2015 11:24:19 +0000
Subject: Probe deferral and R-Car Gen2 regulator quirk (Re: [PATCH v4 5/5] [RFC] clk: shmobile: r8a7795: Add 
Message-Id: <CAMuHMdVYaDzmoM5WfQEDC3qxPHngG9LWOiy3j4gRhAfut68Fiw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

(reducing distribution list to linux-sh)

On Thu, Oct 29, 2015 at 3:03 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Oct 22, 2015 at 2:58 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>>   - Calling platform_driver_probe() from arch_initcall() is too late, as the
>>     IRQC is initialized first (it's located before the CPG in .dtsi).
>>     Hence the IRQC can't find it's Clock Domain, and its probe is deferred.
>>     IRQC will be reprobed later, but in the mean time the Ethernet PHY can't
>>     find its IRQ, as the of_mdio code uses irq_of_parse_and_map(), which
>>     plainly ignores EPROBE_DEFER :-(
>>     Nevertheless, Ethernet works...
>
> To correct myself: renesas-irqc is initialized first because it uses
> postcore_initcall().
>
> The of_mdio issue on R-Car Gen2 boards can be worked around by changing that
> to device_initcall(). That would cause a few more probe deferrals on R-Mobile
> APE6 (r8a73a4), where IRQC is not only the external interrupt controller,
> but also the parent interrupt controller of the PFC/GPIO combo.

This also causes a probe deferral on R-Car Gen2:

     i2c-sh_mobile e60b0000.i2c: genpd_dev_pm_attach() failed to find
PM domain: -2

So far I assumed this was harmless, but I was wrong.

The i2c bus of e60b0000.i2c contains the da9063 and da9210 regulator slaves,
which may have their interrupt lines asserted after a cold boot.

Before, regulator_quirk_notify() ran when the i2c slave devices were added,
before their slave drivers were available:
    1. i2c 6-0058: Masking da9063 interrupt sources,
    2. i2c 6-0068: Masking da9210 interrupt sources.
Later, their drivers are bound:
    3. da9063 driver binding, enable interrupt,
    4. da9210 driver binding.

Now, due to the probe deferral of the i2c bus, adding the i2c slave devices
is done after their drivers became available, and adding devices and binding
these drivers are interleaved:
  1. i2c 6-0058: Masking da9063 interrupt sources,
  2. da9063 driver binding, enable interrupt,
  3. i2c 6-0068: Masking da9210 interrupt sources,
  4. da9210 driver binding.

Hence an interrupt storm happens at step 2, until the irq subsystem decides
to mask the interrupt, and the da9210 interrupt is masked. After that the
system works again (incl. pressing the reset button), until a cold reboot
or da9063-induced restart.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
