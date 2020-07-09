From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Date: Thu, 09 Jul 2020 02:17:37 +0000
Subject: [PATCH] SUPERH: Replace HTTP links with HTTPS ones
Message-Id: <20200709021737.22667-1-grandmaster@al2klimov.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, broonie@kernel.org, sboyd@kernel.org, arnd@arndb.de, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 arch/sh/Kconfig        | 4 ++--
 arch/sh/boards/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9fc2b010e938..bc91bdb0b665 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -74,7 +74,7 @@ config SUPERH
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
 	  gaming console.  The SuperH port has a home page at
-	  <http://www.linux-sh.org/>.
+	  <https://www.linux-sh.org/>.
 
 config GENERIC_BUG
 	def_bool y
@@ -630,7 +630,7 @@ config SMP
 	  Y to "Enhanced Real Time Clock Support", below.
 
 	  See also <file:Documentation/admin-guide/lockup-watchdogs.rst> and the SMP-HOWTO
-	  available at <http://www.tldp.org/docs.html#howto>.
+	  available at <https://www.tldp.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
 
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index fb0ca0c1efe1..cbfe32eba3d9 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -130,7 +130,7 @@ config SH_DREAMCAST
 	depends on CPU_SUBTYPE_SH7091
 	help
 	  Select Dreamcast if configuring for a SEGA Dreamcast.
-	  More information at <http://www.linux-sh.org>
+	  More information at <https://www.linux-sh.org>
 
 config SH_SH03
 	bool "Interface CTP/PCI-SH03"
-- 
2.27.0
