From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 26 Nov 2013 21:43:47 +0000
Subject: Re: [PATCH 09/12] usb: gadget: r8a66597-udc: Convert to clk_prepare/unprepare
Message-Id: <1896305.mmzrFTZ95a@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2111751.RcBFtlCgef"
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2042860.IXZhL6v7c2@avalon> <20131126195422.GJ24310@saruman.home>
In-Reply-To: <20131126195422.GJ24310@saruman.home>
To: linux-arm-kernel@lists.infradead.org


--nextPart2111751.RcBFtlCgef
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Felipe,

On Tuesday 26 November 2013 13:54:22 Felipe Balbi wrote:
> On Tue, Nov 26, 2013 at 03:16:47AM +0100, Laurent Pinchart wrote:
> > On Monday 25 November 2013 20:12:39 Felipe Balbi wrote:
> > > On Tue, Nov 26, 2013 at 02:59:51AM +0100, Laurent Pinchart wrote:
> > > > > > > (2013/10/29 7:49), Laurent Pinchart wrote:
> > > > > > > > Turn clk_enable() and clk_disable() calls into
> > > > > > > > clk_prepare_enable()
> > > > > > > > and clk_disable_unprepare() to get ready for the migration to
> > > > > > > > the
> > > > > > > > common clock framework.
> > > > > > > > 
> > > > > > > > Cc: Felipe Balbi <balbi@ti.com>
> > > > > > > > Cc: linux-usb@vger.kernel.org
> > > > > > > > Signed-off-by: Laurent Pinchart
> > > > > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > > > 
> > > > > > > Thank you for the patch.
> > > > > > > 
> > > > > > > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > > 
> > > > > > Could you please pick this patch up ?
> > > > > 
> > > > > after -rc1 is out, I don't see why not.
> > > > 
> > > > Great then :-)
> > > > 
> > > > As this patch is a dependency for other series that will go through
> > > > different trees, could you please provide a stable branch in your tree
> > > > with this patch included that you will push to v3.14 ?
> > > 
> > > You guys are always killing me with those "stable branch" requests :-)
> > > 
> > > I'll get one up tomorrow. I guess I can avoid a topic branch altogether
> > > if I just make this the first patch in "next" branch. I could push only
> > > $subject for now until you merge then I'll push other stuff. Is that
> > > enough for you ? My 'next' is always immutable.
> > 
> > That sounds good, thank you. You can already push the other patches
> > without waiting for me, I can dig the commit ID of the first patch in your
> > next branch.
> 
> pushed, btw. you should have received my automatic email.

I have, thank you.

> If you merge my next, you'll get only that commit. I believe tomorrow I'll
> be able to push more commits into next.

I've asked Simon Horman (the Renesas SoC kernel maintainer) to merge your next 
branch in his tree.

-- 
Regards,

Laurent Pinchart
--nextPart2111751.RcBFtlCgef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSlRYTAAoJEIkPb2GL7hl1XOkH/31e89nOnRX3PWl9N3IeLPLE
9Uj1ZaQ+T48yyndb6/05MhW4CP1G7i03JH+Uu4TTFZEYvHyykMaE8OV39uzP3V7q
WQsFK2pPiQibtewsSnfWxuyKLu2j7rIH+2zYQrEydRU21Gkwjh5i5RpZ5k17ne0e
oldfCdzZsZaQX175pQD6hAdzzAGffEzoS3fHx3RlCalkVIFo5TTLI1QkU2I79l0w
WmokCjSgePtFJ+TlE/yN0Zjhkaw3tk0AX+o1u6Q9cq+AuxCTIQ1xhUoeESEoi6LR
gBssoliJWO2lIVfJAqCkDQZ3cVo4Z4wo9qwfBc1UzHBcUmrm+myxo11KFeUJqF8=
=HCwI
-----END PGP SIGNATURE-----

--nextPart2111751.RcBFtlCgef--

