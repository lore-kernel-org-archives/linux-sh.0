From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Nov 2009 14:35:08 +0000
Subject: [PATCH 02/05] Driver Core: Early platform driver buffer
Message-Id: <20091105143508.9902.22192.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add early_platform_init_buffer() support and update the
early platform driver code to allow passing parameters
to the driver on the kernel command line.

early_platform_init_buffer() simply allows early platform
drivers to provide a pointer and length to a memory area
where the remaining part of the kernel command line option
will be stored.

Needed to pass baud rate and other serial port options
to the reworked early serial console code on SuperH.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/base/platform.c         |   29 ++++++++++++++++++++++-------
 include/linux/platform_device.h |   20 +++++++++++++++-----
 2 files changed, 37 insertions(+), 12 deletions(-)

--- 0001/drivers/base/platform.c
+++ work/drivers/base/platform.c	2009-11-05 23:18:06.000000000 +0900
@@ -1000,7 +1000,7 @@ static __initdata LIST_HEAD(early_platfo
 int __init early_platform_driver_register(struct early_platform_driver *epdrv,
 					  char *buf)
 {
-	unsigned long index;
+	char *tmp;
 	int n;
 
 	/* Simply add the driver to the end of the global list.
@@ -1019,13 +1019,28 @@ int __init early_platform_driver_registe
 	if (buf && !strncmp(buf, epdrv->pdrv->driver.name, n)) {
 		list_move(&epdrv->list, &early_platform_driver_list);
 
-		if (!strcmp(buf, epdrv->pdrv->driver.name))
+		/* Allow passing parameters after device name */
+		if (buf[n] = '\0' || buf[n] = ',')
 			epdrv->requested_id = -1;
-		else if (buf[n] = '.' && strict_strtoul(&buf[n + 1], 10,
-							 &index) = 0)
-			epdrv->requested_id = index;
-		else
-			epdrv->requested_id = EARLY_PLATFORM_ID_ERROR;
+		else {
+			epdrv->requested_id = simple_strtoul(&buf[n + 1],
+							     &tmp, 10);
+
+			if (buf[n] != '.' || (tmp = &buf[n + 1])) {
+				epdrv->requested_id = EARLY_PLATFORM_ID_ERROR;
+				n = 0;
+			} else
+				n += strcspn(&buf[n + 1], ",") + 1;
+		}
+
+		if (buf[n] = ',')
+			n++;
+
+		if (epdrv->bufsize) {
+			memcpy(epdrv->buffer, &buf[n],
+			       min_t(int, epdrv->bufsize, strlen(&buf[n]) + 1));
+			epdrv->buffer[epdrv->bufsize - 1] = '\0';
+		}
 	}
 
 	return 0;
--- 0001/include/linux/platform_device.h
+++ work/include/linux/platform_device.h	2009-11-05 22:24:51.000000000 +0900
@@ -83,6 +83,8 @@ struct early_platform_driver {
 	struct platform_driver *pdrv;
 	struct list_head list;
 	int requested_id;
+	char *buffer;
+	int bufsize;
 };
 
 #define EARLY_PLATFORM_ID_UNSET -2
@@ -102,21 +104,29 @@ extern int early_platform_driver_probe(c
 				       int nr_probe, int user_only);
 extern void early_platform_cleanup(void);
 
+#define early_platform_init(class_string, platdrv)		\
+	early_platform_init_buffer(class_string, platdrv, NULL, 0)
 
 #ifndef MODULE
-#define early_platform_init(class_string, platform_driver)		\
+#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
 static __initdata struct early_platform_driver early_driver = {		\
 	.class_str = class_string,					\
-	.pdrv = platform_driver,					\
+	.buffer = buf,							\
+	.bufsize = bufsiz,						\
+	.pdrv = platdrv,						\
 	.requested_id = EARLY_PLATFORM_ID_UNSET,			\
 };									\
-static int __init early_platform_driver_setup_func(char *buf)		\
+static int __init early_platform_driver_setup_func(char *buffer)	\
 {									\
-	return early_platform_driver_register(&early_driver, buf);	\
+	return early_platform_driver_register(&early_driver, buffer);	\
 }									\
 early_param(class_string, early_platform_driver_setup_func)
 #else /* MODULE */
-#define early_platform_init(class_string, platform_driver)
+#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
+static inline char *early_platform_driver_setup_func(void)		\
+{									\
+	return bufsiz ? buf : NULL;					\
+}
 #endif /* MODULE */
 
 #endif /* _PLATFORM_DEVICE_H_ */
