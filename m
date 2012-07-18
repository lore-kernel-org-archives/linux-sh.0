From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Wed, 18 Jul 2012 12:02:52 +0000
Subject: Re: [PATCH] mtd: sh_flctl: Switch from tick-based to time-based timeout
Message-Id: <1342612972.7530.19.camel@brekeke>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-AgJ6QFlEPV/EGajUF8wP"
List-Id: <linux-sh.vger.kernel.org>
References: <1341410726-10562-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1341410726-10562-1-git-send-email-hechtb@gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Bastian Hecht <hechtb@gmail.com>, linux-mtd@lists.infradead.org, Linux-SH <linux-sh@vger.kernel.org>


--=-AgJ6QFlEPV/EGajUF8wP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-07-04 at 16:05 +0200, Bastian Hecht wrote:
> Instead of counting down a compile-time value, we use a value based on
> jiffies.
>=20
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Pushed to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-AgJ6QFlEPV/EGajUF8wP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQBqXsAAoJECmIfjd9wqK0u94QAMU39xcd1UJTnb8LbX5biFSZ
S4wZT3cQAbonwcB4AZ4t2yljOG6Qln6u4eK2HKyQMLjicc2djINRTpwzmeKFmZrf
+0s47Xxy9a5p3pgL1hfbUi7s7UQEUvHUwrgYDSBJRmxXKhXeI4M8jpkQrnp14KYH
8oZZoknGB9Ljs0hZsZGnnRv01eQjlvy/AqKYVlSVmpkhXruwepSQcfcB5QvS71XW
zED0z4ktEmFbJPBcX8k7qoEFzLl3OGUoKy/Oa7NFTCvW5wBhTyrW0VcCFo1i8VzN
Em3pqW/1gLE4cqkkjpSQLkJegEwq7vkgmH6Cr4PrSGFIWJpBjSuymCg/+9zlBdeZ
+VwMrcta2OSg/wBRVo7R4yJ1DDfNSU2nRzVafWuYUjYLKpi8NUR8zpShxVP25ht7
2gYrZLpjT+2zqzLPH2s4xsiLf13F/hH8Ixt6b3a2+esZDXoctlxa90aPE0H2mDq1
aDyuNqPHr62CGDD+2/gjZ7Mx24E+FoF2ntkz9BASBfTzkxNdJ2qrqF5rCSDreSiD
mnAj/Ts/4L6Kp+naCj0Ns8/n8olqS0Lpvnto5L8CTrW4K6UW/1JEZDTVaxap4fCD
LelcRSLsgEUtYFLWNRsZc+G2fGIDVD5pdMgcs2cbE8iyqKWia7AvUMZqsB4vOIvW
WG0y1sFXb0clvsqemACp
=XToN
-----END PGP SIGNATURE-----

--=-AgJ6QFlEPV/EGajUF8wP--

