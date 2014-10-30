From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 30 Oct 2014 13:54:18 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: lager: Add I2C2 clock frequency to device tree
Message-Id: <20141030135417.GD23852@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bajzpZikUji1w+G9"
List-Id: <linux-sh.vger.kernel.org>
References: <1414648520-30184-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1414648520-30184-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 02:55:20PM +0900, Simon Horman wrote:
> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>=20
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> [simon: rebased]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
>=20
> If this is useful I wonder if it is should be set in the lager board DTS
> file instead of the r8a7790 SoC DTSI file.

? This IS set in the .dts and not the .dtsi.

400kHz should never be set in a .dtsi. Not all i2c slave devices support
it. 100kHz is the default which all slaves need to support. But since
I've seen cases where the board needs to lower even further because of
board design issues, I'm getting reluctant to set even 100kHz in dtsi
files in general.

>=20
>=20
>  arch/arm/boot/dts/r8a7790-lager.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7=
790-lager.dts
> index 830f2e8..32c7e48 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -426,6 +426,7 @@
> =20
>  &iic2	{
>  	status =3D "ok";
> +	clock-frequency =3D <400000>;
>  	pinctrl-0 =3D <&iic2_pins>;
>  	pinctrl-names =3D "default";
> =20
> --=20
> 2.1.1
>=20

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUUkMJAAoJEBQN5MwUoCm2RUgP/0TvsDHlMb9VHC+G7A0nZks0
5+oa22LDUxoiB3jD2dTi4jrl8sJOXWW6I0aIujAdW0DXUBGY5yQqYTKZej4EgPDx
3VP7v2fIjQVUJObrTpyCd9xBuK44FAy6iG2cA90uU08Q/4roquWrXfpf4P5GUCpE
qM2KNlMRVbMENixlXCXbIbMtW9DBriHP4x+m31uaRYL0FyMASHxN8jV9JzLIft34
zO7LYg0qTdWrplB0rxiVycUn4RVJucf9y3ddeQkGLAnMrueO5toLzu+Q3HIWzUud
f9SyxQeU27O0Yt5uohxtgaTkyIh9Fzppwuu9mvDKj4LZvv6mQKuFsOSMp1aH8Eww
H5GzjsmVKhLzkdeVbHzXgdo9DWCZoFmpUKcZhRxKSQ1hEukkWkRFZ6KfP4JmpyqG
ONnJRX+pJu6XL0BcUehmnA2XqNsiBHZOcsDrD9ck4lZUZ12/x9eQcdsvbawzywoF
XjQNLTF059/Fkz2IJos/DcoqP6Jpz8lBXxJLx9O8MK/pdeLYCxnIc9kRg7xZsTtZ
EJQRFFKiUlclSGgHMujmxKcJgn39y2EVLC1OELdXur9kUU9i46yO1n5dzBsAsBsp
gXNoxN1VPoRfNTwcp8sWRxcrUrY99R0sObEkLzNu+vqVyjbsFFtp9VlUsDhf6vCj
qC6vqUrcP/6zcfKP6dOO
=wTkx
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
