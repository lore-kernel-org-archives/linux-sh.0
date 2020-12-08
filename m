Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C007C1B0E3
	for <linux-sh@archiver.kernel.org>; Tue,  8 Dec 2020 18:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E23823B51
	for <linux-sh@archiver.kernel.org>; Tue,  8 Dec 2020 18:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgLHSWE (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 8 Dec 2020 13:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgLHSWE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 8 Dec 2020 13:22:04 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B8AC061749
        for <linux-sh@vger.kernel.org>; Tue,  8 Dec 2020 10:21:24 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id f11so8869982ljm.8
        for <linux-sh@vger.kernel.org>; Tue, 08 Dec 2020 10:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0k84cTJrPrOsfvGsmPwU8to4k4bv8pA/cUAkq67lZ4=;
        b=AC5YoYGqbL0xyIdm7w/CqruuyDH5jOztpfPYHMJIDZlchb0MGpTJJZxi6R9nJOTIC9
         qp+RQtAhVh4tnggDjFLw1wtS0vd+uQIRW62L4TXWzGJim8b1m+UaubDNNVA9+LCpl951
         lBvUDkdtm/0HK/VbWOPNHgh35sw1ivR+Ul2tivGESiWnTgQ+YbfeGDfs0UtvIWdHqOQC
         fx05AGTiNgTzgn6KJYEE+bWwtqVxce77FmJ5uKbeSDQehUwuX0ID/DJ4Bgy6J38fW7Tx
         kdGliwxMnh+3sONHiT1DETkgQsP5F5YBh2f0O/sikn0pS8Em18udaSqCAPDOOmwGfE+U
         KSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=C0k84cTJrPrOsfvGsmPwU8to4k4bv8pA/cUAkq67lZ4=;
        b=eUPhenPTKNiMsVeu/yDdJM1gcynrrszlwIw7EizglqESkPFv+UBCpzEivXFCUicXpT
         NFPd1pA4rTRRhJ9hi4L6NadEu6MFf8p1jHR+C/pteKOuvkRIQmJZVyCOT5NG8SicmUnJ
         sF7cs3M5fdZFfAgfeA7/7q7GpzNxV3CPgflo6Hdp5ss62neInv4BtxfKP+uDpbwRGrsy
         AFGdPSEr0MVWB3c2A1G0veiImHFkPS0qmz/RLWR7LGqrjMLRto+ZGqh5LxErQ2dv/hsp
         pIZdaUcBAHdd9xZbZR85so4RiexDDriaENtitR11EPaMTnO6pG9/Xc4ds4xYuqoQh0U0
         0Hvg==
X-Gm-Message-State: AOAM531gVKiUHdD0kBAfCBcxP51yvK04/ZsC0fAMk+EGs5qGeYSd0gGp
        eLOPzaHOoCgpFqMEq+qH++Y=
X-Google-Smtp-Source: ABdhPJwDbu5R1+AZBzoVB8RnJPphmbbskhgVjPL2+zvZ4NdGdPJScB54B5k3svF8l/dl1LwVBbYJEA==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr11660073ljg.27.1607451682463;
        Tue, 08 Dec 2020 10:21:22 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:ebc8:8af6:c516:9561])
        by smtp.gmail.com with ESMTPSA id w2sm3342859lfe.40.2020.12.08.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:21:21 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/1] sh: W=1 warning fixes in fbdev
Date:   Tue,  8 Dec 2020 19:21:16 +0100
Message-Id: <20201208182117.163642-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

In certain configurations the current definition of iounmap()
caused set-but-not-used warnings.

This is fixed by casting the input parameter with (void).

The sole patch included here was a part of a larger video/fbdev/
set of patches.  This explains the "v4" tag.

Yoshinori san and Rich - please apply to the sh tree.

	Sam

Sam Ravnborg (1):
      sh: Fix set but not used warnings with !CONFIG_MMU

 arch/sh/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


