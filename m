Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8605DC433EF
	for <linux-sh@archiver.kernel.org>; Fri,  8 Oct 2021 11:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A85B61027
	for <linux-sh@archiver.kernel.org>; Fri,  8 Oct 2021 11:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbhJHLDZ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 8 Oct 2021 07:03:25 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:34297 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240117AbhJHLDY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 8 Oct 2021 07:03:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HQlcH5cyHz4xbV;
        Fri,  8 Oct 2021 22:01:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1633690887;
        bh=B4qzHAigKKJHhzM+dPDATq6BWHA36ShynfcFOX354Uw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ecgb6jGX08YbAx5B1reNn4h/kU3Gen7kievibOO69w+92xKGfimzG9blAbi2wPVuT
         bzRQvpw1Gsq6L5OISVmfgRGEMrtpfffTD3SxPCSAMjCA7BaSe9z1Uwt8UhxvwagCXt
         RG8jZ9yVbHmz/oZlWgdyytG8dpN+zilnWPdwvHzOrKK+z9cUFtnbh9EiaF6DvYThDq
         y+nA3s2Jr7OnqG1H9G2arDaiYJ9T+Ocn4v009hMVegWkEyhfV3tBa+fnPnVWJ1bKT9
         NTxKKbhG9DIb5b2JYg+QufFs7CUHZN2G28KnkHe3XTX54qxanjx0qe1ihehNmLNt3p
         OX9W1GxfbYAzQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
Subject: Re: [PATCH 07/12] powerpc: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-8-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-8-robh@kernel.org>
Date:   Fri, 08 Oct 2021 22:01:15 +1100
Message-ID: <8735pbok5g.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> Replace open coded parsing of CPU nodes' 'reg' property with
> of_get_cpu_hwid().
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/powerpc/kernel/smp.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 9cc7d3dbf439..d96b0e361a73 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1313,18 +1313,13 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  int cpu_to_core_id(int cpu)
>  {
>  	struct device_node *np;
> -	const __be32 *reg;
>  	int id = -1;
>  
>  	np = of_get_cpu_node(cpu, NULL);
>  	if (!np)
>  		goto out;
>  
> -	reg = of_get_property(np, "reg", NULL);
> -	if (!reg)
> -		goto out;
> -
> -	id = be32_to_cpup(reg);
> +	id = of_get_cpu_hwid(np, 0);
>  out:
>  	of_node_put(np);
>  	return id;

This looks OK to me.

All the systems I can find have a /cpus/#address-cells of 1, so the
change to use of_n_addr_cells() in of_get_cpu_hwid() should be fine.

I booted it on a bunch of systems with no issues.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
