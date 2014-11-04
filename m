From: Felipe Balbi <balbi@ti.com>
Date: Tue, 04 Nov 2014 23:01:19 +0000
Subject: Re: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <20141104230119.GM24983@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aiCxlS1GuupXjEh3"
List-Id: <linux-sh.vger.kernel.org>
References: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
In-Reply-To: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
To: linux-sh@vger.kernel.org

--aiCxlS1GuupXjEh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 05, 2014 at 01:55:17AM +0300, Sergei Shtylyov wrote:
> Hello.
>=20
> On 11/05/2014 01:53 AM, Felipe Balbi wrote:
>=20
> >>There is a typo ("prove" instead of "probe") in the error message print=
ed when
> >>the platform initialization fails. Replace that word with more fitting =
"init".
>=20
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> >this actually goes through me, I'll take it in a bit.
>=20
>    Er, OK. Could you update MAINTAINERS?

there is no entry for renesas driver in MAINTAINERS.

Shimoda-san, care to send a patch adding yourself or Morimoto-san as
maintainers for Renesas driver and pointing to my tree in kernel.org ?

Thank you

--=20
balbi

--aiCxlS1GuupXjEh3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWVq/AAoJEIaOsuA1yqREF0AP/2EXnEDAAdaNQ6PRiLTzPaBS
ufBQeVHqS9oHwSsZDouEpEn2tajERoaSZ3lxpoJuAdS2BRiJSopklNBoog/dEk/7
4NtRG9CPkntz7x09D/XMxDRnvhFuaBzJg/oulYw6YozEto55ySz86TtWIsh6uDN2
g2AaBLrNKOrL6kem52+QJo7Jt2vPAzMVLZ05IJm2R35T0GO5XCn5Olupc39SAWk8
eVHFDs8MJHstybiCFRnMFvtqLnjMnRIl4uFd8AU1Y1t0vjjLgP9kIzLnC6V/MUIk
6EvYU6+cNqUpwNKMgNtMlblhwIoLpE2FWE3vQmFGZ0d6AcXqHaPNtcGvLUxRtw7Y
BGTTNfalc2NIAAB0eRu+ASE5SgwJhMmMIET5OnXgGyl+qD7uyalIUWuXDWy6pxyL
PS4jmD59rbIZgP0/AVl+4wSyikxR8Mq+00inTXQQ/TbDtrq+m2Cbt6l+0T1saJXT
/umSybmBWzTuVJHRm7BVAtfGnKV2+ZH5eLnOvLexsQqTAHyko3GvtFK+LUctbwIa
1z5093+jnfZ/JHwJKH6ka8rvADDUK4kHQjQEJ8u5M1oXlvXkkSI94OTnjk0HtxVV
4VJvj0QyJ2JhVQI4A0I3SIQ5kxjY+FyjTozleI4gRc09siudP3MFwsMIqfSmSXMk
6EDXRWVNcmyO7cj3A5ch
=3FIy
-----END PGP SIGNATURE-----

--aiCxlS1GuupXjEh3--
