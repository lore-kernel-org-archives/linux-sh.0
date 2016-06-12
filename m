From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 12 Jun 2016 06:54:33 +0000
Subject: [PATCH v2 15/17] sh: SH-INTC helper files
Message-Id: <1465714475-24111-16-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/include/dt-bindings               | 1 +
 include/dt-bindings/interrupt-controller/sh_intc.h | 2 ++
 2 files changed, 3 insertions(+)
 create mode 120000 arch/sh/boot/dts/include/dt-bindings
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

diff --git a/arch/sh/boot/dts/include/dt-bindings b/arch/sh/boot/dts/include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/sh/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/include/dt-bindings/interrupt-controller/sh_intc.h b/include/dt-bindings/interrupt-controller/sh_intc.h
new file mode 100644
index 0000000..8c9dcdc
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/sh_intc.h
@@ -0,0 +1,2 @@
+#define evt2irq(evt)		(((evt) >> 5) - 16)
+#define irq2evt(irq)		(((irq) + 16) << 5)
-- 
2.7.0

