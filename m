From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 06 Jul 2010 04:31:29 +0000
Subject: [PATCH v2 1/6] sh: change PVR of SH7757 for 2nd cut
Message-Id: <4C32B1A1.1080404@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

And I would like to remove the 1st cut supporting.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---

 I asked my boss about the 1st cut supporting, and we decided to stop
 the support.

 arch/sh/kernel/cpu/sh4/probe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/probe.c b/arch/sh/kernel/cpu/sh4/probe.c
index d180f16..b93458f 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -150,7 +150,7 @@ void __cpuinit cpu_probe(void)
 			boot_cpu_data.type = CPU_SH7724;
 			boot_cpu_data.flags |= CPU_HAS_L2_CACHE;
 			break;
-		case 0x50:
+		case 0x10:
 			boot_cpu_data.type = CPU_SH7757;
 			break;
 		}
-- 
1.7.1

