From: Mark Brown <broonie@kernel.org>
Date: Thu, 15 May 2014 10:14:50 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: Fix warnings due to improper printk formats
Message-Id: <20140515101450.GN12304@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3nVcjXxU7R27OJCj"
List-Id: <linux-sh.vger.kernel.org>
References: <1399936220-17123-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <871tvysge5.wl%kuninori.morimoto.gx@renesas.com>
 <20140513213935.GA6784@verge.net.au>
 <5372D5E4.9060300@renesas.com>
In-Reply-To: <5372D5E4.9060300@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms@verge.net.au>, alsa-devel@alsa-project.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org


--3nVcjXxU7R27OJCj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 14, 2014 at 11:33:08AM +0900, Kuninori Morimoto wrote:

> >Morimoto-san, should Mark Brown need to be CCed on a re-post
> >in order for him to see this?

> Ahh, I didn't notice that Mark wasn't CCed.
> He never (?) accepts patch which doesn't have "To" him.

Well, sometimes I do but it's much less likely I'll even see an e-mail
that only went to the lists than if it goes to my inbox and since CCing
the maintainer is one of the things SubmittingPatches tells you to do
people really ought to know better.  Anyway, I saw this one and applied
it.

--3nVcjXxU7R27OJCj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTdJOXAAoJELSic+t+oim99VEP/jqitqDkI4/b84VxbvTbGZCs
vq9Oyrio3QBMRjG+pDyP1MTRyphzmwMN+HflVBCob/jFavD5fXe28tCg5HawohBC
hpOHr8OIjwGuVGV8DSj9I+r1HZOyyEAmbo3IgJDsYLvzaZ0ng2RkTHyDg+5GbKee
KkJAZLgUa7NeALpgoXmtd5MtzqxncgeNutM6x/IyinHHIByGC5dkkVUv42/Irv51
+n1HRov8NA7folgsxGtkGJDwFMa6pO7Ime1lbCoRwyToi6L77vj2yQiChi0iY6hp
dlBjMsAxk7lPt2xXOYUqFWD/ScrzGmieSYSqes8BxnMJX8phAUC3CR3M2kiiLwC8
+jd2Xr9ZqrPObpKxfsW8pA3Z23TKbBBAH/3hzxCTSbc2gFAdeDyN0LRYFDvv4ZWy
ci+MQkVB3VnSBktyCd2LbdRgNLhAt1XLVAsWaBfeNNyf2wTIUj4ZnahCvmo4itWu
yG1CQFcE6cFM76zSeKWCsdAf1j1ZILdXFlzL4+YcqlofdHjd/GxmtQNekw1r5Fuw
alJREiYTlOPIiYSeF7HyWI8LjLy1O9uYV3364ZEVMoK5+z6UqJi20PMZOLm9Wsi0
9eZzQ1gvc9YgNY8WC5M79XnRTVt44TDNx02yyVpxRGtjplJ7c9cau468dYYs+ANg
s3wFm2GA/RVc+KhtWCd8
=jpuF
-----END PGP SIGNATURE-----

--3nVcjXxU7R27OJCj--
