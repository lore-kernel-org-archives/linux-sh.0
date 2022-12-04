Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46A2C47089
	for <linux-sh@archiver.kernel.org>; Sun,  4 Dec 2022 01:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLDBdL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 3 Dec 2022 20:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLDBct (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 3 Dec 2022 20:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175B1A210
        for <linux-sh@vger.kernel.org>; Sat,  3 Dec 2022 17:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670117505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ueAglvJtCjt6234pC1YgPM7y4iC/0ZyTKdRHiIvyVAM=;
        b=iJ1EaHFKS0+NELGQsk7h2GxTW13d1MHFzcHiJfeBvteHW3L0U/Jg2TLyiP40xvWBO4jTm4
        PeNyxgONoCNxl6TzROtU3Vd+GN3B/1eW5FtFG5V46vMRapiK3F9cuvlmk2kbKZhlHmnt/P
        0LmYU5Yy0O5BNOEagrJCt+1ahjccsrM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-jhdNYiZBN8SKwnEUewJfCQ-1; Sat, 03 Dec 2022 20:31:40 -0500
X-MC-Unique: jhdNYiZBN8SKwnEUewJfCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D087185A792;
        Sun,  4 Dec 2022 01:31:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 105C81410DDA;
        Sun,  4 Dec 2022 01:31:32 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, stephen.s.brennan@oracle.com, urezki@gmail.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sh@vger.kernel.org
Subject: [PATCH v1 7/7] sh: mm: set VM_IOREMAP flag to the vmalloc area
Date:   Sun,  4 Dec 2022 09:30:46 +0800
Message-Id: <20221204013046.154960-8-bhe@redhat.com>
In-Reply-To: <20221204013046.154960-1-bhe@redhat.com>
References: <20221204013046.154960-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Currently, for vmalloc areas with flag VM_IOREMAP set, except of the
specific alignment clamping in __get_vm_area_node(), they will be
1) Shown as ioremap in /proc/vmallocinfo;
2) Ignored by /proc/kcore reading via vread()

So for the ioremap in __sq_remap() of sh, we should set VM_IOREMAP
in flag to make it handled correctly as above.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sh@vger.kernel.org (open list:SUPERH)
---
 arch/sh/kernel/cpu/sh4/sq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index a76b94e41e91..27f2e3da5aa2 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -103,7 +103,7 @@ static int __sq_remap(struct sq_mapping *map, pgprot_t prot)
 #if defined(CONFIG_MMU)
 	struct vm_struct *vma;
 
-	vma = __get_vm_area_caller(map->size, VM_ALLOC, map->sq_addr,
+	vma = __get_vm_area_caller(map->size, VM_IOREMAP, map->sq_addr,
 			SQ_ADDRMAX, __builtin_return_address(0));
 	if (!vma)
 		return -ENOMEM;
-- 
2.34.1

