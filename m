From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Sat, 13 May 2017 11:10:58 +0000
Subject: [PATCH 5/5] docs-rst: convert sh book to ReST
Message-Id: <5191b09353c6bb042951bcb2d703e146d8990677.1494672881.git.mchehab@s-opensource.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1494672881.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494672881.git.mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jani Nikula <jani.nikula@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Markus Heiser <markus.heiser@darmarit.de>, Takashi Iwai <tiwai@suse.de>, "Herton R. Krzesinski" <herton@redhat.com>, linux-sh@vger.kernel.org

Use pandoc to convert documentation to ReST by calling
Documentation/sphinx/tmplcvt script.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/DocBook/Makefile |   4 +-
 Documentation/DocBook/sh.tmpl  | 105 -----------------------------------------
 Documentation/conf.py          |   2 +
 Documentation/index.rst        |  11 +++++
 Documentation/sh/index.rst     |  59 +++++++++++++++++++++++
 5 files changed, 73 insertions(+), 108 deletions(-)
 delete mode 100644 Documentation/DocBook/sh.tmpl
 create mode 100644 Documentation/sh/index.rst

diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
index 226e5e9fc801..efba7f980895 100644
--- a/Documentation/DocBook/Makefile
+++ b/Documentation/DocBook/Makefile
@@ -6,9 +6,7 @@
 # To add a new book the only step required is to add the book to the
 # list of DOCBOOKS.
 
-DOCBOOKS := \
-	    lsm.xml \
-	    sh.xml
+DOCBOOKS := lsm.xml
 
 ifeq ($(DOCBOOKS),)
 
diff --git a/Documentation/DocBook/sh.tmpl b/Documentation/DocBook/sh.tmpl
deleted file mode 100644
index 4a38f604fa66..000000000000
--- a/Documentation/DocBook/sh.tmpl
+++ /dev/null
@@ -1,105 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
-	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
-
-<book id="sh-drivers">
- <bookinfo>
-  <title>SuperH Interfaces Guide</title>
-  
-  <authorgroup>
-   <author>
-    <firstname>Paul</firstname>
-    <surname>Mundt</surname>
-    <affiliation>
-     <address>
-      <email>lethal@linux-sh.org</email>
-     </address>
-    </affiliation>
-   </author>
-  </authorgroup>
-
-  <copyright>
-   <year>2008-2010</year>
-   <holder>Paul Mundt</holder>
-  </copyright>
-  <copyright>
-   <year>2008-2010</year>
-   <holder>Renesas Technology Corp.</holder>
-  </copyright>
-  <copyright>
-   <year>2010</year>
-   <holder>Renesas Electronics Corp.</holder>
-  </copyright>
-
-  <legalnotice>
-   <para>
-     This documentation is free software; you can redistribute
-     it and/or modify it under the terms of the GNU General Public
-     License version 2 as published by the Free Software Foundation.
-   </para>
-      
-   <para>
-     This program is distributed in the hope that it will be
-     useful, but WITHOUT ANY WARRANTY; without even the implied
-     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-     See the GNU General Public License for more details.
-   </para>
-      
-   <para>
-     You should have received a copy of the GNU General Public
-     License along with this program; if not, write to the Free
-     Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
-     MA 02111-1307 USA
-   </para>
-      
-   <para>
-     For more details see the file COPYING in the source
-     distribution of Linux.
-   </para>
-  </legalnotice>
- </bookinfo>
-
-<toc></toc>
-
-  <chapter id="mm">
-    <title>Memory Management</title>
-    <sect1 id="sh4">
-    <title>SH-4</title>
-      <sect2 id="sq">
-        <title>Store Queue API</title>
-!Earch/sh/kernel/cpu/sh4/sq.c
-      </sect2>
-    </sect1>
-    <sect1 id="sh5">
-      <title>SH-5</title>
-      <sect2 id="tlb">
-	<title>TLB Interfaces</title>
-!Iarch/sh/mm/tlb-sh5.c
-!Iarch/sh/include/asm/tlb_64.h
-      </sect2>
-    </sect1>
-  </chapter>
-  <chapter id="mach">
-    <title>Machine Specific Interfaces</title>
-    <sect1 id="dreamcast">
-      <title>mach-dreamcast</title>
-!Iarch/sh/boards/mach-dreamcast/rtc.c
-    </sect1>
-    <sect1 id="x3proto">
-      <title>mach-x3proto</title>
-!Earch/sh/boards/mach-x3proto/ilsel.c
-    </sect1>
-  </chapter>
-  <chapter id="busses">
-    <title>Busses</title>
-    <sect1 id="superhyway">
-      <title>SuperHyway</title>
-!Edrivers/sh/superhyway/superhyway.c
-    </sect1>
-
-    <sect1 id="maple">
-      <title>Maple</title>
-!Edrivers/sh/maple/maple.c
-    </sect1>
-  </chapter>
-</book>
diff --git a/Documentation/conf.py b/Documentation/conf.py
index dfe14f7525d0..77d47bb1df1d 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -375,6 +375,8 @@ latex_documents = [
      'The kernel development community', 'manual'),
     ('security/index', 'security.tex', 'The kernel security subsystem manual',
      'The kernel development community', 'manual'),
+    ('sh/index', 'sh.tex', 'SuperH architecture implementation manual',
+     'The kernel development community', 'manual'),
     ('sound/index', 'sound.tex', 'Linux Sound Subsystem Documentation',
      'The kernel development community', 'manual'),
     ('userspace-api/index', 'userspace-api.tex', 'The Linux kernel user-space API guide',
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 25c4da41da6b..e9017bb3a6ce 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -76,6 +76,17 @@ needed).
    crypto/index
    filesystems/index
 
+Architecture-specific documentation
+-----------------------------------
+
+These books provide programming details about architecture-specific
+implementation.
+
+.. toctree::
+   :maxdepth: 2
+
+   sh/index
+
 Korean translations
 -------------------
 
diff --git a/Documentation/sh/index.rst b/Documentation/sh/index.rst
new file mode 100644
index 000000000000..bc8db7ba894a
--- /dev/null
+++ b/Documentation/sh/index.rst
@@ -0,0 +1,59 @@
+===========+SuperH Interfaces Guide
+===========+
+:Author: Paul Mundt
+
+Memory Management
+========+
+SH-4
+----
+
+Store Queue API
+~~~~~~~~~~~~~~~
+
+.. kernel-doc:: arch/sh/kernel/cpu/sh4/sq.c
+   :export:
+
+SH-5
+----
+
+TLB Interfaces
+~~~~~~~~~~~~~~
+
+.. kernel-doc:: arch/sh/mm/tlb-sh5.c
+   :internal:
+
+.. kernel-doc:: arch/sh/include/asm/tlb_64.h
+   :internal:
+
+Machine Specific Interfaces
+=============+
+mach-dreamcast
+--------------
+
+.. kernel-doc:: arch/sh/boards/mach-dreamcast/rtc.c
+   :internal:
+
+mach-x3proto
+------------
+
+.. kernel-doc:: arch/sh/boards/mach-x3proto/ilsel.c
+   :export:
+
+Busses
+===
+
+SuperHyway
+----------
+
+.. kernel-doc:: drivers/sh/superhyway/superhyway.c
+   :export:
+
+Maple
+-----
+
+.. kernel-doc:: drivers/sh/maple/maple.c
+   :export:
-- 
2.9.3

