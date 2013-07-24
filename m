From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 24 Jul 2013 08:56:09 +0000
Subject: [PATCH v5 3/3] ARM: shmobile: lager: enable nfsroot in DTS
Message-Id: <1374656169-9241-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1374656169-9241-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1374656169-9241-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>

Now that Ether support has been added to the lager board
it is possible to use nfsroot. This configuration is
in line with that of other shmobile boards.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch has a run-time dependency on "ARM: shmobile: lager: enable Ether"

v2
* Split out as a new patch from "ARM: shmobile: lager: enable Ether"
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 09a84fc..b2f61f0 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -16,7 +16,7 @@
 	compatible = "renesas,lager", "renesas,r8a7790";
 
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel";
+		bootargs = "console=ttySC6,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96 rw";
 	};
 
 	memory@40000000 {
-- 
1.8.2.1

