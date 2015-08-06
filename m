From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Aug 2015 08:09:33 +0000
Subject: [PATCH 12/13 v4][RFC] Local: Hack: enable Initramfs
Message-Id: <87fv3wyh75.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Because SalvatorX can't use network at this point, this patch enables
Initramfs for booting

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - new patch

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9139c0b..3645eb8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -23,6 +23,7 @@ CONFIG_CGROUP_HUGETLB=y
 # CONFIG_NET_NS is not set
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="${PATH}/initramfs"
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-- 
1.9.1

