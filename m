From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Jan 2016 16:22:18 +0000
Subject: Re: [RFC v4 4/4] clk: r8a7795: add RWDT clock
Message-Id: <CAMuHMdWDMiPosb46khK_X5gdS6EiK82ofseRmJGaCv+9b4K1xg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452287553-18895-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452287553-18895-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Fri, Jan 8, 2016 at 10:12 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
> index 23e98fef97f105..b05cb490394454 100644
> --- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
> +++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
> @@ -122,6 +122,7 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
>         DEF_MOD("scif2",                 310,   R8A7795_CLK_S3D4),
>         DEF_MOD("pcie1",                 318,   R8A7795_CLK_S3D1),
>         DEF_MOD("pcie0",                 319,   R8A7795_CLK_S3D1),
> +       DEF_MOD("rwdt0",                 402,   R8A7795_CLK_S3D1),

According to the datasheet, the watchdog's clock is RCLK (R8A7795_CLK_R), not
S3D1.

Note that you have to add that clock's definition to r8a7795_core_clks[] first.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
