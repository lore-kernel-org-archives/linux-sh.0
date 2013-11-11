From: Felipe Balbi <balbi@ti.com>
Date: Mon, 11 Nov 2013 19:53:31 +0000
Subject: Re: [PATCH 09/12] usb: gadget: r8a66597-udc: Convert to clk_prepare/unprepare
Message-Id: <20131111195330.GE19212@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MIdTMoZhcV1D07fI"
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <526F8427.8000209@renesas.com> <1930202.N3RGv6418i@avalon>
In-Reply-To: <1930202.N3RGv6418i@avalon>
To: linux-arm-kernel@lists.infradead.org

--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2013 at 03:09:33PM +0100, Laurent Pinchart wrote:
> Hi Felipe,
>=20
> On Tuesday 29 October 2013 18:47:19 Shimoda, Yoshihiro wrote:
> > Hi Laurent-san,
> >=20
> > (2013/10/29 7:49), Laurent Pinchart wrote:
> > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable() a=
nd
> > > clk_disable_unprepare() to get ready for the migration to the common
> > > clock framework.
> > >=20
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > Cc: linux-usb@vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> >=20
> > Thank you for the patch.
> >=20
> > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> Could you please pick this patch up ?

after -rc1 is out, I don't see why not.

--=20
balbi

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSgTW6AAoJEIaOsuA1yqREDuEP/11VUo8Dl1aGHB/XDNwG1Z0J
Erch6pGeRHYe0t6tArBUl9mQ6FXDScrpkg7V4KUzGFZwwflwsoWP3w/2Qlw8Lpc1
ioQSgRDoQPQXINcfefvZC4Q3ofi4vW9NNHJWkC/4S263ilAFaGyU4xbdeekEH5ZH
CG6Lm1cG/zfW3fISLvsFgss0x0XbvC88uZZXZbKcfeUKRuoPGhPHUgLY6pLEaPzT
q8q7zUXHiNaUi3AGQk+/qHH8IXv8Ui9bF44gWX1k3phgr6VOZf+zFvtLdDOTp/YY
46ZfP6GaKgS339dZHOFsgIauw+9ObjYGde9cL9o1wq2neJ4zrJcHp8D+tqIJGip4
BbVaHslvoP9MXxHWECksoJ455tyhEsLnLq23AaZg9cxBLY07WRbOTy0bqU95JwD8
Ap9ktj34Q26bN3GKnVkL/eaLZxfSUL9x00NmbayM3YQfBdtH5bCXFTF7Ja5xN/d0
j5Iz7+og6ljQHKDjSEeL8ZqyfFfdNda1hCU5+s8xKn9cb/y3yf3F2hzUd92aNT2a
tkQZMVGiuQs3a+xzA3WPh2DbnNjPN0AYCLYR3UJahggMxWxby1egD2B4ZtEfcXM8
XPNaDIsU8XtwG8KcoJowYqSfktjP2gy9Xsxr9Atrx56dqvwTYvjkwYfrcvlycaVH
jGunwPi9YrryYYA9nt9m
=+0cu
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
