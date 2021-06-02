Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681F3C47083
	for <linux-sh@archiver.kernel.org>; Wed,  2 Jun 2021 23:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4925C61057
	for <linux-sh@archiver.kernel.org>; Wed,  2 Jun 2021 23:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFBXQb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 2 Jun 2021 19:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFBXQa (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 2 Jun 2021 19:16:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516CFC06174A;
        Wed,  2 Jun 2021 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+Z2iQYoHcJ27W7xRyN7L68l/ztKMEA8mYKYCaCL+K58=; b=K6u/pIecNJ1M3HnClPy8gjeS+N
        PWj5JBgkMj7oPADtRL+alHjFpVIKm0N+xkeUgDnJB/j8QrG5YEq67HltKObCvDKnXWkR/wVkNMVZB
        4/qCX8WltZTdxCVMVzr/XV1nstgFNLeiKidBpTWc9WXtBQ8ytQxtTqJEkzvOTCaQbbrLE269vBeJO
        5dZyoMjW9WmwXYCUb9yhMoEDRFf0aptG9seFviC4xLg60o3s1M6bETWWn2pRkiMm2nRxC1B2RrzS4
        iEY4WY/8iig4HPSmEeD3DnTWgn4Fh9igmYst/izqeUbIt6/fJKkjResv96XS38UUU5Ozd3ZwV++O8
        CG9egyXw==;
Received: from [2601:1c0:6280:3f0::ce7d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loa4T-006Rln-Pw; Wed, 02 Jun 2021 23:14:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 1/4] sh: convert xchg() to a statement expression
Date:   Wed,  2 Jun 2021 16:14:41 -0700
Message-Id: <20210602231443.4670-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210602231443.4670-1-rdunlap@infradead.org>
References: <20210602231443.4670-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Use a GCC statement expression (extension) for xchg(), as is done
in other arches.

Fixes this build warning:

../fs/ocfs2/file.c: In function 'ocfs2_file_write_iter':
../arch/sh/include/asm/cmpxchg.h:49:3: warning: value computed is not used [-Wunused-value]
   49 |  ((__typeof__(*(ptr)))__xchg((ptr),(unsigned long)(x), sizeof(*(ptr))))

Fixes: e839ca528718 ("Disintegrate asm/system.h for SH")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
---
This is similar to a patch from Arnd for m68k:
  https://lore.kernel.org/linux-m68k/20201008123429.1133896-1-arnd@arndb.de/

 arch/sh/include/asm/cmpxchg.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210528.orig/arch/sh/include/asm/cmpxchg.h
+++ linux-next-20210528/arch/sh/include/asm/cmpxchg.h
@@ -46,7 +46,7 @@ extern void __xchg_called_with_bad_point
 })
 
 #define xchg(ptr,x)	\
-	((__typeof__(*(ptr)))__xchg((ptr),(unsigned long)(x), sizeof(*(ptr))))
+	({(__typeof__(*(ptr)))__xchg((ptr),(unsigned long)(x), sizeof(*(ptr)));})
 
 /* This function doesn't exist, so you'll get a linker error
  * if something tries to do an invalid cmpxchg(). */
