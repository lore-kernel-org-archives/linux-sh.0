Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3251BC433FE
	for <linux-sh@archiver.kernel.org>; Wed, 27 Oct 2021 23:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BE4610CB
	for <linux-sh@archiver.kernel.org>; Wed, 27 Oct 2021 23:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhJ0XLj (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 27 Oct 2021 19:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhJ0XLe (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 27 Oct 2021 19:11:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6ACC061224
        for <linux-sh@vger.kernel.org>; Wed, 27 Oct 2021 16:09:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r5so3109339pls.1
        for <linux-sh@vger.kernel.org>; Wed, 27 Oct 2021 16:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XJfFTW9EjYJeHoclf1SeEwj25PLenE7ts5EFTr8vzec=;
        b=vYjyS+8EH3CfIBezSrdmSEFFSJc1bpK8IsDLNwp4SIdgzIr0qhB73jSdQ+tZtt+gKe
         gLRCAnofL8DMkcE7vLBKcZfntvEYsCybXJMFIekVgyaoqoB4d2yoy2/fxl6NKOgXIYmd
         GMEiLNFKg0iVmrnBvlpV4pv/PV+nqVeQwlB1PLBrwM8b8vjtjZjGvc3MJRrAfuUoDBNo
         ViaF9lo0gQuECLSnf0dUVzQmZPRvjI+cvfCWgH2cYeMbb2VhrXJlj9sEs5Y4vYC263de
         h2wbGwEHNdbZkGS/4AP/MxQ7HKYBbqiVTjD7lo6//33sqHBHnP35ISg1TmvMKaMznq9A
         cKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XJfFTW9EjYJeHoclf1SeEwj25PLenE7ts5EFTr8vzec=;
        b=ySk1nTwQ71AZS7AKT2mhpjUzsv2tEOJZjRGRML7dKUupK8oNw16V2FGYJa0tukgC3j
         ST1f0xUMAa0DtzTl1nZznYPXc+Vm2FpgmpiOWuF+l6R2nCkgq9J4mmN8RjGvoc6lxV8i
         f3en5hL2tcK3nQ6YVA46R1z1XlRVERIfXl3CvbSAQQagMVFkaVmhnYww0FEKGnLPxGLL
         cOPI4xEJWk65tdXcEEFKAoikhQJaQjbppsRR3LkrwJbwfq3lUoH7oyeXrXtXasZ4qsuZ
         PQVl2eqEtLGSPWj7OD8huODTXEC3JQbRVRIDpFQCM1k6gOOYuftNI8N4nlwmtR5YX6EF
         7q3A==
X-Gm-Message-State: AOAM533+e1Pudd/sTy50siL86VkyJYyetJRU90Tl0o7IIMcGDlp5H2xd
        I1KSyV1DLhbDmeWGZMON3xuxLQ==
X-Google-Smtp-Source: ABdhPJxUJYglQ4uyqyrvUHQJ2HBzLbAnkI4OfP0sJtC8YPLND6BbQ0gKrpcxmED13rpzsyQoceaG3g==
X-Received: by 2002:a17:903:246:b0:13f:2ff9:8b93 with SMTP id j6-20020a170903024600b0013f2ff98b93mr652035plh.54.1635376148047;
        Wed, 27 Oct 2021 16:09:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:60fc:a50:6d27:9fd3])
        by smtp.gmail.com with ESMTPSA id bg15sm739067pjb.15.2021.10.27.16.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:09:07 -0700 (PDT)
Date:   Wed, 27 Oct 2021 16:09:07 -0700 (PDT)
X-Google-Original-Date: Wed, 27 Oct 2021 16:09:01 PDT (-0700)
Subject:     Re: [PATCH v2 18/45] riscv: Use do_kernel_power_off()
In-Reply-To: <20211027211715.12671-19-digetx@gmail.com>
CC:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        lee.jones@linaro.org, rafael@kernel.org, broonie@kernel.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        linux@armlinux.org.uk, daniel.lezcano@linaro.org,
        andriy.shevchenko@linux.intel.com, ulf.hansson@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        geert@linux-m68k.org, gerg@linux-m68k.org, funaho@jurai.org,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, deanbo422@gmail.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ysato@users.sourceforge.jp, dalias@libc.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, lenb@kernel.org, ssantosh@kernel.org,
        krzysztof.kozlowski@canonical.com, linus.walleij@linaro.org,
        wens@csie.org, j.neuschaefer@gmx.net, tony@atomide.com,
        lgirdwood@gmail.com, p.zabel@pengutronix.de, vz@mleia.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        pavel@ucw.cz, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-omap@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     digetx@gmail.com
Message-ID: <mhng-fd8f451c-4860-4b0c-a155-6f65891cd276@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, 27 Oct 2021 14:16:48 PDT (-0700), digetx@gmail.com wrote:
> Kernel now supports chained power-off handlers. Use do_kernel_power_off()
> that invokes chained power-off handlers. It also invokes legacy
> pm_power_off() for now, which will be removed once all drivers will
> be converted to the new power-off API.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/riscv/kernel/reset.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
> index 9c842c41684a..912288572226 100644
> --- a/arch/riscv/kernel/reset.c
> +++ b/arch/riscv/kernel/reset.c
> @@ -23,16 +23,12 @@ void machine_restart(char *cmd)
>
>  void machine_halt(void)
>  {
> -	if (pm_power_off != NULL)
> -		pm_power_off();
> -	else
> -		default_power_off();
> +	do_kernel_power_off();
> +	default_power_off();
>  }
>
>  void machine_power_off(void)
>  {
> -	if (pm_power_off != NULL)
> -		pm_power_off();
> -	else
> -		default_power_off();
> +	do_kernel_power_off();
> +	default_power_off();
>  }

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>
