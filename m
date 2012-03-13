From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Tue, 13 Mar 2012 11:15:13 +0000
Subject: Re: [PATCH] mtd: sh_flctl: Add power management support
Message-Id: <1331637313.3595.10.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-y40YAjKdIhLKn4LaTOVv"
List-Id: <linux-sh.vger.kernel.org>
References: <1331393478-30850-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1331393478-30850-1-git-send-email-hechtb@gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org


--=-y40YAjKdIhLKn4LaTOVv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-03-10 at 16:31 +0100, Bastian Hecht wrote:
> All transactions with the NAND chip require a chip enable signal. So we
> wrap the runtime_pm_get()/put()s around it. As registers are cached, we
> need no suspend()/resume() callbacks.
>=20
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Pushed to l2-mtd.git, thanks.

--=20
Best Regards,
Artem Bityutskiy

--=-y40YAjKdIhLKn4LaTOVv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPXyxBAAoJECmIfjd9wqK0PpoQAL0j4ijACz6BysGaJX9AxwwU
+ETZDhmWVnFRlC1HvbnBwwiLu5G+ZEsF57+AdBgEcwNFs9z/w9O8xHFUjnbabUiw
nNhvS7tmu+ixB5sfnX/Xwsl41FxzGSObKH7MSwzrZ5919vCSQKtiC8IWjoE/uPDR
zw47UVkly8mSyvv+PTb9Wf5uZ6dfyLGo3ASv4HCiQouYznI/7Hq+UkD3ibG6WUbb
n776i+xqlXYlC+9hWDFK/xbHfA7swW1Ht6ufOk1ZbJQdpHd5UbGyGFaFbabj9o3n
O3zHSbsLKKlnPZ+RhyfGSiB9Asx6XmyP32AWnWXU+7zVBT1sP0ak8wuaFznjStio
g2q8eY+7x4RLJ0B1OaBHlhc4xw8WV0q9eM+WoqrFmmPET/gyeVEK125GLhAd9pHV
fvlge3wSTNm+pCrR62krbnivaNwY3KQGNT+8MsNHV+hDym31GAvA7NFOatyX0c9h
8FayNXwTl8qbS5nQeaXSEKDUbweWPHRm4MnjSFFnHOYMEeXDtCsJpHpCh4jSF1wl
aFUcv6aEULRGAf6BTIsQ/pkUc5iWjcCjKxVmZv+oPvA5sNQAExV8bvAcMT73ALDl
NMafSpnSdCdnQnWlY9CwHiAZMYn2IPfcsfCMAElXaI1BkD5iu5ltwPXNREM9jSVD
6Qi8izQDytX+JGpELF9m
=swLi
-----END PGP SIGNATURE-----

--=-y40YAjKdIhLKn4LaTOVv--

