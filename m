From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 13:34:32 +0000
Subject: [PATCH 07/11] sh/numa: Remove the unused parent_node() macro
Message-Id: <1501076076-1974-8-git-send-email-douly.fnst@cn.fujitsu.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: mpe@ellerman.id.au, Dou Liyang <douly.fnst@cn.fujitsu.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

Commit a7be6e5a7f8d ("mm: drop useless local parameters of
__register_one_node()") removes the last user of parent_node().

The parent_node() macro in SUPERH platform is unnecessary.

Remove it for cleanup.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/topology.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/include/asm/topology.h b/arch/sh/include/asm/topology.h
index 358e3f5..6931f50 100644
--- a/arch/sh/include/asm/topology.h
+++ b/arch/sh/include/asm/topology.h
@@ -4,7 +4,6 @@
 #ifdef CONFIG_NUMA
 
 #define cpu_to_node(cpu)	((void)(cpu),0)
-#define parent_node(node)	((void)(node),0)
 
 #define cpumask_of_node(node)	((void)node, cpu_online_mask)
 
-- 
2.5.5



