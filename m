From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 04 Feb 2016 19:30:37 +0000
Subject: Re: [PATCH v2] clk: shmobile: r8a7795: Add SD divider support
Message-Id: <20160204193036.GA1958@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
List-Id: <linux-sh.vger.kernel.org>
References: <1454135639-4102-1-git-send-email-dirk.behme@gmail.com>
In-Reply-To: <1454135639-4102-1-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 30, 2016 at 07:33:59AM +0100, Dirk Behme wrote:
> This patch adds SD[0..3] clock divider support for R-Car Gen3 SoC.
>=20
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Since we don't have UHS support currently, changing the clock is not
really exercised; but the code looks good and if it needs fixing, we can
do it incrementally IMO. What is currently needed works fine on my
Salvator-X for the exposed SD interfaces.

Thanks,

   Wolfram


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWs6bcAAoJEBQN5MwUoCm2zYMP/2OYrmWjiqqkLqqm5Lle5lmh
XvVWZ/qRKH5ixDP5E6FpRUUC7R7wG9VhdBs1rAYrmypaeibhJNkI8hVQGvwoEi+X
bMi4fncoCShS1VIgmailH0f3Rn6tjZwjvECLfA2qMOs6IOPlXsX1cdUK79a0XvBu
icsWXEecNj8h12kqx0CL2TNL5hpVsOoWPwtCi4/NlAcbsXggJFzQuQr2ytpfP0JP
vIe3iXqk+vOV5C+9lWJpCoVz573q9F7P62dMWaoLxHScb9tMeeEap1OXSoWKHy+M
qRXueYpMltkQTSp+zBFnx3XWDRAtn95WqHqNduaBGZnNsgr3L1tt36sRnQ6CQzq6
bDBhTAhHH5OmuvxcVKebupvC5EeF3opF+ANlSH7LqX+5Yoq868iM8vl9lmzidW9m
bbYSmayQTGNaQApYkl0g3fojXGnpoc9hQF4n1GpE+SHz/9XUKq0N+Qp2KKrUBKMb
LcWzWWWVXVAB33pZTluvnBb4CsAcrmoy/KPbAVLVYB1bBno+h8bmdx0x0WB+Nyy7
OQiMUv8gKgd5e9rCyeo5Dbq8biOGApKF0swt7yBF9QZFvnIe8a5quTwn8VryCdHi
41s4VldOBl+yKRItIUnEMkKOwpfyQjxavpDvRNDeHthCflS5ITeIPDcjDMV8gScp
SzW7E0lMNKz5vYTKYEZT
=1waK
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
