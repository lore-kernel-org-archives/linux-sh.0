From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 24 Oct 2015 17:34:03 +0000
Subject: Re: [PATCH v4 5/5] [RFC] clk: shmobile: r8a7795: Add new CPG/MSSR driver
Message-Id: <CAMuHMdUyu6w0LAoH78H2+VHczrWwozDKMX2j8_A4V=jgz0snwA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<1444999760-15750-6-git-send-email-geert+renesas@glider.be>
	<20151020122448.20687.11926@quantum>
	<CAMuHMdUT=fZKCOCdkn+=grZ0wYATghQhmbX-Y6WJ9+ViZ0cidA@mail.gmail.com>
	<20151020130004.20687.91058@quantum>
	<CAMuHMdU8TqCpOskWXGPvwrejfEWSw8Fu4FjkWAKyTc0f_MuWzw@mail.gmail.com>
	<CAMuHMdW4wo0VR2GKeeXhcqwzDF7udkXapFF9fGfEQuh_vSsyoQ@mail.gmail.com>
	<20151024011003.GE19782@codeaurora.org>
In-Reply-To: <20151024011003.GE19782@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Stephen,

On Sat, Oct 24, 2015 at 3:10 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/22, Geert Uytterhoeven wrote:
>> On Tue, Oct 20, 2015 at 3:07 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > On Tue, Oct 20, 2015 at 3:00 PM, Michael Turquette
>> > <mturquette@baylibre.com> wrote:
>> >> Quoting Geert Uytterhoeven (2015-10-20 05:31:12)
>> >>> On Tue, Oct 20, 2015 at 2:24 PM, Michael Turquette
>> >>> <mturquette@baylibre.com> wrote:
>> >
>> >> The bindings should go in for 4.4, but if the driver is slated for 4.5
>> >> then can you investigate this some more? Stephen and I are on a mission
>> >> to have _real_ clk drivers.
>> >
>> > Sure, I'll have a deeper look.
>>
>> And so I did (on r8a7791/koelsch).
>>
>> As I want to have as much clock data/code __init as possible (think
>> multi-platform kernels --- pinmux data is a disaster here), I have to use
>> platform_driver_probe().
>>
>>   - Calling platform_driver_probe() from core_initcall() or postcore_initcall()
>>     is too early, as the platform device for the CPG hasn't been created yet.
>>     Hence the CPG Clock Domain isn't registered, and all devices fail to probe
>>     as they can't be attached to their Clock Domain.
>>       -> This is where the -ENOENT came from (I incorrectly assumed it came
>>          from the clock code; sorry for that), and it's converted into
>>          -EPROBE_DEFER by genpd_dev_pm_attach().
>>
>>   - Calling platform_driver_probe() from arch_initcall() is too late, as the
>>     IRQC is initialized first (it's located before the CPG in .dtsi).
>>     Hence the IRQC can't find it's Clock Domain, and its probe is deferred.
>>     IRQC will be reprobed later, but in the mean time the Ethernet PHY can't
>>     find its IRQ, as the of_mdio code uses irq_of_parse_and_map(), which
>>     plainly ignores EPROBE_DEFER :-(
>>     Nevertheless, Ethernet works...
>>
>>   - Using subsys_initcall() and later causes even more probe deferral.
>>
>> So that's why I went with CLK_OF_DECLARE() again...
>
> Understandable for the few clocks that are used by the interrupt
> controller, but for the other clocks, could those be registered
> from a real platform device driver probe path? I've been

In this particular case, that would be the IRQC module clocks and its
parent, the CP clock, which is derived directly from the external crystal.

If we ever have to do this for the GIC, that's gonna be several more
clocks (INTC-SYS / ZS / PLL1 / MAIN / external crystal).

> considering making some API that lets devices associate with the
> clocks that the file had to register with CLK_OF_DECLARE(). The
> driver would have to be builtin then (no modules) but otherwise
> we would be able to benefit from the device driver model for most
> other clocks.

To be honest, that still feels like a hack to me.

I hope dependencies and probe order, and obscure drivers not handling
deferred probe correctly, will be solved later sooner or later,
so hacks like that are no longer needed.

For new SoCs like r8a7795 we can probably just make it a real platform driver,
and make sure the irqc node is located after the cpg node in the .dtsi.

Upon second thought, that may even be feasible for existing SoCs, as
they would need a DTS update to make use of the new bindings/driver anyway,
so the irqc node can be moved at the same time. Backwards compatibility
through the old bindings/drivers would keep on using CLK_OF_DECLARE().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
