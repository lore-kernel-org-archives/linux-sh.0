From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 28 Nov 2013 14:16:19 +0000
Subject: Re: [PATCH 2/2] spi: sh-msiof: Convert to clk_prepare/unprepare
Message-Id: <2098733.0eJJDEzLLR@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2201884.GbWSsosm3Y"
List-Id: <linux-sh.vger.kernel.org>
References: <1385602783-3439-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1385602783-3439-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20131128103407.GI14725@sirena.org.uk>
In-Reply-To: <20131128103407.GI14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart2201884.GbWSsosm3Y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Mark,

On Thursday 28 November 2013 10:34:07 Mark Brown wrote:
> On Thu, Nov 28, 2013 at 02:39:43AM +0100, Laurent Pinchart wrote:
> > Get the driver ready for the migration to the common clock framework by
> > calling clk_prepare() and clk_unprepare(). The calls are added in the
> > probe and remove handlers as the clk_enable() and clk_disable() calls
> > are located in atomic context and there's no callback function in
> > non-atomic context that can be used to prepare/unprepare the clock.
> 
> Applied, thanks.  However it does seem like you should be able to move
> the prepare and disable to runtime PM rather than leaving it prepared
> for the entire time the driver is loaded.  In most systems this won't
> make any difference since prepare won't do anything but it's a bit
> neater.

It would be, but I believe the driver is currently broken in that regard. It 
calls the runtime PM sync API with a spinlock held, which if I'm not mistaken 
isn't right. That should be fixed, but is a bit out of scope of this work, 
hence the simple solution.

-- 
Regards,

Laurent Pinchart

--nextPart2201884.GbWSsosm3Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSl1A4AAoJEIkPb2GL7hl1WF0H/3BMZiUlTUMjZfLXfYTeL8wd
YuBSSSYQOJjPK3EO+8NLbfGw3xD6xKzz4mYZyCVo4wEKtC5YkwK6IA5YkKFY7iPQ
uMQQup9eZbfnl4TGvuXMxU+41IBjuQizEJK68jMJd/4mrKNzDJoizWQl8MuvFIG8
zMyj27ystPAINQ0fYPIxwk89koN3k/2NTwohLq4C63BkD2AhI/XbuLGzPptWzOCK
Htxgh9c9GOEoZuL6ORTc2zlzgQ7b6EhD1ORwhXRCY3woVHkjEq8bFj2FOIQ7PvpJ
z37BIoEmdG/9ZVFAZJtJTe3Z/MGdw+9LxwovmVPo6YupM0DpXzKN3N0w++lZq2A=
=u4CW
-----END PGP SIGNATURE-----

--nextPart2201884.GbWSsosm3Y--

