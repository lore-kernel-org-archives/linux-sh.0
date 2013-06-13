From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 13 Jun 2013 15:38:51 +0000
Subject: Re: [PATCH v3 0/5] Renesas TPU PWM support
Message-Id: <4097084.Y91d0ZYkWB@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart7071856.evoBBcrJJv"
List-Id: <linux-sh.vger.kernel.org>
References: <1370958344-19470-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130612101250.GB30841@mithrandir>
In-Reply-To: <20130612101250.GB30841@mithrandir>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>


--nextPart7071856.evoBBcrJJv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Wednesday 12 June 2013 12:12:51 Thierry Reding wrote:
> On Tue, Jun 11, 2013 at 03:45:39PM +0200, Laurent Pinchart wrote:
> [...]
> 
> > I believe I've addressed most comments received in response to v2, with
> > the exception of channel allocation at .request() time for which I haven't
> > received any answer to my questions. That will hopefully not be a
> > showstopper.
>
> I totally forgot to reply to that mail. Done now. Irrespective of my
> comments, I think that cleanup could also be done as a follow-up patch after
> 3.11.

I'll address your comments and sent a v4. Hopefully it will be the last one.

Given the dependencies between the PWM TPU driver and board code, should I ask 
Simon to take the series in the SH Mobile tree (after receiving your ack of 
course) ?

> Thierry
> 
> P.S.: please not that I've switched email addresses and there's also a
> linux-pwm mailing list that you should Cc on PWM subsystem related
> patches. The info should have propagated to linux-next's MAINTAINERS.

OK, I'll make sure to CC the right addresses.

-- 
Regards,

Laurent Pinchart

--nextPart7071856.evoBBcrJJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQEcBAABAgAGBQJRueeLAAoJEIkPb2GL7hl1qTMH/1JoAGPOpSsH4Aox50hKTNqK
coa8r5Xyz5S12B1JDbOVv78/mkMD967Rmw9Eq50lzSCD+9wAYiXfJYnpI62+hlzC
g/48MtoQtGQp5c9gIAVQ2EUbl5yX+WSfWHB4ZRjvGbPo/dhp4YEokYJmGVD5K+3d
1AzTwsMy/EVwSIaoGRebEoP1pudZ5zxNNc8xT1AfVQMOPv9QuWQ+qr+kgdB5goRd
5k6nRoLn8AYtV7jtSQprqnmGrI/KfAR+QXPvUCA5ZEnleT8UXzv5EGQTVZKAv0bQ
vCTsnMKcyv1NKYgyvnR4LXyMRgi/WA8uhHlu4YOc9gF5NNNG+OeNZhIyyEIpN2c=
=u6Ng
-----END PGP SIGNATURE-----

--nextPart7071856.evoBBcrJJv--

