From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 11:49:37 +0000
Subject: Re: [PATCH 3/6] Add USB support for SH7724
Message-Id: <aec7e5c30904150449v228d750br14920af57467b89a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

More feedback from me. =3D)

On Wed, Apr 15, 2009 at 11:42 AM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> =A0arch/sh/kernel/cpu/sh4a/setup-sh7724.c | =A0 45 ++++++++++++++++++++++=
++++++++++
> =A0drivers/usb/host/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A02 files changed, 46 insertions(+), 1 deletions(-)
>
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/=
sh4a/setup-sh7724.c
> index 71ccb25..4257713 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> @@ -99,15 +99,60 @@ static struct platform_device rtc_device =3D {
> =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D rtc_resources,
> =A0};
>
> +/* USB0 */
> +static struct resource usb0_host_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "r8a66597_hcd",

Please use "USB0" as name for the hardware block.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xa4d80000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xa4d800ff,

Is D1FIFO included in this area? Shouldn't end be ..0123?

> =A0static struct platform_device *sh7724_devices[] __initdata =3D {
> =A0 =A0 =A0 =A0&sci_device,
> =A0 =A0 =A0 =A0&rtc_device,
> + =A0 =A0 =A0 &usb0_device,
> =A0};

How about usb1?

> +#define UPONCR0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xa40501d4
> +#define UPONCR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xa4050192
> +#define USBPOWERON =A0 =A0 0x0600
> +static void __init sh7724_usb_setup(void)
> +{
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* USB initial settings
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* The following settings are necessary
> + =A0 =A0 =A0 =A0* for using the USB modules.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* see "USB Inital Settings" for detail
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 __raw_writew(USBPOWERON , UPONCR0);
> + =A0 =A0 =A0 __raw_writew(USBPOWERON , UPONCR1);
> +}

Hm... In the future we want to control the above dynamically for
better power savings. I guess it's ok as-is for now.

> +++ b/drivers/usb/host/Kconfig
> @@ -317,7 +317,7 @@ config USB_R8A66597_HCD
>
> =A0config SUPERH_ON_CHIP_R8A66597
> =A0 =A0 =A0 =A0boolean "Enable SuperH on-chip R8A66597 USB"
> - =A0 =A0 =A0 depends on USB_R8A66597_HCD && (CPU_SUBTYPE_SH7366 || CPU_S=
UBTYPE_SH7723)
> + =A0 =A0 =A0 depends on USB_R8A66597_HCD && (CPU_SUBTYPE_SH7366 || CPU_S=
UBTYPE_SH7723 || CPU_SUBTYPE_SH7724)
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0 This driver enables support for the on-chip R8A66597 =
in the
> =A0 =A0 =A0 =A0 =A0 SH7366 and SH7723 processors.

Please update the comment as well.

Thanks for your help!

/ magnus
