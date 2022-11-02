Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E1C43219
	for <linux-sh@archiver.kernel.org>; Wed,  2 Nov 2022 18:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiKBSgU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 2 Nov 2022 14:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKBSgI (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 2 Nov 2022 14:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB2C2FC04
        for <linux-sh@vger.kernel.org>; Wed,  2 Nov 2022 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667414062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqLWPThYSO+7/uH6VGCIiG2p0FrpcxY/esl5LuglSyI=;
        b=UaqOzmF3XjoLl4fg9Cex0D2JZhb4Hn4fs/xuSkfevBtbljclmc82i5hLfUwGo4vvNTut3A
        iWqg1vS5Hw7hN7FelKt6q2MtNHS4UVvAj8kccLsIzL80JsEQvUdfSo0GlxoqaAUUbjMiRu
        2go1IVhZ8b4mzdEp4XHbnPGlcHfvYRA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-359-Rb-Y7lINO5KdMGmogwNR5Q-1; Wed, 02 Nov 2022 14:34:20 -0400
X-MC-Unique: Rb-Y7lINO5KdMGmogwNR5Q-1
Received: by mail-qk1-f198.google.com with SMTP id bj1-20020a05620a190100b006fa12a05188so11690399qkb.4
        for <linux-sh@vger.kernel.org>; Wed, 02 Nov 2022 11:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqLWPThYSO+7/uH6VGCIiG2p0FrpcxY/esl5LuglSyI=;
        b=mDL2BNW9VfnqXTCpU5GEgTtd6mk1Zwr5ku/GIC59dU1IkWjw3HJZphJfzV6SuLuXFu
         V9eAePo3+9o0eT/oceH8mYnt4Zvxd3/OrLWm3NPkPXPcMkdXEJSRF7QnweFASDY9JI2w
         iGr3EuUzDf/dGcJia62bgHBBHLIHiWo9RXrsXdRfVBWPdgm+squClR7l3XppioNNd53R
         3RtMbcmyTOIM8QDqxZWobBB72Houtj1ZxK3j52MtI8UdLNCVwwV3sdMvDKDoT+mJ0Xh1
         E8+zLd1VG1hUup6MJ56rYZt2+oZXqp6CoWYI6mF7lyKzMJ+vNYPKlnWxUyjiy3F4LKLn
         KIOg==
X-Gm-Message-State: ACrzQf0O2bMCVI5bHsKwCou+c/p87D/ouEXL39A9ie1IUEdxqiTTdF7P
        NcRVjX+fgNSLKx4kmUgOohseg0EYyodvPsYSXa9IwL1P6cFlnTAJIRSEStPUrMuc/RuUMur0+EF
        /DRgFB2UdAuTFTy2nHhk=
X-Received: by 2002:a05:620a:2185:b0:6fa:9b5:7bcd with SMTP id g5-20020a05620a218500b006fa09b57bcdmr17834827qka.689.1667414059923;
        Wed, 02 Nov 2022 11:34:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zQBXSq1wHjxRSmwTcnsY0fuwHzVoafdqUQfLwgY4gLc/C2queTj08Inp5WgKA+UYkDnhs/w==
X-Received: by 2002:a05:620a:2185:b0:6fa:9b5:7bcd with SMTP id g5-20020a05620a218500b006fa09b57bcdmr17834779qka.689.1667414059700;
        Wed, 02 Nov 2022 11:34:19 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id w187-20020a3794c4000000b006eed47a1a1esm8757820qkd.134.2022.11.02.11.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:34:18 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/8] smp: Trace IPIs sent via arch_send_call_function_ipi_mask()
Date:   Wed,  2 Nov 2022 18:33:32 +0000
Message-Id: <20221102183336.3120536-3-vschneid@redhat.com>
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

This simply wraps around the arch function and prepends it with a
tracepoint, similar to send_call_function_single_ipi().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/smp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index e2ca1e2f31274..c4d561cf50d45 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -160,6 +160,13 @@ void __init call_function_init(void)
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
+static inline void
+send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	trace_ipi_send_cpumask(mask, _RET_IP_, func);
+	arch_send_call_function_ipi_mask(mask);
+}
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
@@ -970,7 +977,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		if (nr_cpus == 1)
 			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
-			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+			send_call_function_ipi_mask(cfd->cpumask_ipi);
 
 		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu, CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
 	}
-- 
2.31.1

