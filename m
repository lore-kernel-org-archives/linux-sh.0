Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32D9C47093
	for <linux-sh@archiver.kernel.org>; Wed,  2 Jun 2021 23:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4E561057
	for <linux-sh@archiver.kernel.org>; Wed,  2 Jun 2021 23:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFBXQb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 2 Jun 2021 19:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhFBXQa (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 2 Jun 2021 19:16:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB64C06175F;
        Wed,  2 Jun 2021 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GgUHuotTSVoUtsVmMlpcVcRaJTyGQL0GcjuUunbehv4=; b=he/QsAyGU3AaG8zugrntxfbguw
        iw0IOeexu3TE+FgSyM2RlGvwqPDhj8VldNEjlrkADXNOVWnUNo29tvzePhNs5QAfGAgYykEK0rHYz
        t9ZHxgm+GmMHArIWHQ3rvQ9QLTEp1tt80WB3mPndPfX7bj1DDo4WDzpAVTKOh+rSBvFhbzf/oe7zY
        ZaKH26ovAt30wABK0gTdV6jaYoLHyHbL1EzpVeFSoGeTy75MIUtIK5prKAQQbor1P9qtR+smsoch5
        g/u82pRMm1h49ml+0B2Tn4aye75ltsQWHndmDy8YDPLUnbAbcO85GdiHg+Ym43vDTLI2WelfRw3vj
        hDwsJhfA==;
Received: from [2601:1c0:6280:3f0::ce7d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loa4U-006Rln-3s; Wed, 02 Jun 2021 23:14:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [RFC PATCH 3/4] sh: define __BIG_ENDIAN for math-emu
Date:   Wed,  2 Jun 2021 16:14:42 -0700
Message-Id: <20210602231443.4670-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210602231443.4670-1-rdunlap@infradead.org>
References: <20210602231443.4670-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The headers in include/math-emu/ test for __BYTE_ORDER == __BIG_ENDIAN
without checking to see if these macros are defined, so add
a define for __BIG_ENDIAN before pulling in these headers.

This placates these build warnings:

In file included from ../arch/sh/math-emu/math.c:23:
../include/math-emu/single.h:50:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
   50 | #if __BYTE_ORDER == __BIG_ENDIAN
In file included from ../arch/sh/math-emu/math.c:24:
../include/math-emu/double.h:59:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
   59 | #if __BYTE_ORDER == __BIG_ENDIAN

Fixes: 4b565680d163 ("sh: math-emu support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/math-emu/sfp-util.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210528.orig/arch/sh/math-emu/sfp-util.h
+++ linux-next-20210528/arch/sh/math-emu/sfp-util.h
@@ -70,4 +70,4 @@
 
 #define __BYTE_ORDER __LITTLE_ENDIAN
 
-
+#define __BIG_ENDIAN 0
