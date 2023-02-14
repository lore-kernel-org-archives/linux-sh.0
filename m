Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DDFC6379F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Feb 2023 07:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBNHqt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Feb 2023 02:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBNHqs (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Feb 2023 02:46:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771511B305
        for <linux-sh@vger.kernel.org>; Mon, 13 Feb 2023 23:46:46 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so10880001wms.0
        for <linux-sh@vger.kernel.org>; Mon, 13 Feb 2023 23:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DacxiEr/DRTGj0ihMvkUuLy+Ahw15SkCabwK0cVB44w=;
        b=qDhFLdhlw3fk5+cbylV4EuicP2cp1j6GaEdWR75BFZ5cfMBViuHmoRACKTBq3oTz7n
         rVewYzdKSuwUurougp6CYy6IznFyHmrUwCi8u3DL9kS12KPbFLP07ynhro3+WFQSogl7
         uRbm7TyoTfgCngAGgMH6zAG0xNfoturbGAhE6YPUOw/BHGya7N+sX2wG73atfoGfioqV
         mZ44LWGz/XNdw1/lRFvORgWHtF//Vi0ebYhMCr3UkzP1JnplE/haXspQGjcP6TSdlIoQ
         MCUGIt9+T8hGMtruIPo9k19B4TRRKfvoX7D14PPhoPGCN7rLnhONxg37CYK0ltz3+z7L
         rxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DacxiEr/DRTGj0ihMvkUuLy+Ahw15SkCabwK0cVB44w=;
        b=qN0XLSx/ar7V0UMDmCrXqSVeOEYmAf068kd2mrRz1gK2h8GMgyDUjfuAcim9SA8JZ0
         5GKtqBmELKsL3RJk3WPmiQZMeOuSIYu26PjTx6h0+zx54xM/ikFjrdg9H/x39JjkO5hs
         oBxvL5A0TXEFjM5bZdeCjgLQCADVJrHfhQ9FqO92HGP2SJOknEKz/suOj4SmS8YNDRdI
         4nm7WDjGuRKwkt3RnB06uAG5CkPpG3TNJ7JurP75d18FnzHwO7k5+jtcXffKlGzknqMz
         lOQRmkQd34PepGQziS7ySUAZWlhsdePvvoDWpm9SRTdHI978RvuZzI6l5YrGvxPulqIQ
         nxCA==
X-Gm-Message-State: AO0yUKXgBfST+uwAj0q1BjKQR8H+0FeC0IDqgPvd+E4u0cmZRwe4GOyu
        MSocsZzJyEg9P0Puemmu6/IMUA==
X-Google-Smtp-Source: AK7set9Rqo60IwHxoePnD0qX8izJ2ESap7X64zOUHv8nkLWZxobCJ+rymd6DUJKr/uol+6YPFby3eQ==
X-Received: by 2002:a05:600c:993:b0:3df:50eb:7ca6 with SMTP id w19-20020a05600c099300b003df50eb7ca6mr1103969wmp.15.1676360804870;
        Mon, 13 Feb 2023 23:46:44 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b003de8a1b06c0sm19248993wml.7.2023.02.13.23.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:46:44 -0800 (PST)
Message-ID: <080a5ccb-7fa0-1a75-538f-a09dc146fc4e@linaro.org>
Date:   Tue, 14 Feb 2023 08:46:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 09/24] mips/cpu: Expose play_dead()'s prototype
 definition
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <39835bc75af2e812fce56400533cb2ab41bcf0e2.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <39835bc75af2e812fce56400533cb2ab41bcf0e2.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Josh,

On 14/2/23 08:05, Josh Poimboeuf wrote:
> Include <asm/smp.h> to make sure play_dead() matches its prototype going
> forward.
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/mips/kernel/smp-bmips.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
> index f5d7bfa3472a..df9158e8329d 100644
> --- a/arch/mips/kernel/smp-bmips.c
> +++ b/arch/mips/kernel/smp-bmips.c
> @@ -38,6 +38,7 @@
>   #include <asm/traps.h>
>   #include <asm/barrier.h>
>   #include <asm/cpu-features.h>
> +#include <asm/smp.h>

What about the other implementations?

$ git grep -L asm/smp.h $(git grep -wlF 'play_dead(void)' arch/mips)
arch/mips/cavium-octeon/smp.c
arch/mips/kernel/smp-bmips.c
arch/mips/kernel/smp-cps.c
arch/mips/loongson64/smp.c

