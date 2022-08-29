Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2118ECAAD5
	for <linux-sh@archiver.kernel.org>; Mon, 29 Aug 2022 12:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiH2M5e (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiH2M4c (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 29 Aug 2022 08:56:32 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39386D103
        for <linux-sh@vger.kernel.org>; Mon, 29 Aug 2022 05:48:27 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id sg35-20020a170907a42300b007414343814bso1482554ejc.18
        for <linux-sh@vger.kernel.org>; Mon, 29 Aug 2022 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=o7nFvD+bAzzd8hTxdy6J5SFI8QAvwQGuiGUQWboy0hk=;
        b=DUROuHk1Z9qzwl+b2DTEg2S7HJMexhpmqANb/PJZ7O33R9XhSPct7AwehP14PQc/2o
         wK/bi8a2CwUsCNYLZ60BVrbEBT9p31oxiK+AfnIEOciyJytERkocF14TQxcpALfKW3+m
         b2Ub+eMgVCVEVNppFz86zBqIyKvR0lUxlYrSs0Pqqu53c88/O9WnN5AbglZY4E2lNY3X
         UurK/UKzohtpKpt81PvQ4NXYcynS9qosWESRGDtGbt4p3CdpxU/ZwTvmCC71hiCrb5Iz
         oBnMf/JVbgAxkVDKJuMfwanruY91nDmZy+mUGQ78tN/tN+0RJuWqqSZWWdmcn4+YhWS4
         IZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=o7nFvD+bAzzd8hTxdy6J5SFI8QAvwQGuiGUQWboy0hk=;
        b=TzxrHSDb9wJaEfIaAKu1mn8AiAOwJMdCV9RKYg6HcLFdobRl8OeddMQIzdnJh3Perg
         B5+9jBrw1UtXHZ0hb/w16gsIBqPNcTN1x+R2batzgBvaqQaFZHralVXGwyi3KKZnm87z
         S4y2SHG3kdKuPtdek4kEbkqNMauejLIJB5fLKHHc/3rQo5Ir+D7Ix9OkJQTBlivZStUV
         7kOBpVDDVxO6/VLUOnid1U+1e6EUTZZDd1LweTqFo3okADBR9kpKNffzxLBO7uK/ozo+
         kOGiWRmDBOlHsm0HAAnXEsSRmhCD8bSRq2OdgaP/iWOczSPI0WKBGdoEPwftxs7zDswV
         V2vg==
X-Gm-Message-State: ACgBeo1vbVWUaoaZYxf7V/yTwrwR7JUvfAw1B5hukUhrr7pRISiJuUl1
        8Ft5mQ+KpQGJ80xBNkYcvdMdWwmksA==
X-Google-Smtp-Source: AA6agR5wokwGhbG/dPuolBfo3Bpkl9cRXVj3x5ekleyIMoAvz+i6ptf2ezpCAANeuPi0p5VgMRtvOQZZzA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:a17:907:75c6:b0:741:75a0:b82b with SMTP id
 jl6-20020a17090775c600b0074175a0b82bmr4672915ejc.465.1661777305817; Mon, 29
 Aug 2022 05:48:25 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:15 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-11-elver@google.com>
Subject: [PATCH v4 10/14] locking/percpu-rwsem: Add percpu_is_write_locked()
 and percpu_is_read_locked()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Implement simple accessors to probe percpu-rwsem's locked state:
percpu_is_write_locked(), percpu_is_read_locked().

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
v4:
* Due to spurious read_count increments in __percpu_down_read_trylock()
  if sem->block != 0, check that !sem->block (reported by Peter).

v2:
* New patch.
---
 include/linux/percpu-rwsem.h  | 6 ++++++
 kernel/locking/percpu-rwsem.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 5fda40f97fe9..36b942b67b7d 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -121,9 +121,15 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 	preempt_enable();
 }
 
+extern bool percpu_is_read_locked(struct percpu_rw_semaphore *);
 extern void percpu_down_write(struct percpu_rw_semaphore *);
 extern void percpu_up_write(struct percpu_rw_semaphore *);
 
+static inline bool percpu_is_write_locked(struct percpu_rw_semaphore *sem)
+{
+	return atomic_read(&sem->block);
+}
+
 extern int __percpu_init_rwsem(struct percpu_rw_semaphore *,
 				const char *, struct lock_class_key *);
 
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 5fe4c5495ba3..185bd1c906b0 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -192,6 +192,12 @@ EXPORT_SYMBOL_GPL(__percpu_down_read);
 	__sum;								\
 })
 
+bool percpu_is_read_locked(struct percpu_rw_semaphore *sem)
+{
+	return per_cpu_sum(*sem->read_count) != 0 && !atomic_read(&sem->block);
+}
+EXPORT_SYMBOL_GPL(percpu_is_read_locked);
+
 /*
  * Return true if the modular sum of the sem->read_count per-CPU variable is
  * zero.  If this sum is zero, then it is stable due to the fact that if any
-- 
2.37.2.672.g94769d06f0-goog

