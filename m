Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6515C433F5
	for <linux-sh@archiver.kernel.org>; Fri,  3 Dec 2021 19:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353459AbhLCTUC (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243129AbhLCTUC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 3 Dec 2021 14:20:02 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA86EC061353
        for <linux-sh@vger.kernel.org>; Fri,  3 Dec 2021 11:16:37 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id p13so3803366pfw.2
        for <linux-sh@vger.kernel.org>; Fri, 03 Dec 2021 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vE5k5wotSQoz2K2yhzYJSHTSX5pQFzA0fYM32NRfV0w=;
        b=kF2pKyaE97/smKBTjkH+JYAzwjVnNvWllOLgI8WLWiH2nE9nQfmvDH87JncSzZhxwE
         jo4HEk6LIgbGld9EgIt3JbFRXibxG9LsRTjReotQMyyQP5Swq4PEI5o2UgGFUWj/xwk8
         oOhjHMxNVIorEdGUrzyCJz36CxAvmUOcJykqENGIskd6dQUpbZa3cM/XsmwEAZ3r05Di
         59qDIUoMezRuzKWykZA2IZSRggatHRhzmr3VqLq4sCLyQrZYiE5mfUO9QWBsC3gbJ38R
         lPmX8J0YZq/9Qd47qFnYZRAGANRIFMaGx2jTrnOaLTz5Y4Kgi2imr3SrVHZ/HYgdXWkj
         dLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vE5k5wotSQoz2K2yhzYJSHTSX5pQFzA0fYM32NRfV0w=;
        b=f9HOsmF9tIhqhINr7ibF2qMvCe71n1bQNqmuNS3M5+HkXvIklB6pxTWOxgoyLL0tDD
         0RnzTYZW7DRqLUCPaJmkQB5BLKV9raUtYPWa9YsGHayzX4Hv8vzJEt2o761CKoDb78w7
         zT9wzbaOAs9787M+Mvh0Cio0/a1B8gVaXSfLvMbJAJmoNGDS9joSEE/mwgkU0ut9wvFa
         Gvn7sZY2zQUBOHtpVKxYDqEfMPyBkH2e2SqmTn2KPlVhv2Ot6Mh8ZPuYPU7vndaOwFyq
         k6PsRnxVv8wPQOKxG4XsGrGB44IghMb/k8VhYCzq3qAMDRXxbqub/b0gK1zDncLmvLv4
         Y2eA==
X-Gm-Message-State: AOAM533FD4gSO3GstvukwyC2jYUyTwZ4YZ3tZfDKGyhTzL/zAYVa3Sot
        iRg7pcUhOUlxzGisd4DwpUt3+Q==
X-Google-Smtp-Source: ABdhPJwdzFi3Q9lpisgwtATTpAQ6z11KXXKQgdXuzlE4OZIAMbKEN+oGytud5lmbZ50sISd0SkPJnw==
X-Received: by 2002:a63:2a97:: with SMTP id q145mr5771640pgq.217.1638558997250;
        Fri, 03 Dec 2021 11:16:37 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m184sm3050117pga.61.2021.12.03.11.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:16:36 -0800 (PST)
Date:   Fri, 03 Dec 2021 11:16:36 -0800 (PST)
X-Google-Original-Date: Fri, 03 Dec 2021 11:16:28 PST (-0800)
Subject:     Re: [PATCH v2 resend] sh: Use generic GCC library routines
In-Reply-To: <411814148d311d5a545672cdd2b0721195e53252.1638539376.git.geert+renesas@glider.be>
CC:     ysato@users.sourceforge.jp, dalias@libc.org, masahiroy@kernel.org,
        rob@landley.net, glaubitz@physik.fu-berlin.de,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert+renesas@glider.be
Message-ID: <mhng-6cd78cba-8ba4-4aa6-bcff-6091a59bba6a@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Fri, 03 Dec 2021 05:52:27 PST (-0800), geert+renesas@glider.be wrote:
> The C implementations of __ashldi3(), __ashrdi3__(), and __lshrdi3() in
> arch/sh/lib/ are identical to the generic C implementations in lib/.
> Reduce duplication by switching SH to the generic versions.
>
> Update the include path in arch/sh/boot/compressed accordingly.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Fix silly typo in subject.
>
> Tested on landisk and qemu/rts7751r2d.
>
> Note that it also works without the change to arch/sh/boot/compressed/,
> as lib/ashldi3.c can be reached via both include/uapi/../../lib/ashldi3.c
> and arch/sh/boot/compressed/../../../../lib/ashldi3.c.
>
> Palmer tried a similar thing before:
> https://lore.kernel.org/linux-arch/20170523220546.16758-1-palmer@dabbelt.com/
> but initially it broke the SH build due to a missing change to
> arch/sh/boot/compressed/, and the later update never got picked up.
> In the mean time, arch/sh/boot/compressed/ was changed, so his patch no
> longer applies.


Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Sorry about that, I guess I forgot about this one.  I'm assuming this is 
going through some sort of SH tree, but LMK if there's anything you need 
from my end.

Thanks!

> Similar for the other architectures, I guess?

I though I sent those all along, but I guess I forgot about a handful of 
them.  Are you offering to pick that up?

> ---
>  arch/sh/Kconfig                   |  3 +++
>  arch/sh/boot/compressed/ashldi3.c |  4 ++--
>  arch/sh/lib/Makefile              |  4 +---
>  arch/sh/lib/ashldi3.c             | 30 -----------------------------
>  arch/sh/lib/ashrdi3.c             | 32 -------------------------------
>  arch/sh/lib/lshrdi3.c             | 30 -----------------------------
>  6 files changed, 6 insertions(+), 97 deletions(-)
>  delete mode 100644 arch/sh/lib/ashldi3.c
>  delete mode 100644 arch/sh/lib/ashrdi3.c
>  delete mode 100644 arch/sh/lib/lshrdi3.c
>
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 70afb30e0b321183..b10c4d852c22852a 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -20,6 +20,9 @@ config SUPERH
>  	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
>  	select GENERIC_IDLE_POLL_SETUP
>  	select GENERIC_IRQ_SHOW
> +	select GENERIC_LIB_ASHLDI3
> +	select GENERIC_LIB_ASHRDI3
> +	select GENERIC_LIB_LSHRDI3
>  	select GENERIC_PCI_IOMAP if PCI
>  	select GENERIC_SCHED_CLOCK
>  	select GENERIC_SMP_IDLE_THREAD
> diff --git a/arch/sh/boot/compressed/ashldi3.c b/arch/sh/boot/compressed/ashldi3.c
> index 7cebd646df839b48..7c12121702309e8c 100644
> --- a/arch/sh/boot/compressed/ashldi3.c
> +++ b/arch/sh/boot/compressed/ashldi3.c
> @@ -1,2 +1,2 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -#include "../../lib/ashldi3.c"
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include "../../../../lib/ashldi3.c"
> diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
> index eb473d373ca43a4b..d20a0768b31fa2b6 100644
> --- a/arch/sh/lib/Makefile
> +++ b/arch/sh/lib/Makefile
> @@ -7,9 +7,7 @@ lib-y  = delay.o memmove.o memchr.o \
>  	 checksum.o strlen.o div64.o div64-generic.o
>
>  # Extracted from libgcc
> -obj-y += movmem.o ashldi3.o ashrdi3.o lshrdi3.o \
> -	 ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o \
> -	 udiv_qrnnd.o
> +obj-y += movmem.o ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o udiv_qrnnd.o
>
>  udivsi3-y			:= udivsi3_i4i-Os.o
>
> diff --git a/arch/sh/lib/ashldi3.c b/arch/sh/lib/ashldi3.c
> deleted file mode 100644
> index e5afe0935847427f..0000000000000000
> --- a/arch/sh/lib/ashldi3.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/module.h>
> -
> -#include "libgcc.h"
> -
> -long long __ashldi3(long long u, word_type b)
> -{
> -	DWunion uu, w;
> -	word_type bm;
> -
> -	if (b == 0)
> -		return u;
> -
> -	uu.ll = u;
> -	bm = 32 - b;
> -
> -	if (bm <= 0) {
> -		w.s.low = 0;
> -		w.s.high = (unsigned int) uu.s.low << -bm;
> -	} else {
> -		const unsigned int carries = (unsigned int) uu.s.low >> bm;
> -
> -		w.s.low = (unsigned int) uu.s.low << b;
> -		w.s.high = ((unsigned int) uu.s.high << b) | carries;
> -	}
> -
> -	return w.ll;
> -}
> -
> -EXPORT_SYMBOL(__ashldi3);
> diff --git a/arch/sh/lib/ashrdi3.c b/arch/sh/lib/ashrdi3.c
> deleted file mode 100644
> index ae263fbf25383b70..0000000000000000
> --- a/arch/sh/lib/ashrdi3.c
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/module.h>
> -
> -#include "libgcc.h"
> -
> -long long __ashrdi3(long long u, word_type b)
> -{
> -	DWunion uu, w;
> -	word_type bm;
> -
> -	if (b == 0)
> -		return u;
> -
> -	uu.ll = u;
> -	bm = 32 - b;
> -
> -	if (bm <= 0) {
> -		/* w.s.high = 1..1 or 0..0 */
> -		w.s.high =
> -		    uu.s.high >> 31;
> -		w.s.low = uu.s.high >> -bm;
> -	} else {
> -		const unsigned int carries = (unsigned int) uu.s.high << bm;
> -
> -		w.s.high = uu.s.high >> b;
> -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
> -	}
> -
> -	return w.ll;
> -}
> -
> -EXPORT_SYMBOL(__ashrdi3);
> diff --git a/arch/sh/lib/lshrdi3.c b/arch/sh/lib/lshrdi3.c
> deleted file mode 100644
> index 33eaa1edbc3c0656..0000000000000000
> --- a/arch/sh/lib/lshrdi3.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/module.h>
> -
> -#include "libgcc.h"
> -
> -long long __lshrdi3(long long u, word_type b)
> -{
> -	DWunion uu, w;
> -	word_type bm;
> -
> -	if (b == 0)
> -		return u;
> -
> -	uu.ll = u;
> -	bm = 32 - b;
> -
> -	if (bm <= 0) {
> -		w.s.high = 0;
> -		w.s.low = (unsigned int) uu.s.high >> -bm;
> -	} else {
> -		const unsigned int carries = (unsigned int) uu.s.high << bm;
> -
> -		w.s.high = (unsigned int) uu.s.high >> b;
> -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
> -	}
> -
> -	return w.ll;
> -}
> -
> -EXPORT_SYMBOL(__lshrdi3);
