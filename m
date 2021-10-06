Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43525C433EF
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE9461131
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbhJFQqC (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:46:02 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37639 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbhJFQpv (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:51 -0400
Received: by mail-ot1-f47.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so3860784otv.4;
        Wed, 06 Oct 2021 09:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODdwkiH4tXq9GvyXH7/gt65PfkKCS+62hrrbhfBOAKY=;
        b=KjVsZlxx2i4DNdKl4plQ7nquC69f93FQm8Z8JNSY/+Jeif9it35gDBSFUpOamO4Kfy
         Sh8VqPOHRHNQjJvpdQvavgc/MpFrpG85PnWD1GsLbIsR3kt+WWRaYC9ND0k8j/yME2Kt
         350QGD0gNz0yQBrWlgVUeliy0h3SSIU0wI1KXj03GXf5XiOB1Hcs9oDz/jGtz6jW7KAk
         tT046I82ScmDM7729vVDQq3orDhfgKsWAQJC4XWtxeyjX2boA65FGbEREl5Auc/id+2Z
         s8GYN+MupuutmZHYVWDtRIoQZwB7e2qBlkYxLsBiYywHgrtI1iR+kmE33FFMauKtrvCD
         3jPw==
X-Gm-Message-State: AOAM530mQ60mKh0xHJFsGFNudKEAeyKedbJL21F82tHwLS+xnuz58fGb
        wauKdYjBaXpvaBGbYiXjWw==
X-Google-Smtp-Source: ABdhPJyKbg8/vmyrEytsmwBD61hnJT/KfL8RD1L+0+jj33vwvFOqRG7dPOrAYWXK5lnk+W9TvgzSoQ==
X-Received: by 2002:a05:6830:1ad3:: with SMTP id r19mr19253078otc.98.1633538638626;
        Wed, 06 Oct 2021 09:43:58 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 12/12] cacheinfo: Set cache 'id' based on DT data
Date:   Wed,  6 Oct 2021 11:43:32 -0500
Message-Id: <20211006164332.1981454-13-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Use the minimum CPU h/w id of the CPUs associated with the cache for the
cache 'id'. This will provide a stable id value for a given system. As
we need to check all possible CPUs, we can't use the shared_cpu_map
which is just online CPUs. As there's not a cache to CPUs mapping in DT,
we have to walk all CPU nodes and then walk cache levels.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/cacheinfo.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 66d10bdb863b..44547fd96f72 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -136,6 +136,31 @@ static bool cache_node_is_unified(struct cacheinfo *this_leaf,
 	return of_property_read_bool(np, "cache-unified");
 }
 
+static void cache_of_set_id(struct cacheinfo *this_leaf, struct device_node *np)
+{
+	struct device_node *cpu;
+	unsigned long min_id = ~0UL;
+
+	for_each_of_cpu_node(cpu) {
+		struct device_node *cache_node = cpu;
+		u64 id = of_get_cpu_hwid(cache_node, 0);
+
+		while ((cache_node = of_find_next_cache_node(cache_node))) {
+			if ((cache_node == np) && (id < min_id)) {
+				min_id = id;
+				of_node_put(cache_node);
+				break;
+			}
+			of_node_put(cache_node);
+		}
+	}
+
+	if (min_id != ~0UL) {
+		this_leaf->id = min_id;
+		this_leaf->attributes |= CACHE_ID;
+	}
+}
+
 static void cache_of_set_props(struct cacheinfo *this_leaf,
 			       struct device_node *np)
 {
@@ -151,6 +176,7 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
 	cache_get_line_size(this_leaf, np);
 	cache_nr_sets(this_leaf, np);
 	cache_associativity(this_leaf);
+	cache_of_set_id(this_leaf, np);
 }
 
 static int cache_setup_of_node(unsigned int cpu)
-- 
2.30.2

