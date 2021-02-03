Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE17C433E0
	for <linux-sh@archiver.kernel.org>; Wed,  3 Feb 2021 15:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4830264F8C
	for <linux-sh@archiver.kernel.org>; Wed,  3 Feb 2021 15:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhBCP0W (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhBCP0U (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 Feb 2021 10:26:20 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A23C0613D6;
        Wed,  3 Feb 2021 07:25:38 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id h16so16686380qth.11;
        Wed, 03 Feb 2021 07:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWUu8TQWR/FVJN1QtA9XEHxUBZiX9CVxwsUiUtU9XBU=;
        b=ZmuIEjSDLiWkKN0ydU44pkP+rvcy2TK/o2M/xlcuZc/NPWfSUhqVdR1obr5bJ6KtCz
         bwdwKq+K0zbKzJftY7aRxtRsNEKCQgdOxphL5+hrDB21OxF17DS+cy3U0lGFF4q1yjoy
         Ug2Kk8/lRZPTjujvas3xiKc3SZ2Lf1aWl6JTcam8r1ohpjqcInqilbNfzWyVHGkPBznC
         r6Dd0DHqu0ILQUsuzCdimSC+73b3lFrVW8UJcJ+ysHeyIJRqquUZTKAdSKvMxjtHVx2o
         AH8sWmXEZ413upq7gSOCr+W5UhpgpM4eGfhxG7fXUtcx7UZ9zF78Y5GnX3lvbkN1VmOB
         Ci0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWUu8TQWR/FVJN1QtA9XEHxUBZiX9CVxwsUiUtU9XBU=;
        b=nYexjGaE6SIln7B4cNvkmDtgaFi2ZQ3xAwHKZezdxGIIWR7IXoqxmytCzu+Yk3G82J
         xKYJ5OnDRQY1vdTSXMtG/pB2w6qbsoTrnONBLRSTO58CXp8gfxcVQO4wYkryjDr4chi7
         g4deosWrhIcHCAJewYsFh+BY3a+mDBMZG4TYExkUFvM0+YxFKbgIMkOcWkagurGLWLdI
         woDlX5KgOQ5XedLPtqvBucNS5m8pyHSH/Yvad3RbySVInLH3hjnjPpOgueKFPdJNll0S
         04wAXeKkEHnc10HnyHRDdMv0LAVeaaITCp4DUnMwA45uOqOu1/bCxjTP58Yq8Oy1l+y4
         Lj8w==
X-Gm-Message-State: AOAM533pzFjzSCdxe7eZxbSlvjHzZJbSF6UuHGQZXdObWHpNdwYFPo1C
        CrELcYHb/5kXohlwmbfaZWy1l+wOhJMtrLdg
X-Google-Smtp-Source: ABdhPJzHRjwS3ez2QV3mK+M28cjiWptoPjo4CLIt5LzWVtS63fBqj9CeoihdEhg9C2g+rbgg1VWsYg==
X-Received: by 2002:ac8:5a01:: with SMTP id n1mr2885885qta.107.1612365937656;
        Wed, 03 Feb 2021 07:25:37 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.139])
        by smtp.gmail.com with ESMTPSA id f14sm1814960qkl.76.2021.02.03.07.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:25:36 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: sh: kernel: Change to correct spelling archtecture to architecture in the file relocate_kernel.S
Date:   Wed,  3 Feb 2021 20:55:21 +0530
Message-Id: <20210203152521.16776-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/sh/kernel/relocate_kernel.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/relocate_kernel.S b/arch/sh/kernel/relocate_kernel.S
index d9bf2b727b42..deda2f60a8f2 100644
--- a/arch/sh/kernel/relocate_kernel.S
+++ b/arch/sh/kernel/relocate_kernel.S
@@ -3,7 +3,7 @@
  * relocate_kernel.S - put the kernel image in place to boot
  * 2005.9.17 kogiidena@eggplant.ddo.jp
  *
- * LANDISK/sh4 is supported. Maybe, SH archtecture works well.
+ * LANDISK/sh4 is supported. Maybe, SH architecture works well.
  *
  * 2009-03-18 Magnus Damm - Added Kexec Jump support
  */
--
2.26.2

