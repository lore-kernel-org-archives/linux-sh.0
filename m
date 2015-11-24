From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 24 Nov 2015 21:05:01 +0000
Subject: Re: [PATCH] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <20151124210501.GA1584@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
List-Id: <linux-sh.vger.kernel.org>
References: <1448376627-12255-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1448376627-12255-1-git-send-email-wsa@the-dreams.de>
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Note that I could not yet read EDID with Magnus' Koelsch.

This has been tackled as well now. The clock for the GPIO controller was
off, so no interrupt was passed through.


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVND9AAoJEBQN5MwUoCm2xEMQALDggIMD4RQAuCUOS25ZfvQk
iKQltJPesRlzh5KXtRSZQnp9HfEaOp/mPDGjouJ73z6Tzk3K5UVPcg/t1XbdqT8i
NIZ1y74u7XcXVNy1E753L4HvBu6mwfetFzlWOTW55lz/Aexpnc78+VTtamzYJqky
0FknGgD46ee9Dwnw37XR5N/14snmfBSYcRNVgxMQCFIWPfNbzmZS1tXLQd47LcmP
TvhdMLt9jAPdMmr3olhZttxJJny4Fdwg3YNHA9tEScIixDU5LgdR8WdFo8Cf2upy
O0nMvtHcORU5gPrxyjHrX+QIUCaiqyHvks7ijCmdycDWzGE2Lx3Nh3nw4mwm1qvX
feFd+5lSFnzxWV4o8jdqyP1GjXtMjTETk7FLHxPInHXH/ymXlT/30THye5oZmgvB
Co0cW9n/MIPVzTr8iISgRzoGy5ZFgsVqmzdHGt7UjfeWuV+7mNsqCDlU/7iYvVDk
z8vsnLTJMqW/au/MTSOfEDBIRmQTkk7MA61vilATFvDAVdr3CIeFh55ogOWqvg2n
mwRFks+42mnboQCadvlseotIMHlj38TxW0I9ccDD+PVGeKVYKJsovPpy6jEJVxgt
bGksj4kDRhylVPP2P3EZt9RczlKfZRmZgq6p+YEWBX46vrNaqYdGDkLyhhnjggNF
HYror2zcuYgnve5lfUDR
=6xEN
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
