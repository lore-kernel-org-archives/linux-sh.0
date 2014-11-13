From: Mark Brown <broonie@kernel.org>
Date: Thu, 13 Nov 2014 11:07:40 +0000
Subject: Re: [PATCH][resend] of: Add vendor 2nd prefix for Asahi Kasei Corp
Message-Id: <20141113110740.GE3815@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uYGmg1LLWPQm165X"
List-Id: <linux-sh.vger.kernel.org>
References: <5398AB07.4040304@wwwdotorg.org>
 <87sinbdk44.wl%kuninori.morimoto.gx@renesas.com>
 <878ulzx6hr.wl%kuninori.morimoto.gx@gmail.com>
 <20140922130026.GK3290@leverpostej>
 <CAMuHMdX22z97SbGS1HDiYfJ1PXxyEN2S8D7w4sr+4bUwD+mJZw@mail.gmail.com>
 <20140922132743.GM3290@leverpostej>
 <87y4rfhmgl.wl%kuninori.morimoto.gx@renesas.com>
 <1415845309.4269.6.camel@perches.com>
 <20141113025105.GA16652@verge.net.au>
 <87vbmjhj00.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbmjhj00.wl%kuninori.morimoto.gx@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms@verge.net.au>, Joe Perches <joe@perches.com>, Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <robh@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>


--uYGmg1LLWPQm165X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 13, 2014 at 03:33:38AM +0000, Kuninori Morimoto wrote:

> > I think that what Morimoto-san wanted to say was something like this:

> >   I guess that removing the "ak" line from vendor-prefixes.txt would
> >   be sufficient to cause checkpatch to generate a warning about
> >   using the deprecated "ak" vendor prefix. Is that a good approach?

> Yes, this is.
> Thank you Simon, Sorry Joe.

It'd be a bit nicer to be able to leave it there with a note saying it
was legacy (if only so people don't try to add it back) but I don't mind
too much.

--uYGmg1LLWPQm165X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZJD7AAoJECTWi3JdVIfQTcwH/iqbf8HyIXkT9aD8GTzeQF+E
QjfY2W/KOY6HGjGPuCixw2+tvHCWg6oUzFLti0q0q3VJctk/S3nvynGcMujndTGi
HsLHd7JZ/2fJkr8Ov1g5DXX8BzbklfE9uG2YzBa9blFyqI24QO16VJlVRsTigarz
osaC9BPvGu96leqvXWdpwJDK+rRef27kuMKnaeb+3tqpRUMCCmmn55iaxWYIIvwz
jbVXYbTBm1gdNi7Nf411YTJ3Hwe463qFemX2/XgVe32qjX7HF7mrEmBHbjGHeAWz
F0j3dmSEoRsFvQm0yG5LuMoYGQtFss0dd/AyE+rokv6ykGZdl/OJRgpWvCPpjms=
=ts6R
-----END PGP SIGNATURE-----

--uYGmg1LLWPQm165X--
