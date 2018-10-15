From: Mark Brown <broonie@kernel.org>
Date: Mon, 15 Oct 2018 11:22:06 +0000
Subject: Applied "spi: sh-msiof: fix deferred probing" to the spi tree
Message-Id: <20181015112206.75EE011224A9@debutante.sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <c705888d-128a-bf3a-7828-ce105b3665d4@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.orglinux-spi@vger.kernel.org

The patch

   spi: sh-msiof: fix deferred probing

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From f34c6e6257aa477cdfe7e9bbbecd3c5648ecda69 Mon Sep 17 00:00:00 2001
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 12 Oct 2018 22:48:22 +0300
Subject: [PATCH] spi: sh-msiof: fix deferred probing

Since commit 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
platform_get_irq() can return -EPROBE_DEFER. However, the driver overrides
an error returned by that function with -ENOENT which breaks the deferred
probing. Propagate upstream an error code returned by platform_get_irq()
and remove the bogus "platform" from the error message, while at it...

Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 101cd6aae2ea..30ea0a2068e0 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1343,8 +1343,8 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
 	i = platform_get_irq(pdev, 0);
 	if (i < 0) {
-		dev_err(&pdev->dev, "cannot get platform IRQ\n");
-		ret = -ENOENT;
+		dev_err(&pdev->dev, "cannot get IRQ\n");
+		ret = i;
 		goto err1;
 	}
 
-- 
2.19.0.rc2
