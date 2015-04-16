From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Date: Thu, 16 Apr 2015 10:35:38 +0000
Subject: [RFC/PATCH v2 3/5] devicetree: bindings: Add new cpuidle enable method for Renesas R-car SoCs
Message-Id: <1429180540-5692-4-git-send-email-keita.kobayashi.ym@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
In-Reply-To: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>

This patch add the ARM CPUs Device Tree binding to document a new
enable method of Renesas cpuidle.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 8b9e0a9..663ee11 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -196,6 +196,7 @@ nodes to be present and contain the properties described below.
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "renesas,rcar-idle"
 			    "rockchip,rk3066-smp"
 
 	- cpu-release-addr
-- 
1.9.1

