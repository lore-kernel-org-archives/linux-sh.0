From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 17 Oct 2008 07:53:57 +0000
Subject: [PATCH] sh: ap325rxa: Add support RTC RX-8564LC in AP325RXA board
Message-Id: <48F84495.9010807@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Renesas AP325RXA board has Epson RX-8564LC of RTC.
This patch supports RTC of this board.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/board-ap325rxa.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index 7ae8dcd..6abaf46 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -294,6 +294,9 @@ static struct platform_device *ap325rxa_devices[] __initdata = {
 };

 static struct i2c_board_info __initdata ap325rxa_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("pcf8563", 0x51),
+	},
 };

 static int __init ap325rxa_devices_setup(void)
-- 
1.5.6.5

