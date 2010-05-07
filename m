From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 May 2010 09:21:16 +0000
Subject: [PATCH] sh: add PVR of SH7757 2nd cut
Message-Id: <4BE3DB8C.9060205@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4/probe.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/probe.c b/arch/sh/kernel/cpu/sh4/probe.c
index d180f16..07ddcbd 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -151,6 +151,7 @@ void __cpuinit cpu_probe(void)
 			boot_cpu_data.flags |= CPU_HAS_L2_CACHE;
 			break;
 		case 0x50:
+		case 0x10:
 			boot_cpu_data.type = CPU_SH7757;
 			break;
 		}
-- 
1.5.5
