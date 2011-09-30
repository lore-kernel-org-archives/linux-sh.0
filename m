From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 30 Sep 2011 06:18:21 +0000
Subject: Re: [PATCH] sh: modify the asm/sh_eth.h to linux/sh_eth.h in some boards
Message-Id: <CABMQnVKBbNHgTVNZc=KV76_KttyG2bMQ56YoaBc3MuAXj=syqQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4E82D17A.7050108@renesas.com>
In-Reply-To: <4E82D17A.7050108@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Tested-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

2011/9/28 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> =A0- This patch depends on the following patch:
> =A0- net: sh_eth: move the asm/sh_eth.h to include/linux/
> =A0- This patch doesn't contain board-sh7757lcr.c, because
> =A0 it needs more modification.
>
> =A0arch/sh/boards/board-espt.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/sh/boards/mach-ecovec24/setup.c =A0| =A0 =A02 +-
> =A0arch/sh/boards/mach-se/7724/setup.c =A0 | =A0 =A02 +-
> =A0arch/sh/boards/mach-sh7763rdp/setup.c | =A0 =A02 +-
> =A04 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sh/boards/board-espt.c b/arch/sh/boards/board-espt.c
> index 9da92ac..b3ae9d3 100644
> --- a/arch/sh/boards/board-espt.c
> +++ b/arch/sh/boards/board-espt.c
> @@ -13,9 +13,9 @@
> =A0#include <linux/interrupt.h>
> =A0#include <linux/mtd/physmap.h>
> =A0#include <linux/io.h>
> +#include <linux/sh_eth.h>
> =A0#include <asm/machvec.h>
> =A0#include <asm/sizes.h>
> -#include <asm/sh_eth.h>
>
> =A0/* NOR Flash */
> =A0static struct mtd_partition espt_nor_flash_partitions[] =3D {
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-e=
covec24/setup.c
> index b24d69d..7f74985 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -28,13 +28,13 @@
> =A0#include <linux/spi/mmc_spi.h>
> =A0#include <linux/input.h>
> =A0#include <linux/input/sh_keysc.h>
> +#include <linux/sh_eth.h>
> =A0#include <video/sh_mobile_lcdc.h>
> =A0#include <sound/sh_fsi.h>
> =A0#include <media/sh_mobile_ceu.h>
> =A0#include <media/tw9910.h>
> =A0#include <media/mt9t112.h>
> =A0#include <asm/heartbeat.h>
> -#include <asm/sh_eth.h>
> =A0#include <asm/clock.h>
> =A0#include <asm/suspend.h>
> =A0#include <cpu/sh7724.h>
> diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se=
/7724/setup.c
> index d007567..b747c0a 100644
> --- a/arch/sh/boards/mach-se/7724/setup.c
> +++ b/arch/sh/boards/mach-se/7724/setup.c
> @@ -23,12 +23,12 @@
> =A0#include <linux/input.h>
> =A0#include <linux/input/sh_keysc.h>
> =A0#include <linux/usb/r8a66597.h>
> +#include <linux/sh_eth.h>
> =A0#include <video/sh_mobile_lcdc.h>
> =A0#include <media/sh_mobile_ceu.h>
> =A0#include <sound/sh_fsi.h>
> =A0#include <asm/io.h>
> =A0#include <asm/heartbeat.h>
> -#include <asm/sh_eth.h>
> =A0#include <asm/clock.h>
> =A0#include <asm/suspend.h>
> =A0#include <cpu/sh7724.h>
> diff --git a/arch/sh/boards/mach-sh7763rdp/setup.c b/arch/sh/boards/mach-=
sh7763rdp/setup.c
> index f3d828f..dd036f1 100644
> --- a/arch/sh/boards/mach-sh7763rdp/setup.c
> +++ b/arch/sh/boards/mach-sh7763rdp/setup.c
> @@ -17,8 +17,8 @@
> =A0#include <linux/mtd/physmap.h>
> =A0#include <linux/fb.h>
> =A0#include <linux/io.h>
> +#include <linux/sh_eth.h>
> =A0#include <mach/sh7763rdp.h>
> -#include <asm/sh_eth.h>
> =A0#include <asm/sh7760fb.h>
>
> =A0/* NOR Flash */
> --
> 1.7.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Nobuhiro Iwamatsu
