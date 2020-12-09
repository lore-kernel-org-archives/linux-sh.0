Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EB8C433FE
	for <linux-sh@archiver.kernel.org>; Wed,  9 Dec 2020 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E30823B6B
	for <linux-sh@archiver.kernel.org>; Wed,  9 Dec 2020 17:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbgLIR14 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732750AbgLIR1f (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 9 Dec 2020 12:27:35 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99568C0613CF
        for <linux-sh@vger.kernel.org>; Wed,  9 Dec 2020 09:26:54 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id u19so2446501edx.2
        for <linux-sh@vger.kernel.org>; Wed, 09 Dec 2020 09:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SbpP1XQ1shPBp8DaFALcEJRwJn/qLid/T4j1wfzXX2o=;
        b=RX/3O64wEoA8L5MH4PpczX1DZlxGQaB+9SAa011g5eFqqIvulSZZtV9MPQ1tEUQnki
         0mNybMGkFsBxQl6ei1ZepCoPCgpqoCLHHydoOy1jLf5HJpTROpiBPBmHlt3ed5F6K6Sl
         NxUAdwkIMXrJxrwQd5+z9I/AujZMb6/VnMkcL84PBecYOagcC0wF7maC5LP5OS/RXbA3
         uBHNvUm5NKsAHgC254QDtXXkm6cFpMB1Msxj7yG7yeEvxT8UjdPiGXGlZnWqXYhgszEp
         snm2BZ27CeKdjtJ1U6LjlKQeymX+KjO37ZUufaVA+xIq2ogLR1l/BbZP4yp9oTzU0PhV
         Wyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SbpP1XQ1shPBp8DaFALcEJRwJn/qLid/T4j1wfzXX2o=;
        b=Y+kpT1WYEtICH/DLcBVFMHhv+6zrUSowGuy+fVHe+X5I1i0+s1s5mOxBSIZFmLrFQ5
         aLp5NRsfLCeV1V+cP3g4K5GCkyzUiHVZObPqiSem7Y/5a2Wbr7LDVFW07ASqwUNoi768
         xuDE/dIOkoDYDluPWhsh69G2530/4puxC5Ee5u0WvCyj/dQnO8RMBhJ/+3xX8Fi/PjCN
         EFESU8wmlVtR1fdqAMwdWG10SW2GXtGRGhTwe5eRx7uQvSODI4YUrvGHRRxo21k10oIJ
         WSMspj5MUern9ziQqs9A1pqwz9FqDVEog9RMtPPcs08w3NRY2SlqjpabqPsrJ1JzVyl7
         C8lQ==
X-Gm-Message-State: AOAM532wJRq6sCBwg687a/MiC00vnil3vqBiHsQFQMC5gtDhggew3mKE
        HRSkYcGcMRO9GWsnW8cj7iW9Rw+7MjF8kA0T5Gki7fzy3Qy84JM5
X-Google-Smtp-Source: ABdhPJxtFSQIIMnrBsJ0bpGv4WvcU1daI5mAFaXtkcrw7IxWFgjZZ1oHf1G7LYYXJd2CgIGahoa8K9Jf5BHuyZLhA7k=
X-Received: by 2002:aa7:d75a:: with SMTP id a26mr2931708eds.230.1607534813254;
 Wed, 09 Dec 2020 09:26:53 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Dec 2020 22:56:42 +0530
Message-ID: <CA+G9fYuNKqyvku1im6_zS5PjK9nG3Jf6qNwpQjaB8WRWO5BXzA@mail.gmail.com>
Subject: [sh] smp-shx3.c: error: ignoring return value of 'request_irq',
 declared with attribute warn_unused_result
To:     open list <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org,
        lkft-triage@lists.linaro.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Linux next 20201209 tag the arch 'sh' defconfig build failed to build with
gcc-8, gcc-9 and gcc-10.

arch/sh/kernel/cpu/sh4a/smp-shx3.c: In function 'shx3_prepare_cpus':
arch/sh/kernel/cpu/sh4a/smp-shx3.c:76:3: error: ignoring return value
of 'request_irq', declared with attribute warn_unused_result
[-Werror=unused-result]
   request_irq(104 + i, ipi_interrupt_handler,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        IRQF_PERCPU, "IPI", (void *)(long)i);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:
-------------------
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

tuxmake --runtime docker --target-arch sh --toolchain gcc-9 --kconfig defconfig

metadata:
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    target_arch: sh
    toolchain: gcc-9
    git_short_log: 2f1d5c77f13f (\Add linux-next specific files for 20201209\)
    git_sha: 2f1d5c77f13fe64497c2e2601605f7d7ec4da9b1
    git_describe: next-20201209
    download_url: https://builds.tuxbuild.com/1lPwmsuPj4eW5gsLeObYvbXC3fw/

Full build log,
https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/899463251

-- 
Linaro LKFT
https://lkft.linaro.org
