From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Jun 2013 07:34:18 +0000
Subject: [PATCH 01/06] ARM: shmobile: Introduce SHMOBILE_FIXUP() helper
Message-Id: <20130605073418.15758.93704.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605073410.15758.37563.sendpatchset@w520>
In-Reply-To: <20130605073410.15758.37563.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Introduce SHMOBILE_FIXUP() as a helper function to
allow boards to specify their memory base and size.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-06-04 13:01:40.000000000 +0900
@@ -37,4 +37,17 @@ static inline void __init shmobile_init_
 	shmobile_cpuidle_init();
 }
 
+#define SHMOBILE_FIXUP(boardname, mem_start, mem_size)			\
+static void __init boardname##_fixup(struct tag *tag, char **cmdline,	\
+				struct meminfo *mi)			\
+{									\
+	for (; tag->hdr.size; tag = tag_next(tag)) {			\
+		if (tag->hdr.tag = ATAG_MEM) {				\
+			tag->u.mem.start = (mem_start);			\
+			tag->u.mem.size = (mem_size);			\
+			break;						\
+		}							\
+	}								\
+}
+
 #endif /* __ARCH_MACH_COMMON_H */
