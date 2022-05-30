Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BC1C433EF
	for <linux-sh@archiver.kernel.org>; Mon, 30 May 2022 12:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiE3MKB (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 30 May 2022 08:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiE3MJ5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 30 May 2022 08:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B70405DA3F
        for <linux-sh@vger.kernel.org>; Mon, 30 May 2022 05:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653912595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l+xhfzs8lWvum/5z4y3LJduPiIcYZl/dK4jHG88Ohl0=;
        b=KHv0KSDiAQniJyGccqIT3z2RKcGNG88FsKCXw5D1Tm1uxMEkVSU3QlR5GRRVxLQK39x2fj
        tcmwch0eGDF0S0oP/QF+uB9RsxcrT1tFonHJZFROnN7TBxtLJj9ZUC3sWL8eqWmiV4aj64
        5D/WxSSz+6ds8OUIQKC/r6Yz1jzbO5Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-bmzpHDSXPdOUkfjJ9dqVjw-1; Mon, 30 May 2022 08:09:52 -0400
X-MC-Unique: bmzpHDSXPdOUkfjJ9dqVjw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41D7C3804501;
        Mon, 30 May 2022 12:09:52 +0000 (UTC)
Received: from localhost (ovpn-13-142.pek2.redhat.com [10.72.13.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74C94492C3B;
        Mon, 30 May 2022 12:09:50 +0000 (UTC)
Date:   Mon, 30 May 2022 20:09:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sh: cast away __iomem to remove sparse warning
Message-ID: <YpS0C8tVG2E5jGSV@MiWiFi-R3L-srv>
References: <20220507013411.74277-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507013411.74277-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi,

On 05/07/22 at 09:34am, Baoquan He wrote:
> LKP reported a sparse warning in arch/sh/kernel/crash_dump.c during
> a kdump patchset reviewing:
> https://lore.kernel.org/all/202204082128.JKXXDGpa-lkp@intel.com/T/#u
> 
> ../arch/sh/kernel/crash_dump.c:23:36: sparse: warning: incorrect type in argument 1 (different address spaces)
> ../arch/sh/kernel/crash_dump.c:23:36: sparse:    expected void const *addr
> ../arch/sh/kernel/crash_dump.c:23:36: sparse:    got void [noderef] __iomem *
> 
> This warning happened when __iomem pointer is passed into fucntion
> which doesn't expect it. Casting away the __iomem can fix it.

This warning was reported by lkp during one patchset posted and
reviewing. Since it's not related to the patchset, I just sent it
separately so that later code change on arch/sh/kernel/crash_dump.c
won't trigger the lkp warning again.

[PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
https://lore.kernel.org/all/20220408090636.560886-2-bhe@redhat.com/T/#u

Now the above patchset has been merged into linus's tree, please
consider taking this patch.

Thanks
Baoquan

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/sh/kernel/crash_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
> index 19ce6a950aac..52d1d54eb6b1 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -20,7 +20,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
>  		return 0;
>  
>  	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> -	csize = copy_to_iter(vaddr + offset, csize, iter);
> +	csize = copy_to_iter((const void __force *)vaddr + offset, csize, iter);
>  	iounmap(vaddr);
>  
>  	return csize;
> -- 
> 2.34.1
> 

