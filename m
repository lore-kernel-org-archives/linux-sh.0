From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 08 Nov 2012 07:48:36 +0000
Subject: [PATCH 2/2] tty: sh-sci: Remove SH7377 support
Message-Id: <1352360916-9397-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The shmobile SH7377 already was removed from source tree.
This remove SH7377 support for sh-sci.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/tty/serial/sh-sci.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index fc1e6f4..5aca736 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -15,7 +15,6 @@
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
     defined(CONFIG_ARCH_SH73A0) || \
-    defined(CONFIG_ARCH_SH7377) || \
     defined(CONFIG_ARCH_SH7372) || \
     defined(CONFIG_ARCH_R8A7740)
 
-- 
1.7.10.4

