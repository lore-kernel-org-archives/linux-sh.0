From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jun 2014 06:40:26 +0000
Subject: [PATCH v2] ARM: shmobile: Lager memory map update
Message-Id: <20140606064026.14410.80482.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the Lager DTS to make use of the new unified legacy 
memory map where the legacy window on Lager and Koelsch
have the same size.

With this change in place the code gets aligned with the
documentation.

After update the Lager board has the following map:
Bank0: 1GiB RAM (Legacy 32-bit: 0x40000000->0x7fffffff)
Bank1: 3GiB RAM (LPAE area: 0x140000000->0x1ffffffff)

Before the update the old map looked like this:
Bank0: 2GiB RAM (Legacy 32-bit: 0x40000000->0xbfffffff)
Bank1: 2GiB RAM (LPAE area: 0x180000000->0x1ffffffff)

Tested with and without LPAE on r8a7790 Lager.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-v3.15-rc8-20140605

 Changes since V1:
 - Updated commit log to include reason

 arch/arm/boot/dts/r8a7790-lager.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7790-lager.dts
+++ work/arch/arm/boot/dts/r8a7790-lager.dts	2014-06-05 14:49:42.000000000 +0900
@@ -29,12 +29,12 @@
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0 0x40000000 0 0x80000000>;
+		reg = <0 0x40000000 0 0x40000000>;
 	};
 
 	memory@180000000 {
 		device_type = "memory";
-		reg = <1 0x80000000 0 0x80000000>;
+		reg = <1 0x40000000 0 0xc0000000>;
 	};
 
 	lbsc {
