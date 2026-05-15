Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426D403150
	for <linux-sh@vger.kernel.org>; Fri, 15 May 2026 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868969; cv=none; b=saw5VV6hyA2Vyv2MzHHFGcK7tbfrPnwV6MdUkhHwkSE01jdw7kPAuImrQ9OaPyYX65SPF3NZynYFpBfkzSVYZV9vmwtR7eAbZaGNVXLwLi1GSwz7R5KfV5NgtzTuWMszHUF/7/ORSuefRdfUtbSykvbZnpVrngn4Bs0qlKs/fQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868969; c=relaxed/simple;
	bh=462IIuZWKSb2z2va0IZCI1UQVrUp+oQCeV2bIS5QOQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prFzpkwL1DAmrVzRmgiEA8s5fq8kx8okcluzW5c26OuigcpqqY2y+9q2hVCFrmAR0YeIz3kOIb2frvgQ9nD4ZxdgY8XEFqz1eiH/+k00lW0c5IrZ4zcIooUlXBLlxl2mrVLbxwTMjrD9+kkD0+nms3IcpaxcRAhql/KLUF06Yd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBPO4rf8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBPO4rf8"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45d96d21e82so35580f8f.0
        for <linux-sh@vger.kernel.org>; Fri, 15 May 2026 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778868966; x=1779473766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KSj7BhGKMu4dEn7f6TZANHhuDLD6LpO6jlTgA6yCJg=;
        b=UBPO4rf8vogPuOAI8AbjCohkWpm0XAg6srxM8hH17e0hdtMh5RrMNIqHoRVAf11Rtr
         u7ajRpTeqBjN7xIcYwKqMZXYhSo36iMw38UZWcD16gMk+oVtOIEUhwNxAQkfl2sdoetP
         mJFnKeb67rcOXFenZum1KP6BRUz2YzbEVv4GX414L4YIVYCjvcMDEoj1XuNLwU+6suly
         ZO2/P/p5XUwCgkVM0ROmcs1bt+RnKW0IUhh8GhvOPM11vIJ38ksBAU/dbfRRPyBS+1ad
         53U+90bAZhao+HrYlsQTHQvf/HzgUSJlMVm6aPczEMLTp6X1esSoyKGzAs0/81hSbiAP
         rBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778868966; x=1779473766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KSj7BhGKMu4dEn7f6TZANHhuDLD6LpO6jlTgA6yCJg=;
        b=HdOnXQ94u9nWl/G6obJyd8nNL4fbXra19AmmzqmksXWjEn+bhXTtp9QCrxrF0CIvbs
         nnEsT9I44PJkNYmrR/HeIo+TMldv9PnBjMoB2Rz3RfHTThZnhak+d6RH2ig9Wo8vIYdf
         09jRT9bOtMtwjqnrNspglcorWFHQVXVORh0xaBNy8QM24h6oyJ5evQu1DBeSFNLPrJc7
         YJ4T8wmIBtrQXGO1Y1Rcl1rB8XkNSlbPx1JauDRbiLDO4vpak4pkLfIBNvuySoZ8kWXY
         GgCpcLK5XFBn5ZPDNxdv6JflshCRpHMDj841S5jyGO59vQyf6JdHCeaWtZCH6GTU1tzc
         8G4A==
X-Gm-Message-State: AOJu0Yz6j5ary0AbJmVoZfQbjDem9qGUw/USGL2UeGtpQjsnyG14XNfW
	COqCpACyfArNK5cRa88rqNtVItMABMNcA+sXMNg45tkLcaXt7Tld6e4/uIbjIGs=
X-Gm-Gg: Acq92OFJumgp2T9B6sUqbK6lbnyFZSeYasgXPDx9Ch3cD+aXNc8CYAXwrTC47DsBhVq
	M+73r3k4kfKjSyM/4sYOhN8NvlCaSKteW4X/EemZJC+5ZkZgyYRvH+x7ifoRs1LW12FJ7u0sjaF
	/1NzBT6Nfw/1j0gNXS5PHQxhPotzkUbxYNKVUCCfcOUWKQ5moq6poElq+MUA4iE5f2GytU3sJDd
	KsJWXaPyKtg4oSSMiJFS/0BpfVJbCmpQ5jDcQXaEsboOt+ZHOw96L7dLgI8p4E85HQHW2oKzQfM
	A8Bcy9GpoQsDPjNn92KupDQWRErUA5o3PJEExzJat+1EWpVJ6tTVp3q3XVLwy8g6jSNDmj9q2Gq
	xm0YuOmBCRjl1tODPRqlyVJyfMg8NBgxG3G9gq4zuMpkzkwqUXphU1ftSVRxXaduryvkqOhFV/J
	prq4zD+lnSWTiM73dHJIrxXvh5AaXhMCJ1my/+BA0P0HJFVl9OZe5M8KpsLNSYerPfzvdb2LqTQ
	ijqE8g=
