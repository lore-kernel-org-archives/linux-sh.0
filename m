From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 16 Jun 2015 17:27:36 +0000
Subject: Re: [PATCH] [RFC] gpio: Retry deferred GPIO hogging on pin range change
Message-Id: <20150616172736.GH11732@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PEkEgRdBLZYkpbX2"
List-Id: <linux-sh.vger.kernel.org>
References: <1434458208-30600-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434458208-30600-1-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Benoit Parrot <bparrot@ti.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Jun 16, 2015 at 02:36:48PM +0200, Geert Uytterhoeven wrote:
> If a GPIO driver uses gpiochip_add_pin_range() (which is usually the
> case for GPIO/PFC combos), the GPIO hogging mechanism configured from DT
> doesn't work:
>=20
>     requesting hog GPIO lcd0 (chip r8a7740_pfc, offset 176) failed
>=20
> The actual error code is -517 =3D=3D -EPROBE_DEFER.
>=20
> The problem is that PFC+GPIO registration is handled in multiple steps:
>   1. pinctrl_register(),
>   2. gpiochip_add(),
>   3. gpiochip_add_pin_range().
>=20
> Configuration of the hogs is handled in gpiochip_add():
>=20
>     gpiochip_add
>         of_gpiochip_add
>             of_gpiochip_scan_hogs
>                 gpiod_hog
>                     gpiochip_request_own_desc
>                         __gpiod_request
>                             chip->request
>                                 pinctrl_request_gpio
>                                     pinctrl_get_device_gpio_range
>=20
> However, at this point the GPIO controller hasn't been added to
> pinctrldev_list yet, so the range can't be found, and the operation fails
> with -EPROBE_DEFER.
>=20
>   - Exchanging the order of the calls to gpiochip_add() and
>     gpiochip_add_pin_range() is not an option, as the latter depends on
>     initialization done by the former.
>   - Just moving the call of of_gpiochip_scan_hogs() from gpiochip_add()
>     to gpiochip_add_pin_range() is also not an option, as the latter is
>     optional, and thus not used by all drivers.
>=20
> Hence if of_gpiochip_scan_hogs() fails with -EPROBE_DEFER, call it
> again every time the pin range is changed, until it succeeded.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Questions:
>   - Is there a better solution to handle this?
>=20
>   - Should the pin ranges be configured by passing an array of data to
>     gpiochip_add() instead of having calls to gpiochip_add_pin_range()?
>     That would require changing all drivers.
>=20
>   - What happens if you have multiple hogs in multiple ranges?
>     The first hog(s) may be configured multiple times.  Is that a problem?
>=20
>   - In one of the threads that discussed the GPIO hogging mechanism, Maxi=
me
>     Ripard said: "Our pinctrl driver is also our GPIO driver, so they both
>     share the same node."
>     Maxime: Did you try GPIO hogging? Did it work?
>     If yes, which driver are you using? What's different compared to sh-p=
fc?
>     If no, did you get it to work?

I'm using pinctrl-sunxi, and no, I haven't tried it yet, so it
probably have the issue you reported :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgFyIAAoJEBx+YmzsjxAgdAcP/2ZqrmAMBOP8qSk7L2GhbDj1
uzKxurSIluCRr895M6ZMXnXlQBBSAodKXOZs4IO7RTqUdgR1z1AQH/l4F+CA+wBq
7GExs9LRb6noz9Dukc0OwhYjgo7dYgof9nQZTQIVq5RJwvFZ1CEMo54RGTl1v56i
ZqKgsojx5dfF7kR0WqSX5DkgVHHOa+iMNaK1SSYcD66yBoQQh99DbBRJZO67OA0C
QOZVuqwVQEkhp6ydvON9xpcoMBitPKgzV7DnKuI6ibSmcykoNWDqFnVt2LndY6ym
kK9N0C/X/LZrylIOBWM8oRgXtbSrlQG5DNjL4vM6OpCFPthQ4nrykXBk1K/4a5uo
1pnqCWTKbgj/RND6Nhh4Jqi9bgKZMGK1+JEdFZt8GBsCivGdndSovK8Oj3HqJ9Tc
oQ+T91m5EWU+MAvbIx7hCwnD1RIJuWpy4LlbN8JQksaQpJrh4otoDkUfmN97bsvc
rxLAq5vmwB+SLCmahJViCwX+LrGilkbcoeBc5+fOExVS5TKeCbziueuf/8+dqAzM
bdoVUQTYJFHL4Lk2ctKiVnIsSuhSmIdqFMT4nr8WIvg3mCUue6t1sP3+8Rr3yduy
PsJSx2SQR5kdK9VCihRSZiz7jPF0P9vxKK0hPhLz5nnJz90x3qA8gltqSF7EJIbn
QkDaNsO5Vn7zg1lGw/gt
=+89L
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--
