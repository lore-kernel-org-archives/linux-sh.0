Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6685C433DB
	for <linux-sh@archiver.kernel.org>; Sat, 23 Jan 2021 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB0123139
	for <linux-sh@archiver.kernel.org>; Sat, 23 Jan 2021 17:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbhAWRdl (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 23 Jan 2021 12:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbhAWRdX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 23 Jan 2021 12:33:23 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BD7C061788;
        Sat, 23 Jan 2021 09:32:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kg20so11694123ejc.4;
        Sat, 23 Jan 2021 09:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8uPnzNnV4HKAWjbVOjlMDzt9NKZMgpM4gy8WEBWy5EI=;
        b=kvinLGSmLypbvCVFZbq/COJAG4aJel7Fmhc9E2tjYNrQVi7triPQvzel7bipffGmNt
         7SKMZdvVavuSQbnSpYBR2+ZJIRlboD1Ke89zq+9UJgv9tLfgj2Ok6rxy+CrbE5PXPFiO
         cm0VMcdOQeeMD5fifThPCTwJ8PyEvMNnO6E3gtJXogin6eKTRIOu3/8bim967HKy+sxa
         2MFb7Ouoq9NqU+gfYCALA9mxgwYXJRIzY6QVpky49qJyBrR65x0B6csT/K7urzkc175Q
         bqKRXkuqAWpACz7bZ5dPQL2cxob+dYTehrfCENEwUDk8TXZXEUKxpJlR6x+I06bIIsjR
         fk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8uPnzNnV4HKAWjbVOjlMDzt9NKZMgpM4gy8WEBWy5EI=;
        b=egNtt4UBS5Pj8gdKocDBbjJ4kec423AWRwmLdE58l+HUAooTmDBhRHjarT3s2uB0im
         YHofS1TZnC71eydEhmlH90UT8NhXkMT/yix2U4EQ+gzoFGRJ8baeivJsrCc8acImjVdq
         zJXf5DSJd9qeH1+q37YEHCQSS37oVKg6o5FIjhYa04+BIe6ATUnpKDnoXeMUYixrpt4Y
         LZ4tjR3LWp5YI0WmhK0KsMQJRYHLD44Xqdz7sMB35t2XH2nGB2SWiqo9EXxWIw3WwnBl
         x+mhCsoaqlyZZUqvfMNCbH8FHalL59m7c4bHXXprVXm7W0dsEoe/2WOwmcHYR56qbG5z
         ar0Q==
X-Gm-Message-State: AOAM532LaxPVL9H1pU48Gn5I2cJfJ+HrN1CP/N3W6qK3e46bN8mtYIl8
        JxdCqJc77RgW50iqNtCsK3m1Gsr4+y8=
X-Google-Smtp-Source: ABdhPJy1VYbIaVyf1LKMUOEmxoS0nBwtyKwfDnHPAGBNfgIO+n49H90cbBbIMXwmtbBRLh5wV6zvxQ==
X-Received: by 2002:a17:906:7e49:: with SMTP id z9mr1013876ejr.447.1611423161252;
        Sat, 23 Jan 2021 09:32:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:31ee:7e10:5e3d:6832])
        by smtp.gmail.com with ESMTPSA id i18sm7436835edr.2.2021.01.23.09.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 09:32:40 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] sh: fix sparse annotation in SH's __get_user_check()
Date:   Sat, 23 Jan 2021 18:32:37 +0100
Message-Id: <20210123173237.91670-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The pointer in get_user() and friends is supposed to be a __user pointer.
But in SH's implementation of __get_user_check(), the pointer is
assigned to a local variable __gu_addr which is lacking the __user
annotation. As consequence, a warning is issued for every of its uses.

So, add the missing __user annotation (this remove ~700 warnings when
using defconfig).

Link: https://lore.kernel.org/r/202101141753.ropIZ9nh-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/sh/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index 73f3b48d4a34..e2623fe2ac09 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -68,7 +68,7 @@ struct __large_struct { unsigned long buf[100]; };
 ({									\
 	long __gu_err = -EFAULT;					\
 	unsigned long __gu_val = 0;					\
-	const __typeof__(*(ptr)) *__gu_addr = (ptr);			\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	if (likely(access_ok(__gu_addr, (size))))		\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\

base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
-- 
2.30.0

