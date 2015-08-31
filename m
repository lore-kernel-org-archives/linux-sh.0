From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Aug 2015 15:56:49 +0000
Subject: Regression due to dropping "clock-output-names" (was: Re: [PATCH v5 02/05] clk: shmobile: Add Renesa
Message-Id: <CAMuHMdWXpkiKwywgT37EP-iSc9sLOiWAjFzNeAE+T5KJzaNwfA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus, Mike, Stephen,

On Mon, Aug 31, 2015 at 2:49 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
> This V5 patch adds initial CPG support for R-Car Generation 3 and in
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
>  Changes since V4: (Magnus Damm <damm+renesas@opensource.se>)
>  - Simplified clks array handling - thanks Geert!
>  - Updated th DT binding documentation to reflect latest state
>  - of_property_count_strings() -> of_property_count_u32_elems() fix
>
>  Changes since V3: (Magnus Damm <damm+renesas@opensource.se>)
>  - Reworked driver to incorporate most feedback from Stephen Boyd - thanks!!
>  - Major things like syscon and driver model require more discussion.
>  - Added hunk to build drivers/clk/shmobile if ARCH_RENESAS is set.
>
>  Changes since V2: (Magnus Damm <damm+renesas@opensource.se>)
>  - Reworked driver to rely on clock index instead of strings.
>  - Dropped use of "clock-output-names".

Unfortunately dropping "clock-output-names" causes a regression: it turns
out all fixed-factor clocks that have <&cpg_clocks R8A7795_CLK_*> as a parent
have lost their parent clock, and have rate zero.

E.g. instead of

   clock                         enable_cnt  prepare_cnt        rate
accuracy   phase
----------------------------------------------------------------------------------------
 extal                                    1            1    16666600
   50000 0
    main                                  1            1     8333300
   50000 0
       pll1                               1            2   799996800
   50000 0
          cl                              0            0    16666600
   50000 0
          s3                              1            1   133332800
   50000 0
             s3d4                         1            2    33333200
   50000 0
                mstp3_clks.10             2            2    33333200
   50000 0

/sys/kernel/debug/clk/clk_summary now has:

   clock                         enable_cnt  prepare_cnt        rate
accuracy   phase
----------------------------------------------------------------------------------------
 extal                                    0            0    16666600
   50000 0
    main                                  0            0     8333300
   50000 0
       pll1                               0            0   799996800
   50000 0
 cl                                       0            0           0
       0 0
 s3                                       1            1           0
       0 0
    s3d4                                  1            2           0
       0 0
       mstp3_clks.10                      2            2           0
       0 0

Surprisingly, the system still works.

Several clock drivers (e.g. fixed-factor-clock) use of_clk_get_parent_name()
to find the name of the parent clock.
In the absence of "clock-output-names", this returns the name of the device
node of the parent's clock. Which is always "cpg_clocks", and no longer the
name of the clock matching the index.

I believe the same issue is present for MSTP clocks, but there we don't have
children clocks, so it doesn't manifest itself (yet).

A quick workaround is to just re-add the clock-output-names to r8a7795.dtsi:

                                clock-output-names                                         "main", "pll0", "pll1","pll2",
                                        "pll3", "pll4";

Hence it seems like dropping "clock-output-names" for clocks with multiple
outputs is not such a good idea?

See also my question in "Re: [PATCH 3/4 v3][RFC] arm64: renesas: Add initial
r8a7795 SoC support" (http://www.spinics.net/lists/linux-sh/msg44609.html):

| BTW, was "dropping clock-output-names" a general comment for all clock
| drivers, or specific to the SoC's Clock Pulse Generator?
|
| For e.g. "fixed-factor-clock", the driver falls back to using the node's
| name if  "clock-output-names" is not present.
|
| But e.g. for MSTP clocks, that can't be done, as the clocks wouldn't have
| names in that case (single node with multiple clocks). Unless we start
| fabricating them from the node name and the indices."

For MSTP, we started fabricating them, but that doesn't solve the
of_clk_get_parent_name() issue.

Thanks for your comments!

>  Earlier versions: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>  Initial version: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
>  Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   32 +
>  drivers/clk/Makefile                                                     |    1
>  drivers/clk/shmobile/Makefile                                            |    1
>  drivers/clk/shmobile/clk-rcar-gen3.c                                     |  245 ++++++++++
>  4 files changed, 279 insertions(+)
>
> --- /dev/null
> +++ work/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt       2015-08-31 15:49:10.000000000 +0900
> @@ -0,0 +1,32 @@
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
> +  - clock-indices: Indices of the exported clocks
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
> +                clock-indices = <
> +                             R8A7795_CLK_MAIN R8A7795_CLK_PLL0
> +                             R8A7795_CLK_PLL1 R8A7795_CLK_PLL2
> +                             R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
> +                >;
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
