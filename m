From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 12 Jun 2016 06:54:27 +0000
Subject: [PATCH v2 09/17] sh: Use GENERIC_IOMAP on device tree mode
Message-Id: <1465714475-24111-10-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 5e52d53..9e4ccd0 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -12,6 +12,7 @@ config SH_DEVICE_TREE
 	select OF_EARLY_FLATTREE
 	select CLKSRC_OF
 	select GENERIC_CALIBRATE_DELAY
+	select GENERIC_IOMAP
 	help
 	  Select Board Described by Device Tree to build a kernel that
 	  does not hard-code any board-specific knowledge but instead uses
-- 
2.7.0

