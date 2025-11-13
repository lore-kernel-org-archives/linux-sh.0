Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A64350D7C
	for <linux-sh@vger.kernel.org>; Thu, 13 Nov 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058225; cv=none; b=uHh8oIIPXrwyjpZPFrseFlY83HnzbOXFXnoAkwtlYbpuzFI49DtXKxCmCvFK/MMSbQ3oAUXtjbjGf550EmigukqTaIWnZhnmQyFwZaDRDM4scKDkWzQVu1iDLdpsk96mftR55SZoABkvvtOkFKjopyP8SjwVsmragWBTXYMVzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058225; c=relaxed/simple;
	bh=9wONgpFeFR+zvWoiyd3AGKx1BaiS71elSI9ojmPhoaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMQFXF5y0NpJb5VUhXao0xhEPz7zkrSvQ4OT22TyD8/DJT/fF/SlPnni9eBK0p4B/Wqd85eNOisdSmgG0tj3WrNlgME/KtAHMbS2IYppIpPTMB3ug75s6L6gohEt66RoNaombSSMCDPxpi9WcDkOpgesy5XXi7ddd/qb6Nn9iDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93539c5e2b5so633436241.0
        for <linux-sh@vger.kernel.org>; Thu, 13 Nov 2025 10:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763058222; x=1763663022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbr6KNR1bUXZYViotVbUoRUsmFwFNCwuoCWcfoEfOT8=;
        b=VkZE+4hsRY1Cgr0bh+Rf4enXZLqeorWy5zmEZKC0G0iitscQ1mNNJ5mG0p8r0LaXnG
         hISEurnecCX9z1p9j7RVUuUx61TqzoXKv6kGK/DBms0gYA7ajC2DXn8/QHf7zb2omlg5
         2/NtekJ/jva9H+wak5k5atn0rS8edyKpdBByMotYkgv/Wp/fPQT/jsVgqrHLwKh4vNtC
         +Qq9Fba4CFG27XrQV2820quDyt67Wxxo5fL3v9yeg3tIX45PAChxjUUwzQL3tOL2kkhE
         3IuiwSMTEMlmTgDyJfmeudAbeVq+1ouQsg9f1keRPh8dA4eZHdZt9lc7wMP7+ZUzV/97
         og7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrJbIzG4IYXO+XAxW+hn7+Tz9hHUP4jDQq7r6OmhDWcL39zvZHFxGAz/lAmABEZ+4WdRrsXPJhRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoXX4meh8Dul/kTFAazo0rAmOd6xxFOmUAznI7PEkqg15XUon4
	mPE6BnOtdLtLGWKNO+R5+fowPXs0UawNruGuHwOheEWphwWQVNahvv+zhuiFZxAtgtI=
X-Gm-Gg: ASbGncspAEDMfzH4v8aVSFzXlQamH+iqLzU9nUwUOMCUcQJEa9j9SNM0N/E+ZMv01CY
	NUqUgbF5IOPNiAZ9E4V64GC5Z0wLfQc+nUierxjbTj06cxegZMaLz0f6JWJhDIYxbzGA9U441Uf
	KhPPk6pGJQa2AdTE/XtYGVhIjxBHp033DiA2qD31Y0UK2jXgcKlvzYJWSSU8TxhPyjZ5ejwvmbw
	st6ZKFniI8U1oniKGORDfffV03/yEUBel3KmDWMXWqJstuRz5QePjCQ6dYTkOUxlN1LkygktQso
	YkrR1fdrF9IA+62PXkF5+7M00nWrCEl4OIEjtntOlmrsmDWL9koPVqgAohdDRi9y1G7nNrIfzQ3
	8psK4z2gypAyPM+IUJz0wKURPcen00ZJpJplyTZw47f8ddp665TRLKkiAfDaD1Rou3BVF/28FqS
	iNhjGlXoyDl6eRiRVnvflSuftCKGyojMPZ70jepV28VygbdLJb
X-Google-Smtp-Source: AGHT+IFk5ULkPfag1KY3bEI0XNupt7tSEMXSCKw2NhHUKuHwK1JqOY8Mkkch0ZfIHQ6dkcG4+iLckg==
X-Received: by 2002:a05:6102:e08:b0:5db:e32d:a3fc with SMTP id ada2fe7eead31-5dfc5b70db2mr301077137.14.1763058222361;
        Thu, 13 Nov 2025 10:23:42 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dfb729fbb3sm929109137.15.2025.11.13.10.23.42
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:23:42 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso826173137.1
        for <linux-sh@vger.kernel.org>; Thu, 13 Nov 2025 10:23:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2jgWN+9gFTCzploDk9GeO/wYJ0PInrhcfcmP8k0zc5R79N6iw+yqLwxLW9PqJA/q5DkfIVA9Whg==@vger.kernel.org
