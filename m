From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 18 Apr 2014 14:48:07 +0000
Subject: [PATCH v2 07/14] clocksource: shmobile: Remove unused sh_timer_config members
Message-Id: <1397832494-20607-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397832494-20607-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1397832494-20607-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The name, channel_offset, timer_bit, clockevent_rating and
clocksource_rating members are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 include/linux/sh_timer.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/sh_timer.h b/include/linux/sh_timer.h
index 8e1e036..64638b0 100644
--- a/include/linux/sh_timer.h
+++ b/include/linux/sh_timer.h
@@ -2,11 +2,6 @@
 #define __SH_TIMER_H__
 
 struct sh_timer_config {
-	char *name;
-	long channel_offset;
-	int timer_bit;
-	unsigned long clockevent_rating;
-	unsigned long clocksource_rating;
 	unsigned int channels_mask;
 };
 
-- 
1.8.3.2

