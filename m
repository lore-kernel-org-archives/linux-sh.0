From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 14 Mar 2014 07:55:39 +0000
Subject: [PATCH v2 2/2] spi: sh-hspi: Do not specifically request shyway_clk clock
Message-Id: <1394783739-29168-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1394783739-29168-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1394783739-29168-1-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Rather than requesting the shyway_clk call clk_get with
the device and a NULL con_id.

This is in keeping with the way that clk_get() is called
on other drivers used by Renesas Gen 1 SoCs. And I believe
it is compatible with supplying clocks via DT, unlike the current code.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

--

It appears to me that the two uses of this driver are
the r8a7778 and r8a7779 SoCs.

The r8a7779 already clocks setup to allow this driver to continue to work
with this change applied.

The r8a7778 has clocks incorrectly setup to allow this driver to continue
to work with this change applied. This problem is addressed in
"ARM: shmobile: r8a7779: Use clks as MSTP007 parent" which is thus
a pre-requisite of this patch.

v2
* Update changelog
---
 drivers/spi/spi-sh-hspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 82d2f92..e975892 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -274,9 +274,9 @@ static int hspi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	clk = clk_get(NULL, "shyway_clk");
+	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "shyway_clk is required\n");
+		dev_err(&pdev->dev, "couldn't get clock\n");
 		ret = -EINVAL;
 		goto error0;
 	}
-- 
1.8.5.2

