From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 14:07:20 +0000
Subject: [PATCH 01/14] i2c: add dummy inline functions for when CONFIG_OF_I2C(_MODULE) isn't defined
Message-Id: <1348754853-28619-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Ben Dooks <ben-linux@fluff.org>

If CONFIG_OF_I2C and CONFIG_OF_I2C_MODULE are undefined no declaration of
of_find_i2c_device_by_node and of_find_i2c_adapter_by_node will be
available. Add dummy inline functions to avoid compilation breakage.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 include/linux/of_i2c.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index 1cb775f..cfb545c 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -29,6 +29,18 @@ static inline void of_i2c_register_devices(struct i2c_adapter *adap)
 {
 	return;
 }
+
+static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
+{
+	return NULL;
+}
+
+/* must call put_device() when done with returned i2c_adapter device */
+static inline struct i2c_adapter *of_find_i2c_adapter_by_node(
+						struct device_node *node)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF_I2C */
 
 #endif /* __LINUX_OF_I2C_H */
-- 
1.7.2.5

