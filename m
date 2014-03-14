From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 14 Mar 2014 23:11:27 +0000
Subject: [PATCH] sh_eth: exit probe with unknown register layout
Message-Id: <201403150311.25173.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Exit the driver's probe() method when the register layout is unknown as the
driver would cause kernel oops in this case anyway.

While at it, move the corresponding error message printout and convert it from
pr_err() to dev_err().

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This fix is against DaveM 'net-next.git' repo since the issue it solves is not
critical.

 drivers/net/ethernet/renesas/sh_eth.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -2703,7 +2703,6 @@ static const u16 *sh_eth_get_register_of
 		reg_offset = sh_eth_offset_fast_sh3_sh2;
 		break;
 	default:
-		pr_err("Unknown register type (%d)\n", register_type);
 		break;
 	}
 
@@ -2859,6 +2858,12 @@ static int sh_eth_drv_probe(struct platf
 		mdp->cd = (struct sh_eth_cpu_data *)match->data;
 	}
 	mdp->reg_offset = sh_eth_get_register_offset(mdp->cd->register_type);
+	if (!mdp->reg_offset) {
+		dev_err(&pdev->dev, "Unknown register type (%d)\n",
+			mdp->cd->register_type);
+		ret = -EINVAL;
+		goto out_release;
+	}
 	sh_eth_set_default_cpu_data(mdp->cd);
 
 	/* set function */
