From: Felipe Balbi <balbi@ti.com>
Date: Tue, 26 Nov 2013 02:12:39 +0000
Subject: Re: [PATCH 09/12] usb: gadget: r8a66597-udc: Convert to clk_prepare/unprepare
Message-Id: <20131126021239.GA22213@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1930202.N3RGv6418i@avalon> <20131111195330.GE19212@saruman.home>
 <2503238.g4sCZxTpb5@avalon>
In-Reply-To: <2503238.g4sCZxTpb5@avalon>
To: linux-arm-kernel@lists.infradead.org

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 26, 2013 at 02:59:51AM +0100, Laurent Pinchart wrote:
> > > > (2013/10/29 7:49), Laurent Pinchart wrote:
> > > > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable=
()
> > > > > and clk_disable_unprepare() to get ready for the migration to the
> > > > > common clock framework.
> > > > >=20
> > > > > Cc: Felipe Balbi <balbi@ti.com>
> > > > > Cc: linux-usb@vger.kernel.org
> > > > > Signed-off-by: Laurent Pinchart
> > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > >=20
> > > > Thank you for the patch.
> > > >=20
> > > > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >=20
> > > Could you please pick this patch up ?
> >=20
> > after -rc1 is out, I don't see why not.
>=20
> Great then :-)
>=20
> As this patch is a dependency for other series that will go through
> different trees, could you please provide a stable branch in your tree
> with this patch included that you will push to v3.14 ?

You guys are always killing me with those "stable branch" requests :-)

I'll get one up tomorrow. I guess I can avoid a topic branch altogether
if I just make this the first patch in "next" branch. I could push only
$subject for now until you merge then I'll push other stuff. Is that
enough for you ? My 'next' is always immutable.

--=20
balbi

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlAOXAAoJEIaOsuA1yqREEK0QAJNB0fo+zo7hARX6X59YU7o+
S5zJuF/A+uN67f7kWemTTnuEq0n8hbITBK8GLBA9vdBhh8RJ/JJMh9uciwFzWgzg
QueYyloJg3WKQSC9rAx8woXWeOqdqAKXVkr5PYFYNadGl2In3oJC4X9hhRnvZ1Pr
/1AZky3+EScrhC0ff6E8RFAhzIVgx9GcmHddNMQJNySTvn+cyEGq1o1+DU20uYt2
opWErfU9FA80m1xdoXt7BIEe70ph0AXZyJytudGznnUhMdFLqUrETGGiKfidcAup
0gjGcA1KCvM9R9md5MWQ88gbsXfnX7/NPEcI6lE7aHDeJ8XdDO4CQL32AYFcYBBF
IlLWIM1Kf6CDNP8u5C0aJS7zDM+cDZMdsiuRg1TGyxbs4tnuDNclXRDrHcdOunhd
DyqSTn/p8KV9NyxgPWVRjZLf6/LbH+JXY6iJrfTqOA6/yaMrirkvi+xOi/4KaOtB
ItO6hwvxiWXYbdvLT2eDyIDt+Qg8xSa42WTVfUFbmMP/gC9qU6s33PJj6dHb7eVD
RDSp9QKSXaboRgyst2CUO6/ha3SOkCILefswvgVYMzPoZWLHgiN9W3RksEvJpynj
Cf92pDxP22JoNWAnaIJyuKuJbJWMnXmwJZduZG831q2biMpAigww6rHF17xqdy4i
CNXU88iF/iXQk45XmwmF
=+IKY
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
