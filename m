From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 03 Sep 2014 00:49:01 +0000
Subject: [PATCH repost] ARM: shmobile: lager: correct memory map
Message-Id: <20140903004901.GA3277@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The base address of the second memory region on the lager
board is 0x140000000. Update the tag used in the dts file accordingly.

This is a documentation fix and should have no run-time affect.

This problem was introduced when the second memory region
was added to the lager dts file by 62bc32a2573c4219
("ARM: shmobile: Include all 4 GiB of memory on Lager)"
in v3.14.

Reported-by: NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I am reposting this as Olof originally requested a syntax change,
which I followed up on, however that change no longer seems appropriate.
This this patch seems to be correct.

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 0118cbf..84dcafa 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -32,7 +32,7 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
-	memory@180000000 {
+	memory@140000000 {
 		device_type = "memory";
 		reg = <1 0x40000000 0 0xc0000000>;
 	};
-- 
2.0.1

