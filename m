From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 02 Dec 2014 16:35:45 +0000
Subject: [PATCH 4/5] ARM: shmobile: lager: Rename SCIFA[01] serial ports to ttySC[01]
Message-Id: <1417538146-23350-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There's no reason to name the only two available serial ports on the
board ttySC6 and ttySC7 (apart from confusing userspace, which we should
try to avoid).

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 636d53bb87a2..ec843192d653 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -47,12 +47,12 @@
 	compatible = "renesas,lager", "renesas,r8a7790";
 
 	aliases {
-		serial6 = &scifa0;
-		serial7 = &scifa1;
+		serial0 = &scifa0;
+		serial1 = &scifa1;
 	};
 
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		bootargs = "console=ttySC0,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = &scifa0;
 	};
 
-- 
2.0.4

