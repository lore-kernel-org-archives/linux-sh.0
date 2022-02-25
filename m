Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC3CC433EF
	for <linux-sh@archiver.kernel.org>; Fri, 25 Feb 2022 04:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiBYErh (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 24 Feb 2022 23:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiBYErg (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 24 Feb 2022 23:47:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EECC5A150
        for <linux-sh@vger.kernel.org>; Thu, 24 Feb 2022 20:47:04 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m13-20020a17090aab0d00b001bbe267d4d1so6974165pjq.0
        for <linux-sh@vger.kernel.org>; Thu, 24 Feb 2022 20:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SyanVPTDj26hoM0+/34vC3ojlwHE6zX0sye59Y+Rtjs=;
        b=ez/pn28OrXoTJLAydt7fC3l/1BRKMczx0EuxgJzCsoJxTes/Q7y60tcVMO7wzlZseu
         9ifY3jRNBn24/NGKwkqqOVQOACDLdGJKM8O1juUN8Vb5C+HPbiKG5WnRq7DsniVf7u8e
         fw6ieiJnZPOJ/xg6orBYtG5jEZmuIWIwk6hF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SyanVPTDj26hoM0+/34vC3ojlwHE6zX0sye59Y+Rtjs=;
        b=oXv8sV9pp0eaeaU5HBzqnIBltlB8k0+l6QOeRjPPGRbf5Sr6btKOBVJeU0bzGw8vgo
         MkKwBfN6lz8zSuk2ba7i8ZqSqz4VT9Z/nl+F8DGDkjaip9RnenWGuV4lLeGL52YQqqbl
         P7on9b8DtO4hDpFBxPteBICGOptURNQHusg5S6FwrizF6s+SCc0dMnXzLklUgKktEy2S
         e9HdQmaaJ6KDWlq+l0kwBVQYJhEz1USzWZSDtxc//i4CxqYoh+WBYmyYY1tmE6qRLdiQ
         B423hUd327Uk9BxWqOZkpFaKio+MQ62s6t4tZo7i4t5HBoPjLBa7BAWiRXOjaq6tThL1
         qUnA==
X-Gm-Message-State: AOAM531BdMhye8D9p4OaA8NQ6qJ2hSgHMzsw5f1lSHQDUl8XpBhTOxBJ
        3LsGcfCqpnjxVgw1c7mildGxMw==
X-Google-Smtp-Source: ABdhPJzy/9ym4pKvdp7gXGiiTJRBM16FFuwlMDSrJbIDB/E//S1S2eCPnNgmXzRLoOrLqxAOu4UIKw==
X-Received: by 2002:a17:902:f64e:b0:14d:20db:8478 with SMTP id m14-20020a170902f64e00b0014d20db8478mr5755429plg.158.1645764423449;
        Thu, 24 Feb 2022 20:47:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f16-20020a623810000000b004e1b132bc9esm1254834pfa.149.2022.02.24.20.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 20:47:03 -0800 (PST)
Date:   Thu, 24 Feb 2022 20:47:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] usercopy: Check valid lifetime via stack depth
Message-ID: <202202242046.33FF8372@keescook>
References: <20220224060342.1855457-1-keescook@chromium.org>
 <85d42900efaa4fdb8c20de2147d938c7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d42900efaa4fdb8c20de2147d938c7@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Feb 24, 2022 at 08:58:20AM +0000, David Laight wrote:
> From: Kees Cook
> > Sent: 24 February 2022 06:04
> > 
> > Under CONFIG_HARDENED_USERCOPY=y, when exact stack frame boundary checking
> > is not available (i.e. everything except x86 with FRAME_POINTER), check
> > a stack object as being at least "current depth valid", in the sense
> > that any object within the stack region but not between start-of-stack
> > and current_stack_pointer should be considered unavailable (i.e. its
> > lifetime is from a call no longer present on the stack).
> > 
> ...
> > diff --git a/mm/usercopy.c b/mm/usercopy.c
> > index d0d268135d96..5d28725af95f 100644
> > --- a/mm/usercopy.c
> > +++ b/mm/usercopy.c
> > @@ -22,6 +22,30 @@
> >  #include <asm/sections.h>
> >  #include "slab.h"
> > 
> > +/*
> > + * Only called if obj is within stack/stackend bounds. Determine if within
> > + * current stack depth.
> > + */
> > +static inline int check_stack_object_depth(const void *obj,
> > +					   unsigned long len)
> > +{
> > +#ifdef CONFIG_ARCH_HAS_CURRENT_STACK_POINTER
> > +#ifndef CONFIG_STACK_GROWSUP
> 
> Pointless negation
> 
> > +	const void * const high = stackend;
> > +	const void * const low = (void *)current_stack_pointer;
> > +#else
> > +	const void * const high = (void *)current_stack_pointer;
> > +	const void * const low = stack;
> > +#endif
> > +
> > +	/* Reject: object not within current stack depth. */
> > +	if (obj < low || high < obj + len)
> > +		return BAD_STACK;
> > +
> > +#endif
> > +	return GOOD_STACK;
> > +}
> 
> If the comment at the top of the function is correct then
> only a single test for the correct end of the buffer against
> the current stack pointer is needed.
> Something like:
> #ifdef CONFIG_STACK_GROWSUP
> 	if ((void *)current_stack_pointer < obj + len)
> 		return BAD_STACK;
> #else
> 	if (obj < (void *)current_stack_pointer)
> 		return BAD_STACK;
> #endif
> 	return GOOD_STACK;

Oh, yeah, excellent point. I suspect the compiler would probably
optimize it all away, but yes, this is, in fact, easier to read, and
short enough I should probably just not bother with a separate function.

Thanks!

-Kees

> 
> Although it may depend on exactly where the stack pointer
> points to - especially for GROWSUP.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

-- 
Kees Cook
