Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA33C433EF
	for <linux-sh@archiver.kernel.org>; Thu, 16 Sep 2021 08:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D478961164
	for <linux-sh@archiver.kernel.org>; Thu, 16 Sep 2021 08:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhIPIoQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhIPIoP (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 16 Sep 2021 04:44:15 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC46C061764
        for <linux-sh@vger.kernel.org>; Thu, 16 Sep 2021 01:42:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:39fa:3565:945d:98f4])
        by laurent.telenet-ops.be with bizsmtp
        id uYim2500q3mHZPk01Yimhh; Thu, 16 Sep 2021 10:42:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQmyk-0053tr-0C; Thu, 16 Sep 2021 10:42:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQmyj-004q6m-E0; Thu, 16 Sep 2021 10:42:45 +0200
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
Subject: [PATCH 2/2] mm: Move fold_vm_numa_events() to fix NUMA without SMP
Date:   Thu, 16 Sep 2021 10:42:43 +0200
Message-Id: <9d16ccdd9ef32803d7100c84f737de6a749314fb.1631781495.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631781495.git.geert+renesas@glider.be>
References: <cover.1631781495.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

If CONFIG_NUMA=y, but CONFIG_SMP=n (e.g. sh/migor_defconfig):

    sh4-linux-gnu-ld: mm/vmstat.o: in function `vmstat_start':
    vmstat.c:(.text+0x97c): undefined reference to `fold_vm_numa_events'
    sh4-linux-gnu-ld: drivers/base/node.o: in function `node_read_vmstat':
    node.c:(.text+0x140): undefined reference to `fold_vm_numa_events'
    sh4-linux-gnu-ld: drivers/base/node.o: in function `node_read_numastat':
    node.c:(.text+0x1d0): undefined reference to `fold_vm_numa_events'

Fix this by moving fold_vm_numa_events() outside the SMP-only section.

Fixes: f19298b9516c1a03 ("mm/vmstat: convert NUMA statistics to basic NUMA counters")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 mm/vmstat.c | 56 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8ce2620344b2f8b4..5db54581feab9ac9 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -165,6 +165,34 @@ atomic_long_t vm_numa_event[NR_VM_NUMA_EVENT_ITEMS] __cacheline_aligned_in_smp;
 EXPORT_SYMBOL(vm_zone_stat);
 EXPORT_SYMBOL(vm_node_stat);
 
+#ifdef CONFIG_NUMA
+static void fold_vm_zone_numa_events(struct zone *zone)
+{
+	unsigned long zone_numa_events[NR_VM_NUMA_EVENT_ITEMS] = { 0, };
+	int cpu;
+	enum numa_stat_item item;
+
+	for_each_online_cpu(cpu) {
+		struct per_cpu_zonestat *pzstats;
+
+		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
+		for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++)
+			zone_numa_events[item] += xchg(&pzstats->vm_numa_event[item], 0);
+	}
+
+	for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++)
+		zone_numa_event_add(zone_numa_events[item], zone, item);
+}
+
+void fold_vm_numa_events(void)
+{
+	struct zone *zone;
+
+	for_each_populated_zone(zone)
+		fold_vm_zone_numa_events(zone);
+}
+#endif
+
 #ifdef CONFIG_SMP
 
 int calculate_pressure_threshold(struct zone *zone)
@@ -771,34 +799,6 @@ static int fold_diff(int *zone_diff, int *node_diff)
 	return changes;
 }
 
-#ifdef CONFIG_NUMA
-static void fold_vm_zone_numa_events(struct zone *zone)
-{
-	unsigned long zone_numa_events[NR_VM_NUMA_EVENT_ITEMS] = { 0, };
-	int cpu;
-	enum numa_stat_item item;
-
-	for_each_online_cpu(cpu) {
-		struct per_cpu_zonestat *pzstats;
-
-		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
-		for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++)
-			zone_numa_events[item] += xchg(&pzstats->vm_numa_event[item], 0);
-	}
-
-	for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++)
-		zone_numa_event_add(zone_numa_events[item], zone, item);
-}
-
-void fold_vm_numa_events(void)
-{
-	struct zone *zone;
-
-	for_each_populated_zone(zone)
-		fold_vm_zone_numa_events(zone);
-}
-#endif
-
 /*
  * Update the zone counters for the current cpu.
  *
-- 
2.25.1

