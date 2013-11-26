From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 26 Nov 2013 01:59:51 +0000
Subject: Re: [PATCH 09/12] usb: gadget: r8a66597-udc: Convert to clk_prepare/unprepare
Message-Id: <2503238.g4sCZxTpb5@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1785511.lpaN2n2fn7"
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1930202.N3RGv6418i@avalon> <20131111195330.GE19212@saruman.home>
In-Reply-To: <20131111195330.GE19212@saruman.home>
To: linux-arm-kernel@lists.infradead.org


--nextPart1785511.lpaN2n2fn7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Felipe,

On Monday 11 November 2013 13:53:31 Felipe Balbi wrote:
> On Sat, Nov 09, 2013 at 03:09:33PM +0100, Laurent Pinchart wrote:
> > Hi Felipe,
> > 
> > On Tuesday 29 October 2013 18:47:19 Shimoda, Yoshihiro wrote:
> > > Hi Laurent-san,
> > > 
> > > (2013/10/29 7:49), Laurent Pinchart wrote:
> > > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable()
> > > > and clk_disable_unprepare() to get ready for the migration to the
> > > > common clock framework.
> > > > 
> > > > Cc: Felipe Balbi <balbi@ti.com>
> > > > Cc: linux-usb@vger.kernel.org
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > Thank you for the patch.
> > > 
> > > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > 
> > Could you please pick this patch up ?
> 
> after -rc1 is out, I don't see why not.

Great then :-)

As this patch is a dependency for other series that will go through different 
trees, could you please provide a stable branch in your tree with this patch 
included that you will push to v3.14 ?

-- 
Regards,

Laurent Pinchart

--nextPart1785511.lpaN2n2fn7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSlACcAAoJEIkPb2GL7hl1UMYH/1aK4Qy1rr5gx9wxs0c4+JDc
sBzBezlS0pAPJH2ULI97YC5SnCj+VHFhBUO4n66FcAoCJpaK0JroEt8OYHZ7c80N
AdUMKPlhkcW5Pdr+Vt2/WNXFKTiba6xkl2Dp0t3X1MkD8ekCH6WTMEgOVat455Zf
MTsZxsB2+XVPvBqTjYsLwdWwMN+kpNR9DzLx28OqV8kLMZtxRj9MNRQQemvCgfKS
NmXD/4BhvefBNL1ltbFwEhvf/Xf2YCNecEuubni0I2cOfRxwal7oAtdlna4TcXm5
K1I2F7GVtM3J+pJR7oR7Hz/9KIIhvBFkWmUCiibI/07ESu8a7AFL6YWurmxKqF8=
=9vgg
-----END PGP SIGNATURE-----

--nextPart1785511.lpaN2n2fn7--

