From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Apr 2010 00:16:29 +0000
Subject: Re: [PATCH 5/8] SH: Add SDHI DMA support to ecovec
Message-Id: <p2iaec7e5c31004211716z430581dfn9a695537d4d8489a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
	 <Pine.LNX.4.64.1004211734460.5292@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1004211734460.5292@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

On Wed, Apr 21, 2010 at 11:37 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> @@ -442,6 +444,8 @@ static void sdhi0_set_pwr(struct platform_device *pde=
v, int state)
> =A0}
>
> =A0static struct sh_mobile_sdhi_info sdhi0_info =3D {
> + =A0 =A0 =A0 .dma_slave_tx =3D SHDMA_SLAVE_SDHI0_TX,
> + =A0 =A0 =A0 .dma_slave_rx =3D SHDMA_SLAVE_SDHI0_RX,
> =A0 =A0 =A0 =A0.set_pwr =3D sdhi0_set_pwr,
> =A0};
>
> @@ -478,6 +482,9 @@ static void sdhi1_set_pwr(struct platform_device *pde=
v, int state)
> =A0}
>
> =A0static struct sh_mobile_sdhi_info sdhi1_info =3D {
> + =A0 =A0 =A0 .dma_slave_tx =3D SHDMA_SLAVE_SDHI1_TX,
> + =A0 =A0 =A0 .dma_slave_rx =3D SHDMA_SLAVE_SDHI1_RX,
> + =A0 =A0 =A0 .tmio_flags =3D TMIO_DEFER_RX_COMPLETE,

This is a bit odd. How come SDHI1 needs this flag and SDHI0 doesn't?

/ magnus
