From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 02 Oct 2015 06:42:21 +0000
Subject: [PATCH] MAINTAINERS: Add entry Renesas arm64 architecture
Message-Id: <1443768141-19961-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Initial Renesas arm64 architecture support will be for the R-Car H3,
r8a7795, SoC and its Salvator-X board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

* This is intended to accompany
  "[PATCH v10 00/07] Renesas R-Car H3 (r8a7795) integration patches V10"
  though strictly speaking it doesn't depend on it or anything else.
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ba7ab749c85..0067b7156622 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1392,6 +1392,16 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/RENESAS ARM64 ARCHITECTURE
+M:	Simon Horman <horms@verge.net.au>
+M:	Magnus Damm <magnus.damm@gmail.com>
+L:	linux-sh@vger.kernel.org
+W:	http://oss.renesas.com
+Q:	http://patchwork.kernel.org/project/linux-sh/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
+S:	Supported
+F:	arch/arm64/boot/dts/renesas/
+
 ARM/RISCPC ARCHITECTURE
 M:	Russell King <linux@arm.linux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.1.4

