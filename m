From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 May 2015 10:28:34 +0000
Subject: Re: [3.16.y-ckt stable] Patch "ARM: shmobile: r8a7791: Correct SDHI clock labels and output-names" h
Message-Id: <CAMuHMdUcXZZdof-OOowWJ9wuwQeD9Hu5qOp=CKvVO0KttbAdsw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Luis,

On Wed, May 6, 2015 at 11:52 AM, Luis Henriques
<luis.henriques@canonical.com> wrote:
> This is a note to let you know that I have just added a patch titled
>
>     ARM: shmobile: r8a7791: Correct SDHI clock labels and output-names
>
> to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree
> which can be found at:
>
>     http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.16.y-queue
>
> This patch is scheduled to be released in version 3.16.7-ckt11.
>
> If you, or anyone else, feels it should not be added to this tree, please
> reply to this email.

Unless you want to queue other patches that depend on this, I don't think
there's a need to backport this to -stable:
  - Changing the names of the labels doesn't have any visible effects,
    as the phandles referring to them are changed, too,
  - IIRC, nothing relies on the (changed) names of qclock-output-names.

> For more information about the 3.16.y-ckt tree, see
> https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable
>
> Thanks.
> -Luis
>
> ------
>
> From dc02b7f783bc7bf6e4e5b0656ddb742a327599d7 Mon Sep 17 00:00:00 2001
> From: Simon Horman <horms+renesas@verge.net.au>
> Date: Thu, 29 Jan 2015 10:41:24 +0900
> Subject: ARM: shmobile: r8a7791: Correct SDHI clock labels and output-names
>
> commit 2ea0d4ec39ac837e34c07b4783a7c900940e6eaf upstream.
>
> There appears to have been some inconsistency and confusion here as on
> the r8a7790 these clocks are referred to as SD(HI)1 and SD(HI)2 while on
> the r8a7791 and r8a7794 they are referred to as SD(HI)2 and SD(HI)3.
>
> Fixes: 59e79895b95892863 ("ARM: shmobile: r8a7791: Add clocks")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [ luis: backported to 3.16: adjusted context ]
> Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 79f68acfd5d4..1e7a0c9ec3ee 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -533,19 +533,19 @@
>                 };
>
>                 /* Variable factor clocks */
> -               sd1_clk: sd2_clk@e6150078 {
> +               sd2_clk: sd2_clk@e6150078 {
>                         compatible = "renesas,r8a7791-div6-clock", "renesas,cpg-div6-clock";
>                         reg = <0 0xe6150078 0 4>;
>                         clocks = <&pll1_div2_clk>;
>                         #clock-cells = <0>;
> -                       clock-output-names = "sd1";
> +                       clock-output-names = "sd2";
>                 };
> -               sd2_clk: sd3_clk@e615026c {
> +               sd3_clk: sd3_clk@e615026c {
>                         compatible = "renesas,r8a7791-div6-clock", "renesas,cpg-div6-clock";
>                         reg = <0 0xe615026c 0 4>;
>                         clocks = <&pll1_div2_clk>;
>                         #clock-cells = <0>;
> -                       clock-output-names = "sd2";
> +                       clock-output-names = "sd3";
>                 };
>                 mmc0_clk: mmc0_clk@e6150240 {
>                         compatible = "renesas,r8a7791-div6-clock", "renesas,cpg-div6-clock";
> @@ -757,7 +757,7 @@
>                 mstp3_clks: mstp3_clks@e615013c {
>                         compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
>                         reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
> -                       clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7791_CLK_SD0>,
> +                       clocks = <&cp_clk>, <&sd3_clk>, <&sd2_clk>, <&cpg_clocks R8A7791_CLK_SD0>,
>                                  <&mmc0_clk>, <&hp_clk>, <&hp_clk>, <&rclk_clk>;
>                         #clock-cells = <1>;
>                         renesas,clock-indices = <

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
