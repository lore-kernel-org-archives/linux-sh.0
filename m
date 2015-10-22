From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Oct 2015 12:58:11 +0000
Subject: Re: [PATCH v4 5/5] [RFC] clk: shmobile: r8a7795: Add new CPG/MSSR driver
Message-Id: <CAMuHMdW4wo0VR2GKeeXhcqwzDF7udkXapFF9fGfEQuh_vSsyoQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<1444999760-15750-6-git-send-email-geert+renesas@glider.be>
	<20151020122448.20687.11926@quantum>
	<CAMuHMdUT=fZKCOCdkn+=grZ0wYATghQhmbX-Y6WJ9+ViZ0cidA@mail.gmail.com>
	<20151020130004.20687.91058@quantum>
	<CAMuHMdU8TqCpOskWXGPvwrejfEWSw8Fu4FjkWAKyTc0f_MuWzw@mail.gmail.com>
In-Reply-To: <CAMuHMdU8TqCpOskWXGPvwrejfEWSw8Fu4FjkWAKyTc0f_MuWzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michael Turquette <mturquette@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Mike,

On Tue, Oct 20, 2015 at 3:07 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Oct 20, 2015 at 3:00 PM, Michael Turquette
> <mturquette@baylibre.com> wrote:
>> Quoting Geert Uytterhoeven (2015-10-20 05:31:12)
>>> On Tue, Oct 20, 2015 at 2:24 PM, Michael Turquette
>>> <mturquette@baylibre.com> wrote:
>>> > Quoting Geert Uytterhoeven (2015-10-16 05:49:20)
>>> >> +static void __init r8a7795_cpg_mssr_init(struct device_node *np)
>>> >> +{
>>> >> +       struct regmap *regmap;
>>> >> +       u32 reg, cpg_mode;
>>> >> +
>>> >> +       regmap =3D syscon_regmap_lookup_by_phandle(np, "renesas,mode=
mr");
>>> >> +       if (IS_ERR(regmap) ||
>>> >> +           of_property_read_u32_index(np, "renesas,modemr", 1, &reg=
) ||
>>> >> +           regmap_read(regmap, reg, &cpg_mode)) {
>>> >> +               pr_err("%s: failed to parse renesas,modemr\n", np->f=
ull_name);
>>> >> +               return;
>>> >> +       }
>>> >> +
>>> >> +       cpg_pll_config =3D &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg=
_mode)];
>>> >> +       if (!cpg_pll_config->extal_div) {
>>> >> +               pr_err("%s: Prohibited setting (cpg_mode=3D0x%x)\n",
>>> >> +                      __func__, cpg_mode);
>>> >> +               return;
>>> >> +       }
>>> >> +
>>> >> +       cpg_mssr_probe(np, &r8a7795_cpg_mssr_info);
>>> >> +}
>>> >> +CLK_OF_DECLARE(r8a7795_cpg_mssr, "renesas,r8a7795-cpg-mssr",
>>> >> +              r8a7795_cpg_mssr_init);
>>> >
>>> > Is CLK_OF_DECLARE needed? Is it possible to make this a real
>>> > platform_driver =C3=A0 la drivers/clk/qcom/gcc-apq8084.c?
>>>
>>> I tried making it a real platform driver, but it failed: devices that a=
re
>>> part of the Clock Domain failed to get their clock (error -2, IIRC, whi=
ch is
>>> -ENOENT), and thus couldn't be instantiated.
>>> I didn't look deeper at that time.
>>>
>>> [... reading code ...]
>>>
>>> Aha, this may be caused by __of_clk_get_from_provider() returning
>>> hardcoded -ENOENT instead of propagating the error returned by
>>> __clk_create_clk()?
>>
>> Well the only other error thrown by __clk_create_clk is -ENOMEM, so I'm
>> not sure how that would help things.
>
> Hmm, you're right.
>
>> The bindings should go in for 4.4, but if the driver is slated for 4.5
>> then can you investigate this some more? Stephen and I are on a mission
>> to have _real_ clk drivers.
>
> Sure, I'll have a deeper look.

And so I did (on r8a7791/koelsch).

As I want to have as much clock data/code __init as possible (think
multi-platform kernels --- pinmux data is a disaster here), I have to use
platform_driver_probe().

  - Calling platform_driver_probe() from core_initcall() or postcore_initca=
ll()
    is too early, as the platform device for the CPG hasn't been created ye=
t.
    Hence the CPG Clock Domain isn't registered, and all devices fail to pr=
obe
    as they can't be attached to their Clock Domain.
      -> This is where the -ENOENT came from (I incorrectly assumed it came
         from the clock code; sorry for that), and it's converted into
         -EPROBE_DEFER by genpd_dev_pm_attach().

  - Calling platform_driver_probe() from arch_initcall() is too late, as the
    IRQC is initialized first (it's located before the CPG in .dtsi).
    Hence the IRQC can't find it's Clock Domain, and its probe is deferred.
    IRQC will be reprobed later, but in the mean time the Ethernet PHY can't
    find its IRQ, as the of_mdio code uses irq_of_parse_and_map(), which
    plainly ignores EPROBE_DEFER :-(
    Nevertheless, Ethernet works...

  - Using subsys_initcall() and later causes even more probe deferral.

So that's why I went with CLK_OF_DECLARE() again...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
