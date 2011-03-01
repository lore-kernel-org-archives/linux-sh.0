From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Mar 2011 06:45:14 +0000
Subject: [PATCH] sh: Enable PMB support on SH4AL-DSP
Message-Id: <20110301064514.15937.88065.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20110301064150.GB5985@linux-sh.org>
In-Reply-To: <20110301064150.GB5985@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

The SH4AL-DSP core included in sh7372 requires use of the PMB,
update the CONFIG_PMB Kconfig entry to reflect this.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/mm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/mm/Kconfig
+++ work/arch/sh/mm/Kconfig	2011-03-01 15:42:12.000000000 +0900
@@ -83,7 +83,7 @@ config 32BIT
 
 config PMB
 	bool "Support 32-bit physical addressing through PMB"
-	depends on MMU && EXPERIMENTAL && CPU_SH4A && !CPU_SH4AL_DSP
+	depends on MMU && EXPERIMENTAL && CPU_SH4A
 	select 32BIT
 	select UNCACHED_MAPPING
 	help
