From: Steve Kowalik <steven@wedontsleep.org>
Date: Fri, 24 Feb 2017 07:38:38 +0000
Subject: [PATCH 2/2] Documentation: Add arch-guide documentation
Message-Id: <1487921918-25203-3-git-send-email-steven@wedontsleep.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the new SuperH interfaces RST into the documentation tree by adding
a new arch-guide.

Signed-off-by: Steve Kowalik <steven@wedontsleep.org>
---
 Documentation/00-INDEX             |  2 ++
 Documentation/arch-guide/conf.py   | 10 ++++++++++
 Documentation/arch-guide/index.rst | 14 ++++++++++++++
 Documentation/index.rst            | 11 +++++++++++
 4 files changed, 37 insertions(+)
 create mode 100644 Documentation/arch-guide/conf.py
 create mode 100644 Documentation/arch-guide/index.rst

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index c8a8eb1..64625d0 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -60,6 +60,8 @@ admin-guide/
 	- info related to Linux users and system admins.
 aoe/
 	- description of AoE (ATA over Ethernet) along with config examples.
+arch-guide/
+   - info related to architecture-specific code.
 arm/
 	- directory with info about Linux on the ARM architecture.
 arm64/
diff --git a/Documentation/arch-guide/conf.py b/Documentation/arch-guide/conf.py
new file mode 100644
index 0000000..2ac424b
--- /dev/null
+++ b/Documentation/arch-guide/conf.py
@@ -0,0 +1,10 @@
+# -*- coding: utf-8; mode: python -*-
+
+project = 'Linux Kernel architecture-specific Documentation'
+
+tags.add("subproject")
+
+latex_documents = [
+    ('index', 'Linux Kernel architecture-specific Documentation',
+     'The kernel development community', 'manual'),
+]
diff --git a/Documentation/arch-guide/index.rst b/Documentation/arch-guide/index.rst
new file mode 100644
index 0000000..1db4658
--- /dev/null
+++ b/Documentation/arch-guide/index.rst
@@ -0,0 +1,14 @@
+The Linux kernel architecture-specific documentation
+==========================
+
+The following is a collection of architecture-specific documentation for the
+different architectures that the kernel supports.
+
+SuperH
+------
+
+.. toctree::
+   :maxdepth: 1
+
+   ../sh/interfaces.rst
+
diff --git a/Documentation/index.rst b/Documentation/index.rst
index f6e641a..6b3f570 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -60,6 +60,17 @@ needed).
    sound/index
    crypto/index
 
+Architecture-specific documentation
+-----------------------------------
+
+These documents get into the details of architecture-specific code or
+interfaces.
+
+.. toctree::
+   :maxdepth: 2
+
+   arch-guide/index
+
 Korean translations
 -------------------
 
-- 
2.7.4

