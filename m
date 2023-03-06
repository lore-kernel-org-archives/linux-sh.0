Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A4DC6FA9E
	for <linux-sh@archiver.kernel.org>; Mon,  6 Mar 2023 04:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCFEAs (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 5 Mar 2023 23:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCFEAp (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 5 Mar 2023 23:00:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409CF962;
        Sun,  5 Mar 2023 20:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WgyXM7Qo3viihserObDO4DAWeU3lIl1inofxTIVc+4I=; b=sLHdFy4WxAhVNW1qn8Tqz/mfZx
        EjfOu5z0GJrrCgy+lXG1pdjvHCSOdl0REBoLuRxbcs5q0hbpogg6e0s1RfznWmvsNTymj4d2ncbJ9
        WjaQrOJJyYZpH/jrRrKSlhIPCWhQoDgBG7MaVfJ01cLErJK4CawuAXz7/xVfIYRdvtrr7VuZ5I7rk
        x2DOe5aFqqcVlHDqUnG0BJei+qIrY6seGHjq5nLOB3lAK7LRZH5b1OxiNr3oyYyciyDKbZ0ltXAoi
        QRNxtvMOeSEU4M/lNK7mHrpyBwwt3pq8/XGqr04nZOpikMuikxgzQnvDyQk/VeEdZyerMIGW0G+Hz
        JC9H9TsA==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZ21f-00B9yD-FR; Mon, 06 Mar 2023 04:00:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCH 1/7 v4] sh: SH2007: drop the bad URL info
Date:   Sun,  5 Mar 2023 20:00:31 -0800
Message-Id: <20230306040037.20350-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306040037.20350-1-rdunlap@infradead.org>
References: <20230306040037.20350-1-rdunlap@infradead.org>
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
Cc: linux-sh@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2: skipped
v3: skipped
v4: refresh/rebase and resend

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
