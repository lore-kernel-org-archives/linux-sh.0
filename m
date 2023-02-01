Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A465AC636CD
	for <linux-sh@archiver.kernel.org>; Wed,  1 Feb 2023 12:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBAM4x (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBAM4v (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 1 Feb 2023 07:56:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37844C33;
        Wed,  1 Feb 2023 04:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD2B8B82164;
        Wed,  1 Feb 2023 12:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB208C433D2;
        Wed,  1 Feb 2023 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675256207;
        bh=cM5MtNWV+d8D8YxWSV+fcLmFAHndu+7kCKP50Gsy+Ss=;
        h=From:To:Cc:Subject:Date:From;
        b=uCeFZDpARJQWvcjjupzg/14o9OvKZi6lO7FQOa/K9+V8nBiCcwhp0s9H/SoiKad8F
         IPV0TNrP6u9MytuFndp0C22da+OuubwgClRYpDPAQKfgv/HaOf4Do1ZyzlgKEepsWC
         IwFkjnnPaDtZi/ROHrcQM6jmimdTl8MX4ov2TPxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] maple: remove unneeded maple_bus_uevent() callback.
Date:   Wed,  1 Feb 2023 13:56:42 +0100
Message-Id: <20230201125642.624255-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; i=gregkh@linuxfoundation.org; h=from:subject; bh=cM5MtNWV+d8D8YxWSV+fcLmFAHndu+7kCKP50Gsy+Ss=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3EjsEH1sfFFzeVc/LcDOwRG+J7butvl8rzTyWP130Y+qO bf4hHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRnPMMc2W0dWPrr5df1inbtumDj8 H2J69bmxkWNF651Z5l7F/14jXz2fuHTiQsMbi+HwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The driver core recently changed the uevent bus callback to take a const
pointer, and the maple_bus_uevent() was not correctly fixed up.  Instead
of fixing the function parameter types, just remove the callback
entirely as it does not do anything, so it is not necessary.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 2a81ada32f0e ("driver core: make struct bus_type.uevent() take a const *")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
sh maintainers, I'll take this through my tree as that's where the
offending commit is that causes the build breakage.

 drivers/sh/maple/maple.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index e24e220e56ee..e05473c5c267 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -760,12 +760,6 @@ static int maple_match_bus_driver(struct device *devptr,
 	return 0;
 }
 
-static int maple_bus_uevent(struct device *dev,
-			    struct kobj_uevent_env *env)
-{
-	return 0;
-}
-
 static void maple_bus_release(struct device *dev)
 {
 }
@@ -782,7 +776,6 @@ static struct maple_driver maple_unsupported_device = {
 struct bus_type maple_bus_type = {
 	.name = "maple",
 	.match = maple_match_bus_driver,
-	.uevent = maple_bus_uevent,
 };
 EXPORT_SYMBOL_GPL(maple_bus_type);
 
-- 
2.39.1

