From: Mark Salter <msalter@redhat.com>
Date: Tue, 08 Oct 2013 05:10:26 +0000
Subject: [PATCH v2 10/14] sh: select ARCH_MAY_HAVE_PC_PARPORT
Message-Id: <1381209030-351-11-git-send-email-msalter@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381209030-351-1-git-send-email-msalter@redhat.com>
In-Reply-To: <1381209030-351-1-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Mark Salter <msalter@redhat.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

Architectures which support CONFIG_PARPORT_PC should select
ARCH_MAY_HAVE_PC_PARPORT.

Signed-off-by: Mark Salter <msalter@redhat.com>
CC: Paul Mundt <lethal@linux-sh.org>
CC: linux-sh@vger.kernel.org
---
 arch/sh/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 224f4bc..a5d1d2e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -1,5 +1,6 @@
 config SUPERH
 	def_bool y
+	select ARCH_MAY_HAVE_PC_PARPORT
 	select EXPERT
 	select CLKDEV_LOOKUP
 	select HAVE_IDE if HAS_IOPORT
-- 
1.8.3.1

