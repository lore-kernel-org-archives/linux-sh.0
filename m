From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 16 Mar 2009 22:46:45 +0000
Subject: Re: [PATCH] dmaengine: sh: Add support DMA-Engine driver for DMA of
Message-Id: <e9c3a7c20903161546i5de80305r1b0df1605c7718d8@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B8AF67.8080309@renesas.com>
In-Reply-To: <49B8AF67.8080309@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: Linux-sh <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, maciej.sosnowski@intel.com, Paul Mundt <lethal@linux-sh.org>

On Wed, Mar 11, 2009 at 11:44 PM, Nobuhiro Iwamatsu
<iwamatsu.nobuhiro@renesas.com> wrote:
> This supports DMA-Engine driver for DMA of SuperH.
> This supported all DMA channels, and it was tested in SH7722/SH7780.
> This can not use with SH DMA API and can control this in Kconfig.
>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
> Cc: Maciej Sosnowski <maciej.sosnowski@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
> =A0arch/sh/drivers/dma/Kconfig =A0| =A0 12 +-
> =A0arch/sh/drivers/dma/Makefile | =A0 =A03 +-
> =A0arch/sh/include/asm/dma-sh.h | =A0 11 +
> =A0drivers/dma/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A09 +
> =A0drivers/dma/Makefile =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0drivers/dma/shdma.c =A0 =A0 =A0 =A0 =A0| =A0743 ++++++++++++++++++++++=
++++++++++++++++++++
> =A0drivers/dma/shdma.h =A0 =A0 =A0 =A0 =A0| =A0 65 ++++
> =A07 files changed, 840 insertions(+), 5 deletions(-)
> =A0create mode 100644 drivers/dma/shdma.c
> =A0create mode 100644 drivers/dma/shdma.h

Hi,

I have not finished a full review but one problem jumps out, the use
of spin_lock_irqsave to protect against channel/descriptor
manipulations.  The highest level of protection that net_dma and
async_tx assume is spin_lock_bh.  It seems like the pieces of
sh_dmae_interrupt() that touch the descriptor can be moved to the
tasklet, then the locks can be downgraded.

Your other patch, to set the alignment in dmatest, makes me wonder if
this engine can handle unaligned accesses?  If it can not then set the
DMA_PRIVATE capability bit at device registration time to prevent
net_dma and other "public" clients from using these channels.  Public
clients assume that there are no alignment constraints.

Thanks,
Dan
