Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA70EC77B61
	for <linux-sh@archiver.kernel.org>; Fri, 28 Apr 2023 00:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbjD1Au6 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 27 Apr 2023 20:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbjD1Au5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 27 Apr 2023 20:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C5340DB;
        Thu, 27 Apr 2023 17:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E6916409A;
        Fri, 28 Apr 2023 00:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEE62C433EF;
        Fri, 28 Apr 2023 00:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682643055;
        bh=kPHHvsN4zl+1kkKbcWKddFCwf8k3VVH0IxthkflkTEo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NH+/XQxrQuqyApsT0OTgtHXbw7FtBeATGYqLqvvBcJFWHx2Zg/vU7NVTH5tKWefmg
         K6phdgBH12h6h6GCeQVEjKAH1uGvsip72QXXF5HPG1OeLVCyBy6tcnenSTRNomK2cZ
         v0vaMVCG2CGc20NpyclCBAIwovAfteDWqcp7zVkr/7Da84ELVD62igW69C7lyQG8+w
         hgtOf/4YFkXNMueSUfaGpnc/hIcdqIMLUfqN46DkJ9UV2tIOXO77uOySXIxwYNvPxB
         cnKhQ30h3kQmd17keCLqLZbSIhB1guuhhw1ezDM6Z0q3g6UJQz2V+m4+8E6fyOzm3g
         GXh5glTTUGm4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC468E5FFC8;
        Fri, 28 Apr 2023 00:50:55 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7ba5e47fd342b596937022a207ea630ab692a8a9.camel@physik.fu-berlin.de>
References: <7ba5e47fd342b596937022a207ea630ab692a8a9.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7ba5e47fd342b596937022a207ea630ab692a8a9.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.4-tag1
X-PR-Tracked-Commit-Id: e5c23bec0f121b4160dc8ca61e751e734652bd05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 513f17f8d6b67563d977c730d50bc0db6ea6e1b0
Message-Id: <168264305576.17833.12394640784363981694.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 00:50:55 +0000
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 11:30:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.4-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/513f17f8d6b67563d977c730d50bc0db6ea6e1b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
