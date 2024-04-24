Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368B159919
	for <linux-sh@vger.kernel.org>; Wed, 24 Apr 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959930; cv=none; b=ShNizlluU/dI7Mojyf+T+TPwqLaWuBMCkbCmY5Cd/luWZClnoghLmixdrBxpS7GJ+LW9sTx/Rbr4BVePQC/ywoKUE74T1nBuFulre0C4YBuTy2ag7zGVCFTY+OI4XbdPNnuewvoeZ0Gt38DWIPIimU/2eMdQ/3QAGcYiSZjNnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959930; c=relaxed/simple;
	bh=Qrhk/V/T4yIPSOM9glAutxFziuIMWQV+aj4ktOIsFHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AsAo278roRnQM6MMWOT9JEKJuSDWuDRm8zdUE05GoPh53Sj5pbFrMasLIQtBDITLq5OvV71lW/3AaTE84kLzAh1oQSB7glPjJWiWImMYKFClhy+sLG98QH2wuUlt7ZALSof0PIWO2A+HGE5a5QMT7bw5K2Jw1mjJROsgdEwy+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by albert.telenet-ops.be with bizsmtp
	id Ezyl2C0080SSLxL06zylB8; Wed, 24 Apr 2024 13:58:45 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rzbGH-006I8a-8a;
	Wed, 24 Apr 2024 13:58:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rzbGv-00BN8B-Bt;
	Wed, 24 Apr 2024 13:58:45 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] sh: boot: Add proper forward declarations
Date: Wed, 24 Apr 2024 13:58:42 +0200
Message-Id: <b7ea770a3bf26fb2a5f59f4bb83072b2526f7134.1713959841.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arch/sh/boot/compressed/misc.c:110:6: warning: no previous prototype for ‘ftrace_stub’ [-Wmissing-prototypes]
arch/sh/boot/compressed/misc.c:113:6: warning: no previous prototype for ‘arch_ftrace_ops_list_func’ [-Wmissing-prototypes]
arch/sh/boot/compressed/misc.c:123:6: warning: no previous prototype for ‘decompress_kernel’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is v2 of "[PATCH 08/20] sh: boot: Add proper forward declarations".
https://lore.kernel.org/r/2614d991c816ece903ef47c715bcc53881d34f3f.1709326528.git.geert+renesas@glider.be

v2:
  - Rebase on top of "sh: boot: Remove sh5 cache handling".
---
 arch/sh/boot/compressed/misc.c | 2 ++
 arch/sh/boot/compressed/misc.h | 9 +++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 arch/sh/boot/compressed/misc.h

diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index 195367d40031f9e9..3690379cc86bd4fe 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -16,6 +16,8 @@
 #include <asm/addrspace.h>
 #include <asm/page.h>
 
+#include "misc.h"
+
 /*
  * gzip declarations
  */
diff --git a/arch/sh/boot/compressed/misc.h b/arch/sh/boot/compressed/misc.h
new file mode 100644
index 0000000000000000..2b4534faa3052857
--- /dev/null
+++ b/arch/sh/boot/compressed/misc.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MISC_H
+#define MISC_H
+
+void arch_ftrace_ops_list_func(void);
+void decompress_kernel(void);
+void ftrace_stub(void);
+
+#endif /* MISC_H */
-- 
2.34.1

