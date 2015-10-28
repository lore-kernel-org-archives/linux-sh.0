From: Mark Brown <broonie@kernel.org>
Date: Wed, 28 Oct 2015 23:59:46 +0000
Subject: Re: [PATCH] [RFC] ASoC: rsnd: Add missing initialization of ADG req_rate
Message-Id: <20151028235946.GH28319@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OWym5pP/pDvoNOpg"
List-Id: <linux-sh.vger.kernel.org>
References: <1446044628-16924-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1446044628-16924-1-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org


--OWym5pP/pDvoNOpg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2015 at 04:03:48PM +0100, Geert Uytterhoeven wrote:

> If the "clock-frequency" DT property is not found, req_rate is used
> uninitialized, and the "audio_clkout" clock will be created with an
> arbitrary clock rate.

I'd expect that if we support a missing clock frequency property we'd
read the state back from the hardware.

--OWym5pP/pDvoNOpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMWFyAAoJECTWi3JdVIfQev8H/10Xgh+OuWlXpMRdwhDQx7+D
9uwUhznhR8lZnMeSkIhUnqPP255FqGbaVNPc/0txbhmCKbbcdM87GYl5TjRfc/Ko
WkThmpIV0vEysTLTlyA8YYRAsH/vtyI5KVv41kXVxZujC9ExKr8oeVul2NRkmqtX
Pip9eAsKlurtEgF/rmA+UNYz42DTikAtFQHZTcv6bOoNxvndI1EkpdmWuCBCNEJ+
QCscQxBLmT7R4Y16tFuWwPQ/AUYyETMvLHYz/fkF02Z6op0qqUtwJdvhF6Km51OD
eRMOxeT+sKsF/v0TKg59sYUCB2NipONJ2sc9KU7so8N+852nUN2BqTwiQmcApI0=
=f9CS
-----END PGP SIGNATURE-----

--OWym5pP/pDvoNOpg--
