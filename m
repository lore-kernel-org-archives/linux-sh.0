From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 19 Jun 2008 10:27:55 +0000
Subject: [PATCH] sh: Fix Kconfig of AP-325RXA
Message-Id: <485A34AB.4040501@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The CPU of AP-325RXA is SH7723, but a CPU becomes selectable.
This patch fixes this problem.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 10a0c18..ed37cce 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -503,7 +503,7 @@ config SH_MIGOR

 config SH_AP325RXA
 	bool "AP-325RXA"
-	select CPU_SUBTYPE_SH7723
+	depends on CPU_SUBTYPE_SH7723
 	help
 	  Renesas "AP-325RXA" support.
 	  Compatible with ALGO SYSTEM CO.,LTD. "AP-320A"
-- 
1.5.5.1
