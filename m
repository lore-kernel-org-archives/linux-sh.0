From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Sep 2015 08:03:56 +0000
Subject: Re: [PATCH 06/14][RFC] arm64: renesas: r8a7795: add SSI DMA support
Message-Id: <87y4gde68c.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io7in3xo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87io7in3xo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


Hi Geert

> Documentation/devicetree/bindings/sound/renesas,rsnd.txt says:
>=20
>     - dma                           : Should contain Audio DMAC entry
>     - dma-names                     : SSI  case "rx"  (=3Dplayback),
> "tx"  (=CApture)
>                                       SSIU case "rxu" (=3Dplayback),
> "txu" (=CApture)
>=20
> E.g. for "rx" =3D "playback", the SSI receives data from the DMA engine,
> and sends it over the I2S link?
>=20
> So the documentation uses the viewpoint of the DMA engine?

Does it mean "SSI point of view" ?
Then, YES

