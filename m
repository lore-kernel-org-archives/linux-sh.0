From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 04 Mar 2014 11:07:06 +0000
Subject: Re: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
Message-Id: <20140304110706.GA12727@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1722697.3h0GnbWuD3@avalon> <20140303162731.GA3732@katana>
 <2207635.bd10VfTU6U@avalon>
In-Reply-To: <2207635.bd10VfTU6U@avalon>
To: linux-arm-kernel@lists.infradead.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > While the parent is indeed selected at boot time only, and only one p=
arent
> > > is thus needed, parent selection could be performed by a DIP switch
> > > connected to MD_CLK on the board for instance. In that case both pare=
nts
> > > should be available in DT, as selection will be done by the kernel at
> > > boot time, not at DT compile time.
> >=20
> > OK, I understand the case. I still wonder about specifying two parents,
> > though. If a board uses USB_X1, it then has to spefify a dummy EXTAL
> > clock (or an empty one), just because USB_X1 is enumerated as second
> > entry?
>=20
> That's a good question. Mike, would it be possible to support "holes" in =
the=20
> DT clocks lists, like the GPIO DT bindings do ?

I am currently playing with the status property for clocks, so we can
"disable" clocks. Opinions?

=46rom: Wolfram Sang <wsa@sang-engineering.com>
Subject: [PATCH] clk: allow clocks to use the 'status' property

Similar to platform devices, this allows us to set up the clock
hierarchy in dtsi files and enable the used clocks in the board file
later.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5517944..0045f55 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2542,6 +2542,9 @@ void __init of_clk_init(const struct of_device_id *ma=
tches)
 		matches =3D &__clk_of_table;
=20
 	for_each_matching_node_and_match(np, matches, &match) {
+		if (!of_device_is_available(np))
+			continue;
+
 		of_clk_init_cb_t clk_init_cb =3D match->data;
 		clk_init_cb(np);
 	}

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTFbPZAAoJEBQN5MwUoCm2QvAQAJl1ZtNwd3OkCSRRjm1Ie8Fj
xF2/tjBVSocYp+nYbD9oyBhh5s2lTOqEYnTsoXFRjdHkKhqrA0AO41toLVuyi4D0
BSb9BmgiUH9GVINTxoN0/evu8Ht4vdHeW8iJ75XdgReSNJJjy36PaSQTUie8uygq
wFp+Bq36Lh7I5GG7dCMSeh2dUMQc65mcnpTMvJteH1PQpEQGx9sUkuM3a0JhaDB8
HDbyIQLuyX+I2agMAIA9xeJHVw+FfYT/tdmkfWfG931y2fVRADjSZHqscimpzYaC
DVzqI7/oeDsETttGh+MAOSdvE1hrbFi2PIcD0g0118sdiM2W5TAsjXcKn/FAMADA
devtC6keBi038raQtkVbZvlWTH9Et5YbKXYqGXzQT+11hoFu66dZdQJAQR9cxIqe
ufxlK4TLBQie6QDmeBasDr+nf08U3tyiSuRe5dGcDDUp75Hxvkl2i7DGzzlN4Twz
GPAXX4JrByrd0RHEc/Ri+U3rYulGv4vfj8xk0QY4wHUNUyALowXlF5l/kGauN1kl
5z1phwVea754e4F49CU5bU2CsC7VMXYr7jJag//33o0q0hRH2hsCILkA1nk0asGm
yoPD/DC9sxYzoLBLrfHDmlPVP0upWqHw70CutTSxDApJLPNSddvnvWxxCMcbuTbR
OBPZBBjIDEDf+rK3Xv47
=9yAS
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
