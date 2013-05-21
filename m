From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 21 May 2013 10:09:57 +0000
Subject: [ILLUSTRATION 2/2] ARM: shmobile: lager: add CPUFreq support
Message-Id: <Pine.LNX.4.64.1305211206570.2863@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1305211202380.2863@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305211202380.2863@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org

Add DT properties, necessary to enable CPUFreq support on Lager.

Not-Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

As the subject and the NSob signify, this is not to be applied. This is 
just an example, how the CPUFreq support can be enabled on Lager. A proper 
patch will include regulator support.

 arch/arm/boot/dts/r8a7790-lager.dts |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 8d4c396..0e3198f 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -19,6 +19,14 @@
 		bootargs = "console=ttySC6,115200 ignore_loglevel";
 	};
 
+	cpus {
+		cpu@0 {
+			operating-points = <1300000 1000000
+					     100000  900000>;
+			clock-latency = <1000000>;
+		};
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
-- 
1.7.2.5

