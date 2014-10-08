From: Felipe Balbi <balbi@ti.com>
Date: Wed, 08 Oct 2014 18:08:52 +0000
Subject: Re: [PATCH v3 2/3] ARM: shmobile: koelsch: enable HS-USB
Message-Id: <20141008180852.GK22688@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="45wMVEkw4XUbiYON"
List-Id: <linux-sh.vger.kernel.org>
References: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
 <8674731.7YYzQeH0h1@wasted.cogentembedded.com>
 <20141008180513.GJ22688@saruman>
 <54357D76.4050104@cogentembedded.com>
In-Reply-To: <54357D76.4050104@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org

--45wMVEkw4XUbiYON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2014 at 10:07:50PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 10/08/2014 10:05 PM, Felipe Balbi wrote:
>=20
> >>From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> >>Enable HS-USB device for the Koelsch board, defining the GPIO that the =
driver
> >>should check when probing (which is the ID output from MAX3355 OTG chip=
).
>=20
> >>Note that there will be pinctrl-related error messages if both internal=
 PCI
> >>and HS-USB drivers are enabled but they should be just ignored.
>=20
> >>Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >>[Sergei: added pin function/group and prop, moved device node, fixed su=
mmary,
> >>added changelog]
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> >>---
> >>Changes in version 3:
> >>- added pinctrl-related properties;
>=20
> >did you miss pinctrl here ?
>=20
>     No, AFAICS. Or what do you mean?

usb0_pins doesn't appear to be defined anywhere.

--=20
balbi

--45wMVEkw4XUbiYON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNX20AAoJEIaOsuA1yqRE+3oP/ApqlwEBVGbhB6rBbi50hyBZ
6gXHnxy4pfwQlkn1yS4vbeQbEeahjtrg83DpQyS3MPnETiXha6gyc4HR3sBzqufy
GnTkeGFuTH19o7OmHirHwNde/piKGZdfskMXw4vPOdklh5DVq5z7jokZo7g60QFE
17QJu0lyYoLveziSELIwgDpT8IOYL3dO4sYoQb2DKsf5/fHRjxa+swAQOtjWRyPe
s2vQM3OKPEJ3TpVEGdUk14VlCFv+QCZWh/vNYoPBJgaRXRiQz/hPyWWgUbqG4xH8
xTDc2kZwwhm3EvPl8Pu/DxXPkd5RjG/Lx+ohX96YGrSKvUGuFjkPVsYUjoNn4ljV
g82IZHykB/WLTDnGq681rCDRccZw65hRiWmc4LPM2KOyIX/7DS6/1yWmMjgbvh9I
LQIJ88dA0TfthnTHjnGqh9qVoqQnGBp+lYmm6u2N2kTzE5AIT/IEDkIro/73VwPr
b8b6n/GkS6P/A4Myadc82QP2tjyYGqoWL653hdKlvUFWaEkJ8EL8F20k9lvq7qEc
rrjJbrCuDTl7Bsy3LBhPfNjnAMKwRKL3a3euf1FBiDH1oJJR2j3oL5m+RoqUYwsD
fX7TlboSW2sKthCz6nkAPFJiP6WVB78j1AnWLKt5jt7GohYOQkGY+P9vd/x29YWA
6ZA0776RKJRlfl6myjHk
=Qt90
-----END PGP SIGNATURE-----

--45wMVEkw4XUbiYON--
