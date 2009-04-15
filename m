From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 11:36:42 +0000
Subject: Re: [PATCH 4/6] Add I2C support for SH7724
Message-Id: <aec7e5c30904150436v53a292es9f715e1b3956c192@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uy6u31ubd.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uy6u31ubd.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Here comes a few nitpicks!

On Wed, Apr 15, 2009 at 11:42 AM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> =A0arch/sh/kernel/cpu/sh4a/setup-sh7724.c | =A0 45 ++++++++++++++++++++++=
++++++++++
> =A01 files changed, 45 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/=
sh4a/setup-sh7724.c
> index cac953b..ca625c2 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> @@ -125,10 +125,55 @@ static struct platform_device usb0_device =3D {
> =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D usb0_host_resources,
> =A0};
>
> +/* I2C */
> +static struct resource iic0_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "IIC0",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0x04470000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0x04470016 - 1,

Each SuperH Mobile I2C register is accessed using 8-bit read/write
operation, but all registers are 32-bit aligned. sh7724 does not seem
to be any exception. Please use ...0017 as end.

> +static struct resource iic1_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "IIC1",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0x04750000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0x04750016 - 1,

Same here.

> +static struct platform_device iic0_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "i2c-sh_mobile",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0, /* "i2c0" clock */
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(iic0_resources),
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D iic0_resources,
> +};
> +
> +static struct platform_device iic1_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "i2c-sh_mobile",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 1, /* "i2c1" clock */
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(iic1_resources),
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D iic1_resources,
> +};

Why do you keep these structures together? Please put iic0_device
after iic0_resources.

Please fix and resend.

Thanks,

/ magnus
