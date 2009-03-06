From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Fri, 06 Mar 2009 12:29:26 +0000
Subject: [PATCH] Add documentation for "nohlt" kernel parameter
Message-Id: <20090306122925.9779.95415.stgit@Programuotojas>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-sh@vger.kernel.org
Cc: yanok@emcraft.com, wd@denx.de

As per discussion in:
http://marc.info/?l=linux-arm-kernel&m3633652517391&w=2

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
---

 Documentation/kernel-parameters.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)


diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 54f21a5..de06666 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1487,7 +1487,9 @@ and is between 256 and 4096 characters. It is defined in the file
 
 	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
 
-	nohlt		[BUGS=ARM,SH]
+	nohlt		[BUGS=ARM,SH] Tells the kernel that the sleep(SH) or
+			wfi(ARM) instruction doesn't work correctly and not to
+			use it. This is also usefull when using JTAG debugger.
 
 	no-hlt		[BUGS=X86-32] Tells the kernel that the hlt
 			instruction doesn't work correctly and not to

