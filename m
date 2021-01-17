Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4458BC433DB
	for <linux-sh@archiver.kernel.org>; Sun, 17 Jan 2021 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067762064A
	for <linux-sh@archiver.kernel.org>; Sun, 17 Jan 2021 16:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbhAQQXG (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 17 Jan 2021 11:23:06 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:42484 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbhAQQXF (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 17 Jan 2021 11:23:05 -0500
X-Greylist: delayed 18304 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2021 11:23:03 EST
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 10HGLo8D030649;
        Mon, 18 Jan 2021 01:21:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 10HGLo8D030649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1610900511;
        bh=A96ILU3TUGfDLP2inrPNigj9gcgMcZK1odLxYlprZk0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HdzKoqWvcD9A63HAU4U/oBjM4rWPhjpaE+lKlxEgdsQKNlch4H50LPNHRHYBBEWG6
         i+Q61TjrUuFlVjRenV6xR6mZFZEdLsGXtFuLGgr39KMAInFJtG/iatSVU7aicnem2U
         cysy5/WRNOlGjwk9IPqyJNEGlZ3wvjPIslnF7AWA5XgQfVtFG/c560Zmf2i7XPYx45
         1iHhzxk/+pkx1tofeXWnPgLu/mm5iIZc4viLzS4/sF+GziByzSXOyAvK3IgA/lESVF
         g2FB17dPLeqTDKI9dS5HLOofnyda9ih8OBFkw5esdYPTHmmrjavUZjU94JBbu4CNtV
         /EbSxOi1I70Kg==
X-Nifty-SrcIP: [209.85.215.177]
Received: by mail-pg1-f177.google.com with SMTP id n25so9423676pgb.0;
        Sun, 17 Jan 2021 08:21:50 -0800 (PST)
X-Gm-Message-State: AOAM533RvpKZ2ajjH8UpMBh/ELuWpY+jGqvdfAhlBFwoEq5a4l+fq3kY
        uDzEONf8MoCuXB5zZTNcTUFz5kalHBCQuBw6854=
X-Google-Smtp-Source: ABdhPJzlxeLf7lz9OrKj4XXhP84ohvjAhHnWUF3GKa9pB9ctkl38D9YLrTcAupkETI8wsdDODwfHIwm94LS6e+KTvHI=
X-Received: by 2002:a62:820d:0:b029:1ad:d810:6805 with SMTP id
 w13-20020a62820d0000b02901add8106805mr22536477pfd.63.1610900509742; Sun, 17
 Jan 2021 08:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20210117111632.2392635-1-masahiroy@kernel.org>
 <20210117111632.2392635-2-masahiroy@kernel.org> <acc34727-c956-3943-c623-1acd462c2a2d@physik.fu-berlin.de>
In-Reply-To: <acc34727-c956-3943-c623-1acd462c2a2d@physik.fu-berlin.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 18 Jan 2021 01:21:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQL3RUtnw99smJCRc_rOm3PgMZhjc85WT3WwNGCcgK6nw@mail.gmail.com>
Message-ID: <CAK7LNAQL3RUtnw99smJCRc_rOm3PgMZhjc85WT3WwNGCcgK6nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sh: boot: avoid unneeded rebuilds under arch/sh/boot/compressed/
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sun, Jan 17, 2021 at 10:35 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Masahiro!
>
> On 1/17/21 12:16 PM, Masahiro Yamada wrote:
> > Even if none of source code is updated, the following are every time
> > rebuilt:
> >
> >   CC      arch/sh/boot/compressed/cache.o
> >   SHIPPED arch/sh/boot/compressed/ashiftrt.S
> >   AS      arch/sh/boot/compressed/ashiftrt.o
> >   SHIPPED arch/sh/boot/compressed/ashldi3.c
> >   CC      arch/sh/boot/compressed/ashldi3.o
> >   SHIPPED arch/sh/boot/compressed/ashrsi3.S
> >   AS      arch/sh/boot/compressed/ashrsi3.o
> >   SHIPPED arch/sh/boot/compressed/ashlsi3.S
> >   AS      arch/sh/boot/compressed/ashlsi3.o
> >   SHIPPED arch/sh/boot/compressed/lshrsi3.S
> >   AS      arch/sh/boot/compressed/lshrsi3.o
> >   LD      arch/sh/boot/compressed/vmlinux
> >   OBJCOPY arch/sh/boot/zImage
> >
> > Add build artifacts to 'targets' as needed.
> >
> > I turned the library files to check-in files. It is simpler than
> > copying from arch/sh/lib/ at build-time.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/sh/boot/compressed/.gitignore |  5 -----
> >  arch/sh/boot/compressed/Makefile   | 32 ++++++++++++------------------
> >  arch/sh/boot/compressed/ashiftrt.S |  2 ++
> >  arch/sh/boot/compressed/ashldi3.c  |  2 ++
> >  arch/sh/boot/compressed/ashlsi3.S  |  2 ++
> >  arch/sh/boot/compressed/ashrsi3.S  |  2 ++
> >  arch/sh/boot/compressed/lshrsi3.S  |  2 ++
> >  7 files changed, 23 insertions(+), 24 deletions(-)
> >  create mode 100644 arch/sh/boot/compressed/ashiftrt.S
> >  create mode 100644 arch/sh/boot/compressed/ashldi3.c
> >  create mode 100644 arch/sh/boot/compressed/ashlsi3.S
> >  create mode 100644 arch/sh/boot/compressed/ashrsi3.S
> >  create mode 100644 arch/sh/boot/compressed/lshrsi3.S
> >
> > diff --git a/arch/sh/boot/compressed/.gitignore b/arch/sh/boot/compressed/.gitignore
> > index 37aa53057369..cd16663bc7c8 100644
> > --- a/arch/sh/boot/compressed/.gitignore
> > +++ b/arch/sh/boot/compressed/.gitignore
> > @@ -1,7 +1,2 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -ashiftrt.S
> > -ashldi3.c
> > -ashlsi3.S
> > -ashrsi3.S
> > -lshrsi3.S
> >  vmlinux.bin.*
> > diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
> > index 589d2d8a573d..cf3174df7859 100644
> > --- a/arch/sh/boot/compressed/Makefile
> > +++ b/arch/sh/boot/compressed/Makefile
> > @@ -5,12 +5,18 @@
> >  # create a compressed vmlinux image from the original vmlinux
> >  #
> >
> > -targets              := vmlinux vmlinux.bin vmlinux.bin.gz \
> > -                vmlinux.bin.bz2 vmlinux.bin.lzma \
> > -                vmlinux.bin.xz vmlinux.bin.lzo \
> > -                head_32.o misc.o piggy.o
> > +OBJECTS := head_32.o misc.o cache.o piggy.o \
> > +           ashiftrt.o ashldi3.o ashrsi3.o ashlsi3.o lshrsi3.o
> > +
> > +# These were previously generated files. When you are building the kernel
> > +# with O=, make sure to remove the stale files in the output tree. Otherwise,
> > +# the build system wrongly compiles the stale ones.
> > +ifdef building_out_of_srctree
> > +$(shell rm -f $(addprefix $(obj)/, ashiftrt.S ashldi3.c ashrsi3.S ashlsi3.S lshrsi3.S))
> > +endif
> >
> > -OBJECTS = $(obj)/head_32.o $(obj)/misc.o $(obj)/cache.o
> > +targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
> > +           vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo $(OBJECTS)
> >
> >  GCOV_PROFILE := n
> >
> > @@ -33,21 +39,9 @@ ccflags-remove-$(CONFIG_MCOUNT) += -pg
> >  LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e startup \
> >                  -T $(obj)/../../kernel/vmlinux.lds
> >
> > -#
> > -# Pull in the necessary libgcc bits from the in-kernel implementation.
> > -#
> > -lib1funcs-y  := ashiftrt.S ashldi3.c ashrsi3.S ashlsi3.S lshrsi3.S
> > -lib1funcs-obj   := \
> > -     $(addsuffix .o, $(basename $(addprefix $(obj)/, $(lib1funcs-y))))
> > -
> > -lib1funcs-dir                := $(srctree)/arch/$(SRCARCH)/lib
> > -
> > -KBUILD_CFLAGS += -I$(lib1funcs-dir) -DDISABLE_BRANCH_PROFILING
> > -
> > -$(addprefix $(obj)/,$(lib1funcs-y)): $(obj)/%: $(lib1funcs-dir)/% FORCE
> > -     $(call cmd,shipped)
> > +KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> >
> > -$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o $(lib1funcs-obj) FORCE
> > +$(obj)/vmlinux: $(addprefix $(obj)/, $(OBJECTS)) FORCE
> >       $(call if_changed,ld)
> >
> >  $(obj)/vmlinux.bin: vmlinux FORCE
> > diff --git a/arch/sh/boot/compressed/ashiftrt.S b/arch/sh/boot/compressed/ashiftrt.S
> > new file mode 100644
> > index 000000000000..0f3b291a3f4b
> > --- /dev/null
> > +++ b/arch/sh/boot/compressed/ashiftrt.S
> > @@ -0,0 +1,2 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#include "../../lib/ashiftrt.S"
> > diff --git a/arch/sh/boot/compressed/ashldi3.c b/arch/sh/boot/compressed/ashldi3.c
> > new file mode 100644
> > index 000000000000..7cebd646df83
> > --- /dev/null
> > +++ b/arch/sh/boot/compressed/ashldi3.c
> > @@ -0,0 +1,2 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include "../../lib/ashldi3.c"
> > diff --git a/arch/sh/boot/compressed/ashlsi3.S b/arch/sh/boot/compressed/ashlsi3.S
> > new file mode 100644
> > index 000000000000..e354262b275f
> > --- /dev/null
> > +++ b/arch/sh/boot/compressed/ashlsi3.S
> > @@ -0,0 +1,2 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#include "../../lib/ashlsi3.S"
> > diff --git a/arch/sh/boot/compressed/ashrsi3.S b/arch/sh/boot/compressed/ashrsi3.S
> > new file mode 100644
> > index 000000000000..e564be9a4dcd
> > --- /dev/null
> > +++ b/arch/sh/boot/compressed/ashrsi3.S
> > @@ -0,0 +1,2 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#include "../../lib/ashrsi3.S"
> > diff --git a/arch/sh/boot/compressed/lshrsi3.S b/arch/sh/boot/compressed/lshrsi3.S
> > new file mode 100644
> > index 000000000000..5a8281b7e516
> > --- /dev/null
> > +++ b/arch/sh/boot/compressed/lshrsi3.S
> > @@ -0,0 +1,2 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#include "../../lib/lshrsi3.S"
>
> This patch doesn't apply for me while the first one applies without problems:
>
> glaubitz@epyc:..glaubitz/linux-git> git am ../sh-patches-2021/\[PATCH\ 1_2\]\ sh\:\ boot\:\ add\ intermediate\ vmlinux.bin\*\ to\ targets\ instead\ of\ extra-y.eml
> Applying: sh: boot: add intermediate vmlinux.bin* to targets instead of extra-y
> glaubitz@epyc:..glaubitz/linux-git> git am ../sh-patches-2021/\[PATCH\ 2_2\]\ sh\:\ boot\:\ avoid\ unneeded\ rebuilds\ under\ arch_sh_boot_compressed_.eml
> Applying: sh: boot: avoid unneeded rebuilds under arch/sh/boot/compressed/
> error: arch/sh/boot/compressed/ashiftrt.S: already exists in working directory
> error: arch/sh/boot/compressed/ashldi3.c: already exists in working directory
> error: arch/sh/boot/compressed/ashlsi3.S: already exists in working directory
> error: arch/sh/boot/compressed/ashrsi3.S: already exists in working directory
> error: arch/sh/boot/compressed/lshrsi3.S: already exists in working directory

Adrian, these 5 files are currently generated files.

That is why git-am failed.

They are not cleaned up by 'make ARCH=sh clean'
(this is a bug too).


Please remove them manually, then try git am again.







> Patch failed at 0001 sh: boot: avoid unneeded rebuilds under arch/sh/boot/compressed/
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> glaubitz@epyc:..glaubitz/linux-git>
>
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
>


--
Best Regards
Masahiro Yamada
