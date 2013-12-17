From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 17 Dec 2013 21:47:34 +0000
Subject: Re: [PATCH 1/5] pinctrl: r7s72100: add riic groups
Message-Id: <20131217214734.GC1196@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jousvV0MzM2p6OtC"
List-Id: <linux-sh.vger.kernel.org>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1387316678-10174-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 10:44:34PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>=20
> Tested RIIC2 on a genmai board. Other riic groups are untested but seem
> trivial enough to be added.
>=20
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> ---
>=20
> Note: With the current PFC driver as posted by Magnus, it needs another p=
atch
> to work. Yet, I think this is a seperate PFC issue which needs to be sort=
ed out
> seperately and shouldn't affect these declarations. I'll add the needed p=
atch
> as a response to this mail.

Here it goes...

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


--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSsMZ2AAoJEBQN5MwUoCm2VfwQALGBhvSKNxrHqSRLlpvheDv/
X9BcgR5DY8tX8fLZWxfvvb9BylKd0AKZd3ElPMbjUhDJaZSy0CvkWwe3k7JweY4U
t7RGPA1lghqO+ZCflxOyRfUZKz+m1FhOrUzxjWTWY/PJWyLhe5t1nuZiAi/m6iJk
KlZlfmS6rdInmapYigBMJtNrQOQ0KWzV8i7lVVikabjIBrbwz3xwZsB7Y7qTuBVQ
ct2ioWju2e6ae5fNo+zmFLO+xNmxyT8WnFHgKGJys3GObagcgvQ3kn4vcdXgYvhn
QWFTKkuDOdVMR9xlIT8+jbyMvoVeR1utSIhsUlZZexjQcDM8/L43FD04r7IU1iXc
yEWKVxDoPqsEyYaJVCiHcpJFGNg1WwlGalcF+vJutLa1dY/lbjV91IHFQ8aS2eBr
PCaVSBcaDZEkloQ4GCNLPOrghEN9GBt7EgMqM836LwtrLAItrfwC0JCE8NFa39In
B4NHiirmQo62CEGcPhLSm0PRLa98LliP/BpdDI6XEvBB4DoKD2zQM/6eMhO8A0Fi
FAJEzr61bqWIW6mZ1O660w34pkPLd8m5JIjJyRucK3xtHDzuEDW34hZ1VF1L/un1
rz+ExFN5LrC3Nn8f9chHIqck+M066sjzBQjpGAbJ5mv0Bt2catCYBCKf8TBMMMgk
yovlk8BAfoQM7Yh6s0jw
=YQlC
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
