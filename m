Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903CFC433F5
	for <linux-sh@archiver.kernel.org>; Sun, 14 Nov 2021 18:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C20B60FDA
	for <linux-sh@archiver.kernel.org>; Sun, 14 Nov 2021 18:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhKNS4F (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 14 Nov 2021 13:56:05 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:56026 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbhKNS4E (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 14 Nov 2021 13:56:04 -0500
Date:   Sun, 14 Nov 2021 13:53:04 -0500
From:   Rich Felker <dalias@libc.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PULL] arch/sh updates for 5.16
Message-ID: <20211114185302.GA13363@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.libc.org/linux-sh tags/sh-for-5.16

for you to fetch changes up to 8518e694203d0bfd202ea4a80356785b6992322e:

  sh: pgtable-3level: Fix cast to pointer from integer of different size (2021-10-27 16:56:34 -0400)

----------------------------------------------------------------
arch/sh updates for 5.16

----------------------------------------------------------------
Al Viro (1):
      sh: fix trivial misannotations

Geert Uytterhoeven (1):
      sh: pgtable-3level: Fix cast to pointer from integer of different size

Kefeng Wang (1):
      sh: Cleanup about SPARSE_IRQ

Lu Wei (1):
      maple: fix wrong return value of maple_bus_init().

Masahiro Yamada (2):
      sh: boot: add intermediate vmlinux.bin* to targets instead of extra-y
      sh: boot: avoid unneeded rebuilds under arch/sh/boot/compressed/

Nick Desaulniers (1):
      sh: check return code of request_irq

Randy Dunlap (4):
      sh: fix kconfig unmet dependency warning for FRAME_POINTER
      sh: math-emu: drop unused functions
      sh: define __BIG_ENDIAN for math-emu
      sh: fix READ/WRITE redefinition warnings

Tang Bin (1):
      sh: boards: Fix the cacography in irq.c

Yejune Deng (1):
      sh: kdump: add some attribute to function

 arch/sh/Kconfig                      |   1 -
 arch/sh/Kconfig.debug                |   1 +
 arch/sh/boards/mach-landisk/irq.c    |   4 +-
 arch/sh/boot/Makefile                |   4 +-
 arch/sh/boot/compressed/.gitignore   |   5 --
 arch/sh/boot/compressed/Makefile     |  32 ++++----
 arch/sh/boot/compressed/ashiftrt.S   |   2 +
 arch/sh/boot/compressed/ashldi3.c    |   2 +
 arch/sh/boot/compressed/ashlsi3.S    |   2 +
 arch/sh/boot/compressed/ashrsi3.S    |   2 +
 arch/sh/boot/compressed/lshrsi3.S    |   2 +
 arch/sh/include/asm/checksum_32.h    |   5 +-
 arch/sh/include/asm/irq.h            |  11 ---
 arch/sh/include/asm/pgtable-3level.h |   2 +-
 arch/sh/include/asm/sfp-machine.h    |   8 ++
 arch/sh/include/asm/uaccess.h        |   4 +-
 arch/sh/kernel/cpu/sh4a/smp-shx3.c   |   5 +-
 arch/sh/kernel/crash_dump.c          |   4 +-
 arch/sh/kernel/traps_32.c            |   8 +-
 arch/sh/math-emu/math.c              | 147 ++++++-----------------------------
 arch/sh/mm/nommu.c                   |   4 +-
 drivers/sh/maple/maple.c             |   5 +-
 22 files changed, 79 insertions(+), 181 deletions(-)
 create mode 100644 arch/sh/boot/compressed/ashiftrt.S
 create mode 100644 arch/sh/boot/compressed/ashldi3.c
 create mode 100644 arch/sh/boot/compressed/ashlsi3.S
 create mode 100644 arch/sh/boot/compressed/ashrsi3.S
 create mode 100644 arch/sh/boot/compressed/lshrsi3.S