X-Received: by 2002:a05:6102:3051:b0:5d4:1499:99a4 with SMTP id
 ada2fe7eead31-5dfb41e267fmr1793358137.13.1763058221928; Thu, 13 Nov 2025
 10:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202511132024.tfRZgB5P-lkp@intel.com> <20251113100036.70130321f6629ce9cc8956cf@linux-foundation.org>
In-Reply-To: <20251113100036.70130321f6629ce9cc8956cf@linux-foundation.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 19:23:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXpUat2cTH_YBqQNUQY4=Y3em38GDY5vr+HYhd_qk3qcA@mail.gmail.com>
X-Gm-Features: AWmQ_bnmukM8VT5G1Q69IqWca-tF6jQbLcv0pbKs9CiZ8jCmLwhTSfU1v9SpYUk
Message-ID: <CAMuHMdXpUat2cTH_YBqQNUQY4=Y3em38GDY5vr+HYhd_qk3qcA@mail.gmail.com>
Subject: Re: [akpm-mm:mm-unstable 36/283] include/uapi/linux/const.h:20:25:
 warning: conversion from 'long long unsigned int' to 'long unsigned int'
 changes value from '17179869184' to '0'
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, "David Hildenbrand (Red Hat)" <david@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Thu, 13 Nov 2025 at 19:08, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 13 Nov 2025 20:26:42 +0800 kernel test robot <lkp@intel.com> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> > head:   f58b4cb6b0c11172a25c2ade23477f55596d7138
> > commit: 2f6ff71280ffddb27ad7174d24f573e2683870cd [36/283] mm: fix MAX_FOLIO_ORDER on powerpc configs with hugetlb
> > config: sh-randconfig-002-20251113 (https://download.01.org/0day-ci/archive/20251113/202511132024.tfRZgB5P-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 11.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511132024.tfRZgB5P-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202511132024.tfRZgB5P-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from arch/sh/include/asm/bug.h:112,
> >                     from include/linux/bug.h:5,
> >                     from include/linux/mmdebug.h:5,
> >                     from include/linux/mm.h:6,
> >                     from include/linux/migrate.h:5,
> >                     from mm/migrate.c:16:
> >    mm/internal.h: In function 'folio_set_order':
> > >> include/uapi/linux/const.h:20:25: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '17179869184' to '0' [-Woverflow]
> >       20 | #define __AC(X,Y)       (X##Y)
> >          |                         ^~~~~~
> >    include/asm-generic/bug.h:111:32: note: in definition of macro 'WARN_ON_ONCE'
> >      111 |         int __ret_warn_on = !!(condition);                      \
> >          |                                ^~~~~~~~~
> >    mm/internal.h:758:9: note: in expansion of macro 'VM_WARN_ON_ONCE'
> >      758 |         VM_WARN_ON_ONCE(order > MAX_FOLIO_ORDER);
> >          |         ^~~~~~~~~~~~~~~
> >    include/uapi/linux/const.h:21:25: note: in expansion of macro '__AC'
> >       21 | #define _AC(X,Y)        __AC(X,Y)
> >          |                         ^~~~
> >    include/linux/sizes.h:56:41: note: in expansion of macro '_AC'
> >       56 | #define SZ_16G                          _AC(0x400000000, ULL)
> >          |                                         ^~~
> >    include/linux/mm.h:2095:43: note: in expansion of macro 'SZ_16G'
> >     2095 | #define MAX_FOLIO_ORDER         get_order(SZ_16G)
> >          |                                           ^~~~~~
> >    mm/internal.h:758:33: note: in expansion of macro 'MAX_FOLIO_ORDER'
> >      758 |         VM_WARN_ON_ONCE(order > MAX_FOLIO_ORDER);
> >          |                                 ^~~~~~~~~~~~~~~
>
> Oh gee.
>
> Here's the patch: https://lkml.kernel.org/r/20251112145632.508687-1-david@kernel.org
>
> I'll append a copy below.
>
> For a start, you have found an sh config which sets neither
> CONFIG_32BIT not CONFIG_64BIT.  Should that even be possible?

Apparently yes...

arch/sh/mm/Kconfig:

    config 29BIT
            def_bool !32BIT
            select UNCACHED_MAPPING

    config 32BIT
            bool
            default !MMU

    config PMB
            bool "Support 32-bit physical addressing through PMB"
            depends on MMU && CPU_SH4A && !CPU_SH4AL_DSP
            select 32BIT
            select UNCACHED_MAPPING
            help
              If you say Y here, physical addressing will be extended to
              32-bits through the SH-4A PMB. If this is not set, legacy
              29-bit physical addressing will be used.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
