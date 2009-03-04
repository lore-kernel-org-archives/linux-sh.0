From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Wed, 04 Mar 2009 01:37:26 +0000
Subject: Re: [PATCH v2] Add OHCI USB support for SH7786
Message-Id: <29ab51dc0903031737m7ab79b71x4eee98eec994d606@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlg2yu02.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlg2yu02.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2009/3/4 Kuninori Morimoto <morimoto.kuninori@renesas.com>:
>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> v1 -> v2
>
> o use DMA_BIT_MASK
> o add document
> o use __raw_write/read
> o use MACRO for mask, bit definition
> o use cpu_relax while waiting
> o sh7786_devices_setup call sh7786_usb_setup
>
>
> =A0arch/sh/kernel/cpu/sh4a/setup-sh7786.c | =A0 75 ++++++++++++++++++++++=
++++++++++
> =A0drivers/usb/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/usb/host/ohci-hcd.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +-
> =A03 files changed, 78 insertions(+), 1 deletions(-)
>
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/=
sh4a/setup-sh7786.c
> index ca5d987..557de0e 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> @@ -18,6 +18,7 @@
> =A0#include <linux/serial_sci.h>
> =A0#include <linux/io.h>
> =A0#include <linux/mm.h>
> +#include <linux/dma-mapping.h>
> =A0#include <asm/mmzone.h>
>
> =A0static struct plat_sci_port sci_platform_data[] =3D {
> @@ -68,12 +69,86 @@ static struct platform_device sci_device =3D {
> =A0 =A0 =A0 =A0},
> =A0};
>
> +static struct resource usb_ohci_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xffe70400,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xffe704ff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [1] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 77,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 77,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
> + =A0 =A0 =A0 },
> +};
> +
> +static u64 usb_ohci_dma_mask =3D DMA_BIT_MASK(32);
> +static struct platform_device usb_ohci_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sh_ohci",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> + =A0 =A0 =A0 .dev =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .dma_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &=
usb_ohci_dma_mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .coherent_dma_mask =A0 =A0 =A0=3D DMA_BIT_M=
ASK(32),
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(usb_ohci_resources),
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D usb_ohci_resources,
> +};
> +
> =A0static struct platform_device *sh7786_devices[] __initdata =3D {
> =A0 =A0 =A0 =A0&sci_device,
> + =A0 =A0 =A0 &usb_ohci_device,
> =A0};
>
> +
> +/*
> + * Please call this function if your platform board
> + * use external clock for USB
> + * */
> +#define USBCTL0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xffe70858
> +#define CLOCK_MODE_MASK 0xffffff7f
> +#define EXT_CLOCK_MODE =A00x00000080
> +void __init sh7786_usb_use_exclock(void)
> +{
> + =A0 =A0 =A0 u32 val =3D __raw_readl(USBCTL0) & CLOCK_MODE_MASK;
> + =A0 =A0 =A0 __raw_writel(val | EXT_CLOCK_MODE, USBCTL0);
> +}
> +
> +#define USBPCTL1 =A0 =A0 =A0 0xffe70804
> +#define USBST =A0 =A0 =A0 =A0 =A00xffe70808
> +#define PHY_ENB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000001
> +#define PLL_ENB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000002
> +#define PHY_RST =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000004
> +#define ACT_PLL_STATUS 0xc0000000
> +static void __init sh7786_usb_setup(void)
> +{
> + =A0 =A0 =A0 int i =3D 1000000;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* USB initial settings
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* The following settings are necessary
> + =A0 =A0 =A0 =A0* for using the USB modules.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 __raw_writel(0x00ff0040, 0xffe70094);
> + =A0 =A0 =A0 __raw_writel(0x00000001, 0xffe7009c);
> +
You forget to revise here.

> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Set the PHY and PLL enable bit
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 __raw_writel(PHY_ENB | PLL_ENB, USBPCTL1);
> + =A0 =A0 =A0 while (i-- &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0((__raw_readl(USBST) & ACT_PLL_STATUS) !=3D =
ACT_PLL_STATUS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
There is not an error check.


Best regards,
 Nobuhiro
--=20
Nobuhiro Iwamatsu
