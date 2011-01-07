From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 Jan 2011 10:26:24 +0000
Subject: sh: add PVR probing for SH7757 3rd cut
Message-Id: <4D26EA50.1000403@renesas.com>
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
index b93458f..b1edc90 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -151,6 +151,7 @@ void __cpuinit cpu_probe(void)
 			boot_cpu_data.flags |= CPU_HAS_L2_CACHE;
 			break;
 		case 0x10:
+		case 0x11:
 			boot_cpu_data.type = CPU_SH7757;
 			break;
 		}
-- 
1.7.1

