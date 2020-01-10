From: Niklas =?iso-8859-1?Q?S=F6derlund?=  <niklas.soderlund@ragnatech.se>
Date: Fri, 10 Jan 2020 20:29:50 +0000
Subject: Re: [PATCH 00/13] pinctrl: sh-pfc: checker: Various improvements
Message-Id: <20200110202950.GA695049@oden.dyn.berto.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Geert,

Neat series. I always worry when my eyes start to cross each other when=20
looking at the big tables I will make mistakes like this ;-)

On 2020-01-10 14:19:14 +0100, Geert Uytterhoeven wrote:
> 	Hi all,
>=20
> This patch series contains various improvements for the builtin pin
> control table runtime checks of the Renesas Pin Function Controller
> driver.  These checks are enabled with CONFIG_DEBUG_PINCTRL=3Dy, which can
> be combined with CONFIG_COMPILE_TEST=3Dy to increase coverage to all
> Renesas ARM and SuperH SoCs..
>=20
> Note that all issues detected by this have already been fixed in "[PATCH
> 0/6] pinctrl: sh-pfc: More miscellenaous fixes"[1], and are now part of
> linux-next.
>=20
> I plan to queue this in sh-pfc-for-v5.7.

With the fix you point out yourself in 13/13 for=20
CONFIG_PINCTRL_SH_FUNC_GPIO=3Dn feel free to add

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

For the whole series.

>=20
> Thanks for your comments!
>=20
> [1] https://lore.kernel.org/linux-renesas-soc/20191218194812.12741-1-geer=
t+renesas@glider.be/
>=20
> Geert Uytterhoeven (13):
>   pinctrl: sh-pfc: checker: Move data before code
>   pinctrl: sh-pfc: checker: Add helpers for reporting
>   pinctrl: sh-pfc: checker: Add helper for safe name comparison
>   pinctrl: sh-pfc: checker: Add check for config register conflicts
>   pinctrl: sh-pfc: checker: Add check for enum ID conflicts
>   pinctrl: sh-pfc: checker: Improve pin checks
>   pinctrl: sh-pfc: checker: Improve pin function checks
>   pinctrl: sh-pfc: checker: Improve pin group checks
>   pinctrl: sh-pfc: checker: Add drive strength register checks
>   pinctrl: sh-pfc: checker: Add bias register checks
>   pinctrl: sh-pfc: checker: Add ioctrl register checks
>   pinctrl: sh-pfc: checker: Add data register checks
>   pinctrl: sh-pfc: checker: Add function GPIO checks
>=20
>  drivers/pinctrl/sh-pfc/core.c | 312 +++++++++++++++++++++++++++-------
>  1 file changed, 250 insertions(+), 62 deletions(-)
>=20
> --=20
> 2.17.1
>=20
> Gr{oetje,eeting}s,
>=20
> 						Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> 							    -- Linus Torvalds

--=20
Regards,
Niklas S=F6derlund
