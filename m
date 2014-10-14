From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 14 Oct 2014 07:31:34 +0000
Subject: [PATCH] ata: sata_rcar: Add r8a7793 device support
Message-Id: <1413271894-10056-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is against for-next branch of Tejun's libata repo.

 drivers/ata/sata_rcar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 61eb6d7..6f8ed8e 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -841,6 +841,10 @@ static struct of_device_id sata_rcar_match[] = {
 		.compatible = "renesas,sata-r8a7791",
 		.data = (void *)RCAR_GEN2_SATA
 	},
+	{
+		.compatible = "renesas,sata-r8a7793",
+		.data = (void *)RCAR_GEN2_SATA
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sata_rcar_match);
@@ -850,6 +854,7 @@ static const struct platform_device_id sata_rcar_id_table[] = {
 	{ "sata-r8a7779", RCAR_GEN1_SATA },
 	{ "sata-r8a7790", RCAR_GEN2_SATA },
 	{ "sata-r8a7791", RCAR_GEN2_SATA },
+	{ "sata-r8a7793", RCAR_GEN2_SATA },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
-- 
1.9.1

