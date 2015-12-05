From: Joe Perches <joe@perches.com>
Date: Sat, 05 Dec 2015 00:41:03 +0000
Subject: Re: [PATCH] MAINTAINERS: add myself as Renesas Ethernet drivers reviewer
Message-Id: <1449276063.8611.25.camel@perches.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1846877.jRW8849mPU@wasted.cogentembedded.com>
In-Reply-To: <1846877.jRW8849mPU@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2015-12-05 at 03:03 +0300, Sergei Shtylyov wrote:
> liAdd myself as=A0=A0a reviewer for the Renesas Ethernet drivers --
> hopefully I
> won't miss the buggy=A0=A0patches anymore. :-)
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> ---
> The patch is against DaveM's 'net.git' repo.
>=20
> =A0MAINTAINERS |=A0=A0=A0=A08 ++++++++
> =A01 file changed, 8 insertions(+)
>=20
> Index: net/MAINTAINERS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- net.orig/MAINTAINERS
> +++ net/MAINTAINERS
> @@ -8929,6 +8929,14 @@ F:	drivers/rpmsg/
> =A0F:	Documentation/rpmsg.txt
> =A0F:	include/linux/rpmsg.h
> =A0
> +RENESAS ETHERNET DRIVERS
> +R:	Sergei Shtylyov <serge.shtylyov@cogentembedded.com>
> +L:	netdev@vger.kernel.orgc
> +L:	linux-sh@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/ethernet/renesas/
> +F:	include/linux/sh_eth.h

Hello Sergei

Typically a reviewer isn't a maintainer.
Does anyone actually maintain this?

I suggest you mark this "S: Odd fixes" or
remove the "S:" line altogether unless you
really want to become the maintainer.

