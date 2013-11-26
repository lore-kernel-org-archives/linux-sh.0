From: Felipe Balbi <balbi@ti.com>
Date: Tue, 26 Nov 2013 19:54:22 +0000
Subject: Re: [PATCH 09/12] usb: gadget: r8a66597-udc: Convert to clk_prepare/unprepare
Message-Id: <20131126195422.GJ24310@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1qrhXh8iFgyYHgLh"
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2503238.g4sCZxTpb5@avalon> <20131126021239.GA22213@saruman.home>
 <2042860.IXZhL6v7c2@avalon>
In-Reply-To: <2042860.IXZhL6v7c2@avalon>
To: linux-arm-kernel@lists.infradead.org

--1qrhXh8iFgyYHgLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2013 at 03:16:47AM +0100, Laurent Pinchart wrote:
> Hi Felipe,
>=20
> On Monday 25 November 2013 20:12:39 Felipe Balbi wrote:
> > Hi,
> >=20
> > On Tue, Nov 26, 2013 at 02:59:51AM +0100, Laurent Pinchart wrote:
> > > > > > (2013/10/29 7:49), Laurent Pinchart wrote:
> > > > > > > Turn clk_enable() and clk_disable() calls into
> > > > > > > clk_prepare_enable()
> > > > > > > and clk_disable_unprepare() to get ready for the migration to=
 the
> > > > > > > common clock framework.
> > > > > > >=20
> > > > > > > Cc: Felipe Balbi <balbi@ti.com>
> > > > > > > Cc: linux-usb@vger.kernel.org
> > > > > > > Signed-off-by: Laurent Pinchart
> > > > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > >=20
> > > > > > Thank you for the patch.
> > > > > >=20
> > > > > > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > >=20
> > > > > Could you please pick this patch up ?
> > > >=20
> > > > after -rc1 is out, I don't see why not.
> > >=20
> > > Great then :-)
> > >=20
> > > As this patch is a dependency for other series that will go through
> > > different trees, could you please provide a stable branch in your tree
> > > with this patch included that you will push to v3.14 ?
> >=20
> > You guys are always killing me with those "stable branch" requests :-)
> >=20
> > I'll get one up tomorrow. I guess I can avoid a topic branch altogether
> > if I just make this the first patch in "next" branch. I could push only
> > $subject for now until you merge then I'll push other stuff. Is that
> > enough for you ? My 'next' is always immutable.
>=20
> That sounds good, thank you. You can already push the other patches witho=
ut=20
> waiting for me, I can dig the commit ID of the first patch in your next=
=20
> branch.

pushed, btw. you should have received my automatic email. If you merge
my next, you'll get only that commit. I believe tomorrow I'll be able to
push more commits into next.

--=20
balbi

--1qrhXh8iFgyYHgLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlPxuAAoJEIaOsuA1yqRE1GoP/jFcVwGHicdOSmZHESBPxNWc
W0/RpCOR4UvnAxQPusIQszKAl1hxsdKQa2T8NTAgBOtpvI0lXpc1GLFmvKoXL8fd
WEyB5NkECD8IsB8wYRPcaZyDXcAY14AuiODIDiVF3fMFl9wRgsjGZG/YPfH7GGE2
tugkYgxOE/QnIqhUaFTHgGqFQYjNid5SVZu5AiXmNggKNU8RUB8JnsGI83X0OFZX
fBnwMU4f/rqMLIoGY845ijcwf2atMVEpj45dyIZG+xAF89UMG826GOjwzpsVqmwo
j6yFsHzR0jms6drdqCMYIg/PEp5tOtWxYsLWGR+LCpeB4UtJohGuRzNHBBEYJ6Jl
MKz/Qtz9AQotZGCQ+YQnV7gfLd7dLEnc8o9QPmmgTs7JUzbeXYAUiJ+YrOIk4X1m
8GG/AJCHt/J7p5m5pKrlZqwP/jTJMHhiFQyB7mc5DGMJp6IV4HNYqztgsRyfUnbV
g1/KtHjTDGPpaFhoYIN1H3vj70eAUf/29Zh620sNvBcD0O4OxlXv5qFYjYjLStn6
sIvWvyuUFE5t1KqhpTX2NwFmlO1xmkOgURXTG/q4aJoWz3wbpiPAHL3jjVxccqcZ
i82dQQjYLopNrgpjffxVCYYgPdM9ySdW3ctlvDZGPwkd4CwU5JpncRa0+C7kAH6P
kH7kYQFqzEoLmoejIgdW
=1uPY
-----END PGP SIGNATURE-----

--1qrhXh8iFgyYHgLh--
