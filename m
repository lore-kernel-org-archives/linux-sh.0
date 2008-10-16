From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 16 Oct 2008 23:16:40 +0000
Subject: [PATCH] soc-camera: fix compile breakage on SH
Message-Id: <Pine.LNX.4.64.0810170108390.8422@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix Migo-R compile breakage caused by incomplete merge.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Tested-by: Magnus Damm <damm@igel.co.jp>
---

Paul, as I explained in my reply to my own patch to fix this compile 
breakage, as it didn't get Acks soon enough as I hoped, I've splitted it 
into two parts, this is the sh-part. It depends on patch "soc-camera: move 
sensor power management to soc_camera_platform.c", posted simultaneously 
to the V4L tree. But even if you commit it before the v4l-patch gets 
merged, it won't get worth - it will just stay broken until the other one 
gets merged too:-)

Thanks
Guennadi

 arch/sh/boards/mach-migor/setup.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 714dce9..95459f3 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -312,6 +312,14 @@ static void camera_power_off(void)
 	ctrl_outb(ctrl_inb(PORT_PTDR) & ~0x08, PORT_PTDR);
 }
 
+static void camera_power(int mode)
+{
+	if (mode)
+		camera_power_on();
+	else
+		camera_power_off();
+}
+
 #ifdef CONFIG_I2C
 static unsigned char camera_ov772x_magic[]  {
@@ -391,6 +399,7 @@ static struct soc_camera_platform_info ov772x_info = {
 	},
 	.bus_param =  SOCAM_PCLK_SAMPLE_RISING | SOCAM_HSYNC_ACTIVE_HIGH |
 	SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_MASTER | SOCAM_DATAWIDTH_8,
+	.power = camera_power,
 	.set_capture = ov772x_set_capture,
 };
 
@@ -405,8 +414,6 @@ static struct platform_device migor_camera_device = {
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
 	.flags = SOCAM_MASTER | SOCAM_DATAWIDTH_8 | SOCAM_PCLK_SAMPLE_RISING \
 	| SOCAM_HSYNC_ACTIVE_HIGH | SOCAM_VSYNC_ACTIVE_HIGH,
-	.enable_camera = camera_power_on,
-	.disable_camera = camera_power_off,
 };
 
 static struct resource migor_ceu_resources[] = {
-- 
1.5.4

