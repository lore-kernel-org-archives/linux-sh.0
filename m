Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33453C25B4E
	for <linux-sh@archiver.kernel.org>; Tue, 24 Jan 2023 19:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjAXT3c (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjAXT3b (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 24 Jan 2023 14:29:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4474DCCB
        for <linux-sh@vger.kernel.org>; Tue, 24 Jan 2023 11:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674588525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=82l5q/fLAv2sY6gv1oBW5Tvks7WDzg3jqecVI/AwJrc=;
        b=V2sBU2YMbocbsQ9NwF8LHpla/4fSZFzCdsCj+1wUnZ1PGaw6kjGjUFaK8ga4IC5b3fOcFH
        oC9e7nXqcBrjJ2B+7vOhXrYJRi9quTabXaLQ9cgDT5RZsf76mSbbnbnVps/KBC26zntj65
        aY0HEsrhpO1Pml5SakOSZSDr04hmBx4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-KkdaUTNAPRyKSC1woSj-RQ-1; Tue, 24 Jan 2023 14:28:44 -0500
X-MC-Unique: KkdaUTNAPRyKSC1woSj-RQ-1
Received: by mail-qk1-f199.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so11550822qkl.9
        for <linux-sh@vger.kernel.org>; Tue, 24 Jan 2023 11:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82l5q/fLAv2sY6gv1oBW5Tvks7WDzg3jqecVI/AwJrc=;
        b=EcGlonTBPDRX49eM4M/3rcVJgJCE1OW4+VxZOsDOOeo5prolzDxbgRMqUeR1OVsR4L
         rAtaA3eIRn6UXKy6gKeKOQ/by8VlROT2vCZWGqyhgKkbFMMuABv3G8Y3ot5EZvVdEkg4
         OYkz9SRJU47Mp81q0S4GckOCsnmLFwhKP+QQ3o5Ad6wbEWPNgiqf261KYLbSCJqYtBCY
         l0vZYmicd4zhLazg95grjekbraPTCGMAvdXHNhIuC1V5SulVQtx/rxbfSJsCnj1/ewPp
         7AXqP/conW+8zsfEVYk9KHi2C/QLnYusEmZUNvZDwphE7D1kuUyKMb00D4GICIpRmQ5w
         0FDQ==
X-Gm-Message-State: AFqh2koOeF9NHNtZytbyjcezkZCPAXZkHynmyM80ZDMWHJTJOVAMoO5V
        wte3Pe/zP8VFZvu0534RZIZB/E/xSQKqlxwiA7q0mMWfhwAdgPdiBcMEyDE+NytdvU2Ejv12WjF
        ctjr6G/lEERDOUOAYn5Y=
X-Received: by 2002:ac8:7d0a:0:b0:3b6:392d:932e with SMTP id g10-20020ac87d0a000000b003b6392d932emr58439513qtb.48.1674588523938;
        Tue, 24 Jan 2023 11:28:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuUhPqwBpUj0NYkwBWWX+y5Ee4KwG3kdB2aovqWvAs/29sB79WmSHw07CZVqmfyGnYgOHdNVw==
X-Received: by 2002:ac8:7d0a:0:b0:3b6:392d:932e with SMTP id g10-20020ac87d0a000000b003b6392d932emr58439490qtb.48.1674588523736;
        Tue, 24 Jan 2023 11:28:43 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id f1-20020ac840c1000000b003a981f7315bsm1809017qtm.44.2023.01.24.11.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:28:43 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        bgolaszewski@baylibre.com, gregkh@linuxfoundation.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] sh: fix spdx format
Date:   Tue, 24 Jan 2023 05:39:41 -0800
Message-Id: <20230124133941.632974-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

checkpatch reports
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
FILE: arch/sh/include/asm/platform_early.h:1:
+/* SPDX--License-Identifier: GPL-2.0 */

Remove extra -

Fixes: 507fd01d5333 ("drivers: move the early platform device support to arch/sh")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/sh/drivers/platform_early.c     | 2 +-
 arch/sh/include/asm/platform_early.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index 143747c45206..1c2a571a8ab8 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -1,4 +1,4 @@
-// SPDX--License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 
 #include <asm/platform_early.h>
 #include <linux/mod_devicetable.h>
diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/platform_early.h
index fc802137c37d..00b6e6dc4ac4 100644
--- a/arch/sh/include/asm/platform_early.h
+++ b/arch/sh/include/asm/platform_early.h
@@ -1,4 +1,4 @@
-/* SPDX--License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef __PLATFORM_EARLY__
 #define __PLATFORM_EARLY__
-- 
2.26.3

