From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 29 Oct 2015 07:54:12 +0000
Subject: Re: Salvator-X I2C is working on HI speed on renesas-drivers-2015-10-27-v4.3-rc7
Message-Id: <20151029075412.GA1543@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
List-Id: <linux-sh.vger.kernel.org>
References: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
To: linux-sh@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Morimoto-san,

please CC me on such mails, then I'll see them faster.

> In my debug, it seems I2C SCL/SDA speed on 10-27 is very HI.
> (I checked this via CN27 73/74pin)
> But, i2c clock on /sys/kernel/debug/clk/clk_summary in 09-29 <-> 10-27
> seems same value.
>=20
> Where should I check ?

Any changes in the pinctrl tables? Maybe some pin misconfiguration?

I'd like to check as well, but seem to have problems booting my Gen3 :/


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMdCkAAoJEBQN5MwUoCm2vk0P+QF/yaEybFAhB2bPflYJLUS2
XrhruDue6wZESYCuDBoGDedosgGUp4kk02As9R0Q/VPzBfTMwH2UyqXLRRNohg82
eZ8+JRvlsexUBhi+3L8LwLygpqsli6kzV22uJl29zEsP62mIzg5q7ezru3uvp/zj
zgcKbiMXo/wHuqjyOvVV3QZvsIiEcKcWaSvL3TgE+r0WD4C+PbTzWbd36nZk9WLc
1Sa7uAehHIR+IvdL7MRxypJVhq1FqGd/SFlfjEP5+flFKxaH1gGGwDwU7mNrHLN8
+WTezZVzXbz2vJLQR2+PW7eoaTHc0pv1+03UK0+Av12d6QkT6qhMNXszWQYSPl3S
QvcM72SoXyZbcMTQpIDoNZhM653O+OQQRCMoyvFfhINrqo/jpm8qAxUdDA2K0fLx
9YsQ77pE3E1c2+I/MbCnr0w/7zVRQlL8HNL3ghYqDAh3d1E4qr+MnZWfBICXNIR5
aPh62ibqJNS0AXha2mTzxlNR5RoxqzkzdrSFLSdzQtDiMk69G3XwnsCxlI8yPwPE
R1tgIPM6k0je5o/Zqel39xH5JdWeRF0WVm9dAToZkGZo2gaVWL26MtUtF3j5MJnc
b+dHPl/vo5LmFsG0Aw6b2nciz4nw89ZmZxZeFc9YJnVOZHzq+mMeuqsPds3Fczw6
QNOSUWafRPb+/e/p8kSn
=dT0k
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
