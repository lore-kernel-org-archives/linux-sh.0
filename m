From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Nov 2010 04:30:55 +0000
Subject: Re: [PATCH 3/5] ARM: mach-shmobile: mackerel: Add LCDC support
Message-Id: <AANLkTikxOEuy3J=HRiQEusdWgSYKpBUndatJbTW4HfTK@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3peia450p5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3peia450p5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Nov 29, 2010 at 11:21 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> +static struct sh_mobile_lcdc_info lcdc_info =3D {
> + =A0 =A0 =A0 .clock_source =3D LCDC_CLK_BUS,
> + =A0 =A0 =A0 .ch[0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chan =3D LCDC_CHAN_MAINLCD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bpp =3D 16,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .lcd_cfg =3D mackerel_lcdc_modes,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .num_cfg =3D ARRAY_SIZE(mackerel_lcdc_modes=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .interface_type =A0 =A0 =A0 =A0 =3D RGB24,

..and..

> + =A0 =A0 =A0 /* LCDC */
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD17, =A0 NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD16, =A0 NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD15, =A0 NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD14, =A0 NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD13, =A0 NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD12, =A0 NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD11, =A0 NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD10, =A0 NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD9, =A0 =A0NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD8, =A0 =A0NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD7, =A0 =A0NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD6, =A0 =A0NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD5, =A0 =A0NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD4, =A0 =A0NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD3, =A0 =A0NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD2, =A0 =A0NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD1, =A0 =A0NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_LCDD0, =A0 =A0NULL);

Hm, it looks like you are requesting too few pins here.

Today you request 18 data pins (LCDD0 -> LCDD17) for the pinmux, but
the platform data for the LCDC is set to RGB24.

With RGB24 I think you should select 24 data pins (LCDD0 -> LCDD23).

Or perhaps there is some magic bus switch somewhere that I am not seeing? =
=3D)

Thanks,

/ magnus
