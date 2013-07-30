From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 30 Jul 2013 17:57:24 +0000
Subject: [RFC 2/5] arm: boot: allow zboot with appended DTB
Message-Id: <1375207047-8655-3-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I don't see any reason why this should not be allowed.
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0ac9be6..54ac595 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1938,7 +1938,7 @@ endchoice
 
 config ARM_APPENDED_DTB
 	bool "Use appended device tree blob to zImage (EXPERIMENTAL)"
-	depends on OF && !ZBOOT_ROM
+	depends on OF
 	help
 	  With this option, the boot code will look for a device tree binary
 	  (DTB) appended to zImage
-- 
1.7.10.4

