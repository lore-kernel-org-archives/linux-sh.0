From: Steve Kowalik <steven@wedontsleep.org>
Date: Fri, 24 Feb 2017 07:38:37 +0000
Subject: [PATCH 1/2] Documentation: convert sh interfaces to RST
Message-Id: <1487921918-25203-2-git-send-email-steven@wedontsleep.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Convert the SuperH interfaces DocBook to RST.

Signed-off-by: Steve Kowalik <steven@wedontsleep.org>
---
 Documentation/DocBook/Makefile  |   2 +-
 Documentation/DocBook/sh.tmpl   | 105 ----------------------------------------
 Documentation/sh/interfaces.rst |  63 ++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 106 deletions(-)
 delete mode 100644 Documentation/DocBook/sh.tmpl
 create mode 100644 Documentation/sh/interfaces.rst

diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
index 60a17b7..a295eb2 100644
--- a/Documentation/DocBook/Makefile
+++ b/Documentation/DocBook/Makefile
@@ -12,7 +12,7 @@ DOCBOOKS := z8530book.xml  \
 	    kernel-api.xml filesystems.xml lsm.xml kgdb.xml \
 	    gadget.xml libata.xml mtdnand.xml librs.xml rapidio.xml \
 	    genericirq.xml s390-drivers.xml scsi.xml \
-	    sh.xml regulator.xml w1.xml \
+	    regulator.xml w1.xml \
 	    writing_musb_glue_layer.xml
 
 ifeq ($(DOCBOOKS),)
diff --git a/Documentation/DocBook/sh.tmpl b/Documentation/DocBook/sh.tmpl
deleted file mode 100644
index 4a38f60..0000000
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
diff --git a/Documentation/sh/interfaces.rst b/Documentation/sh/interfaces.rst
new file mode 100644
index 0000000..85078d4
--- /dev/null
+++ b/Documentation/sh/interfaces.rst
@@ -0,0 +1,63 @@
+.. Copyright 2008-2010 Paul Mundt
+.. Copyright 2008-2010 Renasas Technology Corp.
+.. Copyright 2010 Renasas Electronics Corp.
+
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
2.7.4

