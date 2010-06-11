From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Fri, 11 Jun 2010 04:49:48 +0000
Subject: Re: [PATCH v2 1/4] Add the directory mach-sh2007 for SH-2007 board
Message-Id: <4C11C06C.5010503@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1275991727-4730-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1275991727-4730-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus,

On 06/10/10 15:30, Magnus Damm wrote:
 > Hi Mitake-san,
 >
 > On Tue, Jun 8, 2010 at 7:08 PM, Hitoshi Mitake
 > <mitake@dcl.info.waseda.ac.jp>  wrote:
 >> This patch adds directory for SH-2007 support.
 >> mach-sh2007/setup.c ... Setup platform devices and provide machine 
vector.
 >>
 >> CAUTION: IDE support is not tested yet,
 >>          because cable for 2.5 inch disk is hard to obtain.
 >>          After obtaining the cable and testing,
 >>          I'll remove #if 0 ... #endif and activate IDE support.
 >> v2:
 >>   * Pending onboardio.c, for dip switch reading and LED manipulating.
 >>    Because these deviced should be treated in more unified way
 >>    such as LED device class. Creating /dev/dipsw is dirty.
 >>    But the LED device is not physical device, it exists logicaly.
 >>    I'm pending my decision about treating dip switch and logical LED 
temporary.
 >>   * Cleaning. setup.c of v1 did lots of non board specific
 >>    (processor specific) things. According to Paul's advice, I 
reduced them.
 >>    And sh2007_init_irq() uses interrupt setting of 7780 specific.
 >>
 >> Cc: Magnus Damm<magnus.damm@gmail.com>
 >> Signed-off-by: Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>
 >> ---
 >>   arch/sh/boards/mach-sh2007/Makefile |    1 +
 >>   arch/sh/boards/mach-sh2007/setup.c  |  314 
+++++++++++++++++++++++++++++++++++
 >>   2 files changed, 315 insertions(+), 0 deletions(-)
 >>   create mode 100644 arch/sh/boards/mach-sh2007/Makefile
 >>   create mode 100644 arch/sh/boards/mach-sh2007/setup.c
 >>
 >> diff --git a/arch/sh/boards/mach-sh2007/Makefile 
b/arch/sh/boards/mach-sh2007/Makefile
 >> new file mode 100644
 >> index 0000000..2b9dba4
 >> --- /dev/null
 >> +++ b/arch/sh/boards/mach-sh2007/Makefile
 >> @@ -0,0 +1 @@
 >> +obj-y += setup.o
 >> diff --git a/arch/sh/boards/mach-sh2007/setup.c 
b/arch/sh/boards/mach-sh2007/setup.c
 >> new file mode 100644
 >> index 0000000..73bb2e9
 >> --- /dev/null
 >> +++ b/arch/sh/boards/mach-sh2007/setup.c
 >> @@ -0,0 +1,314 @@
 >
 > [snip]
 >
 >> +static void release_platform_dev(struct device *dev)
 >> +{
 >> +       dev->parent = NULL;
 >> +}
 >
 > Why? I don't think you need this one.
 >
 >> +struct smsc911x_platform_config smc911x_info = {
 >> +       .flags          = SMSC911X_USE_32BIT,
 >> +       .irq_polarity   = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 >> +       .irq_type       = SMSC911X_IRQ_TYPE_PUSH_PULL,
 >> +};
 >> +
 >> +static struct resource smsc9118_0_resources[] = {
 >> +       [0] = {
 >> +               .start  = SMC0_BASE,
 >> +               .end    = SMC0_BASE + 0xff,
 >> +               .flags  = IORESOURCE_MEM,
 >> +       },
 >> +       [1] = {
 >> +               .start  = evt2irq(0x240),
 >> +               .end    = evt2irq(0x240),
 >> +               .flags  = IORESOURCE_IRQ,
 >> +       }
 >> +};
 >> +
 >> +static struct resource smsc9118_1_resources[] = {
 >> +       [0] = {
 >> +               .start  = SMC1_BASE,
 >> +               .end    = SMC1_BASE + 0xff,
 >> +               .flags  = IORESOURCE_MEM,
 >> +       },
 >> +       [1] = {
 >> +               .start  = evt2irq(0x280),
 >> +               .end    = evt2irq(0x280),
 >> +               .flags  = IORESOURCE_IRQ,
 >> +       }
 >> +};
 >> +
 >> +static struct platform_device smsc9118_0_device = {
 >> +       .name           = "smsc911x",
 >> +       .id             = 0,
 >> +       .num_resources  = ARRAY_SIZE(smsc9118_0_resources),
 >> +       .resource       = smsc9118_0_resources,
 >> +       .dev = {
 >> +               .release       = release_platform_dev,
 >> +               .platform_data =&smc911x_info,
 >> +       },
 >> +};
 >> +
 >> +static struct platform_device smsc9118_1_device = {
 >> +       .name           = "smsc911x",
 >> +       .id             = 1,
 >> +       .num_resources  = ARRAY_SIZE(smsc9118_1_resources),
 >> +       .resource       = smsc9118_1_resources,
 >> +       .dev = {
 >> +               .release       = release_platform_dev,
 >> +               .platform_data =&smc911x_info,
 >> +       },
 >> +};
 >
 > Same here with release_platform_dev.

