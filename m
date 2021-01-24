Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B396CC433DB
	for <linux-sh@archiver.kernel.org>; Sun, 24 Jan 2021 20:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A46322C7B
	for <linux-sh@archiver.kernel.org>; Sun, 24 Jan 2021 20:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbhAXUkU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 24 Jan 2021 15:40:20 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:51296 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbhAXUkT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 24 Jan 2021 15:40:19 -0500
Date:   Sun, 24 Jan 2021 15:39:38 -0500
From:   Rich Felker <dalias@libc.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [GIT PULL] arch/sh updates for 5.11
Message-ID: <20210124203936.GU23432@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.libc.org/linux-sh tags/sh-for-5.11

for you to fetch changes up to b89bc060b53e7054e5c8ca11feea4bc884d83611:

  sh/intc: Restore devm_ioremap() alignment (2021-01-06 19:55:29 -0500)

----------------------------------------------------------------
Cleanup and warning fixes.

----------------------------------------------------------------
Andy Shevchenko (1):
      sh: Drop ARCH_NR_GPIOS definition

Christoph Hellwig (1):
      sh: remove CONFIG_IDE from most defconfig

Geert Uytterhoeven (1):
      sh/intc: Restore devm_ioremap() alignment

Jinyang He (1):
      sh: Remove unused HAVE_COPY_THREAD_TLS macro

Necip Fazil Yildiran (1):
      sh: dma: fix kconfig dependency for G2_DMA

Qinglang Miao (2):
      sh: intc: Convert to DEFINE_SHOW_ATTRIBUTE
      sh: mm: Convert to DEFINE_SHOW_ATTRIBUTE

Randy Dunlap (1):
      arch/sh: hyphenate Non-Uniform in Kconfig prompt

Wang Qing (2):
      arch: sh: remove duplicate include
      sh: mach-sh03: remove duplicate include

 arch/sh/Kconfig                    |  1 -
 arch/sh/boards/mach-sh03/rtc.c     |  1 -
 arch/sh/configs/landisk_defconfig  |  9 ++++-----
 arch/sh/configs/microdev_defconfig |  2 --
 arch/sh/configs/sdk7780_defconfig  |  6 ++----
 arch/sh/configs/sdk7786_defconfig  |  3 ---
 arch/sh/configs/se7750_defconfig   |  1 -
 arch/sh/configs/sh03_defconfig     |  3 ---
 arch/sh/drivers/dma/Kconfig        |  3 +--
 arch/sh/include/asm/gpio.h         |  1 -
 arch/sh/kernel/cpu/sh3/entry.S     |  1 -
 arch/sh/mm/Kconfig                 |  2 +-
 arch/sh/mm/asids-debugfs.c         | 15 ++-------------
 arch/sh/mm/cache-debugfs.c         | 15 ++-------------
 arch/sh/mm/pmb.c                   | 15 ++-------------
 drivers/sh/intc/core.c             |  2 +-
 drivers/sh/intc/virq-debugfs.c     | 14 ++------------
 17 files changed, 17 insertions(+), 77 deletions(-)
