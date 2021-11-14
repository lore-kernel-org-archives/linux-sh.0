Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48933C433EF
	for <linux-sh@archiver.kernel.org>; Sun, 14 Nov 2021 19:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F4461177
	for <linux-sh@archiver.kernel.org>; Sun, 14 Nov 2021 19:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhKNT70 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 14 Nov 2021 14:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233916AbhKNT70 (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Sun, 14 Nov 2021 14:59:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1D55E6112E;
        Sun, 14 Nov 2021 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636919786;
        bh=RWMa0mbgQ/y4ZWCE7akp0t7p8q+43ZK+EArSlQqCEfc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V3UbGUtM7JP5fWfUtiSAnIjkjxjUuH5bCTC1kWL/E3/xmqgalFpF84a1VK4WIfdJB
         wMN1dHhzyw7rxiAkpZZ0KBvdlNHVTGJ3RlKkUrDK0n8NvuEX/rASrXHKAsSjEy2cBg
         zhJeYDDxsYvsgGNkftd3tgemiM56L0LogkhdQ0ejxOrM3Nc6lt8Uerx+6D779ms4UH
         +ISBwqmdTFrWetyLMz6QwJZJiQ95MrbMXnfr00paCJ17iN4HXh1WkHUKuHIEW782Sg
         mhAw2PkYkth2KUDuQcvJXtz0bP3YUBuTBhT7TItUValmQ1qPQN5Fhc9ddjTD188mld
         zt7OVmr/DjhlA==
Subject: Re: [PULL] arch/sh updates for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211114185302.GA13363@brightrain.aerifal.cx>
References: <20211114185302.GA13363@brightrain.aerifal.cx>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211114185302.GA13363@brightrain.aerifal.cx>
X-PR-Tracked-Remote: git://git.libc.org/linux-sh tags/sh-for-5.16
X-PR-Tracked-Commit-Id: 8518e694203d0bfd202ea4a80356785b6992322e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24318ae80d1705acc50f0d70ece543345336a6e1
Message-Id: <163691978608.22669.3984782290572659640.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 19:56:26 +0000
To:     Rich Felker <dalias@libc.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The pull request you sent on Sun, 14 Nov 2021 13:53:04 -0500:

> git://git.libc.org/linux-sh tags/sh-for-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24318ae80d1705acc50f0d70ece543345336a6e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
