From: Mark Brown <broonie@kernel.org>
Date: Thu, 21 May 2015 16:46:30 +0000
Subject: Re: [PATCH 4/4 v2] ASoC: rsnd: spin lock for interrupt handler
Message-Id: <20150521164630.GB21577@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="78WCQgNEg63vc82l"
List-Id: <linux-sh.vger.kernel.org>
References: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
 <87382qtwto.wl%kuninori.morimoto.gx@renesas.com>
 <20150521105940.GV21577@sirena.org.uk>
 <20150521161552.GT3140@localhost>
In-Reply-To: <20150521161552.GT3140@localhost>
To: Vinod Koul <vinod.koul@intel.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org


--78WCQgNEg63vc82l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2015 at 09:45:52PM +0530, Vinod Koul wrote:
> On Thu, May 21, 2015 at 11:59:40AM +0100, Mark Brown wrote:

> > This looks fine but I guess it depends on patch 1 otherwise more errors
> > will be introduced?

> The 1st one looks good to me and was about to apply, but saw this and to
> sync would you the 1st patch thru ASoC tree or fine with me applying that
> one

Morimoto-san, do the two patches need to go through the same tree?  I
guess it's better to have them both in the ASoC tree given how much work
you're doing on these drivers.  Vinod, do you want to apply and send a
pull request or do you just want to ack?

--78WCQgNEg63vc82l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXgvmAAoJECTWi3JdVIfQWXAH/iZctSRpTquEQMVPjhF57DWo
sqvD/ABzXJSPja69I1U/mVxqJ4aOt0IFhSowehzviEbhFZ9HaUqh4ZpbDmt3VkGp
xgAihIqu8nZREZoa/MmIy+E1UI1Vmg4AsivN88kU74Hc7KjHiv5l6P5AnucHfoMv
M4vbz/6mZCqwaGUsTsm6JJEszhtvvsTF06i8PbFakzmttEAr+mzDwesDRIUh7hQ/
hR3AoLZtxxHQOcruSr4SygVeZW5C7vNFas+4bod269gLS8TWT470pdknHBPGAu74
ktOiCSAYiEX8m9Gg1fjPsHPl43yuB+QgnuiVVFqBsdFjPf3tY0yH7zGajP08P5c=
=foG7
-----END PGP SIGNATURE-----

--78WCQgNEg63vc82l--
