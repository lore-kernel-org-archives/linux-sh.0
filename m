From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 15 Jun 2020 06:50:22 +0000
Subject: [PATCH 17/22] docs: sh: convert register-banks.txt to ReST
Message-Id: <adf117cf1edd7f43cb839ff2800f4315dfbcce13.1592203650.git.mchehab+huawei@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1592203650.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

- Add a SPDX header;
- Adjust document title to follow ReST style;
- Add blank lines to make ReST markup happy
- Add it to sh/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sh/index.rst                          |  1 +
 .../sh/{register-banks.txt => register-banks.rst}   | 13 ++++++++++---
 arch/sh/Kconfig.cpu                                 |  2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)
 rename Documentation/sh/{register-banks.txt => register-banks.rst} (88%)

diff --git a/Documentation/sh/index.rst b/Documentation/sh/index.rst
index 56c08790265d..580f3b17e841 100644
--- a/Documentation/sh/index.rst
+++ b/Documentation/sh/index.rst
@@ -8,6 +8,7 @@ SuperH Interfaces Guide
     :maxdepth: 1
 
     new-machine
+    register-banks
 
 Memory Management
 ========diff --git a/Documentation/sh/register-banks.txt b/Documentation/sh/register-banks.rst
similarity index 88%
rename from Documentation/sh/register-banks.txt
rename to Documentation/sh/register-banks.rst
index a6719f2f6594..2bef5c8fcbbc 100644
--- a/Documentation/sh/register-banks.txt
+++ b/Documentation/sh/register-banks.rst
@@ -1,5 +1,8 @@
-	Notes on register bank usage in the kernel
-	=====================
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Notes on register bank usage in the kernel
+=====================
 
 Introduction
 ------------
@@ -23,11 +26,15 @@ Presently the kernel uses several of these registers.
 
 	- r0_bank, r1_bank (referenced as k0 and k1, used for scratch
 	  registers when doing exception handling).
+
 	- r2_bank (used to track the EXPEVT/INTEVT code)
+
 		- Used by do_IRQ() and friends for doing irq mapping based off
 		  of the interrupt exception vector jump table offset
+
 	- r6_bank (global interrupt mask)
+
 		- The SR.IMASK interrupt handler makes use of this to set the
 		  interrupt priority level (used by local_irq_enable())
+
 	- r7_bank (current)
-
diff --git a/arch/sh/Kconfig.cpu b/arch/sh/Kconfig.cpu
index 97ca35f2cd37..fff419f3d757 100644
--- a/arch/sh/Kconfig.cpu
+++ b/arch/sh/Kconfig.cpu
@@ -85,7 +85,7 @@ config CPU_HAS_SR_RB
 	  that are lacking this bit must have another method in place for
 	  accomplishing what is taken care of by the banked registers.
 
-	  See <file:Documentation/sh/register-banks.txt> for further
+	  See <file:Documentation/sh/register-banks.rst> for further
 	  information on SR.RB and register banking in the kernel in general.
 
 config CPU_HAS_PTEAEX
-- 
2.26.2
