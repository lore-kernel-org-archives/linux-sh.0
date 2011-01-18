From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jan 2011 20:55:34 +0000
Subject: [PATCH] sh: Fix sh build failure when CONFIG_SFC=m
Message-Id: <1295384134-26329-1-git-send-email-aurelien@aurel32.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CONFIG_SFC=m uses topology_core_cpumask() which, for sh, expects
cpu_core_map to be exported. It is not. This patch exports the needed
symbol.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/sh/kernel/topology.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/topology.c b/arch/sh/kernel/topology.c
index 948fdb6..38e8628 100644
--- a/arch/sh/kernel/topology.c
+++ b/arch/sh/kernel/topology.c
@@ -17,6 +17,7 @@
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
 cpumask_t cpu_core_map[NR_CPUS];
+EXPORT_SYMBOL(cpu_core_map);
 
 static cpumask_t cpu_coregroup_map(unsigned int cpu)
 {
-- 
1.7.2.3

