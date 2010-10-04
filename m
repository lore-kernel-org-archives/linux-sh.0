From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 04 Oct 2010 20:44:25 +0000
Subject: [PATCH 7/7] sh: Annotate oprofile_arch_exit() with __exit marker
Message-Id: <4426d17460dc88dcb3d6e3af1b91af4db83785ae.1286222593.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1286222593.git.matt@console-pimps.org>
In-Reply-To: <cover.1286222593.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Richter <robert.richter@amd.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>

In order to avoid a section mismatch we need to annotate
oprofile_arch_exit() with an __exit marker.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/oprofile/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/oprofile/common.c b/arch/sh/oprofile/common.c
index 449f842..93033d8 100644
--- a/arch/sh/oprofile/common.c
+++ b/arch/sh/oprofile/common.c
@@ -29,7 +29,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	return oprofile_perf_init(ops);
 }
 
-void oprofile_arch_exit(void)
+void __exit oprofile_arch_exit(void)
 {
 	oprofile_perf_exit();
 }
-- 
1.7.1

