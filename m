Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA70C61DA4
	for <linux-sh@archiver.kernel.org>; Tue, 14 Feb 2023 08:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBNIN3 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Feb 2023 03:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjBNINR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Feb 2023 03:13:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CA53AB0
        for <linux-sh@vger.kernel.org>; Tue, 14 Feb 2023 00:13:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so10927196wms.0
        for <linux-sh@vger.kernel.org>; Tue, 14 Feb 2023 00:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRk5ZZgGHESQjRAciCkzTAgvsM2DNZ9ZsvdntVwJ0aM=;
        b=VyF1fPdQ9QypQQWSzFllqGzI7seyTSuDNNWwfWkkysTNgd3Z0AjIHNF4LL0vR9kDt1
         TWXLrpk12hmDLU5xwDRS8oUfZzApeC/OHNNgO/kMt5igi3066XuNNQHPHFYxq5aB3Iio
         Rm5A78vOgv0qZPG3TgPZ61nsLc76jlc9DVGKtErGMeKDI9u1sAq/m/nABeTJZydjJdxc
         KGyGm1+PtUnlS5irzivoc/koNSZhBHg8b061deMm/1IYjdDegSeovedsXz378PrcPSkc
         AtwiyODrhxTX3DivF8dzOcKQXifNwgDmLtIw7KfLqn/lQcvbpYuvCV1bwFmaRQqmk4vF
         cK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRk5ZZgGHESQjRAciCkzTAgvsM2DNZ9ZsvdntVwJ0aM=;
        b=W6VkSxmFGLLQt6pnTSBz+OqWdfCVmcSz7RyLHGAiJ3EpQhKvrMehzAimfAKC13sld6
         SHdVnVEfe3Tmx5gl9jRxM8/uMp1vlSedPeJd1Z3rzRn9lua6+Gl/BxTk59mBF753sIrd
         tciMxx2ROiSyfERENPpnl1YZlEht+it9pCUJ7TEWHWnV2urGLh4sWUms06bru4deoGzE
         upt12cXXn8LB2bQKVHsGZ59ZrrBj6/UFC4qW2PShS9pOxP/ijnH0kFBLIIb+XDTg4Jgp
         3vx5x8Ioe3/Nuc5Hy/wGDNoJyyGG144bUCLoxXytqwGsq4pqclECKfM62zCXUEZ9GYR9
         rAwA==
X-Gm-Message-State: AO0yUKWH+AnOrGkBphf9U6dOAYDVxtq6qQbWgFHx/EFmFl9IJ4Vwviqu
        qsByhWY8BmXR5zM8gv43V3D/hw==
X-Google-Smtp-Source: AK7set86AEK8D+D8+uPrCG75m0oQUNX8HZoOAkr8DDcCJCZFL80/CRikdClz+P95k5T2L/MBj1J/jQ==
X-Received: by 2002:a05:600c:30d2:b0:3dc:4fd7:31f7 with SMTP id h18-20020a05600c30d200b003dc4fd731f7mr1177763wmn.41.1676362392093;
        Tue, 14 Feb 2023 00:13:12 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b003db1ca20170sm17626418wmq.37.2023.02.14.00.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:13:11 -0800 (PST)
Message-ID: <14274f04-2991-95bd-c29b-07e86e8755c1@linaro.org>
Date:   Tue, 14 Feb 2023 09:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 04/24] arm64/cpu: Mark cpu_die() __noreturn
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
 <e47fc487980d5330e6059ac6e16416bec88cda0e.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e47fc487980d5330e6059ac6e16416bec88cda0e.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 14/2/23 08:05, Josh Poimboeuf wrote:
> cpu_die() doesn't return.  Annotate it as such.  By extension this also
> makes arch_cpu_idle_dead() noreturn.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/arm64/include/asm/smp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index fc55f5a57a06..5733a31bab08 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -100,7 +100,7 @@ static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
>   extern int __cpu_disable(void);
>   
>   extern void __cpu_die(unsigned int cpu);
> -extern void cpu_die(void);
> +extern void __noreturn cpu_die(void);
>   extern void cpu_die_early(void);

Shouldn't cpu_operations::cpu_die() be declared noreturn first?

