From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Apr 2010 00:02:57 +0000
Subject: Re: [PATCH 2/8] SH: add DMA slave IDs for two SDHI controllers, add
Message-Id: <j2xaec7e5c31004211702v9ba71743jedd24562f8dea0a5@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
	 <Pine.LNX.4.64.1004211732340.5292@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1004211732340.5292@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

Hi Guennadi,

On Wed, Apr 21, 2010 at 11:36 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> SuperH SDHI controllers can use DMA, add slave IDs to the header and slave
> definitions to sh7722.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0arch/sh/include/asm/dmaengine.h =A0 =A0 =A0 =A0| =A0 =A04 ++++
> =A0arch/sh/kernel/cpu/sh4a/setup-sh7722.c | =A0 10 ++++++++++
> =A02 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sh/include/asm/dmaengine.h b/arch/sh/include/asm/dmaeng=
ine.h
> index 2a02b61..876e601 100644
> --- a/arch/sh/include/asm/dmaengine.h
> +++ b/arch/sh/include/asm/dmaengine.h
> @@ -29,6 +29,10 @@ enum {
> =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUA_RX,
> =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUB_TX,
> =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUB_RX,
> + =A0 =A0 =A0 SHDMA_SLAVE_SDHI0_RX,
> + =A0 =A0 =A0 SHDMA_SLAVE_SDHI0_TX,
> + =A0 =A0 =A0 SHDMA_SLAVE_SDHI1_RX,
> + =A0 =A0 =A0 SHDMA_SLAVE_SDHI1_TX,
> =A0};
>
> =A0#endif

Thanks for your work on this. Two SDHIs may be enough for most
processor types, but I think the G3 processor actually has three. With
that in mind, I think it makes more sense to keep the slave ids
together with the processor specific bits in for instance
arch/sh/include/cpu-sh4/cpu/sh7722.h.

If you have time, can you please make a patch that moves the slave ids
into the processor specific header files? This on top of the other
code in the sh/dmaengine topic branch.

With that in place it will be easy to extend each processor type by
itself without having to tie in dependencies on a single asm file.

Thanks,

/ magnus
