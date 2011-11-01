From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 01 Nov 2011 05:57:01 +0000
Subject: [PATCH] sh: Add default uImage rule for sh7757lcr
Message-Id: <1320127021-7966-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 99385d0..3fc0f41 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -80,6 +80,7 @@ defaultimage-$(CONFIG_SH_RSK)			:= uImage
 defaultimage-$(CONFIG_SH_URQUELL)		:= uImage
 defaultimage-$(CONFIG_SH_MIGOR)			:= uImage
 defaultimage-$(CONFIG_SH_AP325RXA)		:= uImage
+defaultimage-$(CONFIG_SH_SH7757LCR)		:= uImage
 defaultimage-$(CONFIG_SH_7724_SOLUTION_ENGINE)	:= uImage
 defaultimage-$(CONFIG_SH_7206_SOLUTION_ENGINE)	:= vmlinux
 defaultimage-$(CONFIG_SH_7619_SOLUTION_ENGINE)	:= vmlinux
-- 
1.7.7

