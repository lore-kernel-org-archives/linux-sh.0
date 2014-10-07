From: Mark Brown <broonie@kernel.org>
Date: Tue, 07 Oct 2014 17:24:09 +0000
Subject: Re: [PATCH] ASoC: simple-card: Initialize headphone and mic GPIO numbers
Message-Id: <20141007172409.GS4609@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Qf878oECjVTnCF6M"
List-Id: <linux-sh.vger.kernel.org>
References: <1412687366-6400-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1412687366-6400-1-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Dylan Reid <dgreid@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org


--Qf878oECjVTnCF6M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 03:09:26PM +0200, Geert Uytterhoeven wrote:
> The uninitialized default of 0 for gpio_hp_det and gpio_mic_det doesn't
> play well with asm-generic's gpio_is_valid():

Applied, thanks.

--Qf878oECjVTnCF6M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNCG4AAoJECTWi3JdVIfQK7MH/1pl0zcL8f9mIzBXXC4esXw3
ll0OSPIHoN9lquIs9e+NBxOZo12ycrtIwoPI+xlMNsPJHq5FlPZBTCEySdXja05j
vy2zcZjWQvnAtk8qh3QkqYJnypCKB0RpssMNOuE7ACQjtlsBWfDzL7rImd80kBSX
tkCfaA9CPon9Bzi0xgg6wbdHB8iEko/Isk29zyTAOVsPyaSm3flRNtqL18WVIJl4
JQDrfo8rQwBrJP0XUYmbyOJwqNXT/YlMREteOhwJuieoSsDfhJ6W3hN4u+pMwtk1
GYoKJzz4VX2JjQNBHU1nurFroBV3B1CiXRpOOcAfUQUKvu4IaI+1RT9DIRPjF/M=
=dgdy
-----END PGP SIGNATURE-----

--Qf878oECjVTnCF6M--
