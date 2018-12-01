From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 01 Dec 2018 01:43:51 +0000
Subject: [PATCH -next] sh: kfr2r09: drop pointless static qualifier in kfr2r09_usb0_gadget_setup()
Message-Id: <1543628631-99957-1-git-send-email-yuehaibing@huawei.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There is no need to have the 'struct clk *camera_clk' variable static
since new value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/sh/boards/mach-kfr2r09/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index c70bc78..203d249 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -477,7 +477,7 @@ static int kfr2r09_usb0_gadget_setup(void)
 
 static int __init kfr2r09_devices_setup(void)
 {
-	static struct clk *camera_clk;
+	struct clk *camera_clk;
 
 	/* register board specific self-refresh code */
 	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF |
