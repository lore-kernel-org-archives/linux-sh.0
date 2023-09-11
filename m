Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C062CA0EC3
	for <linux-sh@archiver.kernel.org>; Mon, 11 Sep 2023 21:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243854AbjIKVu1 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbjIKKRC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 11 Sep 2023 06:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8357E5F
        for <linux-sh@vger.kernel.org>; Mon, 11 Sep 2023 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694427372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Idpm1MsTIMkQeLscANw6c5qO2H9vlf95D23Ujw5h12Y=;
        b=IiCse5ysEAlNAbrhjicki59YugzcYmSZvoiD4IIp9vGSB6bynIWRvG+F00AGCUMtMHlQYI
        UKimmdRin1VOfTDU/vg4DEAzDs34jug7859oQZfUoFLOfVQmg+bAhWVQsN4s3gjxWDCz7J
        W4r9aF9XoHucPRLy8iTQXMuPYTVf8mk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-ReNWdvrBOJOCrFLzcN4uOg-1; Mon, 11 Sep 2023 06:16:07 -0400
X-MC-Unique: ReNWdvrBOJOCrFLzcN4uOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 283503811F25;
        Mon, 11 Sep 2023 10:16:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 315D110F1BE9;
        Mon, 11 Sep 2023 10:16:05 +0000 (UTC)
Date:   Mon, 11 Sep 2023 18:16:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: mm: Re-add lost __ref to ioremap_prot() to fix
 modpost warning
Message-ID: <ZP7o4np4v0bth8dj@MiWiFi-R3L-srv>
References: <20230911093850.1517389-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911093850.1517389-1-geert+renesas@glider.be>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 09/11/23 at 11:38am, Geert Uytterhoeven wrote:
> When __ioremap_caller() was replaced by ioremap_prot(), the __ref
> annotation added in commit af1415314a4190b8 ("sh: Flag
> __ioremap_caller() __init_refok.") was removed, causing a modpost
> warning:
> 
>     WARNING: modpost: vmlinux: section mismatch in reference: ioremap_prot+0x88 (section: .text) -> ioremap_fixed (section: .init.text)
> 
> ioremap_prot() calls ioremap_fixed() (which is marked __init), but only
> before mem_init_done becomes true, so this is safe.  Hence fix this by
> re-adding the lost __ref.
> 
> Fixes: 0453c9a78015cb22 ("sh: mm: convert to GENERIC_IOREMAP")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/sh/mm/ioremap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
> index c33b3daa4ad1a3e6..33d20f34560fd5cb 100644
> --- a/arch/sh/mm/ioremap.c
> +++ b/arch/sh/mm/ioremap.c
> @@ -72,8 +72,8 @@ __ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
>  #define __ioremap_29bit(offset, size, prot)		NULL
>  #endif /* CONFIG_29BIT */
>  
> -void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> -			   unsigned long prot)
> +void __iomem __ref *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +				 unsigned long prot)

Sorry for the mistake, and I possibly missed the warning when building. 

Reviewed-by: Baoquan He <bhe@redhat.com>

>  {
>  	void __iomem *mapped;
>  	pgprot_t pgprot = __pgprot(prot);
> -- 
> 2.34.1
> 

