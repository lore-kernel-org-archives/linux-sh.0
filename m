From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 10:50:38 +0000
Subject: [PATCH 05/05] sh: Let SH_TIMER_CMT select GENERIC_TIME
Message-Id: <20090415105038.29940.67915.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Let SH_TIMER_CMT select GENERIC_TIME. This since GENERIC_TIME is
required to build the CMT driver. Without this patch the TMU driver
must be enabled for the CMT driver to build.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-02-04 19:29:12.000000000 +0900
@@ -431,6 +431,7 @@ config SH_CMT
 config SH_TIMER_CMT
 	bool "CMT clockevents driver"
 	depends on SYS_SUPPORTS_CMT && !SH_CMT
+	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 
 config SH_MTU2
