From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 Apr 2015 12:43:38 +0000
Subject: [PATCH/RFC v6 3/7] ARM: shmobile: R-Mobile: Add support for PM domain power-on/off latencies
Message-Id: <1430138622-14029-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam@baylibre.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Parse the optional PM domain power-on/off latencies, as specified from
DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - Rebased on top of v4.1-rc1 for new RFC.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 95018209ff0b37cc..747d557b7016ec6d 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -367,6 +367,7 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
 	for_each_child_of_node(parent, np) {
 		struct rmobile_pm_domain *pd;
 		u32 idx = ~0;
+		u32 latency;
 
 		if (of_property_read_u32(np, "reg", &idx)) {
 			/* always-on domain */
@@ -377,6 +378,10 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
 			return -ENOMEM;
 
 		pd->genpd.name = np->name;
+		if (!of_property_read_u32(np, "power-on-latency", &latency))
+			pd->genpd.power_on_latency_ns = latency;
+		if (!of_property_read_u32(np, "power-off-latency", &latency))
+			pd->genpd.power_off_latency_ns = latency;
 		pd->base = base;
 		pd->bit_shift = idx;
 
-- 
1.9.1

