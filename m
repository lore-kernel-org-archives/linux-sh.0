Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243E38D007
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144683; cv=none; b=jpHOPb0UzeR53NQ9fYaY0lf/ayoOxoAvFmT9Vw5MMjkgT4FVVqJhkfCmfEsfk6SuLgzoqbD3ooWUxq0zkjQ67igpzlyFGM29v3dOi5wPxgLvcMKkcSMi+TFPAArDBVBbA78HdLsaAuc+I0EAW1SpAblCrNWgf1KR7MD4mO99wMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144683; c=relaxed/simple;
	bh=/3X00LOV6XS2/d5basJ/GaE5xVPyz12pOp53OU6UFU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXI8k4ehqqVm/Jgo/9bq7OnSDX9KyQJTAhfNJfth6d0WOXejO9O9ZOry62p/8gIjx3OjBCzNs3WzIBe3GdOhKy1wYpDnOUdoApWzT4FwCbwwLa9tUrvOpZdDwzuAnJR9ZoW8RbCIORrgu5yZTRFjB0NPFxscmckzsvhUkXZt6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj+faPOh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj+faPOh"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3811f512167so1057285a91.3
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144681; x=1783749481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCLbWy4o3f9MGLq9llGCaidDXhV4syaFRnFA+H+ZRkQ=;
        b=Wj+faPOhABtfCg+chonEXSwcP6eWlKnzUCR0oufkQWXBSsSY+DWZEyjnfTClmZTjJB
         s+EOng4gReNKA9yD0nUUNvqmqPMjID0c9qtl2FJ/pwoXmlYgV8F5a4vZZLAFkL8qe3Mt
         tKHkT5/kc5fhTfEFZbErCdAXRR5en0P32FhmvJBrGZ+MAVwdnpM9TY5jHxbJNYs7iz9D
         QsS+CAtY/7yvjGfUuhZ54ZZbTHpEOcYJuCG/TF3L0pp0SgIBaTf64eVTRSxPY3clJtCu
         6yTntvlT1M9M0GDnommn/N87yZene1Z4vBQUdexftwY0QLjbDmcMGtTfuj5/cYht2eW4
         3C/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144681; x=1783749481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YCLbWy4o3f9MGLq9llGCaidDXhV4syaFRnFA+H+ZRkQ=;
        b=KLv093ciellVMldeRgp+bAbMZbsx8NkZ6WGa12LxF6gAptwdRnwgJfLOVeneNhdTaB
         YTUSMQC7vY7yS/a1z2u6LgxdH5iSJHHAZ6oCDmhEJla0pbYovz5fx4NWyBK2PJbpHAqT
         p1Y0ip1Os//JV9vUcqoUSmjMZj2YTUK4ZaBc3vqctNHz+zLQF/fYBm+c0NvC5K8lYTWZ
         Jd4ojY2SEcPakPTzc1GC1tk+amZpoYKt58/l0e+DNgsaNYuz6bbCg2WjysOn+p5dN7hg
         LTaWOTwbXtthgZt9Oy7q7h4EW2F5azXcEzHuVVixFqKYnROqOfwgy1C4+SA4AjooEG+R
         Ux/g==
X-Forwarded-Encrypted: i=1; AHgh+Rr7MJn3r3oSJ1XtyIZ/jYZJsuONy+0+3wGbu8tq/aF2tIo8PNBUQKD/e7uxtnXnupS5apu7V3aXSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnwkM5AhSuqNimS2WkhIVlhDv01s67xKMgABNrKrR9Lk/lY1J
	kfiJg/WyOPTSEeUmx26pVGEXYwrG1YQYL5XaIoGmlJ4AyudR21UIknsqvRCjAw==
X-Gm-Gg: AfdE7clvtCJsMgO3XElhm9rsOJG4h5zkJVq/QQ+w8sBPv9HCfU0ERhl2D9+h/cKFao1
	0NePv21Z/fLlWv/8pZRccQjwN3GAXHp4c9dE6SnxZWoCPTmVVCMgkXwzVnshB8jFRz0DxWGR2nf
	Hjxu9MRlqBkBcg8zw00gsv2a8YTADbSs2/0VD91r1O1XXnO9BXoW0l7dHqU4OyiA38x4QgOc7P7
	+KKAAqEMM4u0PCfPr8hj5ifJPKJQQI3of4rfmo97ugKHx+/6OQfcFmUJGhy4r5HeHKABsigdkMG
	YZG887Q7x6/iJgdUV4jIvXVE4EQSds8qx/YxW6GsHQW3YXa1Hm6nNEtf+Nf4Tw7i3/kuJfPJ2Zm
	Bpw78fEhcSXazaL5rJF69bN4pn+W2j6QxYTICwaFRjtSJkvOw7dKYCMgqPDdTdWVNE7tTS4kEKC
	q8MWJbwtlzWWYPkmaweDjp6DlOkcUli4JoaWwJGJLW2wq4/TJJs9GkbqljOFwfve2fUQNwhCRzH
	7o=
