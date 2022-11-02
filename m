Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8154C4332F
	for <linux-sh@archiver.kernel.org>; Wed,  2 Nov 2022 18:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiKBShG (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 2 Nov 2022 14:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKBShC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 2 Nov 2022 14:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297EE2FC14
        for <linux-sh@vger.kernel.org>; Wed,  2 Nov 2022 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667414066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPxNJZ59dAj9Aw/rnn/vqSwo8b8sDM1O6Xi76OwhNZs=;
        b=Fe71/qi6ynieum+6CED0InQm406/v4yXSAzYo77+vPxSWtmHhgXkkS1zsoSVjZmE5xMuLQ
        jDaQRqrZq+bu9wzNN13KxiPVqc/DdQP6o+aNltlP+srcOMw12wtmHGJmB/lXu3GE0D6/Wv
        PaK3mSES+/gU9o2HPY4J6haSkcMA1Lc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-256-WKcSrSQ9PXKaM9xy0o3z3Q-1; Wed, 02 Nov 2022 14:34:25 -0400
X-MC-Unique: WKcSrSQ9PXKaM9xy0o3z3Q-1
Received: by mail-qv1-f70.google.com with SMTP id e13-20020ad450cd000000b004bb49d98da4so10367503qvq.9
        for <linux-sh@vger.kernel.org>; Wed, 02 Nov 2022 11:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPxNJZ59dAj9Aw/rnn/vqSwo8b8sDM1O6Xi76OwhNZs=;
        b=YdBFWZRCKMy7XjGiR+pIsPjPreqyOTgmIeggZlhI1bLJA3fM8aNz6iHFtw1DxClw4G
         u0QJaWRNdQmarfgQ2M9KVvpVZWoB28XX7Mg66ssGK3MNVvcDXD6nsRoN8CfZdT6MSZuA
         DXZzSCM5MZBlAwlB/OcZ0sqxf/M4jgkEws4qOLhqY25bmFNObIaL98K0k/JiZRfeGREU
         j7Rbb4g0YVPNbkmx5a+d5ftJ50iNSOrGJdzNE+vtS25vfen263feRWtQKHEimCEZ6rEe
         NOa0s6f+AzNGrFLysLNqI0eaLsKDkA9zdaEiFfqVoQI1lPBvaT3v2MXPTLzh2A8CApSl
         pGXw==
X-Gm-Message-State: ACrzQf03qoJOfDvHvpTLJNFWVGuzyM7nXkIYc7Sj+2xopnYtKjwW29QJ
        4SlqybZuuZmrtYkeQXkzUFKsQgAbS22JppTFbQQ5zqzNR6knO4BPd8KWNHwESmoeqPdfBT5YW32
        0WSXoGL823S+9UPZ9iLE=
X-Received: by 2002:a37:92c6:0:b0:6fa:28b2:1e2a with SMTP id u189-20020a3792c6000000b006fa28b21e2amr13574177qkd.9.1667414064977;
        Wed, 02 Nov 2022 11:34:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4EXOUjNlIxUYR8PDvF9w7H8/QWuUsvimzUEYEqnOFqRnuqhuZtDCzI4Vu/740apEttSzlakQ==
X-Received: by 2002:a37:92c6:0:b0:6fa:28b2:1e2a with SMTP id u189-20020a3792c6000000b006fa28b21e2amr13574163qkd.9.1667414064758;
        Wed, 02 Nov 2022 11:34:24 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id w187-20020a3794c4000000b006eed47a1a1esm8757820qkd.134.2022.11.02.11.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:34:23 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH v2 5/8] irq_work: Trace self-IPIs sent via arch_irq_work_raise()
Date:   Wed,  2 Nov 2022 18:33:33 +0000
Message-Id: <20221102183336.3120536-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102182949.3119584-1-vschneid@redhat.com>
References: <20221102182949.3119584-1-vschneid@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

IPIs sent to remove CPUs via irq_work_queue_on() are now covered by
trace_ipi_send_cpumask(), add another instance of the tracepoint to cover
self-IPIs.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/irq_work.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc43..aec38c294ce68 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -22,6 +22,8 @@
 #include <asm/processor.h>
 #include <linux/kasan.h>
 
+#include <trace/events/ipi.h>
+
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
 static DEFINE_PER_CPU(struct task_struct *, irq_workd);
@@ -74,6 +76,16 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
 
+static inline void irq_work_raise(struct irq_work *work)
+{
+	if (trace_ipi_send_cpumask_enabled() && arch_irq_work_has_interrupt())
+		trace_ipi_send_cpumask(cpumask_of(smp_processor_id()),
+				       _RET_IP_,
+				       work->func);
+
+	arch_irq_work_raise();
+}
+
 /* Enqueue on current CPU, work must already be claimed and preempt disabled */
 static void __irq_work_queue_local(struct irq_work *work)
 {
@@ -99,7 +111,7 @@ static void __irq_work_queue_local(struct irq_work *work)
 
 	/* If the work is "lazy", handle it from next tick if any */
 	if (!lazy_work || tick_nohz_tick_stopped())
-		arch_irq_work_raise();
+		irq_work_raise(work);
 }
 
 /* Enqueue the irq work @work on the current CPU */
-- 
2.31.1

