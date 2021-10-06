Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40BCC433F5
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87237610E5
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhJFQpa (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:30 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42793 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhJFQp2 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:28 -0400
Received: by mail-oi1-f175.google.com with SMTP id x187so2464276oix.9;
        Wed, 06 Oct 2021 09:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jBzMvIMgnR7M/3yhI7B+vslrQk5E3C0Pdi0d+USOXmM=;
        b=lKAeLC9r17NMcHj0W2tJAF27RAB1XfMR5afeQawc9v55LcLokP8Q3ou8GzO7qSBm0y
         cM4kwUZOwBsCnieLBo0vkzBSQYa2saturs8bXxE2benYdciWglT7e2IG0nwB2PHUyVU/
         YnIIpJYDQbFIDOQivrp+skZmgZnpVY4CTW8pvYKNLy25LuKJHidKSgNEPx7goAn4OGLo
         1tq48eaytUxxezZd2xCzMahOly8TEYixkecUZAORcIrv1PGVX1osBBA5psSxReGyFJt2
         YqLI+8nc4zfyDYt1XEykLqsFIYICT6Szq9iph7gpp/3z1dEP48qEp0ZsCrrEvDLFGaiD
         H78w==
X-Gm-Message-State: AOAM532najdQMh0/57fxxP1ii9hOgyyftOHITSqh8tILxG1UFe+ejvJ/
        FDu4pNeAg80YxkqOX+vjTg==
X-Google-Smtp-Source: ABdhPJx7CXhXT5M1W0CAhtBp2h8eMcQ5I0cRndKVwy8olo5SejcUQh3JemHdw8Jrz5VsbxC5vFcqCA==
X-Received: by 2002:a05:6808:2221:: with SMTP id bd33mr8117373oib.64.1633538615382;
        Wed, 06 Oct 2021 09:43:35 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
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
Subject: [PATCH 00/12] DT: CPU h/w id parsing clean-ups and cacheinfo id support
Date:   Wed,  6 Oct 2021 11:43:20 -0500
Message-Id: <20211006164332.1981454-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The first 10 patches add a new function, of_get_cpu_hwid(), which parses
CPU DT node 'reg' property, and then use it to replace all the open
coded versions of parsing CPU node 'reg' properties.

The last 2 patches add support for populating the cacheinfo 'id' on DT
platforms. The minimum associated CPU hwid is used for the id. The id is
optional, but necessary for resctrl which is being adapted for Arm MPAM.

Tested on arm64. Compile tested on arm, x86 and powerpc.

Rob

Rob Herring (12):
  of: Add of_get_cpu_hwid() to read hardware ID from CPU nodes
  ARM: Use of_get_cpu_hwid()
  ARM: broadcom: Use of_get_cpu_hwid()
  arm64: Use of_get_cpu_hwid()
  csky: Use of_get_cpu_hwid()
  openrisc: Use of_get_cpu_hwid()
  powerpc: Use of_get_cpu_hwid()
  riscv: Use of_get_cpu_hwid()
  sh: Use of_get_cpu_hwid()
  x86: dt: Use of_get_cpu_hwid()
  cacheinfo: Allow for >32-bit cache 'id'
  cacheinfo: Set cache 'id' based on DT data

 arch/arm/kernel/devtree.c       | 22 ++-------------------
 arch/arm/mach-bcm/bcm63xx_pmb.c |  6 +++---
 arch/arm64/kernel/smp.c         | 31 ++----------------------------
 arch/csky/kernel/smp.c          |  6 ++----
 arch/openrisc/kernel/smp.c      |  6 +-----
 arch/powerpc/kernel/smp.c       |  7 +------
 arch/riscv/kernel/cpu.c         |  3 ++-
 arch/sh/boards/of-generic.c     |  5 ++---
 arch/x86/kernel/devicetree.c    |  5 ++---
 drivers/base/cacheinfo.c        | 34 ++++++++++++++++++++++++++++++++-
 drivers/of/base.c               | 22 +++++++++++++++++++++
 include/linux/cacheinfo.h       |  2 +-
 include/linux/of.h              |  1 +
 13 files changed, 74 insertions(+), 76 deletions(-)

-- 
2.30.2

