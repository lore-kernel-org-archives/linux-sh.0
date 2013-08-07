From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Aug 2013 04:38:42 +0000
Subject: [GIT PULL 25/26] ARM: shmobile: kzm9d: remove nfsroot settings from bootargs
Message-Id: <6de69131854501dcc9585d44087430584f8ccdf4.1375840527.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

NFS detail settings like "nfsroot=,rsize@96,wsize@96" are no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d-reference.dts | 2 +-
 arch/arm/boot/dts/emev2-kzm9d.dts           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d-reference.dts b/arch/arm/boot/dts/emev2-kzm9d-reference.dts
index bed676b..cceefda 100644
--- a/arch/arm/boot/dts/emev2-kzm9d-reference.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d-reference.dts
@@ -21,7 +21,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96";
+		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
 	};
 
 	reg_1p8v: regulator@0 {
diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index dda13bc..f92e812 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -21,6 +21,6 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96";
+		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
 	};
 };
-- 
1.8.3.2

