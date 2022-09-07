Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FE8ECAAD3
	for <linux-sh@archiver.kernel.org>; Wed,  7 Sep 2022 23:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIGXrj (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIGXri (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Sep 2022 19:47:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E574B8A6F
        for <linux-sh@vger.kernel.org>; Wed,  7 Sep 2022 16:47:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t6-20020a17090a950600b0020063f8f964so2274186pjo.0
        for <linux-sh@vger.kernel.org>; Wed, 07 Sep 2022 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QA7YsklnD2cfDCjZnRS3vgbzndyD3I08QYNTHl1zCqo=;
        b=ZLBdFbRl5paMgO0B2nkuSUB92aTwmtmqanZFesgw5UFus70dkXrDyjCNdhChN3pJI2
         t8e2tFazYgcQ2/I+HCWkNpNnhTL+sGFQ2IQmiy8gFk422S7/bBjOweZRLDXszByhh4xi
         VaMpTtbZBDMm4nqrs2mAgMKZ9VkS11Y3DZbhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QA7YsklnD2cfDCjZnRS3vgbzndyD3I08QYNTHl1zCqo=;
        b=IFf4sgEQpTCA5Es1hYPKZO597Rrmwh/7l6zDzH5opijQVZfNEKtHn1gRDuskZztEGl
         ror1MyebQf2dWNGjMoEXt4fZknfMWd+XfcrXyZ3LJejk3l3sGSzjOrCigcfzMg/WTkb8
         u6L5Q3P2CqiAzGJb2xoRVv5YDhmDDiN8MpLws2ePpuYKIow5hwBaFgUbDM1gfOjYk+8W
         m+oXAeqz7IB7Q7IJSC2pR+aA2jNOA2IBc2phnihDsGUQYUtYGQLy12c0iBi9VT1geDf7
         gRCMFrT6JSUsPu8VYFsX3u6g38MdncB0GbvKh8RWuj4v4kelTjEhEhfjHJWlaZl9Izzq
         m4LA==
X-Gm-Message-State: ACgBeo2rEoR6yLQf3DrkFlpAxgN4V7NOUzChurUpoJPHu/Cl0+gS5bxt
        0Nvd5IVLa1FyJnNeVfML2wjZcQ==
X-Google-Smtp-Source: AA6agR6FxJPicYC0Cds/ZMsA1yhEHsGrUHcNbVNraLL0wYnkuXuYdtKZvewZkYvWfNoqDsOEyKfeIg==
X-Received: by 2002:a17:903:556:b0:176:84c9:df3 with SMTP id jo22-20020a170903055600b0017684c90df3mr6335255plb.98.1662594455557;
        Wed, 07 Sep 2022 16:47:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r28-20020aa79edc000000b0053e38ac0ff4sm4585765pfq.115.2022.09.07.16.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:47:34 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:47:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.0-rc4
Message-ID: <202209071646.A95761A@keescook>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905071915.2312316-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Sep 05, 2022 at 09:46:01AM +0200, Geert Uytterhoeven wrote:
> On Mon, 5 Sep 2022, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.0-rc4[1] to v6.0-rc3[3], the summaries are:
> >  - build errors: +3/-16
> 
>   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
> 
> sh4-gcc11/sh-allyesconfig (-Werror)

Sent a patch for this:
https://lore.kernel.org/linux-hardening/20220907234345.96798-1-keescook@chromium.org/

>   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 258:25
> 
> s390x-gcc11/s390-allyesconfig (inlined from 'copy_process' at /kisskb/src/kernel/fork.c:2200:2)

This error appears to have vanished?

> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b90cb1053190353cc30f0fef0ef1f378ccc063c5/ (all 135 configs)

Status	Date/time	Target
OK	Sep 7, 13:54	linus/s390-allyesconfig/s390x-gcc11

-- 
Kees Cook
