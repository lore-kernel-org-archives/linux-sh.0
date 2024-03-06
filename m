Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D1134BF
	for <linux-sh@vger.kernel.org>; Wed,  6 Mar 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760013; cv=none; b=cljIBpVIkN0vPwBQs5Unrpy20XNfoLOWFuACwMNZIlfrz/Pz2JsAvqiKtrlmTvEv8cA9WSYh1KjZG5OfB3rukDPg/JHFNcqhYL/+wBFzXquN69BReaa8YUTEkLD8F8DlZHtXph7gcXZKeKU9c5grjOrvfQRCmY4QH1v0q9NkUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760013; c=relaxed/simple;
	bh=pnwgk882TFy2NEAr8PKIavVFArqSnIjQ0tDYENNBNs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ofzsQB5Bld2CHamaUlYdYxhg5pmjbVtjEZAUp5ykWfZbB39U2+rcLYNNN/Qeb1Bjti7bss4JKLvkD21P9pMuwxpPXHOWZjhsQccnQF22qXfRiM8FWVAr+zDxh0ja4m8hCPnE+THG6ke8eMjZNh4af4om+TFGlSJCy68gpblugZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyg8-0006eB-Tb; Wed, 06 Mar 2024 22:19:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyg3-004otZ-Ty; Wed, 06 Mar 2024 22:19:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyg3-000so7-2h;
	Wed, 06 Mar 2024 22:19:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Duoming Zhou <duoming@zju.edu.cn>,
	linux-sh@vger.kernel.org,
	kernel@vpengutronix.de
Subject: [PATCH] sh: push-switch: Convert to platform remove callback returning void
Date: Wed,  6 Mar 2024 22:19:47 +0100
Message-ID: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pnwgk882TFy2NEAr8PKIavVFArqSnIjQ0tDYENNBNs4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQXd7/8Wxu82vV0d5TGXCXhNyeMmFJus7GZ1qrZboyry bh/XFq0k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJxDhxMCw9XPn7q4ph+rad 749eXhn/Jl1a0Po8b3qpiuT20ANcK/zjzy32P8+nW/zV6vUfF4Vdm65EN5kpL5tp3bjBoqE98kd gvp/Jk7wedcUXKpnTn7V6rOfUPhznlV0VNyWhqap95qybhTOyhcodr/rPan/EdDbyYczEf1MOqU 9Q4rdM+ROhLTTF7udU3WdnJNT+/rZ05pASCJg9oenAzpj8d7X2FYcCVbvNJpZm/c9lYp3sGbpcy Ez5hFB+/4+7hTNTrk/n3f/JblpjxDmj5m16MpOXBz76JvajSHFz3ZGikl2s57X/yOfuqnujsKiv RdjgcVJe6mP+E0+9Lj2PcdxztTTgywuXLXVyKQm6ewwsAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sh@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/sh/drivers/push-switch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.c
index 6ecba5f521eb..362e4860bf52 100644
--- a/arch/sh/drivers/push-switch.c
+++ b/arch/sh/drivers/push-switch.c
@@ -91,7 +91,7 @@ static int switch_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int switch_drv_remove(struct platform_device *pdev)
+static void switch_drv_remove(struct platform_device *pdev)
 {
 	struct push_switch *psw = platform_get_drvdata(pdev);
 	struct push_switch_platform_info *psw_info = pdev->dev.platform_data;
@@ -106,13 +106,11 @@ static int switch_drv_remove(struct platform_device *pdev)
 	free_irq(irq, pdev);
 
 	kfree(psw);
-
-	return 0;
 }
 
 static struct platform_driver switch_driver = {
 	.probe		= switch_drv_probe,
-	.remove		= switch_drv_remove,
+	.remove_new	= switch_drv_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 	},

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0

