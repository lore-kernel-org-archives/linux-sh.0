From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 29 Aug 2015 09:32:10 +0000
Subject: Re: [PATCH v4 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <CANqRtoTCoONvfbwoTVQpcoPFhiQrj9iWFqM65Rh4Lo9HE4hcaw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150829091323.28546.28287.sendpatchset@little-apple>
	<20150829091346.28546.42552.sendpatchset@little-apple>
In-Reply-To: <20150829091346.28546.42552.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk <linux-clk@vger.kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, SH-Linux <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>

On Sat, Aug 29, 2015 at 6:13 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
> This patch adds initial CPG support for R-Car Generation 3 and in
> particular the R8A7795 SoC.
>
> The R-Car Gen3 clock hardware has a register write protection feature that
> needs to be shared between the CPG function needs to be shared between
> the CPG and MSTP hardware somehow. So far this feature is simply ignored.
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  Changes since V3: (Magnus Damm <damm+renesas@opensource.se>)
>  - Reworked driver to incorporate most feedback from Stephen Boyd - thanks!!
>  - Major things like syscon and driver model require more discussion.
>  - Added hunk to build drivers/clk/shmobile if ARCH_RENESAS is set.
>
>  Changes since V2: (Magnus Damm <damm+renesas@opensource.se>)
>  - Reworked driver to rely on clock index instead of strings.
>  - Dropped use of "clock-output-names".
>
>  Earlier versions: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>  Initial version: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
>  Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   31 +
>  drivers/clk/Makefile                                                     |    1
>  drivers/clk/shmobile/Makefile                                            |    1
>  drivers/clk/shmobile/clk-rcar-gen3.c                                     |  249 ++++++++++
>  4 files changed, 282 insertions(+)
>
> --- /dev/null
> +++ work/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt       2015-08-29 16:23:54.982366518 +0900
> @@ -0,0 +1,31 @@
> +* Renesas R-Car Gen3 Clock Pulse Generator (CPG)
> +
> +The CPG generates core clocks for the R-Car Gen3 SoCs. It includes three PLLs
> +and several fixed ratio dividers.
> +
> +Required Properties:
> +
> +  - compatible: Must be one of
> +    - "renesas,r8a7795-cpg-clocks" for the r8a7795 CPG
> +    - "renesas,rcar-gen3-cpg-clocks" for the generic R-Car Gen3 CPG
> +
> +  - reg: Base address and length of the memory resource used by the CPG
> +
> +  - clocks: References to the parent clocks: first to the EXTAL clock
> +  - #clock-cells: Must be 1
> +  - clock-output-names: The names of the clocks. Supported clocks are
> +    "main", "pll0", "pll1", "pll2", "pll3", "pll4"
> +
> +
> +Example
> +-------
> +
> +       cpg_clocks: cpg_clocks@e6150000 {
> +               compatible = "renesas,r8a7795-cpg-clocks",
> +                            "renesas,rcar-gen3-cpg-clocks";
> +               reg = <0 0xe6150000 0 0x1000>;
> +               clocks = <&extal_clk>;
> +               #clock-cells = <1>;
> +               clock-output-names = "main", "pll0", "pll1","pll2",
> +                                    "pll3", "pll4";
> +       };

Seems that I forgot update the DT binding bits. Will fix in next verison.

Thanks,

/ magnus