X-Received: by 2002:a17:90b:1d51:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-3835a16be4bmr1976700a91.16.1783144680987;
        Fri, 03 Jul 2026 22:58:00 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:00 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:40 -0700
Subject: [PATCH 17/26] sh: maple: implement bus-level probe/remove
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-17-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

Implement probe() and remove() methods for the maple bus, and update
struct maple_driver to have its own probe() and remove() members that
take struct maple_device * directly.

Adjust all maple drivers (keyboard, mouse, joystick, vmu-flash) to
use these new bus-level methods, simplifying their probe and remove
functions by removing the need to cast from struct device * using
to_maple_dev().

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 12 ++++--------
 drivers/input/keyboard/maple_keyb.c   | 14 +++++---------
 drivers/input/mouse/maplemouse.c      | 12 ++++--------
 drivers/mtd/maps/vmu-flash.c          | 13 ++++---------
 drivers/sh/maple/maple.c              | 27 ++++++++++++++++++++++++++-
 include/linux/maple.h                 |  2 ++
 6 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 955e01bcfa0c..6864243b0b4a 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -78,7 +78,7 @@ static void dc_pad_close(struct input_dev *dev)
 }
 
 /* allow the controller to be used */
-static int probe_maple_controller(struct device *dev)
+static int probe_maple_controller(struct maple_device *mdev)
 {
 	static const short btn_bit[32] = {
 		BTN_C, BTN_B, BTN_A, BTN_START, -1, -1, -1, -1,
@@ -94,7 +94,6 @@ static int probe_maple_controller(struct device *dev)
 		-1, -1, -1, -1, -1, -1, -1, -1,
 	};
 
-	struct maple_device *mdev = to_maple_dev(dev);
 	int i, error;
 	struct dc_pad *pad;
 	struct input_dev *idev;
@@ -145,23 +144,20 @@ static int probe_maple_controller(struct device *dev)
 	return error;
 }
 
-static int remove_maple_controller(struct device *dev)
+static void remove_maple_controller(struct maple_device *mdev)
 {
-	struct maple_device *mdev = to_maple_dev(dev);
 	struct dc_pad *pad = maple_get_drvdata(mdev);
 
 	input_unregister_device(pad->dev);
 	kfree(pad);
-
-	return 0;
 }
 
 static struct maple_driver dc_pad_driver = {
 	.function =	MAPLE_FUNC_CONTROLLER,
+	.probe =	probe_maple_controller,
+	.remove =	remove_maple_controller,
 	.drv = {
 		.name	= "Dreamcast_controller",
-		.probe	= probe_maple_controller,
-		.remove	= remove_maple_controller,
 	},
 };
 
diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index e277b929a375..ab9257db7e03 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -158,15 +158,12 @@ static void dc_kbd_close(struct input_dev *dev)
 	maple_getcond_callback(mdev, NULL, 0, MAPLE_FUNC_KEYBOARD);
 }
 
-static int probe_maple_kbd(struct device *dev)
+static int probe_maple_kbd(struct maple_device *mdev)
 {
-	struct maple_device *mdev;
 	int i, error;
 	struct dc_kbd *kbd;
 	struct input_dev *idev;
 
-	mdev = to_maple_dev(dev);
-
 	kbd = kzalloc_obj(*kbd);
 	if (!kbd) {
 		error = -ENOMEM;
@@ -214,9 +211,8 @@ static int probe_maple_kbd(struct device *dev)
 	return error;
 }
 
-static int remove_maple_kbd(struct device *dev)
+static void remove_maple_kbd(struct maple_device *mdev)
 {
-	struct maple_device *mdev = to_maple_dev(dev);
 	struct dc_kbd *kbd = maple_get_drvdata(mdev);
 
 	guard(mutex)(&maple_keyb_mutex);
@@ -224,15 +220,15 @@ static int remove_maple_kbd(struct device *dev)
 	input_unregister_device(kbd->dev);
 	kfree(kbd);
 
-	return 0;
+
 }
 
 static struct maple_driver dc_kbd_driver = {
 	.function = MAPLE_FUNC_KEYBOARD,
+	.probe =	probe_maple_kbd,
+	.remove =	remove_maple_kbd,
 	.drv = {
 		.name = "Dreamcast_keyboard",
-		.probe = probe_maple_kbd,
-		.remove = remove_maple_kbd,
 	},
 };
 
diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index f67e3eb5841b..03cb666d278d 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -64,9 +64,8 @@ static void dc_mouse_close(struct input_dev *dev)
 }
 
 /* allow the mouse to be used */
