From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Feb 2014 10:20:06 +0000
Subject: Re: Maybe this is CCF bug
Message-Id: <CAMuHMdXbNMFUguC6Wc0gEhiHjBPTLKT8mH5tWw0OqXfpbOqgcg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjlkq1v1.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87zjlkq1v1.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Feb 21, 2014 at 9:58 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> Now, I'm working for sound DT support,
> and I noticed common clock setting's strange behavior.
> I guess this is bug, but 50% my misunderstanding.
>
> Now, we have clock index on ${LINUX}/include/dt-bindings/clock/r8a7790-clock.h
> For example, r8a7790's MSTP9 case, like this
>
>         /* MSTP9 */
>         #define R8A7790_CLK_GPIO5               7
>         #define R8A7790_CLK_GPIO4               8
>         #define R8A7790_CLK_GPIO3               9
>         #define R8A7790_CLK_GPIO2               10
>         #define R8A7790_CLK_GPIO1               11
>         #define R8A7790_CLK_GPIO0               12
>         #define R8A7790_CLK_RCAN1               15
>         #define R8A7790_CLK_RCAN0               16
>         #define R8A7790_CLK_QSPI_MOD            17
>         #define R8A7790_CLK_IICDVFS             26
>         #define R8A7790_CLK_I2C3                28
>         #define R8A7790_CLK_I2C2                29
>         #define R8A7790_CLK_I2C1                30
>         #define R8A7790_CLK_I2C0                31
>
> and MSTP9 is like this
>
>         mstp9_clks: mstp9_clks@e6150994 {
>                 compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
>                 reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
>                 clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>,
>                          <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
>                 #clock-cells = <1>;
>                 renesas,clock-indices = <
>                         R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD
>                         R8A7790_CLK_I2C3 R8A7790_CLK_I2C2 R8A7790_CLK_I2C1
>                         R8A7790_CLK_I2C0
>                 >;
>                 clock-output-names >                         "rcan1", "rcan0", "qspi_mod", "i2c3", "i2c2", "i2c1", "i2c0";
>         };
>
> And, now, spi parent is MSTP9 QSPI MOD
>
>         spi: spi@e6b10000 {
>                 ...
>                 clocks = <&mstp9_clks R8A7790_CLK_QSPI_MOD>;
>                 ...
>         };
>
> This SPI would like to use MSTP9's 17th (= R8A7790_CLK_QSPI_MOD) clock as its parent.
> But, mstp9_clks has 7 clocks only.
> R8A7790_CLK_xxx means "bit shift", not "index" on DT clock.

Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt says:

    The MSTP groups are sparsely populated. Unimplemented
    gate clocks must not be declared.

> On ${LINUX}/drivers/clk/shmobile/clk-mstp.c,
> it try to get parent name by
>
>         parent_name = of_clk_get_parent_name(np, i);
>
> and it returns "mstp9_clks" in this case.
> Maybe SPI would like to get "qspi_mod" ?

I don't know about of_clk_get_parent_name(), but in the end the QSPI driver
does seem to get the right clock, cfr. this output on Lager reference:

clk qspi_mod at 97500000 Hz
clk qspi at 97500000 Hz
clk pll1_div2 at 780000000 Hz
clk pll1 at 1560000000 Hz
clk main at 20000000 Hz
clk extal at 20000000 Hz

with the (whitespace-damaged) patch at the end of this email.

BTW, you do have these 2 applied?

    clk: shmobile: rcar-gen2: Fix clock parent all non-PLL clocks
    clk: shmobile: rcar-gen2: Fix qspi divisor

They are not in Simon's repository, but in
http://git.linaro.org/people/mike.turquette/linux.git/shortlog/refs/heads/clk-fixes

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 239bd4206fc6..5ae0cdf96231 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -22,6 +22,11 @@
  *
  */

+#ifdef CONFIG_COMMON_CLK
+#include <linux/clk-private.h>
+#else
+#include <linux/sh_clk.h>
+#endif
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -1311,6 +1316,18 @@ static int rspi_probe(struct platform_device *pdev)
                goto error1;
        }

+{
+    struct clk *clk = rspi->clk;
+
+    while (clk) {
+#ifdef CONFIG_COMMON_CLK
+       printk("clk %s at %lu Hz\n", clk->name, clk_get_rate(clk));
+#else
+       printk("clk at %lu Hz\n", clk_get_rate(clk));
+#endif
+       clk = clk->parent;
+    }
+}
        init_waitqueue_head(&rspi->wait);

        master->bus_num = pdev->id;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
