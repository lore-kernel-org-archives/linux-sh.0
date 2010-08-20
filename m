From: =?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?= <m.nazarewicz@samsung.com>
Date: Fri, 20 Aug 2010 01:15:22 +0000
Subject: Re: [PATCH 3/5] DMA: reduce the number of memory allocations
Message-Id: <op.vhpprwkr7p4s8u@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
	<Pine.LNX.4.64.1008191634160.26145@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008191634160.26145@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, 19 Aug 2010 16:40:15 +0200, Guennadi Liakhovetski <g.liakhovetski@g=
mx.de> wrote:

> Allocate the bitmap in dma_declare_coherent_memory() together with the st=
ruct
> dma_coherent_mem object.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/base/dma-coherent.c |   11 +++--------
>  1 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
> index f369e27..8efdfd4 100644
> --- a/drivers/base/dma-coherent.c
> +++ b/drivers/base/dma-coherent.c
> @@ -11,7 +11,7 @@ struct dma_coherent_mem {
>  	dma_addr_t	device_base;
>  	int		size;
>  	int		flags;
> -	unsigned long	*bitmap;
> +	unsigned long	bitmap[0];
>  };

Wouldn't "bitmap[]" be better? AFAIR "bitmap[0]" is really a GCC extension =
and
C99 has introduced "bitmap[]" for exactly the above purpose.

--=20
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=3D./ `o
| Computer Science,  Micha=C5=82 "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--

