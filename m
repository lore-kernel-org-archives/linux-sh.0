From: Vandana BN <bnvandana@gmail.com>
Date: Thu, 27 Jun 2019 06:45:47 +0000
Subject: [PATCH] Documentation:sh:convert register-banks.txt to register-banks.rst
Message-Id: <20190627063347.11137-1-bnvandana@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, corbet@lwn.net, linux-sh@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, gregkh@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, Vandana BN <bnvandana@gmail.com>

This patch converts register-banks.txt to ReST format, No content
change.
Added register-banks.rst to sh/index.rst

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 Documentation/sh/index.rst                                | 5 +++++
 .../sh/{register-banks.txt => register-banks.rst}         | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)
 rename Documentation/sh/{register-banks.txt => register-banks.rst} (90%)

diff --git a/Documentation/sh/index.rst b/Documentation/sh/index.rst
index bc8db7ba894a..59b4e0e17aca 100644
--- a/Documentation/sh/index.rst
+++ b/Documentation/sh/index.rst
@@ -57,3 +57,8 @@ Maple

 .. kernel-doc:: drivers/sh/maple/maple.c
    :export:
+
+.. toctree::
+   :maxdepth: 2
+
+   register-banks
diff --git a/Documentation/sh/register-banks.txt b/Documentation/sh/register-banks.rst
similarity index 90%
rename from Documentation/sh/register-banks.txt
rename to Documentation/sh/register-banks.rst
index a6719f2f6594..acccfaf80355 100644
--- a/Documentation/sh/register-banks.txt
+++ b/Documentation/sh/register-banks.rst
@@ -1,8 +1,9 @@
-	Notes on register bank usage in the kernel
-	=====================
+=====================
+Notes on register bank usage in the kernel
+=====================

 Introduction
-------------
+======

 The SH-3 and SH-4 CPU families traditionally include a single partial register
 bank (selected by SR.RB, only r0 ... r7 are banked), whereas other families
@@ -30,4 +31,3 @@ Presently the kernel uses several of these registers.
 		- The SR.IMASK interrupt handler makes use of this to set the
 		  interrupt priority level (used by local_irq_enable())
 	- r7_bank (current)
-
--
2.17.1
