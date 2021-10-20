Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E62C433EF
	for <linux-sh@archiver.kernel.org>; Wed, 20 Oct 2021 18:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F696103D
	for <linux-sh@archiver.kernel.org>; Wed, 20 Oct 2021 18:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhJTSuW (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhJTSuR (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Wed, 20 Oct 2021 14:50:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A10E6103D;
        Wed, 20 Oct 2021 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634755683;
        bh=n8VrOe4I2yKWKENo2xOz+GrW26l+tosuZNQ1rYD5gKE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X8tKojH7Z8fdPyVTk4z+AoVAS3a9h5oYDEVDa7uI3b3vQWDC0RDkopnsSuFW09wMx
         S5ymoCHlxw+BZDcfi8a/SbXyaru92R/D/4JVacWcGVpk2lCHkMZKGKNpRCcpV4amQE
         0SC95mBmBf+xrbZsPKYOZ3Tw+i6Awvb4CDoD4fADso7xeFCGtNQbQjFeERWiYt5J4a
         XviC1MWcQkWkyhnJbBbb7MhB9KdUgixAetlN+ZjGulMI+TYlz6yOX8pi/IJu8QIrAm
         DPTPSRiUO2vc4Q2/LyUL9rJoQfRdVbdcu/SicgghaP/nLNsd5aIhVOahGYlBk3gw4h
         jokZEwKpwMQ/g==
Received: by mail-lf1-f42.google.com with SMTP id g36so328184lfv.3;
        Wed, 20 Oct 2021 11:48:02 -0700 (PDT)
X-Gm-Message-State: AOAM532bXNhmVLh6cfAOUxsJB+NDo+eiCLht4tPeKR4iEnlNWXGLeu4P
        /I69BmJlS2QuRZe9tLV1khZkLcBv1KlsB4zS7g==
X-Google-Smtp-Source: ABdhPJyDkQcU37hcsbyKe6namKZuEksRA+CPb1y/N+dx0XKOp77yba3905ZumF5lcfjyaXaZElnjUUGJ+2NqhJwXc9g=
X-Received: by 2002:aa7:cd0a:: with SMTP id b10mr942298edw.164.1634755670808;
 Wed, 20 Oct 2021 11:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211006164332.1981454-1-robh@kernel.org>
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 Oct 2021 13:47:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLg1=T52MqhsGgmAcRueC_nJdivGg4h+M2Bd8W3fyHCmg@mail.gmail.com>
Message-ID: <CAL_JsqLg1=T52MqhsGgmAcRueC_nJdivGg4h+M2Bd8W3fyHCmg@mail.gmail.com>
Subject: Re: [PATCH 00/12] DT: CPU h/w id parsing clean-ups and cacheinfo id support
To:     Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, X86 ML <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Oct 6, 2021 at 11:43 AM Rob Herring <robh@kernel.org> wrote:
>
> The first 10 patches add a new function, of_get_cpu_hwid(), which parses
> CPU DT node 'reg' property, and then use it to replace all the open
> coded versions of parsing CPU node 'reg' properties.
>
> The last 2 patches add support for populating the cacheinfo 'id' on DT
> platforms. The minimum associated CPU hwid is used for the id. The id is
> optional, but necessary for resctrl which is being adapted for Arm MPAM.
>
> Tested on arm64. Compile tested on arm, x86 and powerpc.
>
> Rob
>
> Rob Herring (12):
>   of: Add of_get_cpu_hwid() to read hardware ID from CPU nodes
>   ARM: Use of_get_cpu_hwid()
>   ARM: broadcom: Use of_get_cpu_hwid()
>   arm64: Use of_get_cpu_hwid()
>   csky: Use of_get_cpu_hwid()
>   openrisc: Use of_get_cpu_hwid()
>   powerpc: Use of_get_cpu_hwid()
>   riscv: Use of_get_cpu_hwid()
>   sh: Use of_get_cpu_hwid()
>   x86: dt: Use of_get_cpu_hwid()
>   cacheinfo: Allow for >32-bit cache 'id'
>   cacheinfo: Set cache 'id' based on DT data

I've fixed up the openrisc error and applied 1-10 to the DT tree.

The cacheinfo part is going to need some more work. I've found I will
need the cache affinity (of possible cpus) as well, so I plan to also
store the affinity instead of looping thru caches and cpus again.

Rob
