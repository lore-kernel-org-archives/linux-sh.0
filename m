From: Luca Santini <luca.santini@spesonline.com>
Date: Fri, 12 Sep 2008 07:57:17 +0000
Subject: Re: [PATCH] edosk7760 physmap-flash support
Message-Id: <48CA20DD.9000905@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48C8F12E.6080305@spesonline.com>
In-Reply-To: <48C8F12E.6080305@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

trying to eliminate line wrapping....


diff --git a/arch/sh/boards/board-edosk7760.c b/arch/sh/boards/board-edosk7760.c
index 7cc5e11..14a09d4 100644
--- a/arch/sh/boards/board-edosk7760.c
+++ b/arch/sh/boards/board-edosk7760.c
@@ -24,6 +24,7 @@
 #include <linux/smc91x.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/mtd/physmap.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
@@ -40,6 +41,53 @@
 
 #define ETHERNET_IRQ	5
 
+/* NOR flash */
+static struct mtd_partition edosk7760_nor_flash_partitions[] = {
+	{
+		 .name = "bootloader",
+		 .offset = 0,
+		 .size = (1 * 1024 * 1024), /*1MB*/
+		 .mask_flags = MTD_WRITEABLE,	/* Read-only */
+	}, {
+		 .name = "kernel",
+		 .offset = MTDPART_OFS_APPEND,
+		 .size = (2 * 1024 * 1024), /*2MB*/
+	}, {
+		 .name = "fs",
+		 .offset = MTDPART_OFS_APPEND,
+		 .size = (26 * 1024 * 1024),
+	}, {
+		 .name = "other",
+		 .offset = MTDPART_OFS_APPEND,
+		 .size = MTDPART_SIZ_FULL,
+	},
+};
+
+
+static struct physmap_flash_data edosk7760_nor_flash_data = {
+	.width		= 4,
+	.parts		= edosk7760_nor_flash_partitions,
+	.nr_parts	= ARRAY_SIZE(edosk7760_nor_flash_partitions),
+};
+
+static struct resource edosk7760_nor_flash_resources[] = {
+	[0] = {
+		.name	= "NOR Flash",
+		.start	= 0x00000000,
+		.end	= (32 * 1024 * 1024) -1, 	/* 32MB*/
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device edosk7760_nor_flash_device = {
+	.name		= "physmap-flash",
+	.resource	= edosk7760_nor_flash_resources,
+	.num_resources	= ARRAY_SIZE(edosk7760_nor_flash_resources),
+	.dev		= {
+		.platform_data = &edosk7760_nor_flash_data,
+	},
+};
+
 /* i2c initialization functions */
 static struct sh7760_i2c_platdata i2c_pd = {
 	.speed_khz	= 400,
@@ -121,9 +169,10 @@ static struct platform_device smc91x_dev = {
 
 /* platform init code */
 static struct platform_device *edosk7760_devices[] __initdata = {
+	&smc91x_dev,
+	&edosk7760_nor_flash_device,
 	&sh7760_i2c0_dev,
 	&sh7760_i2c1_dev,
-	&smc91x_dev,
 };
 
 static int __init init_edosk7760_devices(void)


Luca Santini wrote:
> diff --git a/arch/sh/boards/board-edosk7760.c 
> b/arch/sh/boards/board-edosk7760.c
> index 7cc5e11..14a09d4 100644
> --- a/arch/sh/boards/board-edosk7760.c
> +++ b/arch/sh/boards/board-edosk7760.c
> @@ -24,6 +24,7 @@
>  #include <linux/smc91x.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
> +#include <linux/mtd/physmap.h>
>  #include <asm/machvec.h>
>  #include <asm/io.h>
>  #include <asm/addrspace.h>
> @@ -40,6 +41,53 @@
> 
>  #define ETHERNET_IRQ    5
> 
> +/* NOR flash */
> +static struct mtd_partition edosk7760_nor_flash_partitions[] = {
> +    {
> +         .name = "bootloader",
> +         .offset = 0,
> +         .size = (1 * 1024 * 1024), /*1MB*/
> +         .mask_flags = MTD_WRITEABLE,    /* Read-only */
> +    }, {
> +         .name = "kernel",
> +         .offset = MTDPART_OFS_APPEND,
> +         .size = (2 * 1024 * 1024), /*2MB*/
> +    }, {
> +         .name = "fs",
> +         .offset = MTDPART_OFS_APPEND,
> +         .size = (26 * 1024 * 1024),
> +    }, {
> +         .name = "other",
> +         .offset = MTDPART_OFS_APPEND,
> +         .size = MTDPART_SIZ_FULL,
> +    },
> +};
> +
> +
> +static struct physmap_flash_data edosk7760_nor_flash_data = {
> +    .width        = 4,
> +    .parts        = edosk7760_nor_flash_partitions,
> +    .nr_parts    = ARRAY_SIZE(edosk7760_nor_flash_partitions),
> +};
> +
> +static struct resource edosk7760_nor_flash_resources[] = {
> +    [0] = {
> +        .name    = "NOR Flash",
> +        .start    = 0x00000000,
> +        .end    = (32 * 1024 * 1024) -1,     /* 32MB*/
> +        .flags    = IORESOURCE_MEM,
> +    }
> +};
> +
> +static struct platform_device edosk7760_nor_flash_device = {
> +    .name        = "physmap-flash",
> +    .resource    = edosk7760_nor_flash_resources,
> +    .num_resources    = ARRAY_SIZE(edosk7760_nor_flash_resources),
> +    .dev        = {
> +        .platform_data = &edosk7760_nor_flash_data,
> +    },
> +};
> +
>  /* i2c initialization functions */
>  static struct sh7760_i2c_platdata i2c_pd = {
>      .speed_khz    = 400,
> @@ -121,9 +169,10 @@ static struct platform_device smc91x_dev = {
> 
>  /* platform init code */
>  static struct platform_device *edosk7760_devices[] __initdata = {
> +    &smc91x_dev,
> +    &edosk7760_nor_flash_device,
>      &sh7760_i2c0_dev,
>      &sh7760_i2c1_dev,
> -    &smc91x_dev,
>  };
> 
>  static int __init init_edosk7760_devices(void)
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
