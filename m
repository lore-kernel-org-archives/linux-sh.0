From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2015 13:07:31 +0000
Subject: Re: [PATCH v4 5/5] [RFC] clk: shmobile: r8a7795: Add new CPG/MSSR driver
Message-Id: <CAMuHMdU8TqCpOskWXGPvwrejfEWSw8Fu4FjkWAKyTc0f_MuWzw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<1444999760-15750-6-git-send-email-geert+renesas@glider.be>
	<20151020122448.20687.11926@quantum>
	<CAMuHMdUT=fZKCOCdkn+=grZ0wYATghQhmbX-Y6WJ9+ViZ0cidA@mail.gmail.com>
	<20151020130004.20687.91058@quantum>
In-Reply-To: <20151020130004.20687.91058@quantum>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michael Turquette <mturquette@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Mike,

On Tue, Oct 20, 2015 at 3:00 PM, Michael Turquette
<mturquette@baylibre.com> wrote:
> Quoting Geert Uytterhoeven (2015-10-20 05:31:12)
>> On Tue, Oct 20, 2015 at 2:24 PM, Michael Turquette
>> <mturquette@baylibre.com> wrote:
>> > Quoting Geert Uytterhoeven (2015-10-16 05:49:20)
>> >> +static void __init r8a7795_cpg_mssr_init(struct device_node *np)
>> >> +{
>> >> +       struct regmap *regmap;
>> >> +       u32 reg, cpg_mode;
>> >> +
>> >> +       regmap =3D syscon_regmap_lookup_by_phandle(np, "renesas,modem=
r");
>> >> +       if (IS_ERR(regmap) ||
>> >> +           of_property_read_u32_index(np, "renesas,modemr", 1, &reg)=
 ||
>> >> +           regmap_read(regmap, reg, &cpg_mode)) {
>> >> +               pr_err("%s: failed to parse renesas,modemr\n", np->fu=
ll_name);
>> >> +               return;
>> >> +       }
>> >> +
>> >> +       cpg_pll_config =3D &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_=
mode)];
>> >> +       if (!cpg_pll_config->extal_div) {
>> >> +               pr_err("%s: Prohibited setting (cpg_mode=3D0x%x)\n",
>> >> +                      __func__, cpg_mode);
>> >> +               return;
>> >> +       }
>> >> +
>> >> +       cpg_mssr_probe(np, &r8a7795_cpg_mssr_info);
>> >> +}
>> >> +CLK_OF_DECLARE(r8a7795_cpg_mssr, "renesas,r8a7795-cpg-mssr",
>> >> +              r8a7795_cpg_mssr_init);
>> >
>> > Is CLK_OF_DECLARE needed? Is it possible to make this a real
>> > platform_driver =C3=A0 la drivers/clk/qcom/gcc-apq8084.c?
>>
>> I tried making it a real platform driver, but it failed: devices that are
>> part of the Clock Domain failed to get their clock (error -2, IIRC, whic=
h is
>> -ENOENT), and thus couldn't be instantiated.
>> I didn't look deeper at that time.
>>
>> [... reading code ...]
>>
>> Aha, this may be caused by __of_clk_get_from_provider() returning
>> hardcoded -ENOENT instead of propagating the error returned by
>> __clk_create_clk()?
>
> Well the only other error thrown by __clk_create_clk is -ENOMEM, so I'm
> not sure how that would help things.

Hmm, you're right.

> The bindings should go in for 4.4, but if the driver is slated for 4.5
> then can you investigate this some more? Stephen and I are on a mission
> to have _real_ clk drivers.

Sure, I'll have a deeper look.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
