From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 03 Jul 2012 10:06:56 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <20120703100655.GF29030@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KJY2Ze80yH5MUxol"
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
To: linux-sh@vger.kernel.org


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 03, 2012 at 06:59:30PM +0900, Tetsuyuki Kobayashi wrote:

> +CONFIG_REGULATOR_DUMMY=y

No, this should only ever be enabled as a crutch to get things working.
It should not be enabled by default.

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8sQ5AAoJEBus8iNuMP3d/GUP/RSGy6yUwgU4vJe+pgExNr6b
b98RXsTI6UqdZSptBKjFCWDXaWUSBpQXIFLZ2qEQv3LPGevfQf6EiQZkgB455HdM
SdV5hRgsH80jT35rzKjutyMADDEkREJPx5Te/c9I0Ls7Isggv5HiN0HYceBdovp/
qfWHpiOlQPyX8pQ0bXu0T7bQykeDRhFv05hauN1uXedfMPjosQah6vUvqzVQHB+u
jLWc0Ah4CJZNiFH7NhzLEautForvjsRpUZihncUNFFNe9YOzz3S4ndoXy9lkOcyo
/sgc4CnmY/LwPmEpHlO9ZWheomLBu4WQ1EIvB/JI1q+L8LBGoV10vBGBuXWuXugl
vCZi1qwgzbhgNm4OmsjGnMQkf5+n4LQBOI9hrRvZIKUDw96GopFibXsXZkRAI5+A
Q3TqU7E7xTh2DbR+hSLoFQvGTb84fMk2Lk6e/RA1c36iWuWrGKpjZuWXHC8UVT1c
xdcddBPB/Vkuwc30vwfr1V5kAjvKBAgTUjWe7GbAXXwPv+SxVe3xHu2neH+1W6fR
WMgCh5kUi11Uqxt+/XiJiGFXhucdEyMHfmGWH+h/kyp6jFTdTzzJlhT6owHU6Zqg
EAB56s9yJBB2KbA827weNMnvp0XVCUtMW37N897aWg4Hp8yS+SwizxrSvVrTDXhO
xDvO+hJKn73wxJGqXbxN
=mC0Y
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
