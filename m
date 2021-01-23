Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A048C433DB
	for <linux-sh@archiver.kernel.org>; Sat, 23 Jan 2021 16:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565F622581
	for <linux-sh@archiver.kernel.org>; Sat, 23 Jan 2021 16:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbhAWQ55 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 23 Jan 2021 11:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWQ5z (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 23 Jan 2021 11:57:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29DAC06174A
        for <linux-sh@vger.kernel.org>; Sat, 23 Jan 2021 08:57:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 190so6945751wmz.0
        for <linux-sh@vger.kernel.org>; Sat, 23 Jan 2021 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skswexMnBRp+YiFP+stQMrUdlfm/pATxTq719Tzrsz8=;
        b=q6/89rcOwgpT7vyGUGu6HcfZAK58xGqQ4aSSsRB0RRv6HXGnsDB2JKEndXd12JI0bC
         1tzXxvq0hnV9rTji1ZSD+2gLf7NqBAobPIJzDYdesbz9kaK3aMTXCZoyGybSfTNngQ7A
         kmH8IPEH+wlIRxsS/YWaXJbdrJ3pFyV/P/o4Aon/NN40rijjVw5IfcgbueH0NJ4qMiuk
         D3pk1AC+fojueKvRKFBnLK6rZ53VYE2zKIrEkfrf7dSBAeEQialyN0WXNHRlXdCWY4M4
         GZyeTaz4JuK24bHfjG+9QOPEda34NrA6l7BdTxEtEZQ6pyg3sTQLMY+hMN19Sn/9cDP7
         NRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skswexMnBRp+YiFP+stQMrUdlfm/pATxTq719Tzrsz8=;
        b=m5YCQ5Pn1devzqTbAtKq3uN46B8Hwioevb3DNu2NM1+FDx66MW9ynDsEdzK/1Vvwcu
         3WBoZtCy4wiJZBe72ppVJeO8ouCiAYFXvNcitjlEYvin3uILZktJOEMoqTp9Fi6jmmPz
         Y8JUFb5vXduo/F2TavAawlw7KuODOvjM8ThmJKM1Nf7JM4PuFqeiKz/S16aq//ZxG1Vl
         4oI8fP1shJdxXJo26d7/p/kEGuioVr4HlDLNPSLjSMYrnEdak7KJXeloVEE/Lkk10X8d
         HnwVwpfFuyFtGZZKseWien9bzY45D8mxF8nRleVfms/EZoO6ll73X6YTgfgJwwhC8VNT
         nrwg==
X-Gm-Message-State: AOAM532fOw92vXi3BazdPpqwE0pqrztn1Qbrjb8TTmP2g1IoP2Sk+7DC
        +4BccOknCqNNROxqQ4c5g/y7Ldd8uk00dVZV7KM=
X-Google-Smtp-Source: ABdhPJx/LxC7ooaNnMOKIH4HRyqm7ttDZlvQy5CQQa6n3I206Ea9DFXV0KOuYvcCVJAyNIRx4SJRUQ==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr2856836wmb.25.1611421033160;
        Sat, 23 Jan 2021 08:57:13 -0800 (PST)
Received: from P-ASN-Vodka-geleg.numericable.fr (154.112.91.79.rev.sfr.net. [79.91.112.154])
        by smtp.gmail.com with ESMTPSA id v4sm16642902wrw.42.2021.01.23.08.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 08:57:12 -0800 (PST)
From:   =?UTF-8?q?Geoffrey=20Le=20Gourri=C3=A9rec?= 
        <geoffrey.legourrierec@gmail.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/1] Use types.h and not time_types.h in sockios.h
Date:   Sat, 23 Jan 2021 17:56:52 +0100
Message-Id: <20210123165652.10884-1-geoffrey.legourrierec@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

This fixes builds for sh arch when libc is not using relevant
time data structures definitions for 32-bit machines. A previous
commit [1] provided a fix, that we seemed to slip through here.

As of the time of this writing, the bug was found with v5.10.7,
with uclibc 1.0.37 only (currently the only libc supporting sh
architecture). uclibc, unlike glibc or muslibc, does not seem to
have made the complete move to post-year-2038 world for 32-bit.
The issue can be reproduced as follows:

