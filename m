Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70135C4338F
	for <linux-sh@archiver.kernel.org>; Fri, 30 Jul 2021 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CF660720
	for <linux-sh@archiver.kernel.org>; Fri, 30 Jul 2021 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhG3TLA (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 30 Jul 2021 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhG3TK7 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 30 Jul 2021 15:10:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0265C06175F
        for <linux-sh@vger.kernel.org>; Fri, 30 Jul 2021 12:10:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu8-00068i-Au; Fri, 30 Jul 2021 21:10:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu6-0005yn-4D; Fri, 30 Jul 2021 21:10:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu6-0007Ke-3E; Fri, 30 Jul 2021 21:10:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Rich Felker <dalias@libc.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-sh@vger.kernel.org
Subject: [PATCH v2 2/4] sh: superhyway: Simplify check in remove callback
Date:   Fri, 30 Jul 2021 21:10:33 +0200
Message-Id: <20210730191035.1455248-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de>
References: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=RI6GBOcwaT/YqLauV9PR/s+g33ul7kmjbz/l8bF0LdQ=; m=Jckb/3cKtVVMbGmghSGQQ0azpY4z4Lj4Rosk4zfdvSg=; p=t6rnEvMxvPF/adrQkDOYow4gALaPv+ywQx6bUC5qg+Q=; g=2dc54acdd2fd4631e007d1a263badb652279fe9f
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEETqIACgkQwfwUeK3K7AkIVAf+LfF 0vOPnYsdxAocnVR+xaAR/6TX+XBiVHrXuq0QGK1RnXV275HWgj7JuNzzI+m5kjmO+cZIy9TvSIkRU 5AYlKOlxq2rJT3S4/2HAxX2BMhBoU3kRzOhQFjRAdd3u664ukGnFtyT/3jMebZYfpW5ackzh6cfOY X7Q+wm0uDOdPQsNNNhUcNQPERnHOaJMF5NE7Y+2rDWZ3nkljePt6DCq3x1tuQGa3ZyvgVTOeqnm3W 2g9UvENIL/t63iKGtBQb7nzJW5UyYZPhO7/FJiGxQw6PyUnbsOYJ2jEAt/+1v8tq1u1tnP604Bxn3 dp2ve9ytsSKVZziNfqtcXPU2cJYJ8mw==
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

