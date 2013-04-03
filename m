From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Apr 2013 06:33:08 +0000
Subject: [PATCH 02/04] ARM: shmobile: r8a7779 pinmux platform device cleanup
Message-Id: <20130403063308.2500.76867.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130403063246.2500.65318.sendpatchset@w520>
In-Reply-To: <20130403063246.2500.65318.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use DEFINE_RES_MEM() to save a couple of lines of code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7779.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2013-04-03 15:30:16.000000000 +0900
@@ -63,12 +63,8 @@ void __init r8a7779_map_io(void)
 	iotable_init(r8a7779_io_desc, ARRAY_SIZE(r8a7779_io_desc));
 }
 
-static struct resource r8a7779_pfc_resources[] = {
-	[0] = {
-		.start	= 0xfffc0000,
-		.end	= 0xfffc023b,
-		.flags	= IORESOURCE_MEM,
-	},
+static const struct resource r8a7779_pfc_resources[] = {
+	DEFINE_RES_MEM(0xfffc0000, 0x023c),
 };
 
 static struct platform_device r8a7779_pfc_device = {
@@ -80,15 +76,8 @@ static struct platform_device r8a7779_pf
 
 #define R8A7779_GPIO(idx, npins) \
 static struct resource r8a7779_gpio##idx##_resources[] = {		\
-	[0] = {								\
-		.start	= 0xffc40000 + 0x1000 * (idx),			\
-		.end	= 0xffc4002b + 0x1000 * (idx),			\
-		.flags	= IORESOURCE_MEM,				\
-	},								\
-	[1] = {								\
-		.start	= gic_iid(0xad + (idx)),			\
-		.flags	= IORESOURCE_IRQ,				\
-	}								\
+	DEFINE_RES_MEM(0xffc40000 + (0x1000 * (idx)), 0x002c),		\
+	DEFINE_RES_IRQ(gic_iid(0xad + (idx))),				\
 };									\
 									\
 static struct gpio_rcar_config r8a7779_gpio##idx##_platform_data = {	\
