Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007A6C433F5
	for <linux-sh@archiver.kernel.org>; Tue, 21 Sep 2021 12:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D102160F0F
	for <linux-sh@archiver.kernel.org>; Tue, 21 Sep 2021 12:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhIUMed (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 21 Sep 2021 08:34:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56006 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhIUMec (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 21 Sep 2021 08:34:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B644D22113;
        Tue, 21 Sep 2021 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632227582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHYjB+PylponO9o3SOyjJk7Ga4SEkTKyJ/ThM4qiWO8=;
        b=XnKlOhrb1DP7in/DcBC+5HImoKYcpvy/Rlz9IMaeQ+IWjzo7fXUdJZn84bBc2adMHD5EkZ
        4H3OCK+CEjxyxxLK28ylUncFXgIUS1t/qjr4Cnmc8jOBJjYDWwBeEjwHNyMqLFMo+Yk02L
        Nq4UWodnw6FRfn1W4EEsl6t6LmkzjQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632227582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHYjB+PylponO9o3SOyjJk7Ga4SEkTKyJ/ThM4qiWO8=;
        b=wmhPEEBO/+QmAG2MzcQc1bcfrMpKA4YSM9IWxWxJoDhXuOMIOWt9OEqltpqdVQhW3x4kYu
        l7JQ/fDY8reHtbAw==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 203F8A3BA0;
        Tue, 21 Sep 2021 12:33:01 +0000 (UTC)
Date:   Tue, 21 Sep 2021 13:32:58 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Gon Solo <gonsolo@gmail.com>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Move node_reclaim_distance to fix NUMA without
 SMP
Message-ID: <20210921123258.GE3891@suse.de>
References: <cover.1631781495.git.geert+renesas@glider.be>
 <6432666a648dde85635341e6c918cee97c97d264.1631781495.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <6432666a648dde85635341e6c918cee97c97d264.1631781495.git.geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Sep 16, 2021 at 10:42:42AM +0200, Geert Uytterhoeven wrote:
> If CONFIG_NUMA=y, but CONFIG_SMP=n (e.g. sh/migor_defconfig):
> 
>     sh4-linux-gnu-ld: mm/page_alloc.o: in function `get_page_from_freelist':
>     page_alloc.c:(.text+0x2c24): undefined reference to `node_reclaim_distance'
> 
> Fix this by moving the declaration of node_reclaim_distance from an
> SMP-only to a generic file.
> 
> Fixes: a55c7454a8c887b2 ("sched/topology: Improve load balancing on AMD EPYC systems")
> Suggested-by: Matt Fleming <matt@codeblueprint.co.uk>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
