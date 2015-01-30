From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 30 Jan 2015 17:01:30 +0000
Subject: Re: [PATCH] i2c: sh_mobile: terminate DMA reads properly
Message-Id: <20150130170129.GA8476@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
List-Id: <linux-sh.vger.kernel.org>
References: <1422552796-11315-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422552796-11315-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 06:33:16PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> DMA read requests could miss proper termination, so two more bytes would
> have been read via PIO overwriting the end of the buffer with wrong
> data. Make DMA stop handling more readable while we are here.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUy7jpAAoJEBQN5MwUoCm2fzAQAIrIfLOI2Thp0kQMI8uw97mD
zD5RvSpLkXOt1LDIrCMN/PVM4eD1Sxohn6hOH+ZQjpTAPMhjGSvsSkFDakQpQnBd
sLtrMjc9OaYTLbXvh7kE3e8OsrHEDwPd3djuR7Z/oiNqZuwgZinSeM8b7aT3uYl+
ghyQEJi6WBdpbWBDXFSdGkSdvXCsJ/e5AQINdnE61uvXIkmO6EQlUgG43wLY6ZEh
LWpKyi7ZerYd8HI6nrkIDU2Zx3MKenvnSp7xJ7os4X/sMACDvQc0Ieq4lK9vHifc
KKmR6iA1EMmJRMfuBA4i4cZQeP0romYWrxuoQpG9TG0QYXMapXhutcxOAtZ4tYtg
zyMQBpN5o1bjKqMJWdvOQIj5aVwwa37nobSvSHki8pvW/36L/bPpe3iVW9foDTxz
XzEihzlZFr4eALRMKisTUJ+/5IYshOly0Bm1lAhMTDXEj46UfU+IpaRYtpQdH1U5
0wWz7BJqopwQ7U7d1u5JTBnSqUBC2lydtREG3wf33zallon3jGl1HVRv685Z/FVr
9Ou9HK6EjaQ4xIyHCLUbzYpizzo1GDoR7DCFBmYKmQm7iU/hTnwk1Kx3OCil5JMz
P50uZKivkpQUqFCtpOaVwLCPH5C3buJRnA9MVw3s/XB8JI9figMBAXH+a4aLUttk
1isKyyp21k/yuN45LInr
=y3kJ
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
