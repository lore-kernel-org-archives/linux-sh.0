Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DC5C433FE
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 20:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C9461177
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 20:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbhJFUp4 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbhJFUp4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 16:45:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E5DC061753;
        Wed,  6 Oct 2021 13:44:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso4834837pjb.4;
        Wed, 06 Oct 2021 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uukXjZUQ/w+EOWxXqSK1+sdvRdmpSRZkmYypGawzIsM=;
        b=QT+moIpptwRsvjJhH6SoVjzQTZZ76DE7Nw9kqS29J/CEKIqSBkKNAPsy0jT6+cMT5r
         0B+0+QxpzmLLa3r7jEXnwxbIQgJkwMi/us4S+81A070jhHgCr7uQ+fbqDmEae7tJyZrW
         KXcNV8SnxYIgrHqlro0WODjOtXLW8X88ZHdiubGxyQ6s4VSefvMST/UT52GjNmBirP7J
         vPJrn4/h0HeMwFA9oFdn+ECv8WDQE4jLb4GwOzBBu4isPwb9sn2ye3J8U1vaLKqwIt6z
         g4sBC+3kK0eokeo5x1JO49TmdiQsp14FxekFKZ6n9Z+Jk+BJ4arhTM0CkIcl8c56mqWF
         a5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uukXjZUQ/w+EOWxXqSK1+sdvRdmpSRZkmYypGawzIsM=;
        b=VEFyg7RWWiqrBN1ghf0WFRGdya2NV8YeXc9yTR4umQ+RrbZmQMnKUMYk8M/hqdnAx9
         K4TGUGQ0ku+OwqDO4QXMmIPgXHNBiMVjRjkAJuiCrGyTpc5x1MXP4+815LugJU/VuzBi
         IqruQBBdfsjTnt5tGmGhd88L5AUoYYv34nPUMel02xhi0gxIbABqd+xUUpuNikXr24dZ
         VLMX65Pcl9NFDvaCjr1vOQdC58utfmHXSH+aKSSP0/nhZhaIaKe36FgkAt3ffrKDUdu5
         Y23a7SOxGTK2pfKN7NXyvcH7V+1bUFsOvlwh/gOyLVbDAl917qiYCUrGD95UapPmEDQ7
         EZ9w==
X-Gm-Message-State: AOAM533+Mmt0p51sP+xx9MaukHN+UPZrkiUr54ioP/lKQLYJI2phPS3z
        PlDjOgdiLE9rAi0JozSsR7w=
X-Google-Smtp-Source: ABdhPJxbN+u6234S13N4970pWpeBYhU6hjO3nALy/nZjNDvGJdvqZ+ABgTpyG64/0LL2Z6QM8DUU9w==
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id m1-20020a170902bb8100b0012da7ec3d85mr328965pls.17.1633553043180;
        Wed, 06 Oct 2021 13:44:03 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id q8sm5806904pja.52.2021.10.06.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:44:02 -0700 (PDT)
Date:   Thu, 7 Oct 2021 05:44:00 +0900
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
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/12] openrisc: Use of_get_cpu_hwid()
Message-ID: <YV4KkAC2p9D4yCnH@antec>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-7-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006164332.1981454-7-robh@kernel.org>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Oct 06, 2021 at 11:43:26AM -0500, Rob Herring wrote:
> Replace open coded parsing of CPU nodes' 'reg' property with
> of_get_cpu_hwid().
> 
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/openrisc/kernel/smp.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> index 415e209732a3..7d5a4f303a5a 100644
> --- a/arch/openrisc/kernel/smp.c
> +++ b/arch/openrisc/kernel/smp.c
> @@ -65,11 +65,7 @@ void __init smp_init_cpus(void)
>  	u32 cpu_id;
>  
>  	for_each_of_cpu_node(cpu) {
> -		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> -			pr_warn("%s missing reg property", cpu->full_name);
> -			continue;
> -		}
> -
> +		cpu_id = of_get_cpu_hwid(cpu);

You have defined of_get_cpu_hwid to return u64, will this create compiler
warnings when since we are storing a u64 into a u32?

It seems only if we make with W=3.

I thought we usually warned on this.  Oh well, for the openrisc bits.

Acked-by: Stafford Horne <shorne@gmail.com>

>  		if (cpu_id < NR_CPUS)
>  			set_cpu_possible(cpu_id, true);
>  	}
> -- 
> 2.30.2
> 