Ah, sorry, this is meaningless function.
I'll remove it in next series.

 >
 >> +static struct resource cf_resources[] = {
 >> +       [0] = {
 >> +               .start  = CF_BASE + CF_OFFSET,
 >> +               .end    = CF_BASE + CF_OFFSET + 0x0f,
 >> +               .flags  = IORESOURCE_MEM,
 >> +       },
 >> +       [1] = {
 >> +               .start  = CF_BASE + CF_OFFSET + 0x206,
 >> +               .end    = CF_BASE + CF_OFFSET + 0x20f,
 >> +               .flags  = IORESOURCE_MEM,
 >> +       },
 >> +       [2] = {
 >> +               .start  = evt2irq(0x2c0),
 >> +               .end    = evt2irq(0x2c0),
 >> +               .flags  = IORESOURCE_IRQ,
 >> +       },
 >> +};
 >> +
 >> +static struct pata_platform_info cf_info = {
 >> +};
 >> +
 >> +static struct platform_device cf_device  = {
 >> +       .name           = "pata_platform",
 >> +       .id             = 0,
 >> +       .num_resources  = ARRAY_SIZE(cf_resources),
 >> +       .resource       = cf_resources,
 >> +       .dev = {
 >> +               .platform_data =&cf_info,
 >> +       },
 >> +};
 >> +
 >> +#if 0  /* I'll turn this code on after testing IDE... */
 >> +static struct resource ide_resources[] = {
 >> +       [0] = {
 >> +               .start  = IDE_BASE + IDE_OFFSET,
 >> +               .end    = IDE_BASE + IDE_OFFSET + 0x0f,
 >> +               .flags  = IORESOURCE_MEM,
 >> +       },
 >> +       [1] = {
 >> +               .start  = IDE_BASE + IDE_OFFSET + 0x206,
 >> +               .end    = IDE_BASE + IDE_OFFSET + 0x20f,
 >> +               .flags  = IORESOURCE_MEM,
 >> +       },
 >> +       [2] = {
 >> +               .start  = evt2irq(0x300),
 >> +               .end    = evt2irq(0x300),
 >> +               .flags  = IORESOURCE_IRQ,
 >> +       },
 >> +};
 >> +
 >> +
 >> +static struct pata_platform_info ide_info = {
 >> +};
 >> +
 >> +static struct platform_device ide_device  = {
 >> +       .name           = "pata_platform",
 >> +       .id             = 1,
 >> +       .num_resources  = ARRAY_SIZE(ide_resources),
 >> +       .resource       = ide_resources,
 >> +       .dev = {
 >> +               .platform_data =&ide_info,
 >> +       },
 >> +};
 >> +#endif
 >> +
 >> +static struct platform_device *sh2007_devices[] __initdata = {
 >> +&smsc9118_0_device,
 >> +&smsc9118_1_device,
 >> +&cf_device,
 >> +#if 0
 >> +&ide_device,
 >> +#endif
 >
 > Please remove the #if0 stuff if possible. You can always make another
 > patch for these features later on if needed.

OK. I'll remove #if 0.
I might be able to obtain cable for 2.5 inch HDD in near future.
I'll be able to test IDE support soon.

 >
 > Apart from that it looks ok to me!
 >

Thanks for your review!

        Hitoshi
