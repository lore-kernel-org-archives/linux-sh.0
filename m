From: Matt Fleming <matt@console-pimps.org>
Date: Wed, 28 Apr 2010 11:11:30 +0000
Subject: [PATCH] sh: native_cpu_disable() build error when CONFIG_HOTPLUG_CPU=n
Message-Id: <2055fb5d5b201eb36a3814cf0dc4658c33a33bcd.1272453051.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

arch/sh/kernel/smp.c:164: error: conflicting types for 'native_cpu_disable'
/home/matt/src/kernels/sh-2.6/arch/sh/include/asm/smp.h:48: error: previous declaration of 'native_cpu_disable' was here

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
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
1.6.4.rc0

