From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Apr 2013 08:55:33 +0000
Subject: Re: [PATCH v3 4/9] rcar-phy: remove EHCI internal buffer setup
Message-Id: <20130410085533.GM7983@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FX+Db2fp7WJhXKrW"
List-Id: <linux-sh.vger.kernel.org>
References: <201304100232.30889.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304100232.30889.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org

--FX+Db2fp7WJhXKrW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2013 at 02:32:30AM +0400, Sergei Shtylyov wrote:
> Now that the EHCI internal  buffer setup is done by the platform code, we=
  can
> remove  such code from this driver as it  never  really belonged here.  W=
e also
> no longer need the 2nd memory region now (2nd EHCI controller is simply m=
issing
> in e.g. R8A7778 SoC).
>=20
> The patch has been tested on the Marzen and BOCK-W boards.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Felipe Balbi <balbi@ti.com>

Note that this will conflict with my latest phy changes since all phy
drivers got renamed.

--=20
balbi

--FX+Db2fp7WJhXKrW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZSkFAAoJEIaOsuA1yqRE7J8QAJ11W6MktcqipaSc7EqkAgEx
LSQI9gn5FyE6k52JCGPjGMWaXcSTuUDDOYvfaUrtEC7YkkwAuDCqqeZK5kVW5WJO
5Cmm7XVNDHhqAvRmXj+gNOrXRZDaT0X90/2/qK9KxHX6rHBB2zieHhHfblEBDbWw
W0sGqH0DqgJqAHChOgpDqoF0AJ0J8MbGLDCnzew01VBbm9HKyTbE3EL2rb573Ggv
lkukUzw3SNxBIpXYO/4UEmcB9IPDFpMuKrMVf1eLqXdza+h1h2B7uQpAtRYn82bb
rqzNhKsqMQGM1qrf+37xM5vOMnUks3IpzNDuCbq+/gRh7X9sQvinR3W1+df1YuCP
4/31+qIXTKvldwXvxk7dH5gJEfdS5/2vX+GSU9jbsCB/S9Ce5mnRQp8j+OhX5shc
qdRSc0EB4w1lau7wAxxYSvZbmuQdC2QPWMlEG7HIqUZlFN7dPzFSGX40ltsCcKLH
UCN3KBHrPKoeJnUDCfg0yHJgVIJkfvqXtvIdTaP6ni5d8ylnnLV1QwBg3Gu6oaXP
MxO3cNMo29/cmX4MFlmBQKPEvKnPW29c6gNT7uFYV0YPOS2B67rbWS3yX9y9fZte
nvTASzASKRXmy6hgDj9ZLid8pApjZ2LXzb6GDPG9FQ9XTLjvfy8J5XglfHBDGqOT
sk3zuMN9xMJznbdr/Ev5
=3zdi
-----END PGP SIGNATURE-----

--FX+Db2fp7WJhXKrW--
