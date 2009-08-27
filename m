From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 27 Aug 2009 13:57:26 +0000
Subject: Re: [BUG] arch/sh/include/mach-common/mach/sh7785lcr.h: PCA9564_ADDR
Message-Id: <4A9690C6.3030300@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4A95800A.7020603@gentoo.org>
In-Reply-To: <4A95800A.7020603@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Thu, Aug 27, 2009 at 12:01:03PM +0900, yoshii.takashi@renesas.com wrote:
>> Oh, sorry.
>> This might be because the board I sent you was a special version.
>> You (and possibly others who use this version) should revert that commit.
>> I'm really sorry for inconvenient.
>>
>> Paul, are there any good way to support this kind of small differences?
>> Is it ok to add configuration menu item like below?
>>
> Presumably we can figure the version out from the FPGA? If so, we can
> just figure out which devices to register, and have different devices for
> different versions.
> 
> If we can't figure it out from the FPGA, then the next best bet is to use
> the mach types, the version information can be encoded in a new
> mach-type, and we can simply have a mach_is_xxx() check for determining
> the board version and doing the appropriate fixups. We already do this
> today for some boards (highlander, r2d, etc.).

Thank you very much for your comment.
Unfortunately, this board don't have version register in FPGA.
So I made a patch that it adds mach_is_sh7785lcr_pt().
Would you check this patch?

Thanks,
Yoshihiro Shimoda

---
Subject: [PATCH] sh: sh7785lcr: fix prototype board on 32bit MMU mode.

Fix the problem that cannot work PCA9564 on 32bit MMU mode
using prototype board.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/boards/Kconfig                       |    7 +++++++
 arch/sh/boards/board-sh7785lcr.c             |   18 ++++++++++++++++++
 arch/sh/include/mach-common/mach/sh7785lcr.h |    2 ++
 arch/sh/tools/mach-types                     |    1 +
 4 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index b66f6d1..ee5bb20 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -171,6 +171,13 @@ config SH_SH7785LCR_29BIT_PHYSMAPS
 	  DIP switch(S2-5). If you set the DIP switch for S2-5 = ON,
 	  you can access all on-board device in 29bit address mode.

+config SH_SH7785LCR_PT
+	bool "SH7785LCR prototype board on 32-bit MMU mode"
+	depends on SH_SH7785LCR && 32BIT
+	default n
+	help
+	  If you use prototype board, this option is enabled.
+
 config SH_URQUELL
 	bool "Urquell"
 	depends on CPU_SUBTYPE_SH7786
diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index 42410a1..726427c 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -223,6 +223,19 @@ static struct platform_device sm501_device = {
 	.resource	= sm501_resources,
 };

+static struct resource i2c_proto_resources[] = {
+	[0] = {
+		.start	= PCA9564_PROTO_32BIT_ADDR,
+		.end	= PCA9564_PROTO_32BIT_ADDR + PCA9564_SIZE - 1,
+		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8BIT,
+	},
+	[1] = {
+		.start	= 12,
+		.end	= 12,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 static struct resource i2c_resources[] = {
 	[0] = {
 		.start	= PCA9564_ADDR,
@@ -271,6 +284,11 @@ static int __init sh7785lcr_devices_setup(void)
 	i2c_register_board_info(0, sh7785lcr_i2c_devices,
 				ARRAY_SIZE(sh7785lcr_i2c_devices));

+	if (mach_is_sh7785lcr_pt()) {
+		i2c_device.resource = &i2c_proto_resources;
+		i2c_device.num_resources = ARRAY_SIZE(i2c_proto_resources);
+	}
+
 	return platform_add_devices(sh7785lcr_devices,
 				    ARRAY_SIZE(sh7785lcr_devices));
 }
diff --git a/arch/sh/include/mach-common/mach/sh7785lcr.h b/arch/sh/include/mach-common/mach/sh7785lcr.h
index 90011d4..1292ae5 100644
--- a/arch/sh/include/mach-common/mach/sh7785lcr.h
+++ b/arch/sh/include/mach-common/mach/sh7785lcr.h
@@ -35,6 +35,8 @@
 #define PCA9564_ADDR		0x06000000	/* I2C */
 #define PCA9564_SIZE		0x00000100

+#define PCA9564_PROTO_32BIT_ADDR	0x14000000
+
 #define SM107_MEM_ADDR		0x10000000
 #define SM107_MEM_SIZE		0x00e00000
 #define SM107_REG_ADDR		0x13e00000
diff --git a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
index b573628..6639b25 100644
--- a/arch/sh/tools/mach-types
+++ b/arch/sh/tools/mach-types
@@ -53,6 +53,7 @@ RSK7203			SH_RSK7203
 AP325RXA		SH_AP325RXA
 SH7763RDP		SH_SH7763RDP
 SH7785LCR		SH_SH7785LCR
+SH7785LCR_PT		SH_SH7785LCR_PT
 URQUELL			SH_URQUELL
 ESPT			SH_ESPT
 POLARIS			SH_POLARIS
-- 
1.5.5

