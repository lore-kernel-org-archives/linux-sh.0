From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 27 Nov 2014 00:07:50 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Handle hardware descriptor allocation failure
Message-Id: <1695373.od5H2ihtGp@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1416924617-15939-1-git-send-email-j@bitron.ch>
In-Reply-To: <1416924617-15939-1-git-send-email-j@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>, Simon Horman <horms+renesas@verge.net.au>
Cc: Magnus Damm <damm+renesas@opensource.se>, Vinod Koul <vinod.koul@intel.com>, Phil Edworthy <phil.edworthy@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, dmaengine@vger.kernel.org

Hi J=FCrg,

Thank you for the patch.

On Tuesday 25 November 2014 15:10:17 J=FCrg Billeter wrote:
> If the atomic DMA coherent pool is too small, disable use of hardware
> descriptor lists instead of crashing the system:
>=20
> ERROR: 256 KiB atomic DMA coherent pool is too small!
> Please increase it with coherent_pool=3D kernel parameter!
>=20
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
004
> Internal error: Oops: a07 [#1] PREEMPT SMP ARM
>=20
> PC is at rcar_dmac_chan_reinit+0x3c/0x160
> LR is at _raw_spin_lock_irqsave+0x18/0x5c
>=20
> [<802132c0>] (rcar_dmac_chan_reinit) from [<80214818>]
> (rcar_dmac_isr_error+0x84/0xa0) [<80214818>] (rcar_dmac_isr_error) from
> [<80060484>] (handle_irq_event_percpu+0x50/0x150) [<80060484>]
> (handle_irq_event_percpu) from [<800605c0>] (handle_irq_event+0x3c/0x5c)
> [<800605c0>] (handle_irq_event) from [<8006350c>]
> (handle_fasteoi_irq+0xb8/0x198) [<8006350c>] (handle_fasteoi_irq) from
> [<8005fdb0>] (generic_handle_irq+0x20/0x30) [<8005fdb0>]
> (generic_handle_irq) from [<8000fcd0>] (handle_IRQ+0x50/0xc4) [<8000fcd0>]
> (handle_IRQ) from [<800092cc>] (gic_handle_irq+0x28/0x5c) [<800092cc>]
> (gic_handle_irq) from [<80012700>] (__irq_svc+0x40/0x70)
>=20
> Kernel panic - not syncing: Fatal exception in interrupt
>=20
> Signed-off-by: J=FCrg Billeter <j@bitron.ch>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  drivers/dma/sh/rcar-dmac.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index f8f70eb..f18b1b6 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -679,8 +679,8 @@ static void rcar_dmac_realloc_hwdesc(struct
> rcar_dmac_chan *chan, desc->hwdescs.size =3D size;
>  }
>=20
> -static void rcar_dmac_fill_hwdesc(struct rcar_dmac_chan *chan,
> -				  struct rcar_dmac_desc *desc)
> +static int rcar_dmac_fill_hwdesc(struct rcar_dmac_chan *chan,
> +				 struct rcar_dmac_desc *desc)
>  {
>  	struct rcar_dmac_xfer_chunk *chunk;
>  	struct rcar_dmac_hw_desc *hwdesc;
> @@ -689,7 +689,7 @@ static void rcar_dmac_fill_hwdesc(struct rcar_dmac_ch=
an
> *chan,
>=20
>  	hwdesc =3D desc->hwdescs.mem;
>  	if (!hwdesc)
> -		return;
> +		return -ENOMEM;
>=20
>  	list_for_each_entry(chunk, &desc->chunks, node) {
>  		hwdesc->sar =3D chunk->src_addr;
> @@ -697,6 +697,8 @@ static void rcar_dmac_fill_hwdesc(struct rcar_dmac_ch=
an
> *chan, hwdesc->tcr =3D chunk->size >> desc->xfer_shift;
>  		hwdesc++;
>  	}
> +
> +	return 0;
>  }
>=20
>  /* ---------------------------------------------------------------------=
---
>  @@ -933,8 +935,10 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan,
> struct scatterlist *sgl, * additional complexity remains to be
> investigated.
>  	 */
>  	desc->hwdescs.use =3D !highmem && nchunks > 1;
> -	if (desc->hwdescs.use)
> -		rcar_dmac_fill_hwdesc(chan, desc);
> +	if (desc->hwdescs.use) {
> +		if (rcar_dmac_fill_hwdesc(chan, desc) < 0)
> +			desc->hwdescs.use =3D false;
> +	}
>=20
>  	return &desc->async_tx;
>  }

--=20
Regards,

Laurent Pinchart

