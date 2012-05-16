From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 16 May 2012 06:45:07 +0000
Subject: [PATCH 02/08] ARM: Undelete KZM9D mach-type V3
Message-Id: <20120516064507.32286.10714.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20120516064449.32286.77941.sendpatchset@w520>
In-Reply-To: <20120516064449.32286.77941.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Undelete the KZM9D mach-type to allow build of board
for EMEV2 SoC support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - posted before in different series, here just bumped version to match V3

 arch/arm/tools/mach-types |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/tools/mach-types
+++ work/arch/arm/tools/mach-types	2012-05-14 19:38:03.000000000 +0900
@@ -530,6 +530,7 @@ nokia_rm680		MACH_NOKIA_RM680	NOKIA_RM68
 msm8960_sim		MACH_MSM8960_SIM	MSM8960_SIM		3230
 msm8960_rumi3		MACH_MSM8960_RUMI3	MSM8960_RUMI3		3231
 gsia18s			MACH_GSIA18S		GSIA18S			3234
+kzm9d			MACH_KZM9D		KZM9D			3246
 mx53_loco		MACH_MX53_LOCO		MX53_LOCO		3273
 tx53			MACH_TX53		TX53			3279
 encore			MACH_ENCORE		ENCORE			3284
