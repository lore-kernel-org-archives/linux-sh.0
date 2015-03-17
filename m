From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 17 Mar 2015 07:15:21 +0000
Subject: [RFC V2 1/4] pinctrl: allow to unselect a state
Message-Id: <1426576524-22315-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Needed to implement an i2c n-to-1 bus demultiplexer where n different
I2C IP cores should be able to serve the same bus (like i2c-rcar,
i2c-sh_mobile, and i2c-gpio on Renesas RCar Gen2 SoCs).

Alternative: We could also skip this patch and define two states instead
of one to be used in the demuxer, like "active" and "passive". The
drawback there is, that the passive state needs some dummy pins which
are not actually used. They would only exist to free the active pins, so
those could be used by another I2C core.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since RFC V1: none, only rebased

 drivers/pinctrl/core.c           | 34 +++++++++++++++++++++++-----------
 include/linux/pinctrl/consumer.h |  5 +++++
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 89dca77ca0382e..48d77d04b5d5ed 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -977,18 +977,12 @@ struct pinctrl_state *pinctrl_lookup_state(struct pinctrl *p,
 EXPORT_SYMBOL_GPL(pinctrl_lookup_state);
 
 /**
- * pinctrl_select_state() - select/activate/program a pinctrl state to HW
- * @p: the pinctrl handle for the device that requests configuration
- * @state: the state handle to select/activate/program
+ * pinctrl_deselect_state() - deselect a pinctrl state to HW
+ * @p: the pinctrl handle for the device that requests deconfiguration
  */
-int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
+void pinctrl_deselect_state(struct pinctrl *p)
 {
-	struct pinctrl_setting *setting, *setting2;
-	struct pinctrl_state *old_state = p->state;
-	int ret;
-
-	if (p->state = state)
-		return 0;
+	struct pinctrl_setting *setting;
 
 	if (p->state) {
 		/*
@@ -1002,9 +996,27 @@ int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
 				continue;
 			pinmux_disable_setting(setting);
 		}
+
+		p->state = NULL;
 	}
+}
+EXPORT_SYMBOL_GPL(pinctrl_deselect_state);
+
+/**
+ * pinctrl_select_state() - select/activate/program a pinctrl state to HW
+ * @p: the pinctrl handle for the device that requests configuration
+ * @state: the state handle to select/activate/program
+ */
+int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
+{
+	struct pinctrl_setting *setting, *setting2;
+	struct pinctrl_state *old_state = p->state;
+	int ret;
+
+	if (p->state = state)
+		return 0;
 
-	p->state = NULL;
+	pinctrl_deselect_state(p);
 
 	/* Apply all the settings for the new state */
 	list_for_each_entry(setting, &state->settings, node) {
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 72c0415d6c2175..5e949122529db8 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -36,6 +36,7 @@ extern struct pinctrl_state * __must_check pinctrl_lookup_state(
 							struct pinctrl *p,
 							const char *name);
 extern int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *s);
+extern void pinctrl_deselect_state(struct pinctrl *p);
 
 extern struct pinctrl * __must_check devm_pinctrl_get(struct device *dev);
 extern void devm_pinctrl_put(struct pinctrl *p);
@@ -102,6 +103,10 @@ static inline int pinctrl_select_state(struct pinctrl *p,
 	return 0;
 }
 
+static inline void pinctrl_deselect_state(struct pinctrl *p)
+{
+}
+
 static inline struct pinctrl * __must_check devm_pinctrl_get(struct device *dev)
 {
 	return ERR_PTR(-ENOSYS);
-- 
2.1.4

