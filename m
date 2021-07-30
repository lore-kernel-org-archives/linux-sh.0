Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18510C432BE
	for <linux-sh@archiver.kernel.org>; Fri, 30 Jul 2021 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065E260E09
	for <linux-sh@archiver.kernel.org>; Fri, 30 Jul 2021 19:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhG3TLC (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 30 Jul 2021 15:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhG3TLB (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 30 Jul 2021 15:11:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9FC06175F
        for <linux-sh@vger.kernel.org>; Fri, 30 Jul 2021 12:10:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu8-00068d-Ao; Fri, 30 Jul 2021 21:10:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu5-0005yh-PK; Fri, 30 Jul 2021 21:10:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu5-0007KF-Nx; Fri, 30 Jul 2021 21:10:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rich Felker <dalias@libc.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org
Subject: [PATCH v2 0/4] Some cleanups after making bus_type::remove return void
Date:   Fri, 30 Jul 2021 21:10:31 +0200
Message-Id: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sh@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hello,

compared to (implicit) v1 that can be found at
https://lore.kernel.org/lkml/20210727080840.3550927-1-u.kleine-koenig@pengutronix.de
I rebased on top of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git's
driver-core-next where Greg already applied one of the patches.

Patch #1 has an updated commit log, the other three patches are
unmodified.

There are no interdependencies between these patches apart from the two
zorro patches. So the patches can also be taken independently by their
respective maintainers.

Uwe Kleine-König (4):
  nubus: Simplify check in remove callback
  sh: superhyway: Simplify check in remove callback
  zorro: Simplify remove callback
  zorro: Drop useless (and hardly used) .driver member in struct
    zorro_dev

 drivers/nubus/bus.c                |  2 +-
 drivers/sh/superhyway/superhyway.c |  2 +-
 drivers/zorro/zorro-driver.c       | 13 ++++---------
 include/linux/zorro.h              |  1 -
 4 files changed, 6 insertions(+), 12 deletions(-)


base-commit: b2c943e52705b211d1aa0633c9196150cf30be47
-- 
2.30.2

