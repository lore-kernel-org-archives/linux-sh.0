From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 31 Oct 2013 11:49:38 +0000
Subject: Re: [PATCH 06/12] i2c: sh_mobile: Convert to clk_prepare/unprepare
Message-Id: <20131031114937.GA3431@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383000569-8916-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org


--YiEDa0DAkWCtVeE4
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

Applied to for-next, thanks!


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSckPRAAoJEBQN5MwUoCm2DPwP/1jnvjIfbtXmPQsC/wgY7XJd
qhUt/41sgRHFK4gKKBcj0wSANC664L7iM9RUyw/yFDpTz3UT44My3Yne+1I5lLFN
wes0u4lxhfoT1n0j3k3Rs0YKUKx6gP43UT/ZhIqFngr1TuAQ4/dOwdya5ymRLs1X
cJSoyEeRol1awShgeVKNdmMTp8Rzvagp2SsN10mHpgQMyphVoF6tWqvw40ozBTVS
AfWCN27gueeu46psT8+f3/EP/7d7AuBWtMQwx6ViSLN2RExFn4kmy5gQ3h+5N+YX
PvAktLUfBvwHU+bJVNGC/yhbsOpu2YN9140pfDNKoF8zf53EoLtZ9vS/wwwKRinS
Cal0Axwer1zBAlBKb6rmWTEdb98ITH5sSsxjHtg6blFPnhGTtCvWA5TkQVVxyagW
wdBm3eTprJjsSDQxZbWOl3QBUGi/sHTRjthk/IuF2SLAzwErNCpeBfMduEPvjlI1
x/5qoel6gh6lo3Dh9EOjSZ9NTTcgKQ5BKxvGRtVlARgQDAyxYeYUIXZ+7weZGDHr
c9QZrcGQTcwC034xzTArYhRg2L7nWgbLrVBRaj+YVS69c+5IaDn5llMJ2cqJFeSt
Wdv1WEvk5/XmLvUC8GJ5hxorDafd8CSAXZ8z8yEcHoUK8DoaFKDvkiyMB8G1QnxU
d8Pla84o60Msi9HbkalZ
=eGA2
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
