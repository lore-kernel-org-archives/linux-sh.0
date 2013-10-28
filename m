From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 28 Oct 2013 22:49:27 +0000
Subject: [PATCH 10/12] usb: r8a66597-hcd: Convert to clk_prepare/unprepare
Message-Id: <1383000569-8916-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
clk_disable_unprepare() to get ready for the migration to the common
clock framework.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/usb/host/r8a66597-hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 2ad004a..a2fdd85 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -95,7 +95,7 @@ static int r8a66597_clock_enable(struct r8a66597 *r8a66597)
 	int i = 0;
 
 	if (r8a66597->pdata->on_chip) {
-		clk_enable(r8a66597->clk);
+		clk_prepare_enable(r8a66597->clk);
 		do {
 			r8a66597_write(r8a66597, SCKE, SYSCFG0);
 			tmp = r8a66597_read(r8a66597, SYSCFG0);
@@ -139,7 +139,7 @@ static void r8a66597_clock_disable(struct r8a66597 *r8a66597)
 	udelay(1);
 
 	if (r8a66597->pdata->on_chip) {
-		clk_disable(r8a66597->clk);
+		clk_disable_unprepare(r8a66597->clk);
 	} else {
 		r8a66597_bclr(r8a66597, PLLC, SYSCFG0);
 		r8a66597_bclr(r8a66597, XCKE, SYSCFG0);
-- 
1.8.1.5

