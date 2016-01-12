From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 Jan 2016 01:20:46 +0000
Subject: Re: [PATCH 1/3 v2] media: soc_camera: rcar_vin: Add rcar fallback compatibility string
Message-Id: <20160112012045.GE3860@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1452539418-28480-1-git-send-email-ykaneko0929@gmail.com>
 <1452539418-28480-2-git-send-email-ykaneko0929@gmail.com>
 <Pine.LNX.4.64.1601112210040.31467@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1601112210040.31467@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-media@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi Guennadi,

On Mon, Jan 11, 2016 at 10:13:30PM +0100, Guennadi Liakhovetski wrote:
> Hello Kaneko-san,
>=20
> On Tue, 12 Jan 2016, Yoshihiro Kaneko wrote:
>=20
> > Add fallback compatibility string for R-Car Gen2 and Gen3, This is
> > in keeping with the fallback scheme being adopted wherever appropriate
> > for drivers for Renesas SoCs.
> >=20
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > ---
>=20
> Have you seen this patch:
>=20
> http://git.linuxtv.org/gliakhovetski/v4l-dvb.git/commit/?h=3Dfor-4.6-1&id=
=8E7825d38bbfcf8af8b0422c88f5e22701d89786
>=20
> that I pushed yesterday? Is it wrong then? Do we have to cancel it, if
> Mauro hasn't pulled it yet? Or would you like to rebase and work on top of
> it?

Sorry about this. There are multiple threads of execution going on
regarding enhancing drivers used by Renesas SoCs and sometimes things
get a little mixed up: this is one of those times.

My opinion is that the patch at the URL above is fine and
that it would be best for Kaneko-san to rebase his work on top of it.
