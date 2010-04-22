From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Apr 2010 00:12:52 +0000
Subject: Re: [PATCH 4/8] MMC: add DMA support to tmio_mmc driver, when used on
Message-Id: <n2saec7e5c31004211712t9441f0r50950ec918bea2e3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
	 <Pine.LNX.4.64.1004211733400.5292@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1004211733400.5292@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

Hi Guennadi,

On Wed, Apr 21, 2010 at 11:37 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> SDHI controllers on SuperH, served by the tmio_mmc driver, can use slave =
DMA
> for data transfer. This patch adds support for the dmaengine API to tmio_=
mmc
> and the necessary interfacing to the sh_mobile_sdhi MFD driver.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> It could be further broken down into MMC and MFD parts if required, I
> think.
>
> =A0drivers/mfd/sh_mobile_sdhi.c =A0 =A0 =A0 | =A0 25 +++-
> =A0drivers/mmc/host/tmio_mmc.c =A0 =A0 =A0 =A0| =A0346 ++++++++++++++++++=
++++++++++++++----
> =A0drivers/mmc/host/tmio_mmc.h =A0 =A0 =A0 =A0| =A0 11 ++
> =A0include/linux/mfd/sh_mobile_sdhi.h | =A0 =A03 +
> =A0include/linux/mfd/tmio.h =A0 =A0 =A0 =A0 =A0 | =A0 10 +
> =A05 files changed, 359 insertions(+), 36 deletions(-)

[snip]

> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index b2b577f..fafd8c9 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -29,12 +29,21 @@
> =A0#include <linux/irq.h>
> =A0#include <linux/device.h>
> =A0#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> =A0#include <linux/mmc/host.h>
> =A0#include <linux/mfd/core.h>
> =A0#include <linux/mfd/tmio.h>
>
> =A0#include "tmio_mmc.h"
>
> +static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
> +{
> +#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
> + =A0 =A0 =A0 /* Switch DMA mode on or off - SuperH specific? */
> + =A0 =A0 =A0 sd_ctrl_write16(host, 0xd8, enable ? 2 : 0);
> +#endif
> +}
> +

Uhh.. #ifdefs. =3D)

Can't this register setting be implented in the SDHI driver?

In general I realize that you need to extend the logic in the tmio_mmc
driver quite a bit to implement DMA support, but I wonder if it is
possible to extend the tmio_mmc driver with callbacks and use them to
hook in the DMA code?

Thanks!

/ magnus
