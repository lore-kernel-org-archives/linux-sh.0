Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B4DC48BDF
	for <linux-sh@archiver.kernel.org>; Wed,  9 Jun 2021 10:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF9D6139A
	for <linux-sh@archiver.kernel.org>; Wed,  9 Jun 2021 10:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbhFIKzk (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 9 Jun 2021 06:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235462AbhFIKzj (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 9 Jun 2021 06:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623236024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBWPCdmnHsH7qQGe81DFl3a6ru5xcOhjproglm1WObM=;
        b=H7mMWCuUMjVlL38GtuFmFzfGsCuMyYbIknO7K6nDPwO5YYwCQE6zRk7zkCncAgbRiYIndO
        IaT3jcTkghc26Hjzlen12wiztWI8UhCmUIBbAAAEcIo+mdlh/kSkuKZimEiih9kzDCeBdM
        MhOXm+4LL+z8ov7X9SOystoebP2I/MU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-CktaMwIVN_qeIU0jQ55AJw-1; Wed, 09 Jun 2021 06:53:43 -0400
X-MC-Unique: CktaMwIVN_qeIU0jQ55AJw-1
Received: by mail-wr1-f69.google.com with SMTP id e11-20020a056000178bb0290119c11bd29eso5738042wrg.2
        for <linux-sh@vger.kernel.org>; Wed, 09 Jun 2021 03:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JBWPCdmnHsH7qQGe81DFl3a6ru5xcOhjproglm1WObM=;
        b=uLVnTMfqHT8obb7otYZ4AcXlZ6ET9XBfAake1i/Pf1hp1IQ2gW+FjSwyiK1QxeibsL
         2ZPpOHGnQVyzk7c892EB3iyPWay1zW/S6DC2ofWxrMF5QpF8RDIOwr459GcH3WHpxv/R
         HonHr0PPtBcE6U0F0aTEwiKpcn+qW1Frsciauj2mAz5N7+N+soCwxpRLUb/FJ1K0/SGY
         2tUjwfgyiTYZBEpiZs8XKqKuZir8uf3W4fh7gsS185/hRnkkL1x/hfL92g5o+SR/HOfj
         3R8etFYhCoXADKC69xvM1TWZGDsqTcU686Ngujgw9QznnB6lXx3kBIfQN8nWlsHLkGFD
         TIgw==
X-Gm-Message-State: AOAM530V5zDNxE6BdCzR9pyJ6/Z1+FeoY/ODyiTA82QK4JoZilrUifyp
        AzpkB8XyUvUTfKz9QVroVOQKFKfUe4pQ3tQXgMJATIGpXRgYz92+U473zNiZjV97XYFxtjBetzb
        SGV9yt1UFcy7WymhQfIA=
X-Received: by 2002:a05:600c:b50:: with SMTP id k16mr26766722wmr.137.1623236022754;
        Wed, 09 Jun 2021 03:53:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytaUEoH1yZlmOCQRNfd+wo+CI/GKYwuDVo1xp/A/CuJsfRh3qeLKHuz3pPcIzWarSKIwDzSA==
X-Received: by 2002:a05:600c:b50:: with SMTP id k16mr26766696wmr.137.1623236022628;
        Wed, 09 Jun 2021 03:53:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id v15sm1695174wrw.24.2021.06.09.03.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:53:42 -0700 (PDT)
Subject: Re: [PATCH 3/9] arc: remove support for DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
References: <20210602105348.13387-1-rppt@kernel.org>
 <20210602105348.13387-4-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e9ef94f5-02bc-920b-9e6a-2d234e5bbbc5@redhat.com>
Date:   Wed, 9 Jun 2021 12:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602105348.13387-4-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 02.06.21 12:53, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> DISCONTIGMEM was replaced by FLATMEM with freeing of the unused memory map
> in v5.11.
> 
> Remove the support for DISCONTIGMEM entirely.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

