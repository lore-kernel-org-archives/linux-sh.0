From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 31 Oct 2014 08:07:33 +0000
Subject: Re: [PATCH 07/12] ARM: shmobile: koelsch: fixup overkill I2C2 clock frequency
Message-Id: <20141031080733.GA1285@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
List-Id: <linux-sh.vger.kernel.org>
References: <87r3xo1xak.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87r3xo1xak.wl%kuninori.morimoto.gx@gmail.com>
To: linux-sh@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 01:02:59AM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current Koelsch I2C2 has 400kHz settings,
> but, ak4643 audio codec chip which is connected to I2C2 can't
> work such frequency.
> Fixup I2C2 clock frequency.

Basically OK, but we should better explicitly set it to 100000 and not
rely on a default coming from somewhere.

>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8=
a7791-koelsch.dts
> index f722821..1ad9fb3 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -425,7 +425,6 @@
>  	pinctrl-names =3D "default";
> =20
>  	status =3D "okay";
> -	clock-frequency =3D <400000>;
> =20
>  	composite-in@20 {
>  		compatible =3D "adi,adv7180";
> --=20
> 1.7.9.5
>=20

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUU0NEAAoJEBQN5MwUoCm2gpgQAK+5WS82Rgn3Eyq6tuylNjMl
HtFz5k6R6dxT3OHrMOH1UVg97b0wtwhvSYZqTsNwcb9I80+i45jIpDNZHLn1cX0q
hzryRtkqm/GI0zeccKfQgy/IlJsphnxiszBCMdktcGvk7rUF4PuU+qRc1KklcN32
RaM8yh7mw/wLvre4zm3YnePlnqNtZRhkU3VCGQGFAx33r+qL1W5Af56KdWIw7P5H
L9fDg//AUaMFYccHMoaQvvyxsbHT0S8x+S2sgy2xkt9Z+SBAD6pc9wA4b28y3sYn
X2o9WNMxwbUOpyHpC0KihAJvIEdfppSpMs3tGK+9gH0z5puiHF2oy++2bxDZM3aO
nEcFV9EO6rEHDIlXTl1oUYSppOpcsIUc/Fy1y8wZaTlgQYhJj5pmJPWzrApYOvTW
h+ha7E5uJhCdVhbOHYC/fiJQMr5ACA5XCvzCQCTmft+06VTiMMxZcYj6exyQBQkR
6J1BTLe80T6LihC00X1SzPApz5cHx+vEgiUhJdmpCsEYoeaj3T6eO1GgI9mRI/bs
i/3pq713nfj9SM82CnpLSnTHcWBeZ9J7+wHccHcOFal7ao9RX9jVnOVmneNy+23W
JnGyoghN1Qp6xX/z4Q6kbnwTP33jpj/f4gewj4rJSLv+ccgljqUu9an11TaVxcbW
+g7Mdk83ch6nOzK5+VI2
=lquX
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
