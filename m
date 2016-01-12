From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 12 Jan 2016 17:28:51 +0000
Subject: [PATCH] regulator: da9210: fix lockdep warning
Message-Id: <1452619744-14857-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Commit 70cfef26267474 ("regulator: Add lockdep asserts to help detecting
locking misuse") successfully created this WARN, let's fix it:

[    1.218660] WARNING: CPU: 0 PID: 553 at drivers/regulator/core.c:3646 regulator_notifier_call_chain+0x5c/0x88()
...
[    1.220278] [<c0246c20>] (regulator_notifier_call_chain) from [<c02498b4>] (da9210_irq_handler+0x74/0x10c)
[    1.220412]  r7:c0080cac r6:eb1daa00 r5:e64bbf10 r4:00000002
[    1.220547] [<c0249840>] (da9210_irq_handler) from [<c0080cd8>] (irq_thread_fn+0x2c/0x44)
...

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Tested on a Renesas Lager board, running in a reboot-cycle for an hour now.

 drivers/regulator/da9210-regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 8b3cc9f0cd64c0..01c0e3709b6659 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -132,6 +132,8 @@ static irqreturn_t da9210_irq_handler(int irq, void *data)
 	if (error < 0)
 		goto error_i2c;
 
+	mutex_lock(&chip->rdev->mutex);
+
 	if (val & DA9210_E_OVCURR) {
 		regulator_notifier_call_chain(chip->rdev,
 					      REGULATOR_EVENT_OVER_CURRENT,
@@ -155,6 +157,9 @@ static irqreturn_t da9210_irq_handler(int irq, void *data)
 					      NULL);
 		handled |= DA9210_E_VMAX;
 	}
+
+	mutex_unlock(&chip->rdev->mutex);
+
 	if (handled) {
 		/* Clear handled events */
 		error = regmap_write(chip->regmap, DA9210_REG_EVENT_B, handled);
-- 
2.1.4

