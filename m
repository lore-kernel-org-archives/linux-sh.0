From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 14 Oct 2015 05:52:11 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <20151014055211.GB1809@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Pd0ReVV5GZGQvF3a"
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
To: linux-sh@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Tested with a Lager board and using both I2C/IIC. Based on my testings =
in
> > Dublin with a Koelsch board, I'd be very surprised if it fails with Koe=
lsch.
> > Laurent may prove me wrong ;)
>=20
> I've tried to reproduce the problem tonight and couldn't, even without yo=
ur=20
> recent i2c-rcar patches :-/ I'll keep running tests on Koelsch with that=
=20
> configuration and make sure to report any issue I can find.

Thanks for testing!

The good news of your message is that HDMI works on Koelsch, too :)


--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWHe2LAAoJEBQN5MwUoCm2kLEP/RttG01fkrO4Gr+4HfM7z+MO
eIsbrtke0LyK8bdiTtllJ4SUX7Be4HFvx4ynV3NUYX/PtNH0GljUABc6zAe7Lnd1
4tHLWsU7G+199In1EjvYaEbNqPFMtl/sZG/q29082igI6BKq9Lr8S0ZUQNFqQSxd
rDU+baJZNg/YLq4Ru/LVjJbEHNRWSfITGCnzZwZ8lhhIcz/A8ezjLV7zc3k5MOtb
3LLse+DOIm6k8DdtY6ZZ4zJ3vk+Om8194iMvClGSymb63LG5adyzex1F3DVDvAo8
VrqMiUViiV6W3ssT62T20d5pJ6VfiIJejPFjBzx+BoIQ8hIVZVmSFmpHeh9ZnFu/
B9jA99CtxHRdelITRU6BEO9VbcSLZlitBNGROMuQgyzq6VbDUi/rdUlobgPiJOZO
JnYZ8VPV6lusx+XuTP/Upf5q7X36MkNrdYtGM2ggAEWwpEO6hyvqywNUruFowUWk
RhcTAk8xbE5vgsIeoCel7rYZxi36NczEx7C/Jsds13WZ5Kb8eJuTGSTnDH5WnzI4
AS4jOK/1W9Furovu/zrKrhV3c7tJi/bDZI6+jxtxbLBgkApJSrjd3RMcmv50DPOY
CMo92SFAFswHS5yeEdVvTa4H4UF5aN4ATHOvNaXYTY3T0Q/gELUlI9L3rbspgmZp
gzY4qq3xcDnl1wjXFmR0
=WWqw
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
