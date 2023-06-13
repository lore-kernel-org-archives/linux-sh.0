Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2CEB64D0
	for <linux-sh@archiver.kernel.org>; Tue, 13 Jun 2023 15:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjFMPwy (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 13 Jun 2023 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbjFMPww (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 13 Jun 2023 11:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F406D1AC;
        Tue, 13 Jun 2023 08:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 049CF633BC;
        Tue, 13 Jun 2023 15:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D806C433F0;
        Tue, 13 Jun 2023 15:52:48 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Simek <monstr@monstr.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Move the ARCH_DMA_MINALIGN definition to asm/cache.h
Date:   Tue, 13 Jun 2023 16:52:42 +0100
Message-Id: <20230613155245.1228274-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi,

The ARCH_KMALLOC_MINALIGN reduction series defines a generic
ARCH_DMA_MINALIGN in linux/cache.h:

https://lore.kernel.org/r/20230612153201.554742-2-catalin.marinas@arm.com/

Unfortunately, this causes a duplicate definition warning for
microblaze, powerpc (32-bit only) and sh as these architectures define
ARCH_DMA_MINALIGN in a different file than asm/cache.h. Move the macro
to asm/cache.h to avoid this issue and also bring them in line with the
other architectures.

Andrew, if the arch maintainers cc'ed are fine with such change, could
you please take these three patches together with the
ARCH_KMALLOC_MINALIGN series?

Thank you.

Catalin Marinas (3):
  powerpc: Move the ARCH_DMA_MINALIGN definition to asm/cache.h
  microblaze: Move the ARCH_{DMA,SLAB}_MINALIGN definitions to
    asm/cache.h
  sh: Move the ARCH_DMA_MINALIGN definition to asm/cache.h

 arch/microblaze/include/asm/cache.h | 5 +++++
 arch/microblaze/include/asm/page.h  | 5 -----
 arch/powerpc/include/asm/cache.h    | 4 ++++
 arch/powerpc/include/asm/page_32.h  | 4 ----
 arch/sh/include/asm/cache.h         | 6 ++++++
 arch/sh/include/asm/page.h          | 6 ------
 6 files changed, 15 insertions(+), 15 deletions(-)

