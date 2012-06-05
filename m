From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 05 Jun 2012 10:16:29 +0000
Subject: [PATCH v2] ARM: mach-shmobile: set i2c_board_info.type once
Message-Id: <1338891389.4971.45.camel@x61.thuisdomein>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

tsc_device (of struct i2cboard_info) has its "type" member set to
"tsc2007" twice. First through the I2C_BOARD_INFO macro and then
directly. Drop the superfluous second instance.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) v1 was called "Drop superfluous setting of i2c_board_info.type". v2
drops the mach-imx bits. Those were already fixed with a patch called
"ARM: imx: only specify i2c device type once" by Uwe Kleine-K=C3=B6nig.
Sascha Hauer has committed that patch to some unknown to me branch.
Rebased onto v3.5-rc1.

1) Still entirely untested. I'm unsure what toolchain is needed to
compile this and I'm certain that I don't have the hardware.

 arch/arm/mach-shmobile/board-ap4evb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile=
/board-ap4evb.c
index ace6024..b9f3122 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1197,7 +1197,6 @@ static struct tsc2007_platform_data tsc2007_info =3D {
=20
 static struct i2c_board_info tsc_device =3D {
 	I2C_BOARD_INFO("tsc2007", 0x48),
-	.type		=3D "tsc2007",
 	.platform_data	=3D &tsc2007_info,
 	/*.irq is selected on ap4evb_init */
 };
--=20
1.7.7.6

