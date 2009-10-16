From: Rafael Ignacio Zurita <rizurita@yahoo.com>
Date: Fri, 16 Oct 2009 15:22:36 +0000
Subject: Re: [PATCH] sh: add SuperH DAC audio driver for ALSA
Message-Id: <20091016152236.GA6810@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20091008013423.GA26059@rafazurita.homelinux.net>
In-Reply-To: <20091008013423.GA26059@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Paul,
  
On Fri, Oct 09, 2009 at 10:22:24AM +0900, Paul Mundt wrote:
> On Wed, Oct 07, 2009 at 10:34:23PM -0300, Rafael Ignacio Zurita wrote:
[snip]
> > +#include <linux/hrtimer.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/platform_device.h>
> > +#include <sound/core.h>
> > +#include <sound/initval.h>
> > +#include <sound/pcm.h>
> > +#include <asm/clock.h>
> > +#include <asm/hd64461.h>
> > +#include <mach-common/mach/hp6xx.h>
> 
> #include <mach/hp6xx.h> only.
> 
> > +/* Simple platform device */
> > +static struct platform_device *pd;
> > +
> This shouldn't be in the driver, the board code should be registering its
> own platform device.
> 
> > +#define SND_SH_DAC_DRIVER "SH_DAC"
> > +#define BUFFER_SIZE	64000
> > +#define SH_DAC_AUDIO_CHANNEL 1
> > +
> Buffer size and audio channel are things that ideally belong in platform
> data, as these will not be consistent on other platforms.
> 
[snip]
> > +static void dac_audio_start(void)
> > +{
> > +#ifdef CONFIG_SH_HP6XX
> > +	u16 v;
> > +	u8 v8;
> > +
> > +	/* HP Jornada 680/690 speaker on */
> > +	v = inw(HD64461_GPADR);
> > +	v &= ~HD64461_GPADR_SPEAKER;
> > +	outw(v, HD64461_GPADR);
> > +
> > +	/* HP Palmtop 620lx/660lx speaker on */
> > +	v8 = inb(PKDR);
> > +	v8 &= ~PKDR_SPEAKER;
> > +	outb(v8, PKDR);
> > +#endif
> > +	sh_dac_enable(SH_DAC_AUDIO_CHANNEL);
> > +}
> > +
> > +static void dac_audio_stop(struct snd_sh_dac *chip)
> > +{
> > +
> > +#ifdef CONFIG_SH_HP6XX
> > +	u16 v;
> > +	u8 v8;
> > +#endif
> > +
> > +	dac_audio_stop_timer(chip);
> > +
> > +#ifdef CONFIG_SH_HP6XX
> > +	/* HP Jornada 680/690 speaker off */
> > +	v = inw(HD64461_GPADR);
> > +	v |= HD64461_GPADR_SPEAKER;
> > +	outw(v, HD64461_GPADR);
> > +
> > +	/* HP Palmtop 620lx/660lx speaker off */
> > +	v8 = inb(PKDR);
> > +	v8 |= PKDR_SPEAKER;
> > +	outb(v8, PKDR);
> > +#endif
> > +	sh_dac_output(0, SH_DAC_AUDIO_CHANNEL);
> > +	sh_dac_disable(SH_DAC_AUDIO_CHANNEL);
> > +}
> > +
> This shows that at least the start/stop routines need to be defined by
> the platform, while the driver only takes care of the hrtimer management.
> As such, these need to be moved in to function pointers in the platform
> data and moved in to the platform code.
> 
[snip]
> 
> > +/* clean up the module */
> > +static void __exit sh_dac_exit(void)
> > +{
> > +	platform_device_unregister(pd);
> > +	platform_driver_unregister(&driver);
> > +}
> > +
> > +
> > +static int __init sh_dac_init(void)
> > +{
> 
> For some reason you have these defined in reverse order.
> 
> > +	int err;
> > +
> > +	err = platform_driver_register(&driver);
> > +	if (unlikely(err < 0))
> > +		return err;
> > +
> > +	pd = platform_device_register_simple(SND_SH_DAC_DRIVER, -1, NULL, 0);
> > +	if (unlikely(IS_ERR(pd))) {
> > +		platform_driver_unregister(&driver);
> > +		return PTR_ERR(pd);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Once you kill off the platform device silliness, this can just be a
> simple
> 
> 	return platform_driver_register(&driver);

Regarding platform bits, let me show you just the current idea to 
put the platform bits in the proper place : 

 arch/sh/boards/mach-hp6xx/setup.c        |   58 ++++
 include/sound/dac_audio.h                |   21 ++
 sound/sh/snd_sh_dac_audio.c              |  471 ++++++++++++++++++++++++++++++

diff --git a/arch/sh/boards/mach-hp6xx/setup.c b/arch/sh/boards/mach-hp6xx/setup.c
index 8f305b3..826a499 100644
--- a/arch/sh/boards/mach-hp6xx/setup.c
+++ b/arch/sh/boards/mach-hp6xx/setup.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
+#include <sound/dac_audio.h>
 #include <asm/hd64461.h>
 #include <asm/io.h>
 #include <mach/hp6xx.h>
@@ -51,9 +52,66 @@ static struct platform_device jornadakbd_device = {
 	.id		= -1,
 };
 
+static void dac_audio_start(struct dac_audio_pdata *pdata);
+static void dac_audio_stop(struct dac_audio_pdata *pdata);
+
+static struct dac_audio_pdata dac_audio_platform_data = {
+	.buffer_size		= 64000,
+	.channel		= 1,
+	.start			= dac_audio_start,
+	.stop			= dac_audio_stop,
+};
+
+static void dac_audio_start(struct dac_audio_pdata *pdata)
+{
+	u16 v;
+	u8 v8;
+
+	/* HP Jornada 680/690 speaker on */
+	v = inw(HD64461_GPADR);
+	v &= ~HD64461_GPADR_SPEAKER;
+	outw(v, HD64461_GPADR);
+
+	/* HP Palmtop 620lx/660lx speaker on */
+	v8 = inb(PKDR);
+	v8 &= ~PKDR_SPEAKER;
+	outb(v8, PKDR);
+
+	sh_dac_enable(pdata->channel);
+}
+
+static void dac_audio_stop(struct dac_audio_pdata *pdata)
+{
+	u16 v;
+	u8 v8;
+
+	/* HP Jornada 680/690 speaker off */
+	v = inw(HD64461_GPADR);
+	v |= HD64461_GPADR_SPEAKER;
+	outw(v, HD64461_GPADR);
+
+	/* HP Palmtop 620lx/660lx speaker off */
+	v8 = inb(PKDR);
+	v8 |= PKDR_SPEAKER;
+	outb(v8, PKDR);
+
+	sh_dac_output(0, pdata->channel);
+	sh_dac_disable(pdata->channel);
+}
+
+static struct platform_device dac_audio_device = {
+	.name		= "dac_audio",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &dac_audio_platform_data,
+	}
+
+};
+
 static struct platform_device *hp6xx_devices[] __initdata = {
 	&cf_ide_device,
 	&jornadakbd_device,
+	&dac_audio_device,
 };
 
 static void __init hp6xx_init_irq(void)
diff --git a/include/sound/dac_audio.h b/include/sound/dac_audio.h
new file mode 100644
index 0000000..98324e9
--- /dev/null
+++ b/include/sound/dac_audio.h
@@ -0,0 +1,21 @@
+/*
+ * SH_DAC specific configuration, for the dac_audio platform_device
+ *
+ * Copyright (C) 2009 Rafael Ignacio Zurita <rizurita@yahoo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef __INCLUDE_DAC_AUDIO_H
+#define __INCLUDE_DAC_AUDIO_H
+
+struct dac_audio_pdata {
+	int buffer_size;
+	int channel;
+	void (*start)(struct dac_audio_pdata *pd);
+	void (*stop)(struct dac_audio_pdata *pd);
+};
+
+#endif /* __INCLUDE_DAC_AUDIO_H */
diff --git a/sound/sh/snd_sh_dac_audio.c b/sound/sh/snd_sh_dac_audio.c
new file mode 100644
index 0000000..63eda29
--- /dev/null
+++ b/sound/sh/snd_sh_dac_audio.c
@@ -0,0 +1,471 @@
+/*
+ * snd_sh_dac_audio.c - SuperH DAC audio driver for ALSA
+ *
[snip]
+ */
+
+#include <linux/hrtimer.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/dac_audio.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <asm/clock.h>
+#include <asm/hd64461.h>
+#include <mach/hp6xx.h>
+#include <cpu/dac.h>
+
[snip]
+
+/*
+ * "driver" definition
+ */
+static struct platform_driver driver = {
+	.probe	= snd_sh_dac_probe,
+	.remove = snd_sh_dac_remove,
+	.driver = {
+		.name = SND_SH_DAC_DRIVER,
+	},
+};
+
+static int __init sh_dac_init(void)
+{
+	return platform_driver_register(&driver);
+}
+
+/* clean up the module */
+static void __exit sh_dac_exit(void)
+{
+	platform_driver_unregister(&driver);
+}
+
+module_init(sh_dac_init);
+module_exit(sh_dac_exit);

Is that idea better for the platform device? The new include/sound/dac_audio.h
file has the struct for the platform data. Perhaps another platform would like
to use the same struct, if it needs to use the driver (it should set the values
for the members in its board code).

I am also fixing the other problems that you pointed in your mail.
If you are okey with the idea I am going to resend a new version of the patch.
Thanks a lot for the review.

Rafael
