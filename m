From: "Sosnowski, Maciej" <maciej.sosnowski@intel.com>
Date: Tue, 31 Mar 2009 12:05:25 +0000
Subject: RE: [PATCH v3] dmaengine: sh: Add Support SuperH DMA Engine driver
Message-Id: <129600E5E5FB004392DDC3FB599660D790F8C319@irsmsx504.ger.corp.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49C9D558.7030002@renesas.com>
In-Reply-To: <49C9D558.7030002@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

iwamatsu.nobuhiro@renesas.com wrote:
> This supported all DMA channels, and it was tested in SH7722,
> SH7780 and SH7763.
> This can not use with SH DMA API.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> Reviewed-by: Matt Fleming <matt@console-pimps.org>
> ---
> 
>  V3: Reflect Maciej's comments.
> 
>  arch/sh/drivers/dma/Kconfig  |   12 +-
>  arch/sh/drivers/dma/Makefile |    3 +-
>  arch/sh/include/asm/dma-sh.h |   13 +
>  drivers/dma/Kconfig          |    8 +
>  drivers/dma/Makefile         |    2 +
>  drivers/dma/shdma.c          |  756  ++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/shdma.h        |   64 ++++
>  7 files changed, 853 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/dma/shdma.c
>  create mode 100644 drivers/dma/shdma.h
> 

Acked-by: Maciej Sosnowski <maciej.sosnowski@intel.com>