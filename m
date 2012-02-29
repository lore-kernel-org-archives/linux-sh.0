From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 29 Feb 2012 13:50:46 +0000
Subject: [PATCH v2] sh: Fix sh2a vbr table for more than 255 irqs
Message-Id: <1330523446-8646-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2:
  Included SoB

 arch/sh/kernel/cpu/sh2a/ex.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/ex.S b/arch/sh/kernel/cpu/sh2a/ex.S
index 3ead9e6..4568066 100644
--- a/arch/sh/kernel/cpu/sh2a/ex.S
+++ b/arch/sh/kernel/cpu/sh2a/ex.S
@@ -66,6 +66,7 @@ vector	=	0
 	.long	exception_entry0 + vector * 6
 vector	=	vector + 1
 	.endr
+vector	=	0
 	.rept	256
 	.long	exception_entry1 + vector * 6
 vector	=	vector + 1
-- 
1.7.0.4

