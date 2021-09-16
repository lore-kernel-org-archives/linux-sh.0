Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF726C433F5
	for <linux-sh@archiver.kernel.org>; Thu, 16 Sep 2021 08:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DA161164
	for <linux-sh@archiver.kernel.org>; Thu, 16 Sep 2021 08:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhIPIoQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbhIPIoP (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 16 Sep 2021 04:44:15 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A82CC0613C1
        for <linux-sh@vger.kernel.org>; Thu, 16 Sep 2021 01:42:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:39fa:3565:945d:98f4])
        by michel.telenet-ops.be with bizsmtp
        id uYim2500T3mHZPk06YimpQ; Thu, 16 Sep 2021 10:42:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQmyk-0053tq-0b; Thu, 16 Sep 2021 10:42:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQmyj-004q6g-CF; Thu, 16 Sep 2021 10:42:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Matt Fleming <matt@codeblueprint.co.uk>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Gon Solo <gonsolo@gmail.com>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] mm: Move node_reclaim_distance to fix NUMA without SMP
Date:   Thu, 16 Sep 2021 10:42:42 +0200
Message-Id: <6432666a648dde85635341e6c918cee97c97d264.1631781495.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631781495.git.geert+renesas@glider.be>
References: <cover.1631781495.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

If CONFIG_NUMA=y, but CONFIG_SMP=n (e.g. sh/migor_defconfig):

    sh4-linux-gnu-ld: mm/page_alloc.o: in function `get_page_from_freelist':
    page_alloc.c:(.text+0x2c24): undefined reference to `node_reclaim_distance'

Fix this by moving the declaration of node_reclaim_distance from an
SMP-only to a generic file.

Fixes: a55c7454a8c887b2 ("sched/topology: Improve load balancing on AMD EPYC systems")
Suggested-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/sched/topology.c | 1 -
 mm/page_alloc.c         | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4e8698e62f0754a3..738ee7fa79724c7d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1481,7 +1481,6 @@ static int			sched_domains_curr_level;
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
 static struct cpumask		***sched_domains_numa_masks;
-int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 
 static unsigned long __read_mostly *sched_numa_onlined_nodes;
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf1cb1..8b2d7a9bae6c1754 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3966,6 +3966,8 @@ bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
 }
 
 #ifdef CONFIG_NUMA
+int __read_mostly node_reclaim_distance = RECLAIM_DISTANCE;
+
 static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 {
 	return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <=
-- 
2.25.1

