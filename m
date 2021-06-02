Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E27FC4708F
	for <linux-sh@archiver.kernel.org>; Wed,  2 Jun 2021 23:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BC4613E9
	for <linux-sh@archiver.kernel.org>; Wed,  2 Jun 2021 23:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFBXQa (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 2 Jun 2021 19:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFBXQa (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 2 Jun 2021 19:16:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B3DC061756;
        Wed,  2 Jun 2021 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=iMYHPfxhqjuRpDflG9IVpKwulTFrTouXC10oTDpgEso=; b=FWemzFjsnZnyBq9L1v7yuoCKgG
        pA6aiH09ehNICgouz+eF4/oXtL3jqCvfz/NsHVGU585rLZET+kULl/dSfLSh1IxJO5pfyACA2/o32
        5IHl8iXm87MHtOl1p3yEXg8KHA/dF6qLNmZi7mblLACLGbvFE4PuSRGOgDg/f4SjTLN0QkB2HXCff
        FeHqTT7DH4ohB04EhkdZvnRZqrzCdl/ISsLHpClHop8Ha+7va9NcjSnDAo9+vzr91WVzZu6IdKZPQ
        pLj/R0+b89RXUxS27UImZy2+eUdaj26bhBtLI1EXs9YmnrBajtvRXc4ANP0ZHZ75mGqrdsI0NETKB
        Jf+8WblA==;
Received: from [2601:1c0:6280:3f0::ce7d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loa4T-006Rln-EL; Wed, 02 Jun 2021 23:14:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 0/3] sh: fixes for various build warnings
Date:   Wed,  2 Jun 2021 16:14:40 -0700
Message-Id: <20210602231443.4670-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Fix a few build warnings on SUPERH.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org

[PATCH 1/3] sh: convert xchg() to a statement expression
[RFC PATCH 2/3] sh: define __BIG_ENDIAN for math-emu
[PATCH 3/3] sh: fix READ/WRITE redefinition warnings

 arch/sh/include/asm/cmpxchg.h |    2 -
 arch/sh/math-emu/math.c       |   44 ++++++++++++++++----------------
 arch/sh/math-emu/sfp-util.h   |    2 -
 3 files changed, 24 insertions(+), 24 deletions(-)
