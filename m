From: Markus Pietrek <markus.pietrek@emtrion.de>
Date: Tue, 13 Jul 2010 15:12:05 +0000
Subject: Re: [PATCH] sound/soc/sh/siu: Fixed undefined dma_length of scatter
Message-Id: <4C3C8245.9030906@emtrion.de>
List-Id: <linux-sh.vger.kernel.org>
References: <4C3C7E45.8010102@emtrion.de>
In-Reply-To: <4C3C7E45.8010102@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


Please use this patch. The first patch was based on a modified driver where=
 sg is provided as a pointer and not as a local variable.

Signed-off-by: Markus Pietrek <markus.pietrek@emtrion.de>
---
 sound/soc/sh/siu_pcm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 36170be..b0ccd0b 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -127,6 +127,7 @@ static int siu_pcm_wr_set(struct siu_port *port_info,
        sg_init_table(&sg, 1);
        sg_set_page(&sg, pfn_to_page(PFN_DOWN(buff)),
                    size, offset_in_page(buff));
+       sg_dma_len(&sg) =3D size;
        sg_dma_address(&sg) =3D buff;

        desc =3D siu_stream->chan->device->device_prep_slave_sg(siu_stream-=
>chan,
@@ -176,6 +177,7 @@ static int siu_pcm_rd_set(struct siu_port *port_info,
        sg_init_table(&sg, 1);
        sg_set_page(&sg, pfn_to_page(PFN_DOWN(buff)),
                    size, offset_in_page(buff));
+       sg_dma_len(&sg) =3D size;
        sg_dma_address(&sg) =3D buff;

        desc =3D siu_stream->chan->device->device_prep_slave_sg(siu_stream-=
>chan,

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch=E4ftsf=FChrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or other=
wise confidential information.
- If you have received this e-mail in error, you are hereby notified that a=
ny review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
