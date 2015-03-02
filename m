From: Sakari Ailus <sakari.ailus@iki.fi>
Date: Mon, 02 Mar 2015 22:53:37 +0000
Subject: Re: [PATCH 01/10] media: omap3isp: remove unused clkdev
Message-Id: <20150302225336.GV6539@valkosipuli.retiisi.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
 <E1YSTnC-0001JU-CX@rmk-PC.arm.linux.org.uk>
 <118780170.u6ZO5zJrEk@avalon>
In-Reply-To: <118780170.u6ZO5zJrEk@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

Hi Laurent and Russell,

On Tue, Mar 03, 2015 at 12:33:44AM +0200, Laurent Pinchart wrote:
> Hi Russell,
>=20
> On Monday 02 March 2015 17:06:06 Russell King wrote:
> > No merged platform supplies xclks via platform data.  As we want to
> > slightly change the clkdev interface, rather than fixing this unused
> > code, remove it instead.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>=20
> There are quite a few out of tree users that I know of that might be impa=
cted.=20
> On the other hand, out of tree isn't an excuse, and OMAP3 platforms shoul=
d=20
> move to DT. The good news is that DT support for the omap3isp driver is a=
bout=20
> to get submitted, and hopefully merged in v4.1. I thus have no objection =
to=20
> this patch.
>=20
> Sakari, does it conflict with the omap3isp DT support ? If so, how would =
you=20
> prefer to resolve the conflict ? Russell, would it be fine to merge this =

> through Mauro's tree ?

I first thought it wouldn't conflict, but apparently it does. The
conflicting patches are here:

<URL:http://vihersipuli.retiisi.org.uk/cgi-bin/gitweb.cgi?p=3D~sailus/linux=
.git;a=3Dcommitdiff;h=A56c38208ee9200e57421b60b770fb8249935b95>
<URL:http://vihersipuli.retiisi.org.uk/cgi-bin/gitweb.cgi?p=3D~sailus/linux=
.git;a=3Dcommitdiff;hr374c7a69a12afc76f220ef4de983be4583f164>
<URL:http://vihersipuli.retiisi.org.uk/cgi-bin/gitweb.cgi?p=3D~sailus/linux=
.git;a=3Dcommitdiff;h=0F0b86d64a555e308079f985812b011866e2c8f0>

Tne entire set:

<URL:http://vihersipuli.retiisi.org.uk/cgi-bin/gitweb.cgi?p=3D~sailus/linux=
.git;a=3Dshortlog;h=3Drefs/heads/rm696-051-upstream>

I haven't sent that to linux-media yet but I'll do that during the coming
couple of days.

--=20
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
