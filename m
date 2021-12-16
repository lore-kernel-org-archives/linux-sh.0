Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A88C433F5
	for <linux-sh@archiver.kernel.org>; Thu, 16 Dec 2021 09:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhLPJpH (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 16 Dec 2021 04:45:07 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50876
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235538AbhLPJpF (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 16 Dec 2021 04:45:05 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 956873F1C6
        for <linux-sh@vger.kernel.org>; Thu, 16 Dec 2021 09:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639647904;
        bh=QTOsClZwyZOKWiOCdpIZ53KKqBtgpNixsjVEw+qtuPg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Fwvm1aEwvJi2RzvYvod1/X/13R8sYSl5aeAgnrWSE8Kvv1DjWFiBffCQduPZADaYP
         F16GKzjubqOMv+zah0cs6Cs9hxmhnxWUkiz0IjnPf9/VwRNtufBR+nemn1niFxgBua
         GTvaXm8k0N+BZU8rSed7azRzCWsegc71zbBLVR4InBuyvuiN4B5T5CphAk/RM56pYu
         W7T3n7RxwQQglRNj6OSEGoLSaP8hy81dXXTiuxIllNt9oA71LF0uiyjDMLxGwsUWmU
         Ul/E7IPYGuETcKH6WYrqMCtN6wqUy/XpUfN6kKFhAxYuJXG2A0UL8iLahZHVtvqWZK
         xLwUPT4nle2Ug==
Received: by mail-ed1-f70.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so22725623edx.9
        for <linux-sh@vger.kernel.org>; Thu, 16 Dec 2021 01:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTOsClZwyZOKWiOCdpIZ53KKqBtgpNixsjVEw+qtuPg=;
        b=LTXgCel9yqVoyGndTzrkpDwEbYZY15Tnh+sVRirx3ZdV99Bpamhm45+j12nMhblVkv
         jq2fRoRWVbBQqmrnAAe4jF03/g2cvLDr66Yfd3Bn6wGRQeoc/EH3spUUd5geBg+lj36W
         LtfhPtO8W+p6UuJ4tCEZzMARnG5PK1YtAEgR60Bl0Azpamtt9qC2Bhtymt6n5jlL7cMh
         LctgqhPjXfQaoshOTdDg2s74U8OYPL5m02YdEOhkgHioax8s+AQT7+OvlqKV9aytQWMD
         EI5F9/fe2VaAz9nuxcEgilA2mqHe9wXiR77ROao65HzKcArd0SQa9ZqRlTDpGf5cxc/U
         t1Zg==
X-Gm-Message-State: AOAM531mpqM7MbmlXCnbLoRf2LWeYG/kQVR53EeAmpB5deyYA5ZBl//F
        sdgNqVbTHf71hTSRTf6SCz3HlT0b4bBpU3tZhOlPmMtUU1KulIuyGm2VeluV1FfRBeCyjbbb4Xw
        nEsTKmvMI+0paV+Rax+axaY16KlylTJmgpbtE
X-Received: by 2002:a5d:650f:: with SMTP id x15mr646222wru.57.1639647893945;
        Thu, 16 Dec 2021 01:44:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZMiPMQ+W+qW8IbAibX8DdTl4xnrovvGfEQoGvcsc6W8MrweFtPS/7ET8ki9T9yPPhmGQd1g==
X-Received: by 2002:a5d:650f:: with SMTP id x15mr646199wru.57.1639647893659;
        Thu, 16 Dec 2021 01:44:53 -0800 (PST)
Received: from alex.home (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id h4sm4313251wrf.93.2021.12.16.01.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 01:44:53 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 0/6] Cleanup after removal of configs
Date:   Thu, 16 Dec 2021 10:44:20 +0100
Message-Id: <20211216094426.2083802-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

While bumping from 5.13 to 5.15, I found that a few deleted configs had
left some pieces here and there: this patchset cleans that.

Changes in v2:
- Rebase on top of v5.16-rc1
- Removed patch 6 since Matti said he would take care of that
- Added AB, RB

Alexandre Ghiti (6):
  Documentation, arch: Remove leftovers from fscache/cachefiles
    histograms
  Documentation, arch: Remove leftovers from raw device
  Documentation, arch: Remove leftovers from CIFS_WEAK_PW_HASH
  arch: Remove leftovers from mandatory file locking
  Documentation, arch, fs: Remove leftovers from fscache object list
  arch: Remove leftovers from prism54 wireless driver

 Documentation/admin-guide/cifs/usage.rst      |   7 +-
 Documentation/admin-guide/devices.txt         |   8 +-
 .../filesystems/caching/cachefiles.rst        |  34 -----
 Documentation/filesystems/caching/fscache.rst | 123 +-----------------
 arch/arm/configs/axm55xx_defconfig            |   3 -
 arch/arm/configs/cm_x300_defconfig            |   1 -
 arch/arm/configs/ezx_defconfig                |   1 -
 arch/arm/configs/imote2_defconfig             |   1 -
 arch/arm/configs/nhk8815_defconfig            |   1 -
 arch/arm/configs/pxa_defconfig                |   1 -
 arch/arm/configs/spear13xx_defconfig          |   1 -
 arch/arm/configs/spear3xx_defconfig           |   1 -
 arch/arm/configs/spear6xx_defconfig           |   1 -
 arch/mips/configs/decstation_64_defconfig     |   1 -
 arch/mips/configs/decstation_defconfig        |   1 -
 arch/mips/configs/decstation_r4k_defconfig    |   1 -
 arch/mips/configs/fuloong2e_defconfig         |   1 -
 arch/mips/configs/ip27_defconfig              |   1 -
 arch/mips/configs/malta_defconfig             |   1 -
 arch/mips/configs/malta_kvm_defconfig         |   1 -
 arch/mips/configs/malta_qemu_32r6_defconfig   |   1 -
 arch/mips/configs/maltaaprp_defconfig         |   1 -
 arch/mips/configs/maltasmvp_defconfig         |   1 -
 arch/mips/configs/maltasmvp_eva_defconfig     |   1 -
 arch/mips/configs/maltaup_defconfig           |   1 -
 arch/mips/configs/maltaup_xpa_defconfig       |   1 -
 arch/powerpc/configs/pmac32_defconfig         |   1 -
 arch/powerpc/configs/ppc6xx_defconfig         |   1 -
 arch/powerpc/configs/pseries_defconfig        |   1 -
 arch/sh/configs/titan_defconfig               |   1 -
 fs/fscache/object.c                           |   3 -
 fs/fscache/proc.c                             |  12 --
 32 files changed, 6 insertions(+), 209 deletions(-)

-- 
2.32.0

