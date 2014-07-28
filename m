From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 28 Jul 2014 22:12:55 +0000
Subject: [PATCH] sh-pfc: r8a7791: fix CAN pin groups
Message-Id: <201407290212.55656.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I had made last-minute changes before submitting the patch "sh-pfc: r8a7791:
add CAN pin groups"; now I'm seeing that they weren't complete: I had missed
update to the pin group names in pin[01]_groups[]. Drop the "_a" suffixes there.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git' repo.

 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -4509,24 +4509,24 @@ static const char * const audio_clk_grou
 };
 
 static const char * const can0_groups[] = {
-	"can0_data_a",
+	"can0_data",
 	"can0_data_b",
 	"can0_data_c",
 	"can0_data_d",
 	"can0_data_e",
 	"can0_data_f",
-	"can_clk_a",
+	"can_clk",
 	"can_clk_b",
 	"can_clk_c",
 	"can_clk_d",
 };
 
 static const char * const can1_groups[] = {
-	"can1_data_a",
+	"can1_data",
 	"can1_data_b",
 	"can1_data_c",
 	"can1_data_d",
-	"can_clk_a",
+	"can_clk",
 	"can_clk_b",
 	"can_clk_c",
 	"can_clk_d",
