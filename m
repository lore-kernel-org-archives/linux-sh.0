From: Mark Brown <broonie@kernel.org>
Date: Thu, 25 Apr 2013 12:37:50 +0000
Subject: Re: [PATCH v2 2/4] sh-pfc: sh73a0: Add VCCQ MC0 regulator
Message-Id: <20130425123749.GU5019@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MljkYTiQARTYtn+v"
List-Id: <linux-sh.vger.kernel.org>
References: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--MljkYTiQARTYtn+v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2013 at 02:27:32PM +0200, Laurent Pinchart wrote:
> On Thursday 25 April 2013 13:16:49 Mark Brown wrote:

> > Yes, this is commonly done with MFDs for example.

> I've had a quick look at the code, the regmap is passed through platform =
data=20
> to the subdevices. With such an approach I could even pass the lock down =
to=20
> the regulator driver (not that it would be a good idea of course).

Yes, or if the subdevice knows that its parent will always have a regmap
it can use dev_get_regmap() on the parent.

--MljkYTiQARTYtn+v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJReSOMAAoJELSic+t+oim9YioP/Ap4ve6YfcUrMFselkOqUNA/
6wS0zjqmyvVEKq1qvJNfXIpek5xjd4tqEgf2VFAPvdCFrHFMgybN4mzf74C+Q2td
RoxpRLx49nLphIrDIAPRvMMQ1HUBU4q512OSlArZRPp+EtnynwzOUQgFQ7JllaQa
mu4B0QKCTnGpG5pH7ugyQE86jTH15aGHqPFaNEZrosx2wVgbev7tbo9DDrPJPomh
AfjHZrLLrH02Eo2iiNiSgX83n7I79maNNiZeCxg+86eqQD8P5lcU22YB0UfSINDI
vDeilc6UwbZIxMs6//XuqWOoi/GUSoZSmXrRj2VqofJX9dgPeKoHyJ2hFnAZjTg0
qRGzVtxLo2SugK6NbSpeqKVLpSBtOawUolyNSko0Sa87D4wvnafWD2JlJZat735x
Hca3Wz/tpVQDww1mZsjVpneuQ4bl6sB87vu+HauzqTIeR2V1OvEYw4Zy8OT6eDGw
4XlpTZg2NZws40X2ofo+e4OrZHqv0ov85SNI2snSkMYYuWJtHSxI20SYx+7FIlw0
2wBT1AfZjqsbNnDoWwINXHh4IOaHS1IXkrJijBvBxVWEtTTZTOWNt4kKX5ieZhG+
8akKtH12Euvx1asCMfyhN4T98jU9L3g7x0tsV0Sz5SjfG3beslSoPdjq7Ua6ulWl
o9KAXKCmCdTGAO9e7N7O
=1hzS
-----END PGP SIGNATURE-----

--MljkYTiQARTYtn+v--
