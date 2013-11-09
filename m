From: Mark Brown <broonie@kernel.org>
Date: Sat, 09 Nov 2013 15:07:04 +0000
Subject: Re: [PATCH] regulator: gpio-regulator: Don't oops on missing regulator-type property
Message-Id: <20131109150704.GS2493@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fRTiclqxXzPSgD3k"
List-Id: <linux-sh.vger.kernel.org>
References: <1383999148-2516-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383999148-2516-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--fRTiclqxXzPSgD3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 09, 2013 at 01:12:28PM +0100, Laurent Pinchart wrote:
> Catch missing regulator-type property in DT and return an error
> gracefully instead of deferencing a NULL pointer and crashing.

Applied, thanks.

--fRTiclqxXzPSgD3k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfk+QAAoJELSic+t+oim9jn0P/iQATpoUh5HNvuQ5fXYsSf+f
Q8xW0O2QsFVqiv4YQ7W/aip7Xc8KAH3wQb18PWZL+9flP6imPI5HsO3t08kDW1x1
jQ0JEyoqXA0C7RKUAhDLYNC1oi+JHLvgYnjTWCr5uPb4YZeo3m0MMuT3r9DiI5yZ
PGkzMS31dyAJH1w/mbHdihM5CfcDefe4qGJafkIHl4Mxw6t+kETAjnxGeZ/9FRh5
faTeFA8ninBFLXMODhbw9wR4v9+iPiuvxNsWH/WjQbj4ceRiC+ndHkhKZ2tnncRx
rxmYd/488aG9BhN+DKYRJ46nVOszABI0llGAAPUL7LqtL06rhPczZAWNgczb/Qks
KDApbWEysPQ4+7jwCPkh2L6YoR5nhTsMXUM5L90d3R+33P3F50ykijLGsoSlaq9Q
F+LcJc4SKocHk9RKYZpRo+f/INyuZeVh0YuagIh+4l6Ngkmr5yTXeFk1iELg2z0T
A6Ng7RHSnn+F+byvGYaxZWGexjkstOKXmuX1+/fQwVKS8fX6MUqNANMSpksMBxR0
BkeCvgfEbS3WIdFcSbvpYM63ooxUcJoE9SyWCmklQzZrHPmgveSYbMmHDRFekJiG
PsJoRrfQwjrFDYZTDH/2mYiTC9y6PXTq8E1Z2K0FpwhVJ6VpeVgGTn9Sb9un8duL
gvKU8ThdhPTXSMzrZCh3
=08uP
-----END PGP SIGNATURE-----

--fRTiclqxXzPSgD3k--
