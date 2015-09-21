From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Sep 2015 12:03:30 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: r8a7794: add VIN pin groups
Message-Id: <CAMuHMdXf00eXg7qQMzPjCReoMeMFNjLHG20sL3tN+9hbUi3pLQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
	<2918225.gAfMYgxlCz@wasted.cogentembedded.com>
In-Reply-To: <2918225.gAfMYgxlCz@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Hi Sergei,

On Fri, Aug 28, 2015 at 10:46 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
> Add VIN0/1 pin groups to R8A7794 PFC driver.
>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> [Sergei: rebased, renamed, added changelog, gathered 12 VIN1 data pins into a
> single pin group.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> The patch  is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git' repo.
> It depends on the patch I've just posted in order to build.
>
> Changes in version 2:
> - relied on the 'struct vin_data' and #define VIN_DATA_PIN_GROUP() moved to the
>   common header file;
> - added to the VI1_DATA8/9/10/11 pin group VI1_DATA[0-7] pins and renamed/moved
>   this pin group.

Thanks for the update!

>  drivers/pinctrl/sh-pfc/pfc-r8a7794.c |  192 +++++++++++++++++++++++++++++++++++
>  1 file changed, 192 insertions(+)
>
> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
> =================================> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
> @@ -2789,6 +2789,156 @@ static const unsigned int usb1_mux[] = {

> +/* - VIN1 ----------------------------------------------------------------- */
> +static const unsigned int vin1_data8_pins[] = {
> +       RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 13),
> +       RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 15),
> +       RCAR_GP_PIN(5, 16), RCAR_GP_PIN(5, 17),
> +       RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19),
> +};
> +static const unsigned int vin1_data8_mux[] = {
> +       VI1_DATA0_MARK, VI1_DATA1_MARK,
> +       VI1_DATA2_MARK, VI1_DATA3_MARK,
> +       VI1_DATA4_MARK, VI1_DATA5_MARK,
> +       VI1_DATA6_MARK, VI1_DATA7_MARK,
> +};
> +static const unsigned int vin1_data12_pins[] = {
> +       RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 13),
> +       RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 15),
> +       RCAR_GP_PIN(5, 16), RCAR_GP_PIN(5, 17),
> +       RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19),
> +       RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 11),
> +       RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
> +};
> +static const unsigned int vin1_data12_mux[] = {
> +       VI1_DATA0_MARK, VI1_DATA1_MARK,
> +       VI1_DATA2_MARK, VI1_DATA3_MARK,
> +       VI1_DATA4_MARK, VI1_DATA5_MARK,
> +       VI1_DATA6_MARK, VI1_DATA7_MARK,
> +       VI1_DATA8_MARK, VI1_DATA9_MARK,
> +       VI1_DATA10_MARK, VI1_DATA11_MARK,
> +};

According to Table 26.2, VIN Channel 1 on R-Car E2 supports 8, 10, and 12 bit
input data. Can you please add data10, too?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
