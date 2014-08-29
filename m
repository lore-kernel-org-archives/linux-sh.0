From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Aug 2014 13:50:16 +0000
Subject: [PATCH 10/11] [WIP] ARM: shmobile: r8a7740: Add A4SU pm domain support
Message-Id: <1409320217-13278-11-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add support for the A4SU power domain.
This domain contains the USBPHY hardware block, which is currently not
used by any driver.

FIXME: Somehow this should be tied to USBH (or USBF) in A3SP?

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-r8a7740.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 3e15143572dc..d563e623bcb5 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -63,6 +63,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 	}, {
 		.genpd.name	= "A3SG",
 		.bit_shift	= 13,
+	}, {
+		.genpd.name	= "A4SU",
+		.bit_shift	= 20,
 	},
 };
 
-- 
1.7.9.5

