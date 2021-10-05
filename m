Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD096C433F5
	for <linux-sh@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8635C61247
	for <linux-sh@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhJEAVG (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 4 Oct 2021 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEAVG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 4 Oct 2021 20:21:06 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2682C061745;
        Mon,  4 Oct 2021 17:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Nx9dzRig5sSUf5J2therKTnXqFBT45soGJ2fpWnEjHY=; b=zlxAttcrxIAgfDktq3NAYoXxRP
        A962qyZ5l0K0ps0DFPrB5Y28kaz+iOdAjHgd/Rg9mynXPbgNA+2Z2Dprw0fjuz2SuJaftv4sLWJ9T
        LoGmkLEvOyUp3vB4NOdDh4y/YQ+nh/kZqsdQ0eOtabCOvn5Ie7N8jkRUCdoZnZK5p3QxAeGQODV7g
        8Mq0/yKgcZI5ClbOVxlRqalC2Dpx+xj2K3ufICPdsW1iwuibfEchn7cuGTvSrTdXblaIJa9IPGeqL
        /7M8vlz78MuYovgishrs0UlbpEW4mIv7Pw/6/kTsYbj6VA2K9Q367INpcEIilUf1+Y6fW0VVrkBVl
        reT/efnw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXYAs-008SGi-Ti; Tue, 05 Oct 2021 00:19:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/5 v3] sh: fixes for various build and kconfig warnings
Date:   Mon,  4 Oct 2021 17:19:09 -0700
Message-Id: <20211005001914.28574-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Fix a few build warnings and one kconfig warning on SUPERH.

v3: add some Tested-by: and Reviewed-by:
    add 2 more patches
    renumber, rebase, and resend

v2: add a previously-sent Kconfig patch
    add a few more Cc's

 [PATCH 1/5 v3] sh: fix kconfig unmet dependency warning for FRAME_POINTER
 [PATCH 2/5 v3] sh: add git tree to MAINTAINERS
 [PATCH 3/5 v3] sh: math-emu: drop unused functions
 [PATCH 4/5 v3] sh: define __BIG_ENDIAN for math-emu
 [PATCH 5/5 v3] sh: fix READ/WRITE redefinition warnings

 MAINTAINERS                       |    1 
 arch/sh/Kconfig.debug             |    1 
 arch/sh/include/asm/sfp-machine.h |    8 +
 arch/sh/math-emu/math.c           |  147 ++++------------------------
 4 files changed, 32 insertions(+), 125 deletions(-)

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
