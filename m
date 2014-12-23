From: Felipe Balbi <balbi@ti.com>
Date: Tue, 23 Dec 2014 19:16:42 +0000
Subject: Re: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <20141223191642.GB28059@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IrhDeMKUP4DT/M7F"
List-Id: <linux-sh.vger.kernel.org>
References: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
In-Reply-To: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
To: linux-sh@vger.kernel.org

--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2014 at 10:45:26PM +0300, Sergei Shtylyov wrote:
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
>    Felipe, I'm not seeing this patch anywhere in your tree. :-(

it's now on testing/next

--=20
balbi

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmb+aAAoJEIaOsuA1yqREqbIP/jERsSWuh18btPFjg1jnw6Af
M24tyxxd0gGTmvuyfec+AudKYFGMY2s5jBCHAWxHS+0aBP7BuMF6ATFY+y1vZvqC
mn8nI/KjxnfrPVwe51fvMtEA608oa+DB4HUDzMlCa1oAqDebAS1xTMNXWh5P+z2m
Op8kscsLFn+kcPP6F5jwoTfe1AFexq9hQTWjS9asga3576M+s1C0G6AAlYNxFvr9
LFZhJgKY23tHY2gWv/l3nKbHj5pQ+Ww19niS68/pPm0WqvijRF2HEBnNvksRSGOS
NcyZyRHpsOvDxEZUUu3QAqHqcp2Ls5NDIswEmV+zP3smVsUawYfQ67SB1Wnbfef5
bAdM+uFFHZTY8gtjQrfoDw1hO+X2JscMj6N83BvAxixGEtZ7CxOu3r8qk8bS/mFB
Xnh6kpVTWEV4m54dQrC3nOwe6dUHqZMAMQfbthVEWM2UHk+BSLwtam3Ifu+IZAtD
Dbwjn8ezl3gDLBtmeONIpgZHd4YPbId7iTJaoC+KXD2nEvqSJnHFnta1/KtAAfpG
O7+IYfj/W9WIEJiscpDF1wZvuCqJOCSM2RyDvbLkbT2mAdYSoXaf2fq+f6bpWBTG
SnW1Hyy9/5e7D+A6ujhHpnC4vx2pUKHA9+xP5yupWIpHew1U37uh2YZyV9Thbyaz
nda7spYB35o6P/qtVp9l
=298o
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
