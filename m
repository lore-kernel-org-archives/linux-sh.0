Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD382C4332F
	for <linux-sh@archiver.kernel.org>; Wed, 21 Dec 2022 13:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiLUNBm (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 21 Dec 2022 08:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiLUNBg (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 21 Dec 2022 08:01:36 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64DBE6D
        for <linux-sh@vger.kernel.org>; Wed, 21 Dec 2022 05:01:34 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id k11so14636350vsr.4
        for <linux-sh@vger.kernel.org>; Wed, 21 Dec 2022 05:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GDzcNnABsBO1VV0+lqWHXjD9U+uD6P4e2XrXM+GgZjY=;
        b=OTVCHIxPc8hNDzfRmK7t4nuGHJtQn+GYzCbae4exnTy2K1oWgfe5Bvq5GQh6GyddW7
         2e7T9YQ4Q9hhUpYtuS7MCCRyX6ZCuQPnYeOF6aryYzZUSHERWk+cHc026N4/8T8Tl6cC
         +tEqQoAgfKUVPofMAl/+te5vsJxXyo2VMx3lYeKL0YsKh3xyhUI9ZRmQIUxtXh8dYSfU
         GiyYmwW4lfnkZ1QZuUMdaoUknz/e369FeEvsqlnoRpLp+fCnprpwMy9aF9QgXqi/xK/M
         nUz4q51UXhg0Ros9EideGqpoxRMwpeydmqnwRbFlFqPoxl8eKRdi/nC47qaxSx1jr4ms
         3fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDzcNnABsBO1VV0+lqWHXjD9U+uD6P4e2XrXM+GgZjY=;
        b=Tcq2W8B5vbU729BBkpRv9B/Ck/2JBBIFuJp8V4J323JA4DkqPx2QDJ/pAoPJ0VuYBv
         9SHFhBmXcbN8V5Nv6MiOfHa+iYNNxrPcEWHza3ecij9z3DXzKA0Ot2RZ5oUhHaaqkDqx
         mx8GX/3f0wuH6Cr8ZZeNz3jmU+qj9nwOez6Wax3bnPFALVoNG8xl43ulVSTitEzaNKa9
         u22icdb17AHdIqDFRBZCM1xbOE/D8Fec5bLrEohZTGrE5EbueqSrTqqslxvNiP/SqKbL
         iRx4BQb6N1r9MLBzshoXyKw4wbInTQAmV0Zh9+6RAawS2be3zrYxoo14dD+5ysdYtrTs
         J3Mg==
X-Gm-Message-State: AFqh2kqdh8KosgCThV7xBmCYgUOZQuX8A0o4xEsrGRX7neRimv3CC6kP
        kmq9aXSA4Ujx8v1IcPYcRHGlx4ZVOv7v0aIqoGu+VANK1Ck9cr7J
X-Google-Smtp-Source: AMrXdXuNB/sDzfpmzwX8uMWvtWlaf+Aec5yUocSOxzO/t/5RUMp33JfueRvXOl2phY2Pl+iiXeKBYtt36VGElgx7ejo=
X-Received: by 2002:a67:ee5a:0:b0:3b5:21d5:5a0b with SMTP id
 g26-20020a67ee5a000000b003b521d55a0bmr196624vsp.34.1671627693304; Wed, 21 Dec
 2022 05:01:33 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 21 Dec 2022 18:31:22 +0530
Message-ID: <CA+G9fYukf1K+t3LApra9fUtAybtqz15uzdbfpMcRCiWX7+UNHQ@mail.gmail.com>
Subject: sh: compiler_types.h:358:45: error: call to '__compiletime_assert_263'
 declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Cc:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Linux mainline master branch have reported the following regressions.

Regressions found on sh build failures,
  - build/gcc-11-defconfig
  - build/gcc-8-defconfig
  - build/gcc-11-shx3_defconfig
  - build/gcc-8-shx3_defconfig

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=sh
CROSS_COMPILE=sh4-linux-gnu- 'CC=sccache sh4-linux-gnu-gcc'
'HOSTCC=sccache gcc' shx3_defconfig

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=sh
CROSS_COMPILE=sh4-linux-gnu- 'CC=sccache sh4-linux-gnu-gcc'
'HOSTCC=sccache gcc'

  Generating include/generated/machtypes.h
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from /builds/linux/arch/sh/include/asm/hw_irq.h:6,
                 from /builds/linux/include/linux/irq.h:596,
                 from /builds/linux/include/asm-generic/hardirq.h:17,
                 from /builds/linux/arch/sh/include/asm/hardirq.h:9,
                 from /builds/linux/include/linux/hardirq.h:11,
                 from /builds/linux/include/linux/interrupt.h:11,
                 from /builds/linux/include/linux/serial_core.h:13,
                 from /builds/linux/include/linux/serial_sci.h:6,
                 from /builds/linux/arch/sh/kernel/cpu/sh4a/setup-shx3.c:10:
/builds/linux/include/linux/sh_intc.h:100:63: warning: division
'sizeof (void *) / sizeof (void)' does not compute the number of array
elements [-Wsizeof-pointer-div]
  100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 :
sizeof(a)/sizeof(*a)
      |                                                               ^
/builds/linux/include/linux/sh_intc.h:107:9: note: in expansion of
macro '_INTC_ARRAY'
  107 |         _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
      |         ^~~~~~~~~~~
/builds/linux/include/linux/sh_intc.h:124:15: note: in expansion of
macro 'INTC_HW_DESC'
  124 |         .hw = INTC_HW_DESC(vectors, groups, mask_regs,
         \
      |               ^~~~~~~~~~~~
/builds/linux/arch/sh/kernel/cpu/sh4a/setup-shx3.c:309:8: note: in
expansion of macro 'DECLARE_INTC_DESC'
  309 | static DECLARE_INTC_DESC(intc_desc, "shx3", vectors, groups,
      |        ^~~~~~~~~~~~~~~~~
/builds/linux/include/linux/sh_intc.h:100:63: warning: division
'sizeof (void *) / sizeof (void)' does not compute the number of array
elements [-Wsizeof-pointer-div]
  100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 :
sizeof(a)/sizeof(*a)
      |                                                               ^
/builds/linux/include/linux/sh_intc.h:107:34: note: in expansion of
macro '_INTC_ARRAY'
  107 |         _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
      |                                  ^~~~~~~~~~~
/builds/linux/include/linux/sh_intc.h:124:15: note: in expansion of
macro 'INTC_HW_DESC'
  124 |         .hw = INTC_HW_DESC(vectors, groups, mask_regs,
         \
      |               ^~~~~~~~~~~~
/builds/linux/arch/sh/kernel/cpu/sh4a/setup-shx3.c:309:8: note: in
expansion of macro 'DECLARE_INTC_DESC'
  309 | static DECLARE_INTC_DESC(intc_desc, "shx3", vectors, groups,
      |        ^~~~~~~~~~~~~~~~~
/builds/linux/include/linux/sh_intc.h:100:63: warning: division
'sizeof (void *) / sizeof (void)' does not compute the number of array
elements [-Wsizeof-pointer-div]
  100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 :
sizeof(a)/sizeof(*a)
      |                                                               ^
/builds/linux/include/linux/sh_intc.h:107:34: note: in expansion of
macro '_INTC_ARRAY'
  107 |         _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
      |                                  ^~~~~~~~~~~
/builds/linux/include/linux/sh_intc.h:124:15: note: in expansion of
macro 'INTC_HW_DESC'
  124 |         .hw = INTC_HW_DESC(vectors, groups, mask_regs,
         \
      |               ^~~~~~~~~~~~
/builds/linux/arch/sh/kernel/cpu/sh4a/setup-shx3.c:322:8: note: in
expansion of macro 'DECLARE_INTC_DESC'
  322 | static DECLARE_INTC_DESC(intc_desc_irq, "shx3-irq", vectors_irq, groups,
      |        ^~~~~~~~~~~~~~~~~
/builds/linux/include/linux/sh_intc.h:100:63: warning: division
'sizeof (void *) / sizeof (void)' does not compute the number of array
elements [-Wsizeof-pointer-div]
  100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 :
sizeof(a)/sizeof(*a)
      |                                                               ^
/builds/linux/include/linux/sh_intc.h:107:9: note: in expansion of
macro '_INTC_ARRAY'
  107 |         _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
      |         ^~~~~~~~~~~
/builds/linux/include/linux/sh_intc.h:124:15: note: in expansion of
macro 'INTC_HW_DESC'
  124 |         .hw = INTC_HW_DESC(vectors, groups, mask_regs,
         \
      |               ^~~~~~~~~~~~
/builds/linux/arch/sh/kernel/cpu/sh4a/setup-shx3.c:337:8: note: in
expansion of macro 'DECLARE_INTC_DESC'
  337 | static DECLARE_INTC_DESC(intc_desc_irl, "shx3-irl", vectors_irl, groups,
      |        ^~~~~~~~~~~~~~~~~
/builds/linux/include/linux/sh_intc.h:100:63: warning: division
'sizeof (void *) / sizeof (void)' does not compute the number of array
elements [-Wsizeof-pointer-div]
  100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 :
sizeof(a)/sizeof(*a)
      |                                                               ^
/builds/linux/include/linux/sh_intc.h:107:34: note: in expansion of
macro '_INTC_ARRAY'
  107 |         _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
      |                                  ^~~~~~~~~~~
/builds/linux/include/linux/sh_intc.h:124:15: note: in expansion of
macro 'INTC_HW_DESC'
  124 |         .hw = INTC_HW_DESC(vectors, groups, mask_regs,
         \
      |               ^~~~~~~~~~~~
/builds/linux/arch/sh/kernel/cpu/sh4a/setup-shx3.c:337:8: note: in
expansion of macro 'DECLARE_INTC_DESC'
  337 | static DECLARE_INTC_DESC(intc_desc_irl, "shx3-irl", vectors_irl, groups,
      |        ^~~~~~~~~~~~~~~~~
In file included from <command-line>:
In function 'follow_pmd_mask',
    inlined from 'follow_pud_mask' at /builds/linux/mm/gup.c:735:9,
    inlined from 'follow_p4d_mask' at /builds/linux/mm/gup.c:752:9,
    inlined from 'follow_page_mask' at /builds/linux/mm/gup.c:809:9:
/builds/linux/include/linux/compiler_types.h:358:45: error: call to
'__compiletime_assert_263' declared with attribute error: Unsupported
access size for {READ,WRITE}_ONCE().
  358 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
/builds/linux/include/linux/compiler_types.h:339:25: note: in
definition of macro '__compiletime_assert'
  339 |                         prefix ## suffix();
         \
      |                         ^~~~~~
/builds/linux/include/linux/compiler_types.h:358:9: note: in expansion
of macro '_compiletime_assert'
  358 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
/builds/linux/include/asm-generic/rwonce.h:36:9: note: in expansion of
macro 'compiletime_assert'
   36 |         compiletime_assert(__native_word(t) || sizeof(t) ==
sizeof(long long),  \
      |         ^~~~~~~~~~~~~~~~~~
/builds/linux/include/asm-generic/rwonce.h:49:9: note: in expansion of
macro 'compiletime_assert_rwonce_type'
   49 |         compiletime_assert_rwonce_type(x);
         \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/builds/linux/mm/gup.c:661:18: note: in expansion of macro 'READ_ONCE'
  661 |         pmdval = READ_ONCE(*pmd);
      |                  ^~~~~~~~~
make[3]: *** [/builds/linux/scripts/Makefile.build:252: mm/gup.o] Error 1
In file included from <command-line>:
/builds/linux/mm/page_vma_mapped.c: In function 'page_vma_mapped_walk':
/builds/linux/include/linux/compiler_types.h:358:45: error: call to
'__compiletime_assert_262' declared with attribute error: Unsupported
access size for {READ,WRITE}_ONCE().
  358 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
/builds/linux/include/linux/compiler_types.h:339:25: note: in
definition of macro '__compiletime_assert'
  339 |                         prefix ## suffix();
         \
      |                         ^~~~~~
/builds/linux/include/linux/compiler_types.h:358:9: note: in expansion
of macro '_compiletime_assert'
  358 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
/builds/linux/include/asm-generic/rwonce.h:36:9: note: in expansion of
macro 'compiletime_assert'
   36 |         compiletime_assert(__native_word(t) || sizeof(t) ==
sizeof(long long),  \
      |         ^~~~~~~~~~~~~~~~~~
/builds/linux/include/asm-generic/rwonce.h:49:9: note: in expansion of
macro 'compiletime_assert_rwonce_type'
   49 |         compiletime_assert_rwonce_type(x);
         \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/builds/linux/mm/page_vma_mapped.c:210:24: note: in expansion of macro
'READ_ONCE'
  210 |                 pmde = READ_ONCE(*pvmw->pmd);
      |                        ^~~~~~~~~
make[3]: *** [/builds/linux/scripts/Makefile.build:252:
mm/page_vma_mapped.o] Error 1
make[3]: Target 'mm/' not remade because of errors.
make[2]: *** [/builds/linux/scripts/Makefile.build:504: mm] Error 2
/builds/linux/fs/ext4/readpage.c: In function 'ext4_mpage_readpages':
/builds/linux/fs/ext4/readpage.c:405:1: warning: the frame size of
1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  405 | }
      | ^
/builds/linux/fs/mpage.c: In function '__mpage_writepage':
/builds/linux/fs/mpage.c:634:1: warning: the frame size of 1144 bytes
is larger than 1024 bytes [-Wframe-larger-than=]
  634 | }
      | ^
/builds/linux/fs/mpage.c: In function 'do_mpage_readpage':
/builds/linux/fs/mpage.c:308:1: warning: the frame size of 1092 bytes
is larger than 1024 bytes [-Wframe-larger-than=]
  308 | }
      | ^
make[2]: Target './' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:2008: .] Error 2

Build:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.1-13872-gb6bb9676f216/testrun/13772324/suite/build/test/gcc-11-shx3_defconfig/details/



--
Linaro LKFT
https://lkft.linaro.org
