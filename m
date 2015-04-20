From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 20 Apr 2015 17:36:38 +0000
Subject: Re: [RFC] i2c-tools: i2ctransfer: add new tool
Message-Id: <20150420173638.GA1452@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
List-Id: <linux-sh.vger.kernel.org>
References: <1425053816-19804-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1425053816-19804-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2015 at 05:16:56PM +0100, Wolfram Sang wrote:
> This tool allows to construct and concat multiple I2C messages into one
> single transfer. Its aim is to test I2C master controllers, and so there
> is no SMBus fallback.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>=20
> I've been missing such a tool a number of times now, so I finally got aro=
und to
> writing it myself. As with all I2C tools, it can be dangerous, but it can=
 also
> be very useful when developing. I am not sure if distros should supply it=
, I'll
> leave that to Jean's experience. For embedded build systems, I think this
> should be selectable. It is RFC for now because it needs broader testing =
and some
> more beautification. However, I've been using it already to test the i2c_=
quirk
> infrastructure and Renesas I2C controllers.

Jean, my tests went well and so I want to brush it up for inclusion into
i2c-tools upstream. Any show-stoppers you see from a high-level point of
view?


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNTklAAoJEBQN5MwUoCm2InMP/A35+E9oy+kUYOniyroNeflT
9uNkSfI785ygma+hCBHvoMRIMyW7pXsjg6+XhwLsAFOGZRtVpCkixdcOI6UAtRcQ
nlwptY5amZ5twxwOTykecrq5ulo8Upq+8W2vmLUMIOJhJPLejttazzCNdvt+wubw
4+dQSdZOySmDQBIm47y7N5Q4F1dao/FTkEte03qfMcWX59rx9qw2iySv6CMZCrr5
06jXrWDbhag1l1OfViPTrXCftpGZIKyshpDjOh3oSTrdIkZladWkVK+wZZZkx9qR
9Qt//YFzwet1RRwnu0wcocZhTaPxkUnnM5CJ9Zwl0vKl/TM3ysLKz6aPhRHoLJRR
YOxreA2UhURYWGcU3St8LTkJ5NdPOTQKIUz1ZQYydWmn6t8SdxHaeLapw2kl4dSl
8jMRvMH9CbcAyFLN99LQhs2mixCONvBfsUxXRCXAyC0xGn8RRANF0S3uQ4u6LMuJ
kVrg2BQLhMDzyPa88qbnjKw/B4Wgo+AaU6kH/q8oTFUpDcPcjXXdKOW8jDbzvH79
JVFkjrx4e5bXU77yRvOrp+EqqI1OU0YDXklaAXM9oEA7u+IuqziRu/BbcRLDRu/R
Kg0g1jRBOpjPvuWlke1bLtq9HzsF05EuCzYZrV2z6q+wCVjTmy3K2uS/UlnppPew
9NVdkt5PcjBy1cizOFX9
=rEkx
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
