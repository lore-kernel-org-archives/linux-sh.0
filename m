From: Peter Huewe <PeterHuewe@gmx.de>
Date: Thu, 29 Apr 2010 00:56:10 +0000
Subject: [PATCH] arch/sh: Fix wrong function prototype for native_cpu_disable
Message-Id: <201004290256.10506.PeterHuewe@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Matt Fleming <matt@console-pimps.org>, Mike Travis <travis@sgi.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Peter Huewe <peterhuewe@gmx.de>

This patch fixes the prototype of native_cpu_disable if
CONFIG_HOTPLUG_CPU is not set, and thus fixes a build failure[1]

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2536296/

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
KernelVersion: linux-next-20100429

 arch/sh/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 86cd6f9..509b36b 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -161,7 +161,7 @@ int __cpu_disable(void)
 	return 0;
 }
 #else /* ... !CONFIG_HOTPLUG_CPU */
-int native_cpu_disable(void)
+int native_cpu_disable(unsigned int cpu)
 {
 	return -ENOSYS;
 }
-- 
1.6.4.4

