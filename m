From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jun 2015 09:56:37 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: rsrc-card: Remove unused variable in rsrc_card_startup()
Message-Id: <20150622095637.GO14071@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="x4FmxR9v8irbgj/B"
List-Id: <linux-sh.vger.kernel.org>
References: <1434962073-9597-1-git-send-email-geert+renesas@glider.be>
 <87wpyw6stl.wl%kuninori.morimoto.gx@renesas.com>
 <CAMuHMdX0WnQ61FrEmCq5_YCmvoh5NWk5br76+xr+DSXV0ocPcA@mail.gmail.com>
 <s5hpp4o6pfc.wl-tiwai@suse.de>
In-Reply-To: <s5hpp4o6pfc.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>


--x4FmxR9v8irbgj/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2015 at 11:52:07AM +0200, Takashi Iwai wrote:

> Yeah, I see this warning also in build tests of Mark's latest pull
> request.  Mark, was the fix patch already queued?

I have no idea off the top of my head, it'll be in the pull request I
sent you this morning.

--x4FmxR9v8irbgj/B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVh9vUAAoJECTWi3JdVIfQbKoIAIaSvcbaaBU4QI+OV2sTbO3O
YAaSo8AtbgIkHeT1VyR+Ff16YH5GO5dfsB+bR6WluWTeU+NyHMdkuQ2BhfOOAM+t
jlQp1+cDKtqLL+Az0GXZ9FH0/7O0SbGjpub02alFM/GykarGt75Gs8Mmmf0tTt0T
Q/q03quzu/Qot0897otxB/inkv/A0Sg5F/bnfZnJHcQqpO7Wz4hCO4s531NE/KHm
jpaG0acN1fl2z49kUK4w83GLo4fOAcN6wxw84foO0Fp+K8p2Vh4/SLTuRWF6SjB1
IUnjLSdbIK7qKrJpxp01ovAKSO3iNuItFN8cJD97+0LOMB0aYhdxTULKCuMRCEo=
=VPg+
-----END PGP SIGNATURE-----

--x4FmxR9v8irbgj/B--
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
