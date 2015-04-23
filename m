From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 23 Apr 2015 16:29:59 +0000
Subject: Re: [PATCH] i2c: mux: use proper dev when removing "channel-X" symlinks
Message-Id: <20150423162959.GA4689@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
List-Id: <linux-sh.vger.kernel.org>
References: <1429777749-15278-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1429777749-15278-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 10:29:09AM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Those symlinks are created for the mux_dev, so we need to remove it from
> there. Currently, it breaks for muxes where the mux_dev is not the device
> of the parent adapter like this:
>=20
> [   78.234644] WARNING: CPU: 0 PID: 365 at fs/sysfs/dir.c:31 sysfs_warn_d=
up+0x5c/0x78()
> [   78.242438] sysfs: cannot create duplicate filename '/devices/platform=
/i2cbus@8/channel-0'
>=20
> Remove confusing comments while we are here.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Fixes: c9449affad2ae0

Applied to for-current, thanks!


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOR4HAAoJEBQN5MwUoCm25MgQAIzVnJYNbwIPJdwMAko6DnEG
TG6lsuukKc1lMTVftt+IKznaJ6GsC3WEUt3sexxPSKwIK7Ie99p+8wwVImJpZLYK
mx1Ne9MADLcKdgMGw4EnIpkRsW0WXMG4Ww/D1PWRoryfvBhcaAxyPgPgfLgKlUiU
NTB6sdUdsB+ADQ3WeLQembYSysNxsU5Hq3wiPllbNkkYekU8H3QgaLxlT3n4SY+B
oqzl99Nga4eYyqq7Brmwc2Nh0jWuAWB11mFuZQMFOXeNbD/+6Ia3k8xs82cbtamd
+n+rfbuVrWFQ7nt7+oNZrLOKfnHaQMM2VPrI2fKWtbgb1llQBTSWiZxgkqzZ9yZy
+f0nSOdfs1FXeQlP6jYBOzxLSmWZLLPWjAA3nx3iKD8QLdg7nG8/zKrLofJg+D0c
7FurUs7lFHSDDfrfR16lMggQKEobN5M10sJeP9MFo5D2FanAEAIXnN+e1LVema2L
uTG+E/Jn5of4CH3ox1zjauTXCeEZXej+KNwKw2o6Ea+cTzcOMl5DgakOqbGQdzNv
Rjk+xnrGEc5pTxXSkFy2B4zT94pW/vg1tiMalKfqcDYR74En5BqRharKfo16QlrO
1VHtw7/ZeSHhgsrKlCTQUj92s1fykxexh9ap+JwQZIlJR+Ahh1exQiMrtAyTQl4X
7qcIFDH37P+jaxgjzf7W
=dlmQ
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
