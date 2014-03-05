From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 05 Mar 2014 15:07:46 +0000
Subject: Re: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
Message-Id: <20140305150746.GA9228@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <2207635.bd10VfTU6U@avalon> <20140305135431.GA7985@katana>
 <1460103.hdWs652aMT@avalon>
In-Reply-To: <1460103.hdWs652aMT@avalon>
To: linux-arm-kernel@lists.infradead.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> That's fine with me (although given the low complexity I would probably h=
ave=20
> gone directly to supporting both clocks) as long as we can ensure both fo=
rward=20

We need to wait for GPIO support anyhow to get it real.

> and backward compatibility. Should we give a name to the clock input thro=
ugh=20
> the clock-names property for that reason ?

Not needed IMO.

> > Note that the devkit will most likely be the only board ever with a
> > selectable root clock.
>=20
> Most probably, but that's no reason not to support it :-)

Not in itself. Yet a low demand might be, a demand of 0 surely is ;)


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTFz3BAAoJEBQN5MwUoCm25P4P/2+hXs1y7vkNIcG6IOS2xOXj
Qnp5MdKlZVEawK3bDpLseHtgeFsESejnk6Icoux2GRTvUqFdZryI3TsOitYJPwsm
KDPg7wGAi4WkJNQiRzNp5KoY363fKy3d+Pvb1Cq6Tv13bykCpTOssn5hPjHVAF1z
aCyyTFpUdzOjXTq/cl8RHYePTJl1wG2sznuq+3flqlma0AfqcBkFPZ6xoigoM1wb
HnsSYOjNMoGw1vg2dgR44u9s9hhtR5Rr21rEh4dcAwXJ7t5Yzd5UXcgyGfgd7jOc
mkwLEdrfgClklWrwoepGXlfCX0/6UuBHhAlGUE/w1aA/a1z0s3nVdSA8pwiwBYaB
NfH5NYonyhkC/L8XBqA4L4Mr9H0RsRCi41DQiRAQM38zqm9rQtcteIcnc28yfGrS
bS1+N9ZF2EwVh2EZGYsolVo2d0s55Xse8H/Zz48xxlUcW2UoUufikKLyXOBI8AVN
8HKoHasW5xuVjCqKcXrAvkRC8lxBKrWE3ZRretROqojYgea5+RvRMHJ5FQr4mjlD
CJ9pEK7/rEr7Bot4w6LcZ5WtP9FW2aL87dw8f6CH2D6GMlLEQQtXqpvQGrQXb9s3
t5SiX1EiNebel7I9eyYGyIC4tcrXCFKzi+RIlK32D3DVGFKG9jKs30OmJnNsIe5v
piXojS0reZoach46S2VK
=5HZ6
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
