From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 31 Oct 2013 12:02:42 +0000
Subject: Re: [PATCH] i2c: rcar: fixup rcar type naming
Message-Id: <20131031120242.GD3431@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FFoLq8A0u+X9iRU8"
List-Id: <linux-sh.vger.kernel.org>
References: <87ob75zgn2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ob75zgn2.wl%kuninori.morimoto.gx@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2013 at 11:36:52PM -0700, Kuninori Morimoto wrote:
> b720423a2627f045133bec39a31fe2bc0dab86f3
> (i2c: rcar: add rcar-H2 support)
> added R-Car H2 support on i2c-rcar.
> But the added i2c type naming was H1/H2,
> instead of Gen1/Gen2 (Generation 1/2)
> Gen1/Gen2 is better naming on this driver.
>=20
> This patch exchanges rcar_i2c_id_table[],
> but it still can keep compatible, since still there is no user
> for i2c-rcar_h1/h2 at this point.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

OK, since the driver is relatively new: Applied to for-next, thanks!


--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSckbiAAoJEBQN5MwUoCm2YbkP/RRmvwlezK2ozUUoUIv2uuXa
Bl/6nxbk6Cn6irtgSFcMilGHBGfwPsQJDt4jgBQTcw0oZ3hi2vgh5bEbxGvYBiRY
tj8cviUrcQPShOhk6mhENP+u7bg/TDDUmsc0sKXPwld1m3o0uhM9UtxktVTjGGQm
CyQ2WzMgXYdGqK78pFegBGDRxZAyEnifv70wqiWMfWCYrx4mRXq+WJTdzWEBmFgs
vcsCxQ70wrkgv6Kuf/3not1wKeHdfuz2kE6I3Rie2VIo+H5Yq805xwKoHFTu969e
BP9bb7qNOZck6bAaUN2kPRIdlelfLuEnY3g+4q7Z5i/wW//ZWm5cU9OkGbAMwaHg
SyIAtgv1mX59BIfwSZo8xUTayuTGfv+F6KlzkoR6dHoQjmebm52qsZxra890xeFg
scJUEKMROOZSppHLbpxhE+93F5MGouhk+vAJ9H5on39uAXtn5bGpNIQ2M9U9j1B8
kS6C7YaBZcZ7Q/rAK5+xqoosLfq3mYLhKW5TcvbjKU5uOf6a/6T2Nkcwgdet0UnL
rRIw8yQqmkxZy4QSzXldpzFUUcL6/aMR7jS1i3JTqppOr+OHu75S2KXdTxdTDN/V
YKMa4SHYB42EQovbb6H5ZLM3+Fl9IcgU3DEAEyn5TGRVnvfbhBEFM4QtKsGodwB+
SKMS+BaJxvXSKVWjPJSm
=IXEM
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
