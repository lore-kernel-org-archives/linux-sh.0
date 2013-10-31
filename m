From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 31 Oct 2013 11:50:01 +0000
Subject: Re: [PATCH v2 03/19] i2c: sh_mobile: Enable the driver on all ARM platforms
Message-Id: <20131031115001.GB3431@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tjCHc7DPkfUGtrlw"
List-Id: <linux-sh.vger.kernel.org>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383086274-11049-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383086274-11049-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2013 at 11:37:38PM +0100, Laurent Pinchart wrote:
> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
> COMPILE_TEST.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Both i2c patches squashed and applied to for-next, thanks!


--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSckPpAAoJEBQN5MwUoCm2BcoQAJIfbTEwVm2O7KbY/v+DOFeA
lmAzm4KZKMQiCwJsdNk11bo9e0kw/big87ijY/COCKnjnbFYCYWZN9PI8iRjul5y
MCZ8eUsrR6j0DVS1NKzghTsYqRnu6PYwSIysfkc9A7bQ6/kwwUfPaUSqeFSLr3Rl
f18TCzw7xxrKokgHhi2P6v31hQ+qDwetY8GOZQ7wfKypNJE/V351+INrQ+NI15or
w5xXlJ0TFNBktB3fGlv4MNbUHEnK/XubLxGmYytZAKoZui/AksrSFtMZ9NYj1aTh
Hn7vjq3pfMY6H9l+rL2NRgV8SClf991yNc77spN7q888SSBeDF2UJmLfRr/Ckp8e
Hp0A50gVMxFDbPKr/sI1ysc/ZWknPx02H2i+4Sm6YIq8ElcxzAiut/GfzscSXbuD
pz5v9xyS2UK5poCkwCgcr8SMydCdBRLFGl8GKlPGDqanP6aeA2KX0oG7Tuxfmfi/
cntQcvPOnSTiy0Gmk/0IkWQID1mHXt3NQInn3T5QynHhXyI4vd3GZQVw7DYMTVen
tVztMfrG0IhBUOk31WSiNw8C0HoltHFBZ6u0SBTxTJTeGT2pKiYU+avSw9DJjK7E
EGNii+rFp82BxMHd3xdWy9sdS4gxl3JVva6pqzpdBD6LPWPGaEkOwTOXO/RDw3/U
vh5G+9SK6M+3k1UMXi1b
=JmO6
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
