From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Sun, 27 Mar 2011 04:31:47 +0000
Subject: [PATCH 2/2] sh: Add sh_io_port_base check in __ioport_map function
Message-Id: <1301200307-5321-2-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_io_port_base is initialized with -1.
When user use sh_io_port_base, IO port address -1 slips off.
This revise it if sh_io_port_base was set -1.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/kernel/ioport.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/ioport.c b/arch/sh/kernel/ioport.c
index e3ad610..30937e9 100644
--- a/arch/sh/kernel/ioport.c
+++ b/arch/sh/kernel/ioport.c
@@ -19,6 +19,10 @@ void __iomem *__ioport_map(unsigned long addr, unsigned int size)
 	if (sh_mv.mv_ioport_map)
 		return sh_mv.mv_ioport_map(addr, size);
 
+	/* Don't use sh_io_port_base */
+	if (sh_io_port_base = -1)
+		return (void __iomem *)addr;
+
 	return (void __iomem *)(addr + sh_io_port_base);
 }
 EXPORT_SYMBOL(__ioport_map);
-- 
1.7.4.1

