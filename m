From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 Jun 2010 06:30:15 +0000
Subject: Re: [PATCH v2 1/4] Add the directory mach-sh2007 for SH-2007 board
Message-Id: <AANLkTikRPcbyiXfCqMC2zQxqS0oNjwhVUHURbyCRoCwm@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1275991727-4730-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1275991727-4730-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Mitake-san,

On Tue, Jun 8, 2010 at 7:08 PM, Hitoshi Mitake
<mitake@dcl.info.waseda.ac.jp> wrote:
> This patch adds directory for SH-2007 support.
> mach-sh2007/setup.c ... Setup platform devices and provide machine vector.
>
> CAUTION: IDE support is not tested yet,
> =A0 =A0 =A0 =A0 because cable for 2.5 inch disk is hard to obtain.
> =A0 =A0 =A0 =A0 After obtaining the cable and testing,
> =A0 =A0 =A0 =A0 I'll remove #if 0 ... #endif and activate IDE support.
> v2:
> =A0* Pending onboardio.c, for dip switch reading and LED manipulating.
> =A0 Because these deviced should be treated in more unified way
> =A0 such as LED device class. Creating /dev/dipsw is dirty.
> =A0 But the LED device is not physical device, it exists logicaly.
> =A0 I'm pending my decision about treating dip switch and logical LED tem=
porary.
> =A0* Cleaning. setup.c of v1 did lots of non board specific
> =A0 (processor specific) things. According to Paul's advice, I reduced th=
em.
> =A0 And sh2007_init_irq() uses interrupt setting of 7780 specific.
>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
> ---
> =A0arch/sh/boards/mach-sh2007/Makefile | =A0 =A01 +
> =A0arch/sh/boards/mach-sh2007/setup.c =A0| =A0314 +++++++++++++++++++++++=
++++++++++++
> =A02 files changed, 315 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/sh/boards/mach-sh2007/Makefile
> =A0create mode 100644 arch/sh/boards/mach-sh2007/setup.c
>
> diff --git a/arch/sh/boards/mach-sh2007/Makefile b/arch/sh/boards/mach-sh=
2007/Makefile
> new file mode 100644
> index 0000000..2b9dba4
> --- /dev/null
> +++ b/arch/sh/boards/mach-sh2007/Makefile
> @@ -0,0 +1 @@
> +obj-y +=3D setup.o
> diff --git a/arch/sh/boards/mach-sh2007/setup.c b/arch/sh/boards/mach-sh2=
007/setup.c
> new file mode 100644
> index 0000000..73bb2e9
> --- /dev/null
> +++ b/arch/sh/boards/mach-sh2007/setup.c
> @@ -0,0 +1,314 @@

[snip]

> +static void release_platform_dev(struct device *dev)
> +{
> + =A0 =A0 =A0 dev->parent =3D NULL;
> +}

Why? I don't think you need this one.

> +struct smsc911x_platform_config smc911x_info =3D {
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D SMSC911X_USE_32BIT,
> + =A0 =A0 =A0 .irq_polarity =A0 =3D SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
> + =A0 =A0 =A0 .irq_type =A0 =A0 =A0 =3D SMSC911X_IRQ_TYPE_PUSH_PULL,
> +};
> +
> +static struct resource smsc9118_0_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D SMC0_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D SMC0_BASE + 0xff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [1] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D evt2irq(0x240),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D evt2irq(0x240),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
> + =A0 =A0 =A0 }
> +};
> +
> +static struct resource smsc9118_1_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D SMC1_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D SMC1_BASE + 0xff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [1] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D evt2irq(0x280),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D evt2irq(0x280),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
> + =A0 =A0 =A0 }
> +};
> +
> +static struct platform_device smsc9118_0_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "smsc911x",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(smsc9118_0_resources),
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D smsc9118_0_resources,
> + =A0 =A0 =A0 .dev =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .release =A0 =A0 =A0 =3D release_platform_d=
ev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &smc911x_info,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct platform_device smsc9118_1_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "smsc911x",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(smsc9118_1_resources),
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D smsc9118_1_resources,
> + =A0 =A0 =A0 .dev =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .release =A0 =A0 =A0 =3D release_platform_d=
ev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &smc911x_info,
> + =A0 =A0 =A0 },
> +};

Same here with release_platform_dev.

> +static struct resource cf_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D CF_BASE + CF_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D CF_BASE + CF_OFFSET + 0x0f,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [1] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D CF_BASE + CF_OFFSET + 0x206,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D CF_BASE + CF_OFFSET + 0x20f,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [2] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D evt2irq(0x2c0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D evt2irq(0x2c0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct pata_platform_info cf_info =3D {
> +};
> +
> +static struct platform_device cf_device =A0=3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "pata_platform",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(cf_resources),
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D cf_resources,
> + =A0 =A0 =A0 .dev =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &cf_info,
> + =A0 =A0 =A0 },
> +};
> +
> +#if 0 =A0/* I'll turn this code on after testing IDE... */
> +static struct resource ide_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D IDE_BASE + IDE_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D IDE_BASE + IDE_OFFSET + 0x0=
f,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [1] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D IDE_BASE + IDE_OFFSET + 0x206,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D IDE_BASE + IDE_OFFSET + 0x2=
0f,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [2] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D evt2irq(0x300),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D evt2irq(0x300),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
> + =A0 =A0 =A0 },
> +};
> +
> +
> +static struct pata_platform_info ide_info =3D {
> +};
> +
> +static struct platform_device ide_device =A0=3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "pata_platform",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(ide_resources),
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D ide_resources,
> + =A0 =A0 =A0 .dev =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &ide_info,
> + =A0 =A0 =A0 },
> +};
> +#endif
> +
> +static struct platform_device *sh2007_devices[] __initdata =3D {
> + =A0 =A0 =A0 &smsc9118_0_device,
> + =A0 =A0 =A0 &smsc9118_1_device,
> + =A0 =A0 =A0 &cf_device,
> +#if 0
> + =A0 =A0 =A0 &ide_device,
> +#endif

Please remove the #if0 stuff if possible. You can always make another
patch for these features later on if needed.

Apart from that it looks ok to me!

Thanks,

/ magnus
