From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Mar 2015 18:33:53 +0000
Subject: Re: [PATCH] ASoC: rsnd: Use %pad to print dma_addr_t in rsnd_dmapp_init()
Message-Id: <20150310183353.GF28806@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Km2V3aJx5eFEhJmw"
List-Id: <linux-sh.vger.kernel.org>
References: <1425984485-28421-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425984485-28421-1-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org


--Km2V3aJx5eFEhJmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2015 at 11:48:05AM +0100, Geert Uytterhoeven wrote:
> sound/soc/sh/rcar/dma.c: In function 'rsnd_dmapp_init':
> sound/soc/sh/rcar/dma.c:341:2: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]
>   dev_dbg(dev, "id/src/dst/chcr = %d/%x/%x/%08x\n",
>   ^
> sound/soc/sh/rcar/dma.c:341:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]

Applied, thanks.

--Km2V3aJx5eFEhJmw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/zkQAAoJECTWi3JdVIfQWokH/jG14uTC8iOPabGOVekihfsl
eIUcVsi/IChlf1VVChrJXI/Opi4I9F+cjpDQmI1dd3nqU9w1FfSt8qsUtxoescqg
HlJatjEPrNGqqc5/hVpJAO2DGqDDnDjX5/1obfPUcjVXwP12ZBURqq2yvb/g0Krj
JU3M6P4FBopq8E6M7cPwd3BlgoQBV+lWNKj3N6+zA4iBesuAR0h9KB8tUxTHORHw
bSqeyt11Pcl3kva3jb9Q7lhFl+gE6gnfNd4vIwwta7U49HUWnc3jkiC1o3dJSgIb
5L8hee5B3Eh0EBwvZ8cOKFZdqXqDkRcA6G4KzkHY9wpuFZkXbLAILtZo7qO56Ic=
=3Zxb
-----END PGP SIGNATURE-----

--Km2V3aJx5eFEhJmw--