X-Received: by 2002:a5d:5d01:0:b0:43d:73d4:b34 with SMTP id ffacd0b85a97d-45e5c5a10b0mr7341877f8f.16.1778868966089;
        Fri, 15 May 2026 11:16:06 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:fb24:41ce:1d7:fad9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45d9ec39806sm16372821f8f.9.2026.05.15.11.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 11:16:05 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Rich Felker <dalias@libc.org>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH v3] sh: maple: fix empty port handling
Date: Fri, 15 May 2026 20:11:15 +0200
Message-ID: <20260515181115.3244161-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix empty Maple port handling so the bus works with fewer than four
populated ports and devices can be hot-plugged at runtime.

Cast the response code to s8 so 0xff is handled as MAPLE_RESPONSE_NONE,
continue scanning after empty ports, and process devinfo replies for
empty unit-0 ports.

Tested-by: Artur Rojek <contact@artur-rojek.eu>
Acked-by: Artur Rojek <contact@artur-rojek.eu>
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v2->v3: No functional change. Condense commit message and add Tested-by,
        Acked-by tags. 
v1->v2: Don't break hot-plugging of new devices to empty ports.
        Explicitly cast the response code to s8 to use the existing
        logic, that relies on signed chars. In the case of 0xff (all 1s,
        DCs TIMEOUT response) that was interpreted as 255 unknown response
        code, which blocked the maple bus, as busy was never reset. Add
        condition to maple_response_devinfo() to process the devinfo
        for currently empty ports.

v2: https://lore.kernel.org/all/20260426212714.2286437-1-fuchsfl@gmail.com/
v1: https://lore.kernel.org/all/20251112190444.3631533-1-fuchsfl@gmail.com/

 drivers/sh/maple/maple.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 5585f220e495..8e7bb42aef07 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -445,7 +445,7 @@ static int setup_maple_commands(struct device *device, void *ignored)
 /* VBLANK bottom half - implemented via workqueue */
 static void maple_vblank_handler(struct work_struct *work)
 {
-	int x, locking;
+	int x;
 	struct maple_device *mdev;
 
 	if (!maple_dma_done())
@@ -474,13 +474,10 @@ static void maple_vblank_handler(struct work_struct *work)
 				if (!mdev)
 					break;
 				atomic_set(&mdev->busy, 1);
-				locking = maple_add_packet(mdev, 0,
+				maple_add_packet(mdev, 0,
 					MAPLE_COMMAND_DEVINFO, 0, NULL);
-				if (!locking)
-					break;
-				}
 			}
-
+		}
 		maple_pnp_time = jiffies + MAPLE_PNP_INTERVAL;
 	}
 
@@ -578,7 +575,8 @@ static void maple_response_devinfo(struct maple_device *mdev,
 				   char *recvbuf)
 {
 	char submask;
-	if (!started || (scanning == 2) || !fullscan) {
+	if (!started || (scanning == 2) || !fullscan ||
+	    ((mdev->unit == 0) && empty[mdev->port])) {
 		if ((mdev->unit == 0) && (checked[mdev->port] == false)) {
 			checked[mdev->port] = true;
 			maple_attach_driver(mdev);
@@ -644,7 +642,7 @@ static void maple_dma_handler(struct work_struct *work)
 			recvbuf = mq->recvbuf->buf;
 			__flush_invalidate_region(sh_cacheop_vaddr(recvbuf),
 					0x400);
-			code = recvbuf[0];
+			code = (s8)recvbuf[0];
 			kfree(mq->sendbuf);
 			list_del_init(&mq->list);
 			switch (code) {

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.43.0

