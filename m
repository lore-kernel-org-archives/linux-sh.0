From: Michael Turquette <mturquette@baylibre.com>
Date: Tue, 20 Oct 2015 12:24:48 +0000
Subject: Re: [PATCH v4 5/5] [RFC] clk: shmobile: r8a7795: Add new CPG/MSSR driver
Message-Id: <20151020122448.20687.11926@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
 <1444999760-15750-6-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444999760-15750-6-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

Hi Geert,

Quoting Geert Uytterhoeven (2015-10-16 05:49:20)
> +static void __init r8a7795_cpg_mssr_init(struct device_node *np)
> +{
> +       struct regmap *regmap;
> +       u32 reg, cpg_mode;
> +
> +       regmap =3D syscon_regmap_lookup_by_phandle(np, "renesas,modemr");
> +       if (IS_ERR(regmap) ||
> +           of_property_read_u32_index(np, "renesas,modemr", 1, &reg) ||
> +           regmap_read(regmap, reg, &cpg_mode)) {
> +               pr_err("%s: failed to parse renesas,modemr\n", np->full_n=
ame);
> +               return;
> +       }
> +
> +       cpg_pll_config =3D &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode=
)];
> +       if (!cpg_pll_config->extal_div) {
> +               pr_err("%s: Prohibited setting (cpg_mode=3D0x%x)\n",
> +                      __func__, cpg_mode);
> +               return;
> +       }
> +
> +       cpg_mssr_probe(np, &r8a7795_cpg_mssr_info);
> +}
> +CLK_OF_DECLARE(r8a7795_cpg_mssr, "renesas,r8a7795-cpg-mssr",
> +              r8a7795_cpg_mssr_init);

Is CLK_OF_DECLARE needed? Is it possible to make this a real
platform_driver =C3=A0 la drivers/clk/qcom/gcc-apq8084.c?

Sorry if I already asked this in a previous version, but a quick search
of my email didn't reveal anything.

Regards,
Mike

> --=20
> 1.9.1
>=20
