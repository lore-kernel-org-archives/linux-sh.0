From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 29 May 2013 14:39:51 +0000
Subject: Re: [PATCH v2] pwm: renesas-tpu: Add missing pwmchip_remove() call in tpu_remove()
Message-Id: <3139245.zTJ3azFhlR@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1868329.yMO35QUxc7"
List-Id: <linux-sh.vger.kernel.org>
References: <1369057541.11578.1.camel@phoenix> <4528298.O99iVSpig9@avalon> <20130526091824.GA12361@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20130526091824.GA12361@avionic-0098.adnet.avionic-design.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Simon Horman <horms@verge.net.au>, Axel Lin <axel.lin@ingics.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org


--nextPart1868329.yMO35QUxc7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Sunday 26 May 2013 11:18:24 Thierry Reding wrote:
> On Sat, May 25, 2013 at 03:42:42PM +0200, Laurent Pinchart wrote:
> > On Thursday 23 May 2013 21:12:17 Thierry Reding wrote:
> > > On Thu, May 23, 2013 at 10:39:34AM +0900, Simon Horman wrote:
> > > > On Mon, May 20, 2013 at 03:46:59PM +0200, Laurent Pinchart wrote:
> > > > > On Monday 20 May 2013 21:45:41 Axel Lin wrote:
> > > > > > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > > > > 
> > > > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > 
> > > > Thanks. I have queued this up for v3.11 in the pinmux branch
> > > > of my renesas tree on kernel.org.
> > > 
> > > I'd rather take this through the PWM tree along with the original driver
> > > patch.
> > 
> > As I will need to submit a new version of the renesas-tpu patches should I
> > fold this patch in ?
> 
> Yes, that's fine with me. It'd be nice to credit Axel, though.

Sure. I'll add Axel's SoB line to the patch.

-- 
Regards,

Laurent Pinchart

--nextPart1868329.yMO35QUxc7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJRphM9AAoJEIkPb2GL7hl1FyoH/iDam1oxOC4Q+vSOkoB1QN4u
OkJJ92apZwXx7vULqYtdUEl70vA9/XA5ecFO/IPvgKFw7oByrbmo5zJKyeuLXfTS
tAIHVx+u3z28tznMV04Q0affzklSq2cJFmZ0UUDcrUaMXsTKt/suk2KJTf2rHkWU
y8zetsecc6X7MagCycs8Hgt/KNOk3g5daYUgV+BFd1C6cu2Vc3VLbSH6+01lTW3Z
dVWXkWNLaZ5LCe3r2YziQ+Yhm9JhDRLU9VdFGdqbARzvbi/yHfmOY8v+N052y5Rb
FCTBouOkJVAIpe2jGPfiW2lxL5Ge0RKJokDRIG8pSdpwcwVBUhQowKmpXViut14=
=g0Oy
-----END PGP SIGNATURE-----

--nextPart1868329.yMO35QUxc7--