$ git clone git://git.busybox.net/buildroot
$ cd buildroot/
$ git checkout 742f37d
$ rm -rf board/qemu/sh4eb-r2d/patches/linux-headers/
$ sed -e '/BR2_GLOBAL_PATCH_DIR/d' -i configs/qemu_sh4eb_r2d_defconfig
$ make qemu_sh4eb_r2d_defconfig
$ make
$ ./output/images/start-qemu.sh

I tried to understand why the initial commit [1] did not prevent
this issue (see notes below), but failed to do so. If anybody can
shed some light on this, I'll gladly take it.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc94cf2092c7c1267fa2deb8388d624f50eba808

Signed-off-by: Geoffrey Le Gourriérec <geoffrey.legourrierec@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>

---
For the record, here's the build-time error:

/usr/bin/make -j2 -C /builds/clumsyape/buildroot/output/build/uclibc-1.0.37 ARCH="sh" CROSS_COMPILE="/builds/clumsyape/buildroot/output/host/bin/sh4-buildroot-linux-uclibc-" UCLIBC_EXTRA_CFLAGS="" HOSTCC="/usr/bin/gcc"
make[1]: Entering directory '/builds/clumsyape/buildroot/output/build/uclibc-1.0.37'
  GEN libpthread/nptl/sysdeps/unix/sysv/linux/lowlevelcond.h
  GEN libpthread/nptl/sysdeps/unix/sysv/linux/lowlevelcond.h
  GEN libpthread/nptl/sysdeps/unix/sysv/linux/lowlevelrobustlock.h
  GEN libpthread/nptl/sysdeps/unix/sysv/linux/lowlevelrobustlock.h
In file included from /builds/clumsyape/buildroot/output/build/linux-headers-5.10.7/usr/include/asm/sockios.h:5,
                 from /builds/clumsyape/buildroot/output/build/linux-headers-5.10.7/usr/include/asm-generic/socket.h:6,
                 from /builds/clumsyape/buildroot/output/build/linux-headers-5.10.7/usr/include/asm/socket.h:1,
                 from ./include/bits/socket.h:360,
                 from ./include/sys/socket.h:39,
                 from ./include/netinet/in.h:24,
                 from ./include/resolv.h:57,
                 from ./libpthread/nptl/descr.h:36,
                 from ./libpthread/nptl/pthreadP.h:25,
                 from <stdin>:2:
/builds/clumsyape/buildroot/output/build/linux-headers-5.10.7/usr/include/linux/time_types.h:8:2: error: unknown type name '__kernel_time64_t'
    8 |  __kernel_time64_t       tv_sec;                 /* seconds */
      |  ^~~~~~~~~~~~~~~~~
/builds/clumsyape/buildroot/output/build/linux-headers-5.10.7/usr/include/linux/time_types.h:32:2: error: unknown type name '__kernel_old_time_t'
   32 |  __kernel_old_time_t tv_sec;  /* seconds */
      |  ^~~~~~~~~~~~~~~~~~~
libpthread/nptl/sysdeps/unix/sysv/linux/Makefile.commonarch:135: recipe for target 'libpthread/nptl/sysdeps/unix/sysv/linux/lowlevelrobustlock.h' failed
make[1]: *** [libpthread/nptl/sysdeps/unix/sysv/linux/lowlevelrobustlock.h] Error 1
make[1]: Leaving directory '/builds/clumsyape/buildroot/output/build/uclibc-1.0.37'

I did a quick header dependency analysis starting from __kernel_time64_t
(one of the offending types), but could "follow up" to linux/time_types.h
as expected; so I fail to understand how this could break. What's even
more confusing is linux/time_types.h includes linux/types.h itself.
---
 arch/sh/include/uapi/asm/sockios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/uapi/asm/sockios.h b/arch/sh/include/uapi/asm/sockios.h
index ef01ced9e169..d97d14685305 100644
--- a/arch/sh/include/uapi/asm/sockios.h
+++ b/arch/sh/include/uapi/asm/sockios.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SH_SOCKIOS_H
 #define __ASM_SH_SOCKIOS_H
 
-#include <linux/time_types.h>
+#include <linux/types.h>
 
 /* Socket-level I/O control calls. */
 #define FIOGETOWN	_IOR('f', 123, int)
-- 
2.17.1

