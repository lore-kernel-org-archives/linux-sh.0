From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 29 Oct 2013 05:02:24 +0000
Subject: Re: [PATCH 06/12] i2c: sh_mobile: Convert to clk_prepare/unprepare
Message-Id: <20131029050224.GA2643@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383000569-8916-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2013 at 11:49:23PM +0100, Laurent Pinchart wrote:
> Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> clk_disable_unprepare() to get ready for the migration to the common
> clock framework.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSb0FgAAoJEBQN5MwUoCm2AMIP/1oLhhO+LyjodG9rA0wXbZh0
YYNf8eplyyiBRKnv5bN8R4xL0MvwQZyauXD9iJmgcE8r2aRelhd96yGsMSJgTsYt
C1qRSlerzZmUI1I/masyHlJpPZtaK5imaSVGyX/RFL84huTLPvBjvDinTpYRe/e/
MJBJV6zAtrIoEdCvxfVhSZFUc2sN809cBdbVIgTQFxgRVqqafKWY6TabEAelP/5i
73aB9MmSg/NYRELBTCebqu9MUj6Rg/8Wa0TorGTTEH77bSPfDcJC0v8A7TANuCrK
W6MHj91p/8NANIJCJzGjaHF39pj0rYJr2lEz6AE1SSx8DakbgSABDy/6es9pifra
z9+dqapAGtnGs2BCLbBnbmQ5ZvhEgmBNWpeqImfwnys+FmeaqqvjcqAmmJbXwPHx
rOqjWAqC30W2cQPMbKukWuFevyiCaZvkvPHnDMAAS3JhsDae36JW++tevXxDG9CB
PSv+sPDyNU5JMkxPH+XIfEoZCoA8RiHGI0s9wAIz1rZ5PP6p8refNdTxazJPF44+
nEMFu065pk78dVjxDmfXHZ62cxad/kUyNk7LUon+rtq6NMfFipPRckrkbaw8fobj
zA20G9SJ60EJ3sNJM7pYR/CL8ybZXPjnVMiFN4tnAS21Em+t6aNk1R5scZqhe6Hb
EasBqyr3lQWW2YLKshN9
=6rOF
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
