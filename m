From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 Sep 2010 10:07:20 +0000
Subject: Re: [PATCH] sound/soc/sh/siu: Fixed undefined dma_length of scatter
Message-Id: <Pine.LNX.4.64.1009171205250.4988@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4C3C7E45.8010102@emtrion.de>
In-Reply-To: <4C3C7E45.8010102@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Paul, this patch is also required for 2.6.36, AFAICS, you've only merged=20
it for 2.6.37?

Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

On Tue, 13 Jul 2010, Markus Pietrek wrote:

>=20
> Please use this patch. The first patch was based on a modified driver whe=
re sg is provided as a pointer and not as a local variable.
>=20
> Signed-off-by: Markus Pietrek <markus.pietrek@emtrion.de>
> ---
>  sound/soc/sh/siu_pcm.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
> index 36170be..b0ccd0b 100644
> --- a/sound/soc/sh/siu_pcm.c
> +++ b/sound/soc/sh/siu_pcm.c
> @@ -127,6 +127,7 @@ static int siu_pcm_wr_set(struct siu_port *port_info,
>         sg_init_table(&sg, 1);
>         sg_set_page(&sg, pfn_to_page(PFN_DOWN(buff)),
>                     size, offset_in_page(buff));
> +       sg_dma_len(&sg) =3D size;
>         sg_dma_address(&sg) =3D buff;
>=20
>         desc =3D siu_stream->chan->device->device_prep_slave_sg(siu_strea=
m->chan,
> @@ -176,6 +177,7 @@ static int siu_pcm_rd_set(struct siu_port *port_info,
>         sg_init_table(&sg, 1);
>         sg_set_page(&sg, pfn_to_page(PFN_DOWN(buff)),
>                     size, offset_in_page(buff));
> +       sg_dma_len(&sg) =3D size;
>         sg_dma_address(&sg) =3D buff;
>=20
>         desc =3D siu_stream->chan->device->device_prep_slave_sg(siu_strea=
m->chan,
>=20
> _____________________________________
>=20
> Amtsgericht Mannheim
> HRB 110 300
> Gesch=E4ftsf=FChrer: Dieter Baur, Ramona Maurer
> _____________________________________
>=20
> Important Note:
> - This e-mail may contain trade secrets or privileged, undisclosed or oth=
erwise confidential information.
> - If you have received this e-mail in error, you are hereby notified that=
 any review, copying or distribution of it is strictly prohibited.
> - Please inform us immediately and destroy the original transmittal.
>=20
> Thank you for your cooperation.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
