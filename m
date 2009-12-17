From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 17 Dec 2009 03:14:14 +0000
Subject: Re: [PATCH 5/5] sh: dmaengine support for sh7724
Message-Id: <29ab51dc0912161914w6967c9d1l79df27d670f01b6a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange> 
	<Pine.LNX.4.64.0912041942330.3981@axis700.grange> <e9c3a7c20912071702h1aea2026kff22db99a221f6c4@mail.gmail.com> 
	<20091208071302.GA23814@linux-sh.org>
In-Reply-To: <20091208071302.GA23814@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

2009/12/8 Paul Mundt <lethal@linux-sh.org>:
> On Mon, Dec 07, 2009 at 06:02:24PM -0700, Dan Williams wrote:
>> On Fri, Dec 4, 2009 at 11:45 AM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > Add a dmaengine platform device to sh7724, fix DMA channel interrupt n=
umbers.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> > ---
>> >
>> > With this patch dmatest works with channels 0-5, channels 6-11 still d=
on't
>> > work for some reason... So, feel free to discard it for now, if a comp=
lete
>> > fix would be preferred.
>>
>> Does this patch limit operation to channels 0-5? =A0I leave this one for
>> Paul to disposition.
>>
> There are 6 channels per controller, so the fact that the second
> controller isn't working could either be cause the driver needs more work
> to handle multiple controllers properly, or there could be a pinmux issue
> that hasn't been resolved yet for DMAC1. Both of these cases require the
> driver to be a bit smarter, but as Guennadi is presently working on these
> things, doing them incrementally is ok with me. If this gets DMAC0
> working at least where it wasn't before, it's certainly worth applying.
> DMAC1 seems to have more problems than just wrong interrupt numbers, so
> this isn't going to cause any regressions there either.
>
> Acked-by: Paul Mundt <lethal@linux-sh.org>

This patch can not apply Paul's git/HEAD too.
I updated patch.

Acked-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Best regards,
  Nobuhiro

-----

Add a dmaengine platform device to sh7724, fix DMA channel interrupt number=
s.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h |    8 ++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
index f0886bc..c4ed660 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
@@ -19,10 +19,10 @@
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723) || \
       defined(CONFIG_CPU_SUBTYPE_SH7724)
 #define DMTE0_IRQ	48	/* DMAC0A*/
-#define DMTE4_IRQ	40	/* DMAC0B */
-#define DMTE6_IRQ	42
-#define DMTE8_IRQ	76	/* DMAC1A */
-#define DMTE9_IRQ	77
+#define DMTE4_IRQ	76	/* DMAC0B */
+#define DMTE6_IRQ	40
+#define DMTE8_IRQ	42	/* DMAC1A */
+#define DMTE9_IRQ	43
 #define DMTE10_IRQ	72	/* DMAC1B */
 #define DMTE11_IRQ	73
 #define DMAE0_IRQ	78	/* DMA Error IRQ*/
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index a52f351..d32f96c 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -23,9 +23,23 @@
 #include <linux/notifier.h>
 #include <asm/suspend.h>
 #include <asm/clock.h>
+#include <asm/dma-sh.h>
 #include <asm/mmzone.h>
 #include <cpu/sh7724.h>

+/* DMA */
+static struct sh_dmae_pdata dma_platform_data =3D {
+	.mode =3D SHDMA_DMAOR1,
+};
+
+static struct platform_device dma_device =3D {
+	.name	=3D "sh-dma-engine",
+	.id		=3D -1,
+	.dev	=3D {
+		.platform_data	=3D &dma_platform_data,
+	},
+};
+
 /* Serial */
 static struct plat_sci_port scif0_platform_data =3D {
 	.mapbase        =3D 0xffe00000,
@@ -649,6 +663,7 @@ static struct platform_device *sh7724_devices[]
__initdata =3D {
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
+	&dma_device,
 	&rtc_device,
 	&iic0_device,
 	&iic1_device,
--=20
1.6.5.4
