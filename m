From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 31 Mar 2016 22:48:38 +0000
Subject: Re: [PATCH v3 09/11] i2c: rcar: revoke START request early
Message-Id: <20160331224838.GA7381@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
List-Id: <linux-sh.vger.kernel.org>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
 <1447948611-2615-10-git-send-email-wsa@the-dreams.de>
 <56FD9080.4090203@cogentembedded.com>
In-Reply-To: <56FD9080.4090203@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 01, 2016 at 12:02:56AM +0300, Sergei Shtylyov wrote:
> Hello.
>=20
> On 11/19/2015 06:56 PM, Wolfram Sang wrote:
>=20
> >From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> >If we don't clear START generation as soon as possible, it may cause
> >another message to be generated, e.g. when receiving NACK in address
> >phase. To keep the race window as small as possible, we clear it right
> >at the beginning of the interrupt. We don't need any checks since we
> >always want to stop START and STOP generation on the next occasion after
> >we started it.
> >
> >This patch improves the situation but sadly does not completely fix it.
> >It is still to be researched if we can do better given this HW design.
> >
> >Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
>    Thanks for a great work, Wolfram!
>    We need this patch in -stable kernels. The R-Car audio just doesn't wo=
rk
> without it...

Really only this patch? IIRC my tests showed that if you don't remove
the spinlocks (patch 4), the interrupt latency will already be too high
again. In any case, you'd need to do some careful backporting to rip
this out of the whole refactoring series. But maybe you did that already
and have good experiences?


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/alGAAoJEBQN5MwUoCm2aDYQAIphQ8sj8xqYciN2AVn74F8u
h0Sj73iPs5sKbkvO7lDYCrZCk89spGMTNEXkHAs6CPOUe5wTGKjnaBhiwQu7Z7AW
JmCcNbxgdjCmJbo0b7jUVqHSGlBx9TC6kOoyIgG/MiQaMPOWZZ0F2QfquPybDWJM
1fC2XVzi6mKxVDbCWUHunTf7p12v9JAemdNxnHmdTxs9xE+tA54zU/KMlkVFmkBv
KMSflwLno6Um1XrTpOA5C9eOwnLRfcGIgrC9FVEXV5RgsPPUjvgzLq/dTtfhKADM
nPxObX7oEt5czR/tJAGnlyCM1Ja7Y1MYqG7eE9LuSlXhoLGEL8VOEMX5Z/yUcfQM
F7b31zBM+/0IccM5z4J1UTV5hmrsfu91FfGz0OW/SfAJgveRcPKmx3rsZj+czt/y
I466MgFsrk86+Iln8lmjY8K9BUd3zh8/V1IajJYAx/ayPd+JKn/yBhUU2YVp/xfK
JlIODSgb0hllPYhbN3TwR/8RGi90T3EZ3+RlMqdM8RgUIx3N+5RndHRPehm66WMl
X8bVE8wViHYWnByIe60yIO25/bFy7yc1zw61pl+MYUIZ+xL+j8aQBT1fk2g15uv0
bpXKBSuiv2gpJxs3lArPTH4gyYXf3rTrlV4DKMXU39m2V4yZX9gGXAdxfr85ZLqa
qlnAJjWnTL00OuBL8TwS
=wTsX
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
