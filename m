Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FC1FBEB0
	for <linux-sh@vger.kernel.org>; Sun, 26 Apr 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777242351; cv=none; b=r90ZKgVcmtqZLYxomck78mcgpe4+4ZrFeDxZv6ZVhBlJkzCue3UwH3+o+qXblPHtusor/Vk821nmWL035AiiMTKLh3yTVL7WrdcG111C5+2YqXAyynUotNpRsZQzN3QIQZIYVm8MvRSRwqK9j3GeGemY+tHnoS704OJKUy6vMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777242351; c=relaxed/simple;
	bh=8YI7bTE6VqWepiB/YeSkG1B2cIOvT5K5YoVGg2N1S7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ido8wx5rFReDTMTDnLc6nzplZLe76Cwe31oXJMpmVgTJJ5eyinGQomZRuL2IpxWCv0jkPkBVo+4WmAJuA/RAzVL8NHoWmrjW6/BnXPsAmHwnocNC0NftWo0Q2IAnw250VvRbKa6sQCgfFLLYOY0rdhCkgdI2ZMpBrtS//MxPVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBehDcra; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBehDcra"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43eb05b1875so5565592f8f.3
        for <linux-sh@vger.kernel.org>; Sun, 26 Apr 2026 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777242348; x=1777847148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAV7QfybA/MYDdGSOXKDNQ25mr+F/ZwYCIZ6fu/YUyY=;
        b=eBehDcra+yVlp360bu2YR1Im9zPlKQdSjpdPyzjgpGT94VDEZCjPzenQPjF96d/icU
         3gnyXJB2KcgYp+dnNcoqgokLXSFhnVQpFc/jiiqlAztszREO9qsiM/yo0cyNi2PN4jbr
         2INSInW1iRQxGgWFxXuS5BIcLdx01UVlwRGVQo6z+pUL/WY3hVhWQChPqNsBMO0UCLLJ
         wmlFcE7BSRfQe9c2Z4V9gQUa5MCVCcZeBlWCnzwzKy/0GyV7g74Qh99FqBCbzBuergn0
         NGCaNMFpak//Nvwr/MfR7RlPHYx/YiMR/m/DtcLihX06t7Xo0FFNO1LSVLM9Ao9WvAz9
         llqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777242348; x=1777847148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAV7QfybA/MYDdGSOXKDNQ25mr+F/ZwYCIZ6fu/YUyY=;
        b=nyIkMLW6zqiUUcKJLS5pKcCPAOihhDqTbHC59CAtCUsPXTTy6wpoa26tiG7nrn2KjG
         nD30DfT9HxIqmoac48GyyiszWOxqZ0Se1j3P7VXLke+CB5Smu/ujIP9L6ov43PtxFFaA
         ZpqxTlxPEGAsyMVX6mpB1RJd+Cd61rgOywC6ymq9kduDMRXPYXPCtc0Q1RU6yfPL8M4P
         zajdrg54eka/Jndxeo94jyqYD60htvqOCjJlLrHJ+YIEzd8aLa9+ET8x6lNcWvcyrpRM
         9EpvtJfTkjbY9ggEFQ7N2koZsg/I3T7vMbI1ah35eSPDOIHWtUwcEIjY2UFl4FLkdTQa
         srHA==
X-Gm-Message-State: AOJu0YxrKp+apTQMDSxjD3Cbjs6gcK414iawOVFPVlYaS/mEDTpwgMzZ
	JqI9MCG9o+Bdw04VaQHar7tJmhXw23DMDX+YBZkhZzjqpihfNHRgXjUJ0fcFuGo=
X-Gm-Gg: AeBDiev+KkPsMzt/UjTA0A4Yp7R86/imuYALH1EAdzbUd1bA3670xg2ACiIFKf8Gpwl
	+GQqht0z3azDTqzm/Yscg708QN/gu7qdBhtHjDvo+xS3HuEQWzSAn25K4pvOvTmacAQwJRzETXT
	J2nmg77FbxOtRYPzJBrYmkAql3tv6mF7d7/tNr2obXILylCJq9t4K/A4yJxzSBtOVqxwBPV+uFd
	uUJkRaFg4uISUxktNMEoG7V6gBuO2sbE7o9QQkDHr5B8R/X6NgXjXepPBKSwGd+zfTS0G4fMcY9
	BIVaH0iiJJp793AcMmEprl9twBDQZC4Qn6rbL/LJw0aA0TBS98fXhfRnSws4XR4iONYzJANQ6dX
	re4jftQPnmT7nHIGwS0aiNBoH5acj5r/O3IGuQsTQdIpfOm2+AcEWKnN3ebDOOEeiodiAyAFZOn
	ux9oR9YSzRmvzqXgDDbkn5iQkY1gmpKdeiiKYVbW6CoNfaRfDYMCqx0zyvad3o0I8riad4176a1
	qmBPDwqIPXINr/gkf4=
X-Received: by 2002:a5d:5d0b:0:b0:43d:1c4a:37c with SMTP id ffacd0b85a97d-43fe3db3c6dmr61754552f8f.4.1777242347804;
        Sun, 26 Apr 2026 15:25:47 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:d98f:f308:9025:fa5f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e3a341sm81678663f8f.24.2026.04.26.15.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 15:25:47 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Rich Felker <dalias@libc.org>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH v2] sh: maple: fix empty port handling
Date: Sun, 26 Apr 2026 23:27:14 +0200
Message-ID: <20260426212714.2286437-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the handling of empty ports, to restore the ability to use the device
with less than 4 populated ports and also be able to hot-plug new devices
in empty ports at runtime.

Explicitly cast the response code in maple_response_devinfo() to s8 so
that 0xFF from the device gets interpreted as signed and flows like the
NONE response, previously it was considered unknown response code, which
blocked the maple bus.

Remove the locking variable from maple_vblank_handler() as there is no
locking information returned from maple_add_packet() and it lead to only
ever check exactly one empty port.

Update maple_response_devinfo() to explicitly check for empty ports on
unit 0, to be able to hot-plug devices in empty ports.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v1->v2: Don't break hot-plugging of new devices to empty ports.
	Explicitly cast the response code to s8 to use the existing
	logic, that relies on signed chars. In the case of 0xff (all 1s,
	DCs TIMEOUT response) that was interpreted as 255 unknown response
	code, which blocked the maple bus, as busy was never reset. Add
	condition to maple_response_devinfo() to process the devinfo 
	for currently empty ports.

v1: https://lore.kernel.org/all/20251112190444.3631533-1-fuchsfl@gmail.com/

Note that the removal of peripherals is possible, the ports get marked as
empty, but the driver is never detached. That means a peripheral can be
removed, but the port keeps "reserved" for this peripheral and can't be
reused with another peripheral.

VMUs can't be removed at runtime, as MTD keeps a reference to it, so that
mdev->can_unload() is never true. But the same peripheral can be
inserted to the same port again.

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

