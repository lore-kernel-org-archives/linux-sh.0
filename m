Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB9AC61DA3
	for <linux-sh@archiver.kernel.org>; Tue, 21 Feb 2023 03:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjBUDKN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 20 Feb 2023 22:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjBUDKN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 20 Feb 2023 22:10:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6478D1B54B;
        Mon, 20 Feb 2023 19:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=d7owKD5YNPulKIvWy2j12yemtBDAs6ol9u/mp2Pf/xA=; b=fzOl0e0fhhSYl6f8VugbOxcD5r
        r3+1P9sRoaOzO9+qlyiRxD8kolUL+896nFzmLphbkRzaNcD0U5I04khFQiCqTeldR2TbhWdgu5pCz
        aAtwEjundmc76PZFEw1Mru7Yj4VxfmnAo1Qw7Euqg3jCXgH0nMMYMXQkYmbfs6mRxdrGeJRMJ+0P3
        mDAFjjQn8kRWxU9fBGZMtEcFgxL9FmJMdEeCLhHljPHQNcU9KmKFL1hL5K8H9OMMonheVJl7KwR9V
        5cTuMdoSwy9AJmOaBGPo6Sol7xU+HfG0rx27/TaKbYC4zpsP/mXFJzB/aYPsyNsfP1GVLGvVz1X3P
        NItzNc0A==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUJ2c-006PM7-1J; Tue, 21 Feb 2023 03:10:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Subject: [PATCH] sh: SH2007: drop the bad URL info
Date:   Mon, 20 Feb 2023 19:10:04 -0800
Message-Id: <20230221031004.18910-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

This URL provided is no longer functional, so drop it.

Fixes: 3a598264436e ("sh: SH-2007 board support.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/boards/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff -- a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -358,7 +358,6 @@ config SH_SH2007
 	  intended for embedded applications.
 	  It has an Ethernet interface (SMC9118), direct connected
 	  Compact Flash socket, two serial ports and PC-104 bus.
-	  More information at <http://sh2000.sh-linux.org>.
 
 config SH_APSH4A3A
 	bool "AP-SH4A-3A"
