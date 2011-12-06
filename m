From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Dec 2011 16:52:03 +0000
Subject: [PATCH 01/07] ARM: mach-shmobile: Marzen mach-type entry
Message-Id: <20111206165203.19348.80705.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

The marzen board has already been registered through the web interface,
but upstream does not include the mach-type entry yet.

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/tools/mach-types |    1 +
 1 file changed, 1 insertion(+)

--- 0002/arch/arm/tools/mach-types
+++ work/arch/arm/tools/mach-types	2011-12-07 00:30:13.000000000 +0900
@@ -1127,3 +1127,4 @@ m28evk			MACH_M28EVK		M28EVK			3613
 kota2			MACH_KOTA2		KOTA2			3616
 smdk4212		MACH_SMDK4212		SMDK4212		3638
 smdk4412		MACH_SMDK4412		SMDK4412		3765
+marzen			MACH_MARZEN		MARZEN			3790
