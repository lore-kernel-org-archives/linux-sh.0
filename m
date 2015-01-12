From: Rob Landley <rob@landley.net>
Date: Mon, 12 Jan 2015 23:00:46 +0000
Subject: [PATCH] Build superh without CONFIG_EXPERT.
Message-Id: <54B4521E.4050507@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <53700D71.1090201@landley.net>	<53767FB9.5040508@infradead.org> <CAMuHMdVnUqc+gyqok_OAUWT++K-O=9kRQkyUkHduPGxQUQ20oA@mail.gmail.com>
In-Reply-To: <CAMuHMdVnUqc+gyqok_OAUWT++K-O=9kRQkyUkHduPGxQUQ20oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Rob Landley <rob@landley.net>

What sh4 actually wants is HAVE_PATA_PLATFORM, so select that instead.

Signed-off-by: Rob Landley <rob@landley.net>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

 arch/sh/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

A follow-up patch could simplify the defconfigs in arch/sh/configs...

--- linux/arch/sh/Kconfig
+++ linux/arch/sh/Kconfig
@@ -1,7 +1,7 @@
 config SUPERH
 	def_bool y
 	select ARCH_MIGHT_HAVE_PC_PARPORT
-	select EXPERT
+	select HAVE_PATA_PLATFORM
 	select CLKDEV_LOOKUP
 	select HAVE_IDE if HAS_IOPORT_MAP
 	select HAVE_MEMBLOCK
