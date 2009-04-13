From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 13 Apr 2009 06:40:04 +0000
Subject: [PATCH v2] ap325: use edge control for ov772x camera
Message-Id: <uljq42inq.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Because of an influence of the lens,
current ov772x camera on ap325 board display the part on the
edge in strong white.
This patch set edge control parameter to suppress it.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
v1 -> v2

o add explanation

 arch/sh/boards/board-ap325rxa.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index 912458f..39e4691 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -349,6 +349,7 @@ static int ov7725_power(struct device *dev, int mode)
 static struct ov772x_camera_info ov7725_info = {
 	.buswidth  = SOCAM_DATAWIDTH_8,
 	.flags = OV772X_FLAG_VFLIP | OV772X_FLAG_HFLIP,
+	.edgectrl = OV772X_AUTO_EDGECTRL(0xf, 0),
 	.link = {
 		.power  = ov7725_power,
 	},
-- 
1.5.6.3

