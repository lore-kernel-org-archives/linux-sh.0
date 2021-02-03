Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C01C433E9
	for <linux-sh@archiver.kernel.org>; Wed,  3 Feb 2021 15:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F5964F65
	for <linux-sh@archiver.kernel.org>; Wed,  3 Feb 2021 15:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhBCPwW (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbhBCPwK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 Feb 2021 10:52:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7505C061788
        for <linux-sh@vger.kernel.org>; Wed,  3 Feb 2021 07:51:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id sa23so20245217ejb.0
        for <linux-sh@vger.kernel.org>; Wed, 03 Feb 2021 07:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8ZiZgrXUKTPqtav3uMw7TC7Q+Aei5KWAfNt52U+dlDQ=;
        b=rH0DqReYRnjwzpX31BARiullKEije5kg479qo/hGnERWhpgzpT4X1769vLah48SIwg
         v+RJT5IyfS6o/zlQKNZCKMovJUucHYl2vvVPHFmEM6RJtNQeyp604riUlPBTsVpDW373
         wo6gr7iWes5a1p9YYKBqNkERLiuQa+aqmylO8FIz7HD7P1E4gYQGlAco5XquUZvZim6b
         25bJTvBTgrihKk16rJPk3ZK6Q5Hpvm9ehj9Qkj2TgX7rYqHsAofeovyxj3iO85X6TK3i
         WqoqVY6lPLaJxyt3zE3Pq5HvpMDWIDK9VhhRy1IYd38sM452Mq7O4TGohXZartCXVE46
         Gf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8ZiZgrXUKTPqtav3uMw7TC7Q+Aei5KWAfNt52U+dlDQ=;
        b=jxJjG47iMUloyigiTOVYenHF6odiU7kVria1m7BMgb4+nPoHwijMsi2nfTKoTG5RoO
         GgiPKJwIknC9ZKwmt++L3Hk+2CxrcrZo57qv6elM57SEIRutkkwl08V7U7izr8mw7LsW
         3MTUHMQiHD7QJc6BlZTlyPimp5dk5nXItergAXUnJrjnQ3/ShHD9kVnZT2hfVTA8YwMv
         RNxEFETDhBBHVLUUcMMPOAMJOURl6WDt0Etxs9Rvqo8BFxPUsEn2MUQaz9kKNnprFHPy
         2EaP0gTkvQviBxw6mG9soOraKfz8dy8zp8hvCFyl0Y84sKtumBKCeGd+t/Yq9JuwHbro
         QG7A==
X-Gm-Message-State: AOAM533MLKG8EB+EREDGHfnJuIecAlgBcfWmH0JnBcMw3aSycTmE9q9O
        Yeni+iSXN+wXfDyppEnJ6kTnwy6G5CvJ//qnI4ZzfQ==
X-Google-Smtp-Source: ABdhPJw325Fj8DcUghMscoJ2RIXBEp961uIMC8z8Cv3Nbs+QLRe4xLzgr/K6gPQUWefmsx1FIqrtaU0BHyw9vjMq0Pc=
X-Received: by 2002:a17:906:ca0d:: with SMTP id jt13mr3721106ejb.170.1612367488351;
 Wed, 03 Feb 2021 07:51:28 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 3 Feb 2021 21:21:16 +0530
Message-ID: <CA+G9fYv-=GdpLK3-6M9P4J1N-4ypS=GO8T2N15JFWXSmsG1adQ@mail.gmail.com>
Subject: memory_model.h:64:14: error: implicit declaration of function 'page_to_section'
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Linux next tag 20210203 the mips and sh builds failed due to below errors.
Following builds failed with gcc-8, gcc-9 and gcc-10,
  - mips (cavium_octeon_defconfig)
  - sh (defconfig)
  - sh (shx3_defconfig)

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=mips
CROSS_COMPILE=mips-linux-gnu- 'CC=sccache mips-linux-gnu-gcc'
'HOSTCC=sccache gcc' uImage.gz
In file included from arch/mips/include/asm/page.h:258,
                 from arch/mips/include/asm/io.h:29,
                 from include/linux/io.h:13,
                 from arch/mips/include/asm/mips-cps.h:10,
                 from arch/mips/include/asm/smp-ops.h:16,
                 from arch/mips/include/asm/smp.h:21,
                 from include/linux/smp.h:84,
                 from arch/mips/include/asm/cpu-type.h:12,
                 from arch/mips/include/asm/timex.h:19,
                 from include/linux/timex.h:65,
                 from include/linux/time32.h:13,
                 from include/linux/time.h:60,
                 from include/linux/compat.h:10,
                 from arch/mips/kernel/asm-offsets.c:12:
include/linux/mm.h: In function 'is_pinnable_page':
include/asm-generic/memory_model.h:64:14: error: implicit declaration
of function 'page_to_section'; did you mean 'present_section'?
[-Werror=implicit-function-declaration]
  int __sec = page_to_section(__pg);   \
              ^~~~~~~~~~~~~~~
include/asm-generic/memory_model.h:81:21: note: in expansion of macro
'__page_to_pfn'
 #define page_to_pfn __page_to_pfn
                     ^~~~~~~~~~~~~
include/linux/mm.h:1135:15: note: in expansion of macro 'page_to_pfn'
   is_zero_pfn(page_to_pfn(page));
               ^~~~~~~~~~~
In file included from arch/mips/kernel/asm-offsets.c:15:
include/linux/mm.h: At top level:
include/linux/mm.h:1512:29: error: conflicting types for 'page_to_section'
 static inline unsigned long page_to_section(const struct page *page)
                             ^~~~~~~~~~~~~~~
Steps to reproduce:
--------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.


tuxmake --runtime podman --target-arch mips --toolchain gcc-10
--kconfig cavium_octeon_defconfig


-- 
Linaro LKFT
https://lkft.linaro.org
