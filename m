From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 02 Apr 2016 07:27:27 +0000
Subject: Re: [PATCH v3 09/11] i2c: rcar: revoke START request early
Message-Id: <20160402072726.GA1384@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
List-Id: <linux-sh.vger.kernel.org>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
 <1447948611-2615-10-git-send-email-wsa@the-dreams.de>
 <56FD9080.4090203@cogentembedded.com>
 <20160331224838.GA7381@katana>
 <56FED245.4010503@cogentembedded.com>
 <20160401201415.GA25936@katana>
 <56FEFEC4.6010401@cogentembedded.com>
In-Reply-To: <56FEFEC4.6010401@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>    Thanks again! I ended up backporting all the patches up to #9. Not sure
> it'd be acceptable for the -stable kernels since there's a lot of refactors
> involved...

That's what I thought, too.


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/3ReAAoJEBQN5MwUoCm2LPoP/07DBGnGtRDlanenL15+92BO
scogb3kUayqDChSU//RiAYOb12UK8c9gbm2AavM8LNV6BAk2fAlHmma7/HZmteWH
WhxdZ/sv1gmvb6/kGBJsW2uBOpaVpLcLbI5sBU+7HG+kzBLPQpgZRHMnce2KVja5
HH/dUip5C/P5cxAXQOEsov+3Oxxje2YJ7BBfGBLBc+IOaN3h7bpeR1TFZR4SwRKd
GD+yxbZzOV60Nxoe8C1QrkanOSRkIC6ZVq8gJnkYbJzQfxfN31M8KqJPxRmwwHuC
bVJdoqHI0h4WJo/JDXMabbe9Lr2/VlF0wQSLxb5i+d/qZtyec3okcjuxnsLqeKC1
EGgARyiI71LT64ufIvBnFeUdLO6JXB2mldJDgtxoLSjqfwRV0IbnxFoVS8Dm2DjD
kTBc1aFaNvoN1RpgI1Y4OZQqT/AlChjOYheL7OcgheX12aJS+rC0PeXRji3ot66J
pbC3kxPmRzxKcG2tcTiDXTFrY2mFNHKXOOgL9f1a4QGWZ/9dMpobadSAruY3tS77
zc8vv5uaE8NsvdMYkEMfq2fAnskiMawhrS/G1GF3vsaCXTyNfCfKHmVHcxLZRw5f
ixd1WXLCQ6oW8PN7v4HdaSNgtVhPz/bjIIupohPCiweWAHTocl9sfFMW6LLUDn21
+042aKsHqxWIq24XsBTU
=OOCg
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
