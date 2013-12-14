From: Mark Salter <msalter@redhat.com>
Date: Sat, 14 Dec 2013 16:59:32 +0000
Subject: [PATCH 06/10] sh: select ARCH_MIGHT_HAVE_PC_SERIO
Message-Id: <1387040376-26906-7-git-send-email-msalter@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
In-Reply-To: <1387040376-26906-1-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Mark Salter <msalter@redhat.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

Architectures which might use an i8042 for serial IO to keyboard,
mouse, etc should select ARCH_MIGHT_HAVE_PC_SERIO.

Signed-off-by: Mark Salter <msalter@redhat.com>
CC: Paul Mundt <lethal@linux-sh.org>
CC: linux-sh@vger.kernel.org
---
 arch/sh/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9b0979f..3490fc2 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -1,6 +1,7 @@
 config SUPERH
 	def_bool y
 	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_MIGHT_HAVE_PC_SERIO if SH_CAYMAN
 	select EXPERT
 	select CLKDEV_LOOKUP
 	select HAVE_IDE if HAS_IOPORT
-- 
1.8.3.1

