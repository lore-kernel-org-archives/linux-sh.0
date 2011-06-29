From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 29 Jun 2011 10:13:04 +0000
Subject: [PATCH] ARM: mach-shmobile: make a struct in board-ap4evb.c static
Message-Id: <Pine.LNX.4.64.1106291211530.12577@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

struct soc_camera_link imx074_link in board-ap4evb.c doesn't have
to be global.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 08acb6e..a371703 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -858,7 +858,7 @@ static struct i2c_board_info imx074_info = {
 	I2C_BOARD_INFO("imx074", 0x1a),
 };
 
-struct soc_camera_link imx074_link = {
+static struct soc_camera_link imx074_link = {
 	.bus_id		= 0,
 	.board_info	= &imx074_info,
 	.i2c_adapter_id	= 0,
-- 
1.7.2.5

