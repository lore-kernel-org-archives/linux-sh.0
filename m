From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Dec 2015 19:10:17 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7795: Add SDHI support
Message-Id: <CAMuHMdXU9XPXShcokf0XHWB1RwAEhs0J-chUCPjyisUttL6SYw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449237007-4638-1-git-send-email-dirk.behme@gmail.com>
In-Reply-To: <1449237007-4638-1-git-send-email-dirk.behme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Dirk,

On Fri, Dec 4, 2015 at 2:50 PM, Dirk Behme <dirk.behme@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Adds SDHI[0-3] pinmux support to r8a7795 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Thanks for this patch!

> ---
> Note: This patch picked from
>
> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/log/?h=v4.2/rcar-3.0.x
>
> and rebased against
>
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/gen3-latest renesas-drivers-2015-12-01-v4.4-rc3
>
>  drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 284 +++++++++++++++++++++++++++++++++++
>  1 file changed, 284 insertions(+)
>
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> index 54e32c0..a924238 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> @@ -549,6 +549,16 @@ enum {
>  static const u16 pinmux_data[] = {
>         PINMUX_DATA_GP_ALL(),
>
> +       /* NOIP */
> +       PINMUX_IPSR_NOGP(0, SD2_CMD),   /* GP_4_1  */
> +       PINMUX_IPSR_NOGP(0, SD3_CLK),   /* GP_4_7  */
> +       PINMUX_IPSR_NOGP(0, SD3_CMD),   /* GP_4_8  */
> +       PINMUX_IPSR_NOGP(0, SD3_DAT0),  /* GP_4_9  */
> +       PINMUX_IPSR_NOGP(0, SD3_DAT1),  /* GP_4_10 */
> +       PINMUX_IPSR_NOGP(0, SD3_DAT2),  /* GP_4_11 */
> +       PINMUX_IPSR_NOGP(0, SD3_DAT3),  /* GP_4_12 */
> +       PINMUX_IPSR_NOGP(0, SD3_DS),    /* GP_4_17 */

These have already been added using PINMUX_SINGLE() in
"[PATCH v2 1/2] pinctrl: sh-pfc: r8a7795: Add pinmux data for single-function
pins" (http://www.spinics.net/lists/linux-gpio/msg09960.html).

I know that wasn't included in renesas-drivers-2015-12-01-v4.4-rc3, but it is
in renesas-drivers-2015-12-08-v4.4-rc4.

The rest looks fine to me, so if you drop the first hunk, you can add my
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
