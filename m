From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 08:45:27 +0000
Subject: [PATCH] sh: include empty_zero_page in etext
Message-Id: <20090511084527.32203.81488.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Include empty_zero_page in _text. This fixes a problem
introduced by c3e2586b794b12ffcdf69b4e547030b51e18e6d9
which results in broken boot on R2D-Plus.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/vmlinux.lds.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/vmlinux.lds.S
+++ work/arch/sh/kernel/vmlinux.lds.S	2009-05-11 17:21:26.000000000 +0900
@@ -26,12 +26,13 @@ SECTIONS
 	. = CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START + CONFIG_ZERO_PAGE_OFFSET;
 #endif
 
+	_text = .;		/* Text and read-only data */
+
 	.empty_zero_page : AT(ADDR(.empty_zero_page) - LOAD_OFFSET) {
 		*(.empty_zero_page)
 	} = 0
 
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
-		_text = .;		/* Text and read-only data */
 		HEAD_TEXT
 		TEXT_TEXT
 
