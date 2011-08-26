From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 26 Aug 2011 05:05:41 +0000
Subject: [PATCH] sh: Fix implicit declaration of function numa_node_id
Message-Id: <1314335141-15887-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

  CC      arch/sh/kernel/topology.o
  arch/sh/kernel/topology.c: In function ‘topology_init’:
  arch/sh/kernel/topology.c:77: error: implicit declaration of function ‘numa_node_id’

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/topology.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/topology.c b/arch/sh/kernel/topology.c
index ab37955..3297150 100644
--- a/arch/sh/kernel/topology.c
+++ b/arch/sh/kernel/topology.c
@@ -7,6 +7,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
@@ -14,6 +15,7 @@
 #include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/export.h>
+#include <linux/topology.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
-- 
1.7.5.4

