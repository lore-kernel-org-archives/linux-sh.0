Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C63C433FE
	for <linux-sh@archiver.kernel.org>; Tue, 21 Sep 2021 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924FA61100
	for <linux-sh@archiver.kernel.org>; Tue, 21 Sep 2021 12:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhIUMew (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 21 Sep 2021 08:34:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47432 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhIUMev (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 21 Sep 2021 08:34:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 558291FEDB;
        Tue, 21 Sep 2021 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632227602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dGhjX1N6cpuHN9JM5age1eJWWQj7mw2/HE+0xi+w5u0=;
        b=pVdylClFBGkW3WyeYifQUVuXVQ/2kPQaMspUwZ/tBz2guwht1jqWe73fpr3ZGImdp6+0Cw
        +5X72kFCo197jSQmT2L2g/dYouWsF5VbVP6gNkiSYeaOM6V1ioaA4fEJCEbcdZdPwVyagl
        KBZEzsG9go33o/Tcq5bV3582gC4RAgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632227602;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dGhjX1N6cpuHN9JM5age1eJWWQj7mw2/HE+0xi+w5u0=;
        b=AMwbQlAgp+HJ+7o2oEwCyBXim06tHvUZtgkPef/P5ZUadebTKvW8d5qUclQb/EMyqALFOE
        HBunvcRdtDVL6XAQ==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 28FBEA3B96;
        Tue, 21 Sep 2021 12:33:21 +0000 (UTC)
Date:   Tue, 21 Sep 2021 13:33:19 +0100
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
Subject: Re: [PATCH 2/2] mm: Move fold_vm_numa_events() to fix NUMA without
 SMP
Message-ID: <20210921123319.GF3891@suse.de>
References: <cover.1631781495.git.geert+renesas@glider.be>
 <9d16ccdd9ef32803d7100c84f737de6a749314fb.1631781495.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <9d16ccdd9ef32803d7100c84f737de6a749314fb.1631781495.git.geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Sep 16, 2021 at 10:42:43AM +0200, Geert Uytterhoeven wrote:
> If CONFIG_NUMA=y, but CONFIG_SMP=n (e.g. sh/migor_defconfig):
> 
>     sh4-linux-gnu-ld: mm/vmstat.o: in function `vmstat_start':
>     vmstat.c:(.text+0x97c): undefined reference to `fold_vm_numa_events'
>     sh4-linux-gnu-ld: drivers/base/node.o: in function `node_read_vmstat':
>     node.c:(.text+0x140): undefined reference to `fold_vm_numa_events'
>     sh4-linux-gnu-ld: drivers/base/node.o: in function `node_read_numastat':
>     node.c:(.text+0x1d0): undefined reference to `fold_vm_numa_events'
> 
> Fix this by moving fold_vm_numa_events() outside the SMP-only section.
> 
> Fixes: f19298b9516c1a03 ("mm/vmstat: convert NUMA statistics to basic NUMA counters")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
