From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 17 Feb 2015 12:11:11 +0000
Subject: [PATCH/RFC 1/2] regulator: da9210: Mask all interrupt sources to deassert interrupt line
Message-Id: <1424175072-14643-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <CAMuHMdUasUmnHRi5t3GStrt-WKw0Das4noTmZPNtcbqA7nmDvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

After boot-up, some events may be set, and cause the da9210 interrupt
line to be asserted. As the da9210 driver doesn't have interrupt support
yet, this causes havoc on systems where the interrupt line is shared
among multiple devices.

This is the case on e.g. r8a7791/koelsch, where the interrupt line is
shared with a da9063 regulator, and the following events are set:

    EVENT_A = 0x00000011 (GPI0 | GPI4)
    EVENT_B = 0x00000002 (NPWRGOOD)

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
See discussion thread about da9210/da9063 interrupt storm
(ARM: shmobile: koelsch: da9210/da9063 interrupt storm (was: Re: [PATCH 3/4]
ARM: shmobile: koelsch: Add DA9063 PMIC device node for system restart)
https://lkml.org/lkml/2015/2/17/254

---
 drivers/regulator/da9210-regulator.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index bc6100103f7f476e..f0489cb9018b4e78 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -152,6 +152,15 @@ static int da9210_i2c_probe(struct i2c_client *i2c,
 	config.regmap = chip->regmap;
 	config.of_node = dev->of_node;
 
+	/* Mask all interrupt sources to deassert interrupt line */
+	error = regmap_write(chip->regmap, DA9210_REG_MASK_A, ~0);
+	if (!error)
+		error = regmap_write(chip->regmap, DA9210_REG_MASK_B, ~0);
+	if (error) {
+		dev_err(&i2c->dev, "Failed to write to mask reg: %d\n", error);
+		return error;
+	}
+
 	rdev = devm_regulator_register(&i2c->dev, &da9210_reg, &config);
 	if (IS_ERR(rdev)) {
 		dev_err(&i2c->dev, "Failed to register DA9210 regulator\n");
-- 
1.9.1

