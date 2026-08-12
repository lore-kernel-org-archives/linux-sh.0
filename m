Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3231A065;
	Wed, 12 Aug 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544813; cv=none; b=ajsdv/rTeJ0rLCl2ffBi8TnCT53PbR8uA9wfhh4C+L7Slg1iZ7VcydhodVPNJZH87Qss0fHHUJZUUKO8MpmOVdyNk0m58+s7jgB1H+zuZOtKj8JSmeDy0LUrB6NKrQmvGAgO6T5vXB3AWtiPl0Iq923HsOLf/iWGrp1J5HeIF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544813; c=relaxed/simple;
	bh=kNWtMK/mej0FN9Edig2KzXEa4cQq0CIbyIfgbvXKrCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/8gCzfGosXrhlxZN/keptGEDOAsx/fsdO8eyOqJn2p2MGBA0nOoex4Mn8mFyM1Wyar9QdEq9gNdhwgA/gNaae6awfI/yimWL7ZCA0eU2ptgz7T6IPfkQJ7gy07EbDc/ZY3tY4/Uzz3zFQm4ptvw0k6PjoBmOWukBOqjgQOEMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAdphn+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAdphn+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8709C1F000E9;
	Wed, 12 Aug 2026 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544811;
	bh=KEqXzzUG0ZMr6EIyJK/HpR1+jzT22D0QTw+Xc3rpw0Q=;
	h=From:To:Cc:Subject:Date;
	b=nAdphn+ybSzCkjP18sFMSl8mntiY0478lhzqjfHvcVm95USsB9VklDokE+kEh6C6h
	 /3Dy7trGb3K2iONX72hPzVom0QLQXvA5c7Lg6IA9jVZ1BmrIkt4IynD9oEcpSje5Jb
	 9qsWHi0fgEFWfBVs/q75xwRvt62OF5as5XY6q14H3FKKZlNqraby/PdflYO7dJ7FsH
	 xpyyv9+nQ8zHKFhd1KeuA6nuWZkDk07xobmdl/Sq5tQBX9c5G+wxQgSOWGyNT8YMTr
	 l1fNbYJACIAUIAZZMPlK8hu5PCi9WgP2P+QnL9LqLSRAW+J9oi/7l7BGuYLRL8TRfG
	 xrJP+uH9sFL2g==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wu9ur-00000000ESW-08yK;
	Wed, 12 Aug 2026 16:26:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2] maple: switch to dynamic root device
Date: Wed, 12 Aug 2026 16:26:36 +0200
Message-ID: <20260812142636.55563-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver core expects devices to be dynamically allocated and will, for
example, complain loudly when no release function has been provided.

Use root_device_register() to allocate and register the root device
instead of open coding using a static device.

Note that this also fixes a reference leak in case device_register()
fails which may be flagged by static checkers.

Acked-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

It's been over three months (and one reminder) since this series was
posted so resending as a v2 with Artur's tags added.

Johan


 drivers/sh/maple/maple.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 5585f220e495..7c0f847ee368 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -44,7 +44,7 @@ static LIST_HEAD(maple_sentq);
 static DEFINE_MUTEX(maple_wlist_lock);
 
 static struct maple_driver maple_unsupported_device;
-static struct device maple_bus;
+static struct device *maple_bus;
 static int subdevice_map[MAPLE_PORTS];
 static unsigned long *maple_sendbuf, *maple_sendptr, *maple_lastptr;
 static unsigned long maple_pnp_time;
@@ -229,7 +229,7 @@ static struct maple_device *maple_alloc_dev(int port, int unit)
 		return NULL;
 	}
 	mdev->dev.bus = &maple_bus_type;
-	mdev->dev.parent = &maple_bus;
+	mdev->dev.parent = maple_bus;
 	init_waitqueue_head(&mdev->maple_wait);
 	return mdev;
 }
@@ -761,10 +761,6 @@ static int maple_match_bus_driver(struct device *devptr,
 	return 0;
 }
 
-static void maple_bus_release(struct device *dev)
-{
-}
-
 static struct maple_driver maple_unsupported_device = {
 	.drv = {
 		.name = "maple_unsupported_device",
@@ -779,11 +775,6 @@ static const struct bus_type maple_bus_type = {
 	.match = maple_match_bus_driver,
 };
 
-static struct device maple_bus = {
-	.init_name = "maple",
-	.release = maple_bus_release,
-};
-
 static int __init maple_bus_init(void)
 {
 	int retval, i;
@@ -791,9 +782,11 @@ static int __init maple_bus_init(void)
 
 	__raw_writel(0, MAPLE_ENABLE);
 
-	retval = device_register(&maple_bus);
-	if (retval)
+	maple_bus = root_device_register("maple");
+	if (IS_ERR(maple_bus)) {
+		retval = PTR_ERR(maple_bus);
 		goto cleanup;
+	}
 
 	retval = bus_register(&maple_bus_type);
 	if (retval)
@@ -806,22 +799,21 @@ static int __init maple_bus_init(void)
 	/* allocate memory for maple bus dma */
 	retval = maple_get_dma_buffer();
 	if (retval) {
-		dev_err(&maple_bus, "failed to allocate DMA buffers\n");
+		dev_err(maple_bus, "failed to allocate DMA buffers\n");
 		goto cleanup_basic;
 	}
 
 	/* set up DMA interrupt handler */
 	retval = maple_set_dma_interrupt_handler();
 	if (retval) {
-		dev_err(&maple_bus, "bus failed to grab maple "
-			"DMA IRQ\n");
+		dev_err(maple_bus, "bus failed to grab maple DMA IRQ\n");
 		goto cleanup_dma;
 	}
 
 	/* set up VBLANK interrupt handler */
 	retval = maple_set_vblank_interrupt_handler();
 	if (retval) {
-		dev_err(&maple_bus, "bus failed to grab VBLANK IRQ\n");
+		dev_err(maple_bus, "bus failed to grab VBLANK IRQ\n");
 		goto cleanup_irq;
 	}
 
@@ -855,7 +847,7 @@ static int __init maple_bus_init(void)
 	maple_pnp_time = jiffies + HZ;
 	/* prepare initial queue */
 	maple_send();
-	dev_info(&maple_bus, "bus core now registered\n");
+	dev_info(maple_bus, "bus core now registered\n");
 
 	return 0;
 
@@ -878,7 +870,7 @@ static int __init maple_bus_init(void)
 	bus_unregister(&maple_bus_type);
 
 cleanup_device:
-	device_unregister(&maple_bus);
+	root_device_unregister(maple_bus);
 
 cleanup:
 	printk(KERN_ERR "Maple bus registration failed\n");
-- 
2.54.0