-static int probe_maple_mouse(struct device *dev)
+static int probe_maple_mouse(struct maple_device *mdev)
 {
-	struct maple_device *mdev = to_maple_dev(dev);
 	int error;
 	struct input_dev *input_dev;
 	struct dc_mouse *mse;
@@ -111,23 +110,20 @@ static int probe_maple_mouse(struct device *dev)
 	return error;
 }
 
-static int remove_maple_mouse(struct device *dev)
+static void remove_maple_mouse(struct maple_device *mdev)
 {
-	struct maple_device *mdev = to_maple_dev(dev);
 	struct dc_mouse *mse = maple_get_drvdata(mdev);
 
 	input_unregister_device(mse->dev);
 	kfree(mse);
-
-	return 0;
 }
 
 static struct maple_driver dc_mouse_driver = {
 	.function =	MAPLE_FUNC_MOUSE,
+	.probe =	probe_maple_mouse,
+	.remove =	remove_maple_mouse,
 	.drv = {
 		.name = "Dreamcast_mouse",
-		.probe = probe_maple_mouse,
-		.remove = remove_maple_mouse,
 	},
 };
 
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 8f7028ac1b56..c34c768dfb87 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -769,30 +769,25 @@ static void vmu_file_error(struct maple_device *mdev, void *recvbuf)
 }
 
 
-static int probe_maple_vmu(struct device *dev)
+static int probe_maple_vmu(struct maple_device *mdev)
 {
-	struct maple_device *mdev = to_maple_dev(dev);
-
 	mdev->can_unload = vmu_can_unload;
 	mdev->fileerr_handler = vmu_file_error;
 
 	return vmu_connect(mdev);
 }
 
-static int remove_maple_vmu(struct device *dev)
+static void remove_maple_vmu(struct maple_device *mdev)
 {
-	struct maple_device *mdev = to_maple_dev(dev);
-
 	vmu_disconnect(mdev);
-	return 0;
 }
 
 static struct maple_driver vmu_flash_driver = {
 	.function =	MAPLE_FUNC_MEMCARD,
+	.probe =	probe_maple_vmu,
+	.remove =	remove_maple_vmu,
 	.drv = {
 		.name =		"Dreamcast_visual_memory",
-		.probe =	probe_maple_vmu,
-		.remove =	remove_maple_vmu,
 	},
 };
 
diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 35aff2e57d2c..c0715e3ace6f 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -721,6 +721,11 @@ static irqreturn_t maple_vblank_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*
+ * We pass &maple_bus as dev_id for the shared interrupts because
+ * the kernel requires a unique non-NULL token for shared IRQs,
+ * even though the handlers themselves ignore it.
+ */
 static int maple_set_dma_interrupt_handler(void)
 {
 	return request_irq(HW_EVENT_MAPLE_DMA, maple_dma_interrupt,
@@ -765,9 +770,30 @@ static void maple_bus_release(struct device *dev)
 /*
  * maple_bus_type - core maple bus structure
  */
+static int maple_bus_probe(struct device *dev)
+{
+	struct maple_driver *maple_drv = to_maple_driver(dev->driver);
+	struct maple_device *maple_dev = to_maple_dev(dev);
+
+	if (maple_drv->probe)
+		return maple_drv->probe(maple_dev);
+	return -ENODEV;
+}
+
+static void maple_bus_remove(struct device *dev)
+{
+	struct maple_driver *maple_drv = to_maple_driver(dev->driver);
+	struct maple_device *maple_dev = to_maple_dev(dev);
+
+	if (maple_drv->remove)
+		maple_drv->remove(maple_dev);
+}
+
 static const struct bus_type maple_bus_type = {
 	.name = "maple",
 	.match = maple_match_bus_driver,
+	.probe = maple_bus_probe,
+	.remove = maple_bus_remove,
 };
 
 static struct device maple_bus = {
@@ -790,7 +816,6 @@ static int __init maple_bus_init(void)
 	if (retval)
 		goto cleanup_device;
 
-
 	/* allocate memory for maple bus dma */
 	retval = maple_get_dma_buffer();
 	if (retval) {
diff --git a/include/linux/maple.h b/include/linux/maple.h
index 90c26c86e3ed..641cf3330409 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -80,6 +80,8 @@ struct maple_device {
 
 struct maple_driver {
 	unsigned long function;
+	int (*probe)(struct maple_device *dev);
+	void (*remove)(struct maple_device *dev);
 	struct device_driver drv;
 };
 

-- 
2.55.0.rc0.799.gd6f94ed593-goog

