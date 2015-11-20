From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Nov 2015 01:05:50 +0000
Subject: [PATCH 6/6] MAINTAINERS: Add entry for Renesas arm64 architecture
Message-Id: <b138e11931f2fe25cf188ed62b54bc36f59a25ce.1447980335.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1447980335.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1447980335.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Initial Renesas arm64 architecture support will be for the R-Car H3,
r8a7795, SoC and its Salvator-X board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b28828..2cf10697da29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1420,6 +1420,15 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/RENESAS ARM64 ARCHITECTURE
+M:	Simon Horman <horms@verge.net.au>
+M:	Magnus Damm <magnus.damm@gmail.com>
+L:	linux-sh@vger.kernel.org
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

