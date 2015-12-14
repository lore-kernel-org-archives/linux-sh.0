From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 14 Dec 2015 09:49:17 +0000
Subject: Re: [PATCH v2 2/9] i2c: add generic routine to parse DT for timing information
Message-Id: <20151214094917.GC1733@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GZVR6ND4mMseVXL/"
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
 <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
 <1449572085.30729.28.camel@linux.intel.com>
 <20151208130323.GB3359@katana>
 <20151208215103.GA1601@katana>
 <1449663156.30729.63.camel@linux.intel.com>
In-Reply-To: <1449663156.30729.63.camel@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Or maybe just be a bit verbose like the original variant
> int ret;
>=20
> ret =3D device_property_read=E2=80=A6(=E2=80=A6);
> if (ret && use_defaults) {
> =E2=80=A6
> }
>=20
> Among all variants I like the latter one here. What do you think?

I agree and fixed it like this.


--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbpCdAAoJEBQN5MwUoCm2oVkP/RjZqDK5AOtqspvmyuxZzCs0
BQaBbRqL16DL08wDJ4PCzo0q3kbZJluIBCDp+7FGayBnhhhpvcKORLLX3e5B8YOy
4z1iuP7NptPyb/cor2DeGS7u40W+I1QVcgG0oTAiycjyVzmi483O9ULzryq5dEjk
3IGGTo4jvEm+cVUxduWduTSX5onX89wfoPIy6pYRt/4gcJiWE4s8JSWnNqMxlMuk
b+KHMnw/GFMt7yQrskDlvz2xXLqPyQrFgU9ppuUweZHYqUFUEtek3MCEW9WT7qyP
Py4fR2Bms8qex0rdxDDaeUCDpWuB9SZKuJwyNWg5/G4vlHiPM3V1PiCr0D8fQyCF
fra3lih05SdEGwB4cIRGlkE6UrFm5Qx4uX4n+AEhTTvomngpnhbMQodRp9hXxQgQ
N63m2XAf+qGXRq98CGN0plRSMEbk6ZVkrqTbvitnp+8ooCmOn4qf/XxnWA2swugL
xc9ZGTFbrlHaalrrCfBafHSGdW46BgiahNijNke8HkgfXkFCzmFIswrAYQ1b7vtu
HruWUiNZt7GFj346mYJHtnpUWK3jv2wzRCU+217ezG4iSqHT6HQWDf1xSewogTX5
kNJORfdbujcjCwo7Ux8IQifBmF5GSxnnk8lpaZmk7b3OmuGOnb34CYAZdo0XyuXh
MJtYRrv54ifR7URy5cby
=ViYu
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
