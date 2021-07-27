Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A7AC4338F
	for <linux-sh@archiver.kernel.org>; Tue, 27 Jul 2021 08:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEEF60527
	for <linux-sh@archiver.kernel.org>; Tue, 27 Jul 2021 08:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhG0ILB (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 27 Jul 2021 04:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbhG0IK7 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 27 Jul 2021 04:10:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C5EC061757
        for <linux-sh@vger.kernel.org>; Tue, 27 Jul 2021 01:10:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8I92-0006l8-6m; Tue, 27 Jul 2021 10:08:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8I8u-0005sz-UT; Tue, 27 Jul 2021 10:08:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8I8u-0004FT-TM; Tue, 27 Jul 2021 10:08:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-sh@vger.kernel.org
Subject: [PATCH 3/5] sh: superhyway: Simplify check in remove callback
Date:   Tue, 27 Jul 2021 10:08:38 +0200
Message-Id: <20210727080840.3550927-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de>
References: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=RI6GBOcwaT/YqLauV9PR/s+g33ul7kmjbz/l8bF0LdQ=; m=Jckb/3cKtVVMbGmghSGQQ0azpY4z4Lj4Rosk4zfdvSg=; p=t6rnEvMxvPF/adrQkDOYow4gALaPv+ywQx6bUC5qg+Q=; g=2dc54acdd2fd4631e007d1a263badb652279fe9f
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD/vvsACgkQwfwUeK3K7Alu4gf/Ziu 0UWW9yXMBUKwvtNy91ip/ytE1KLxT5NhYt7RdD5GiftKHO8i3ra/aEcMXedW7Vst06IrQSRr0tDM+ 46TtNlUcHb6RWIJILjLd47xQhbOEpp3Wg8xy02VUvZ+OSRfL4het9egYa+6dSveuXe3ynvHkInNFK i+qFMZqd5XaELABY1gml9VeuOswOXsvksokOKznkGF/Zu/Jn4JzLv/WPAPYKmixFiKaey2WjBOfaz 6nwtEKqOySij3hPpJVESpiqqDaUHRZ7ObPXRProT29xP2OOBeErEFaT2/EklD36ucBPbMFYlAOfIj ukOTZW+7wc7C4ZiEf4Rj5Jek61kifXQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sh@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The driver core only calls a remove callback when the device was
successfully bound (aka probed) before. So dev->driver is never NULL.

(And even if it was NULL, to_superhyway_driver(NULL) isn't ...)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/sh/superhyway/superhyway.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/superhyway/superhyway.c b/drivers/sh/superhyway/superhyway.c
index c0ab904c76ec..44324abe21da 100644
--- a/drivers/sh/superhyway/superhyway.c
+++ b/drivers/sh/superhyway/superhyway.c
@@ -155,7 +155,7 @@ static void superhyway_device_remove(struct device *dev)
 	struct superhyway_device *shyway_dev = to_superhyway_device(dev);
 	struct superhyway_driver *shyway_drv = to_superhyway_driver(dev->driver);
 
-	if (shyway_drv && shyway_drv->remove)
+	if (shyway_drv->remove)
 		shyway_drv->remove(shyway_dev);
 }
 
-- 
2.30.2

