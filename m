From: Levente Kurusa <levex@linux.com>
Date: Thu, 19 Dec 2013 15:03:39 +0000
Subject: [PATCH 28/38] superhyway: intc: add missing put_device call
Message-Id: <1387465429-3568-29-git-send-email-levex@linux.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Levente Kurusa <levex@linux.com>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 drivers/sh/intc/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 8f32a13..c89768e 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -504,8 +504,10 @@ static int __init register_intc_devs(void)
 			if (error = 0)
 				error = device_create_file(&d->dev,
 							   &dev_attr_name);
-			if (error)
+			if (error) {
+				put_device(&d->dev);
 				break;
+			}
 		}
 	}
 
-- 
1.8.3.1

