From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 30 Sep 2011 06:35:02 +0000
Subject: Re: [PATCH 4/5] ARM: mach-shmobile: r8a7740: Add i2c support
Message-Id: <CABMQnV+jrXsNvCtTfB_jNjsPDFg-damx=ZWSsKr8-bXOHQ541Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8762kcqglg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762kcqglg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

2011/9/29 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
> r8a7740 I2C needs work around
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> =A0arch/arm/mach-shmobile/setup-r8a7740.c | =A0102 ++++++++++++++++++++++=
++++++++++
> =A01 files changed, 102 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmob=
ile/setup-r8a7740.c
> index b067383..ab43651 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -17,8 +17,10 @@
> =A0* along with this program; if not, write to the Free Software
> =A0* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =A002110-1=
301 =A0USA
> =A0*/
> +#include <linux/delay.h>
> =A0#include <linux/kernel.h>
> =A0#include <linux/init.h>
> +#include <linux/io.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/serial_sci.h>
> =A0#include <linux/sh_timer.h>
> @@ -242,10 +244,110 @@ static struct platform_device *r8a7740_early_devic=
es[] __initdata =3D {
> =A0 =A0 =A0 =A0&cmt10_device,
> =A0};
>
> +/* I2C */
> +static struct resource i2c0_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "IIC0",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xfff20000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xfff20425 - 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [1] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D gic_spi(201),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D gic_spi(204),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct resource i2c1_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "IIC1",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xe6c20000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xe6c20425 - 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [1] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D gic_spi(70),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D gic_spi(73),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct platform_device i2c0_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "i2c-sh_mobile",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D i2c0_resources,
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(i2c0_resources),
> +};
> +
> +static struct platform_device i2c1_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "i2c-sh_mobile",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D i2c1_resources,
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(i2c1_resources),
> +};
> +
> +static struct platform_device *r8a7740_late_devices[] __initdata =3D {
> + =A0 =A0 =A0 &i2c0_device,
> + =A0 =A0 =A0 &i2c1_device,
> +};
> +
> +#define ICCR =A0 0x0004
> +#define ICSTART =A0 =A0 =A0 =A00x0070
> +
> +#define i2c_read(offset) =A0 =A0 =A0 ioread8(reg + offset)
> +#define i2c_write(offset, data) =A0 =A0 =A0 =A0iowrite8(data, reg + offs=
et)

The macro must not depend on the specific local variable.

> +
> +static void r8a7740_i2c_workaround(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 void __iomem *reg;
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!res) {

if (unlikely(res =3D NULL)) {  ?
Please check NULL.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("r8a7740 i2c workaround fail (cannot=
 find resource)\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 reg =3D ioremap(res->start, resource_size(res));
> + =A0 =A0 =A0 if (!reg) {

And this.

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
