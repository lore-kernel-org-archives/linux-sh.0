Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF2C4361B
	for <linux-sh@archiver.kernel.org>; Thu, 10 Dec 2020 06:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342D022D02
	for <linux-sh@archiver.kernel.org>; Thu, 10 Dec 2020 06:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgLJGuv (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbgLJGuu (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 10 Dec 2020 01:50:50 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E24DC0613CF;
        Wed,  9 Dec 2020 22:50:10 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so3285652pgg.13;
        Wed, 09 Dec 2020 22:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k90lU5MzDzOvBvgIqg5sOl2XQp7To9eM40VLuqnHb9U=;
        b=BYO8V+E21HxPZIVpjjF0hPz0LkMPiIOtdY908V/YUOzQqKfaGyHPahZDwGFP61nxBb
         DOZhb5IgPGIhBZ+w8L6xROpnKP05rmij4YdzSLykNJwMZvA1K//9WnwggBYUnDbUK62h
         vXmPWjzDYz6ULAkCXzgTlxUGzBnReNBZZHAoKTWohduZYhAT3C7LDNH9mB+28XTFOmYd
         QCJokhwoOF5R0ieVmIgu3uj0Uc6hQpCy9Bh9HzyY/P27QIi61WtFnjuhZ/rdDPGUt8MJ
         yivFKQcSbFVXe8npOHdcKNsINc2zSuJGdg0QapXTNU/ohweMCfbvyLgAUNQB9QpGvTyr
         Np5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k90lU5MzDzOvBvgIqg5sOl2XQp7To9eM40VLuqnHb9U=;
        b=oe/UHWOuFipgEDRG5Lu6Q21hU+ovFKB74mBIVBiJmJLR6J+ihNPA/JdZBw2texO1cf
         Jwle1tFpLbY0bGtata+0Ghiy4h9npqP5BcBttLqYuaKj4UzVVlbFzIiSID0NbU77+crl
         6dcPO7IHdINPf12YiLmednItM4FaOMSGHW2pUMd0Y6DcSUDi4mKxeN9p7bHeFEQXfKSJ
         +EG5BLfCjsSMX8iG8kH52UvJoroigKFpp4ojQr/DWyg+aN4E1n+zVIXznRVgeUCnhJ2q
         TOZyRmV/5iObqprjYNr1hiasrRAN6EZpECgXGkiDQfVoR/YEEOgZGENUdkIF1mAcbWJ1
         V/iA==
X-Gm-Message-State: AOAM532k1nqrkvmmx4DpK37eH5eCnbEOgTxIq374HO6MlGhLbwm99vFj
        0OsB7AI1cvOhZETVhaJ6n6zufuSeric=
X-Google-Smtp-Source: ABdhPJyE4O/JwfyqisgnapywYS5mMB9cDM3XIK6asuCE7Ld1MOKY55smf4EoOYkOs1SY00+FgODg3Q==
X-Received: by 2002:a65:4544:: with SMTP id x4mr5521631pgr.183.1607583010285;
        Wed, 09 Dec 2020 22:50:10 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id u3sm5096514pfu.47.2020.12.09.22.50.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 22:50:09 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     yejune.deng@gmail.com, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: kdump: add some attribute to function
Date:   Thu, 10 Dec 2020 14:49:58 +0800
Message-Id: <1607582998-13098-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

add '__iomem' for ioremap() and '__user' for copy_to_user().

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 arch/sh/kernel/crash_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
index a908612..5b41b59 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -26,7 +26,7 @@
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
                                size_t csize, unsigned long offset, int userbuf)
 {
-	void  *vaddr;
+	void  __iomem *vaddr;
 
 	if (!csize)
 		return 0;
@@ -34,7 +34,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
 
 	if (userbuf) {
-		if (copy_to_user(buf, (vaddr + offset), csize)) {
+		if (copy_to_user((void __user *)buf, (vaddr + offset), csize)) {
 			iounmap(vaddr);
 			return -EFAULT;
 		}
-- 
1.9.1

