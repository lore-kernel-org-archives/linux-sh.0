Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5D7C433F5
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 21:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308AC61040
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 21:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbhJFV1G (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbhJFV1F (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 17:27:05 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF809C061746;
        Wed,  6 Oct 2021 14:25:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 133so3665956pgb.1;
        Wed, 06 Oct 2021 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e64UMCL2WVnOr2UI7AUcgF8cpI0jeUTyJjvzOQZ8YrE=;
        b=UBSXKYjm15FEKybh0KfefqRjd/fVs22AWYzwe2iCJvmOHscvoAutQW2HwE99YHZeWu
         vEtNDuMS9d78IGfnBrQ47YiMpXMPPhe6dbQyF9hg/uSAQDApFpiVmZ7RCXYk//sWXr1Q
         0LSfp/P7/3d3pFfamzEH93p+y9SKpm/qjQxtZn4fAQUwleau5VdUB+9jn7Ku+OYnfnmC
         SnnK3Phc97T0RV6YdV7B/6OMV0qq1QjiJmwn6G9SBEM6VpE4qBOh3ESLF6KJAuPLSvNB
         EipYZeSbBljiqKzHr1N+foOdNe3WDWrdfrXbmYefd7v8ToBI7aLskwiFwDPpPQdD6I/S
         LWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e64UMCL2WVnOr2UI7AUcgF8cpI0jeUTyJjvzOQZ8YrE=;
        b=JWdC6OOii4vGrggI1sOIRq8lgFC1JohH33kQxyGAZ6apsqXQjeRJBYIfLm/G9yK/8x
         wyn9/BItcZrP12BcwK/nNeMDNWKleaWuOg3ync1Npn+jRceN7IGEr6KAU5CW9N7Nyv/U
         321AY90hWdGwCLKW16qbsBPuqcp7VrPaXZeFVjtV9753Oqg1gdsruRkNzXUoFZFhQWiB
         2jghSJgFeZ21CKz0ygQ/7LUNKvpo4WIk0e1OzBrWhNMnsA1QV6geoB7nFLOLiTN7eiY6
         i+utMKV2J9wo75kbiYAsOi+e3atp9JbiDZh8NgP/evvH5SjKe6kF4tLkxhArxxdi5iI1
         WVcw==
X-Gm-Message-State: AOAM531+sHpjE+qaWCTN4lMkAdeq9nzKXrimslHyejGfKdmAtKF1DIVw
        p4wso4Wm31K1qhAAIdgoUr8=
X-Google-Smtp-Source: ABdhPJyKapemGEMJ+oiRHHIk+xiUwqOqgxkK1126yB2yYflqm+sLMNs5knM5JE9Oh1WDASGMBmxR4Q==
X-Received: by 2002:aa7:92d0:0:b0:44c:ab24:cce7 with SMTP id k16-20020aa792d0000000b0044cab24cce7mr370069pfa.6.1633555512314;
        Wed, 06 Oct 2021 14:25:12 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id i9sm18264104pfd.32.2021.10.06.14.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:25:11 -0700 (PDT)
Date:   Thu, 7 Oct 2021 06:25:09 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, X86 ML <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        Openrisc <openrisc@lists.librecores.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        SH-Linux <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/12] openrisc: Use of_get_cpu_hwid()
Message-ID: <YV4UNQg3QROuTfQ/@antec>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-7-robh@kernel.org>
 <YV4KkAC2p9D4yCnH@antec>
 <CAL_JsqLv+Ym=hxxz2vm0H3pbx1FRkBpHs3V=8DKjG43n+gS+RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLv+Ym=hxxz2vm0H3pbx1FRkBpHs3V=8DKjG43n+gS+RA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Oct 06, 2021 at 04:08:38PM -0500, Rob Herring wrote:
> On Wed, Oct 6, 2021 at 3:44 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Wed, Oct 06, 2021 at 11:43:26AM -0500, Rob Herring wrote:
> > > Replace open coded parsing of CPU nodes' 'reg' property with
> > > of_get_cpu_hwid().
> > >
> > > Cc: Jonas Bonn <jonas@southpole.se>
> > > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > > Cc: Stafford Horne <shorne@gmail.com>
> > > Cc: openrisc@lists.librecores.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  arch/openrisc/kernel/smp.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> > > index 415e209732a3..7d5a4f303a5a 100644
> > > --- a/arch/openrisc/kernel/smp.c
> > > +++ b/arch/openrisc/kernel/smp.c
> > > @@ -65,11 +65,7 @@ void __init smp_init_cpus(void)
> > >       u32 cpu_id;
> > >
> > >       for_each_of_cpu_node(cpu) {
> > > -             if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> > > -                     pr_warn("%s missing reg property", cpu->full_name);
> > > -                     continue;
> > > -             }
> > > -
> > > +             cpu_id = of_get_cpu_hwid(cpu);
> 
> Oops, that should be: of_get_cpu_hwid(cpu, 0);

OK. I checked all other patches in the series, it seems OpenRISC was the only
one missing that.  Sorry I missed it initially.

> I thought I double checked all those...
> 
> > You have defined of_get_cpu_hwid to return u64, will this create compiler
> > warnings when since we are storing a u64 into a u32?
> 
> I'm counting on the caller to know the max size for their platform.

OK.

> >
> > It seems only if we make with W=3.
> >
> > I thought we usually warned on this.  Oh well, for the openrisc bits.
> 
> That's only on ptr truncation I think.

Right, that makes sense.

-Stafford
