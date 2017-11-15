From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Wed, 15 Nov 2017 10:55:55 +0000
Subject: [PATCH v1 02/10] include: media: Add Renesas CEU driver interface
Message-Id: <1510743363-25798-3-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1510743363-25798-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1510743363-25798-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, geert@glider.be, mchehab@kernel.org, hverkuil@xs4all.nl
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Add renesas-ceu header file.

Do not remove the existing sh_mobile_ceu.h one as long as the original
driver does not go away.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 include/media/drv-intf/renesas-ceu.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/media/drv-intf/renesas-ceu.h

diff --git a/include/media/drv-intf/renesas-ceu.h b/include/media/drv-intf/renesas-ceu.h
new file mode 100644
index 0000000..f2da78c
--- /dev/null
+++ b/include/media/drv-intf/renesas-ceu.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+#ifndef __ASM_RENESAS_CEU_H__
+#define __ASM_RENESAS_CEU_H__
+
+#include <media/v4l2-mediabus.h>
+
+#define CEU_FLAG_PRIMARY_SENS	BIT(0)
+#define CEU_MAX_SENS		2
+
+struct ceu_async_subdev {
+	unsigned long flags;
+	unsigned char bus_width;
+	unsigned char bus_shift;
+	unsigned int i2c_adapter_id;
+	unsigned int i2c_address;
+};
+
+struct ceu_info {
+	unsigned int num_subdevs;
+	struct ceu_async_subdev subdevs[CEU_MAX_SENS];
+};
+
+#endif /* __ASM_RENESAS_CEU_H__ */
--
2.7.4

