From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Fri, 16 Nov 2012 05:46:12 +0000
Subject: [PATCH 4/4] drivers: uio: Only allocate new private data when probing device tree node
Message-Id: <1353044772-18803-5-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1353044772-18803-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1353044772-18803-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hjk@hansjkoch.de, gregkh@linuxfoundation.org, magnus.damm@gmail.com, horms@verge.net.au
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Damian Hobson-Garcia <dhobsong@igel.co.jp>

The same condition should be used both when allocating and freeing the
driver private data.  When dev.of_node is non NULL, allocate a new
private data structure, otherwise use the values from the platform data.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/uio/uio_dmem_genirq.c |    2 +-
 drivers/uio/uio_pdrv_genirq.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index bbdf925..252434c 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -153,7 +153,7 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	int ret = -EINVAL;
 	int i;
 
-	if (!uioinfo) {
+	if (pdev->dev.of_node) {
 		int irq;
 
 		/* alloc uioinfo for one device */
diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index 42202cd..45fcceb 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -102,7 +102,7 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 	int ret = -EINVAL;
 	int i;
 
-	if (!uioinfo) {
+	if (pdev->dev.of_node) {
 		int irq;
 
 		/* alloc uioinfo for one device */
-- 
1.7.5.4

