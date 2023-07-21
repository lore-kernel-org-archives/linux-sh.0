Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87824EB64DA
	for <linux-sh@archiver.kernel.org>; Fri, 21 Jul 2023 01:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjGUBOz (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 20 Jul 2023 21:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGUBOy (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 20 Jul 2023 21:14:54 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18255CC
        for <linux-sh@vger.kernel.org>; Thu, 20 Jul 2023 18:14:51 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6Wn45HWgzBRDt6
        for <linux-sh@vger.kernel.org>; Fri, 21 Jul 2023 09:14:48 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1689902088; x=
        1692494089; bh=prNsw1hEDDMkz5G7L9nWB6cVQC30jTEoax0cTGsEIQY=; b=V
        nK35vQpn42Nst+lwFPczzw1czFVwyBXDHXf8VdiTmrkP3rNuSXqC7T2eNu3eStzw
        mVnTtfH8U7jdlYTYhnT88r3mvEdHPF6pEqs1jAv8DsPXgxlErQz7yMErjrPm3Grs
        gwQpufq9PNk/TP9upcIfpLwf46jTkBx7pGSsAt0BZB6sqyIjJy844mn+pW6h/I8A
        c8TbcblOu+gua8b20ey4rRYXMULNaACHreG2cg41AJ0uv46SbX0hDNbgiQFSLwmg
        ESsRXADQSHvpzffFLzNFyZ8YFjtwvqhsRM5Fy863wcqrQjP3/yqUNC/p2jmfrrW3
        hVcfKV414tCd25m+nQdcA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 34uuvwp25A58 for <linux-sh@vger.kernel.org>;
        Fri, 21 Jul 2023 09:14:48 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6Wn43TFxzBJkk9;
        Fri, 21 Jul 2023 09:14:48 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 09:14:48 +0800
From:   zhangyongle001@208suo.com
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: boards: ERROR: that open brace { should be on the
 previous line
User-Agent: Roundcube Webmail
Message-ID: <6abe5f4bb1a7b0373c13ae53ffbc8d1e@208suo.com>
X-Sender: zhangyongle001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Fix the following checkpatch error:
ERROR: that open brace { should be on the previous line

Signed-off-by: zhangyongle <zhangyongle001@208suo.com>
---
  arch/sh/boards/board-sh7757lcr.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c 
b/arch/sh/boards/board-sh7757lcr.c
index f39c8196efdf..f8862f8afc2d 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -191,8 +191,7 @@ static struct platform_device 
sh7757_eth_giga1_device = {
  };

  /* Fixed 3.3V regulator to be used by SDHI0, MMCIF */
-static struct regulator_consumer_supply fixed3v3_power_consumers[] =
-{
+static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
  	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
  	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
  	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
-- 
2.40.1

