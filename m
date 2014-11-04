From: Felipe Balbi <balbi@ti.com>
Date: Tue, 04 Nov 2014 22:53:58 +0000
Subject: Re: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <20141104225358.GL24983@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="L1EIGrW/+75u5Nmw"
List-Id: <linux-sh.vger.kernel.org>
References: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
In-Reply-To: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
To: linux-sh@vger.kernel.org

--L1EIGrW/+75u5Nmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2014 at 01:48:48AM +0300, Sergei Shtylyov wrote:
> There is a typo ("prove" instead of "probe") in the error message printed=
 when
> the platform initialization fails. Replace that word with more fitting "i=
nit".
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

this actually goes through me, I'll take it in a bit.

--=20
balbi

--L1EIGrW/+75u5Nmw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWVkGAAoJEIaOsuA1yqREEjsP/RyULlvCYDxB3+k8kf+Jflcg
GjIFV44HZ3b1WrrxZR9/UeEYwOf0RJBipjgN9FOc2Ed/J+k4Tu2I811v4Ee3gYQi
4kIIrL2rljjLFXOHsLozyghaXW5xyFG2GHihiwgURu396vxlqn9siqG1mYZv08CT
nBXHByOYpmkxvSy8CKOOnFWH1kKd5rWUIkKani+A0Gz07/2oswPvUZDU759gruFg
Vy7b6SFkMMGSafCl2nycr82K0mhSQrtImvUUzYrPDW+K9b+RK98vaPV1ly5ZEr5p
TnIbBH/qbs7IhsEFT+P/rXLxb1YmqHDD3zq2z4hbAbqeN9sVnYxejrZsVxIqhy22
WNBSTvHzN2gR0SK4dmHuNwDdytwZ5l9yhIKuDFFjQnQRSPkXSSlgrt1huS9elZJX
8t/IjdLkk5ofwuM0E/849hv6u0KHL1OmjJraEj90vNkA84JHZq2tYdX0MI5Qv1F2
NcJ76FQfyFVXmiHjIfBbZe0BXJsl2Dbwrre4CjXb+gF5r009NRbRQ+aIpN3JNFDe
i/MF0P5KvHOJZ3jpD6EARPYPRqqX4b65Yzz6Ttre0JUJCR0hbzZRbVkDTeUn50Vu
3oPwstiwS9kK1a3Kg152ooITrXKUO357TOyIs2BJbtooticPjV+kJLSlQ2hzonhx
uhpCe1xqT+pi18L7Bv+g
=J23k
-----END PGP SIGNATURE-----

--L1EIGrW/+75u5Nmw--
