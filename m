From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 21 Oct 2016 19:30:43 +0000
Subject: Re: [sh]: glibc file offset problems since 2.24
Message-Id: <c2564977-0bce-67e1-42e3-f573d46fe466@physik.fu-berlin.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------ABE6AF60F2A0983BFB00F77A"
List-Id: <linux-sh.vger.kernel.org>
References: <53fb3565-53cc-fa22-403f-b7220a5fa4d4@physik.fu-berlin.de>
In-Reply-To: <53fb3565-53cc-fa22-403f-b7220a5fa4d4@physik.fu-berlin.de>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------ABE6AF60F2A0983BFB00F77A
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 10/21/2016 08:36 PM, Rich Felker wrote:
> glibc commit 071af4769fcdfe2cd349157b01f27c9571478ace looks like a
> likely culprit. It was between 2.23 and 2.24 and is related to this
> musl commit which may be easier to understand:

Indeed that looks very suspicious, thanks for pointing this out.

James Clarke (CC'ed) has suggested the attached patch on IRC which I'm testing
right now.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--------------ABE6AF60F2A0983BFB00F77A
Content-Type: text/x-patch;
 name="sh-align-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sh-align-fix.patch"

diff --git a/sysdeps/unix/sysv/linux/sh/pread.c b/sysdeps/unix/sysv/linux/sh/pread.c
index d3f99f3..be8efb1 100644
--- a/sysdeps/unix/sysv/linux/sh/pread.c
+++ b/sysdeps/unix/sysv/linux/sh/pread.c
@@ -19,5 +19,5 @@
 /* SH4 ABI does not really require argument alignment for 64-bits, but
    the kernel interface for pread adds a dummy long argument before the
    offset.  */
-#define __ALIGNMENT_ARG
+#define __ALIGNMENT_ARG 0,
 #include <sysdeps/unix/sysv/linux/pread.c>
diff --git a/sysdeps/unix/sysv/linux/sh/pread64.c b/sysdeps/unix/sysv/linux/sh/pread64.c
index b2e8a25..5d1eaac 100644
--- a/sysdeps/unix/sysv/linux/sh/pread64.c
+++ b/sysdeps/unix/sysv/linux/sh/pread64.c
@@ -19,5 +19,5 @@
 /* SH4 ABI does not really require argument alignment for 64-bits, but
    the kernel interface for pread adds a dummy long argument before the
    offset.  */
-#define __ALIGNMENT_ARG
+#define __ALIGNMENT_ARG 0,
 #include <sysdeps/unix/sysv/linux/pread64.c>
diff --git a/sysdeps/unix/sysv/linux/sh/pwrite.c b/sysdeps/unix/sysv/linux/sh/pwrite.c
index 391ed5e..329c64f 100644
--- a/sysdeps/unix/sysv/linux/sh/pwrite.c
+++ b/sysdeps/unix/sysv/linux/sh/pwrite.c
@@ -19,5 +19,5 @@
 /* SH4 ABI does not really require argument alignment for 64-bits, but
    the kernel interface for pwrite adds a dummy long argument before the
    offset.  */
-#define __ALIGNMENT_ARG
+#define __ALIGNMENT_ARG 0,
 #include <sysdeps/unix/sysv/linux/pwrite.c>
diff --git a/sysdeps/unix/sysv/linux/sh/pwrite64.c b/sysdeps/unix/sysv/linux/sh/pwrite64.c
index 683a5d9..d510780 100644
--- a/sysdeps/unix/sysv/linux/sh/pwrite64.c
+++ b/sysdeps/unix/sysv/linux/sh/pwrite64.c
@@ -17,7 +17,7 @@
    <http://www.gnu.org/licenses/>.  */
 
 /* SH4 ABI does not really require argument alignment for 64-bits, but
-   the kernel interface for pread adds a dummy long argument before the
+   the kernel interface for pwrite adds a dummy long argument before the
    offset.  */
-#define __ALIGNMENT_ARG
+#define __ALIGNMENT_ARG 0,
 #include <sysdeps/unix/sysv/linux/pwrite64.c>


--------------ABE6AF60F2A0983BFB00F77A--
