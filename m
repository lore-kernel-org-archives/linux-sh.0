From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 18 Dec 2013 21:49:44 +0000
Subject: Re: [PATCH V2 1/5] pinctrl: r7s72100: add riic groups
Message-Id: <20131218214943.GC18645@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZmUaFz6apKcXQszQ"
List-Id: <linux-sh.vger.kernel.org>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1387402321-21866-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 10:31:57PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>=20
> Tested RIIC2 on a genmai board. Other riic groups are untested but seem
> trivial enough to be added.
>=20
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> ---
>=20
> V2: keep sorting alphabetical
>=20
> Note: With the current PFC driver as posted by Magnus, it needs another p=
atch
> to work. Yet, I think this is a seperate PFC issue which needs to be sort=
ed out
> seperately and shouldn't affect these declarations. I'll add the needed p=
atch
> as a response to this mail.

=46rom: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] HACK: make magnus new driver work

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/pinctrl/sh-pfc/pfc-r7s72100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c b/drivers/pinctrl/sh-pfc=
/pfc-r7s72100.c
index 00f67e8..a662876 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
@@ -68,11 +68,11 @@ enum {
 #define _P_GPIO(bank, _pin, _name, sfx) _GP_GPIO(16, bank, _pin, _name, sf=
x)
=20
 #define _P_DATA(bank, pin, name, sfx)					\
-	PINMUX_DATA(name##_DATA, name##_PMC_0, name##_PIPC_0,		\
+	PINMUX_DATA(name##_DATA, name##_PMC_0,		\
 		    name##_PIBC_1, name##_PBDC_1)
=20
 #define _P_FN(n, fn, pfcae, pfce, pfc)					\
-	PINMUX_DATA(n##_MARK_FN##fn, n##_PMC_1,	n##_PIPC_1,		\
+	PINMUX_DATA(n##_MARK_FN##fn, n##_PMC_1,		\
 		    n##_PFCAE_##pfcae, n##_PFCE_##pfce, n##_PFC_##pfc)
=20
 #define _P_MARK_FN1(bank, pin, name, sfx) _P_FN(name, 1, 0, 0, 0)


--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSshh3AAoJEBQN5MwUoCm2IhIP/jlWEyUpo5GAvLLjGMBNcwPx
g5WtgnsUDqVt8EVuXocqRF8+nCBviEWsqUopm/Gg7RFj0ARwsV+s3O4TNq5Tl4xV
3LzWnYbN+xNulVhMAdjmcewEDkUWLhN+lqAT3Ven4W2d9hW8zhx8g7OQ5YBC07fx
bfKema0r51ws5zzRvR/xelfPL+qMNQXiGUl2BhlNRCQQYXPbO/XngIoCNr0qs5D3
l3fBJwBHDKkjRwK6FUZ61ZDblLXnUfhUe8hoOnwKhMQ+mA9x0vfZi3FuAyAs75/K
Bvag2eKmr0FbxeUq14WG1XXtOcFbiCdbeAGWurTpYhdjH+OblJUbdhIXBKEWHLIr
frYeI6zt0Nnspqde3RK4n6MkNHTzxf23Z+R26RVJ1BTkPiNeVIzwX1keLcm0SWrb
iTfql8OuirfWKqdLRBFKfZZpdVDEiMEXmrWQMnKG4XOdMPRv+TrpRRtmY8DtRGrn
teW/EAzFSTuiT728imYCnIn/3Ahqa4U74layws8+mLNJKlZGBtRqe4H/ztta/sG0
vXfTK0I9QuCRG/aez/feS0Ly3jX06TQeqzxOl5IR8HA3+FIklxREDE2R6sHteAvJ
Qee4OL6IVS51q34KIO4LtTwQoCarNy8UauB2QZ3RYdlJ5HR+uo2CfPiBGAb4cQwF
GNGut3wZNZPl0Wc/l2Ei
=mbxq
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
