Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C811C43334
	for <linux-sh@archiver.kernel.org>; Thu,  9 Jun 2022 12:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbiFIMD2 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245019AbiFIMD1 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 9 Jun 2022 08:03:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32FD6A40C
        for <linux-sh@vger.kernel.org>; Thu,  9 Jun 2022 05:03:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id g25so25863517ljm.2
        for <linux-sh@vger.kernel.org>; Thu, 09 Jun 2022 05:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1uvmSUGsFaK9iCgbfPZK7tHgGjdwwOqEzHuFfRRs9g=;
        b=WUkfehuOGVt1LjXm/E8vM1d53pS7ZaW2P1Do4rYDPDj9x3HcIScUEYL429OjpkXLee
         jKnWe2xHFGpQfUYwz4KCSM/QSRqVXpKdCN5oz8GsDU5DuvHD+3t72nhyjn/C42AH+FJE
         B8u60LeDgw6TrkfqcF9cmWwgXAWc4dsk/+kvEweY3EkZrpr+48Ul3ihaLREa0VHJVfGd
         QF/a5FQ4uroEtUMkhyWKOGgGpuB3aSGc2gGY+rP76oDwg8gFOBmuE+hJov/QxpNKWfMM
         H/bSpILdyre2NJj4nJFgAVNIzQ30RuGAce6bZLMEB3lWofAjSWjRfethyraCxfQtJqJ5
         +zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1uvmSUGsFaK9iCgbfPZK7tHgGjdwwOqEzHuFfRRs9g=;
        b=NO8FWSs01apGDPnHzilI+3RH1Ocx/ZNn7ggS852mz4mnjpAnQ9QbgMH29rlTWeZT/h
         0EpDOmkl1s/NxjBODA5nhnIOVbpoRLF7EnCuZ1LWrXOxRWqKt5o1rqdUYYg0rfDhAJPr
         Ay1PEkV+3vtrLW5vAhkMAsBkJHeSXIviU1uC8eQZnkMiBIDBy8g69TWIDN3k7gaNxr/n
         wVYu89PpIN5tSEYXV2tG+zs2u6gHqJ0A3LPcmFtJFig4T4ACuZDNpVqo7VhNCmNrgJdZ
         GQzXON9SYiwzZ6REnKKDay9EWPnjuhtePgyhOMqc50UdTM0bdqUfqb7PGYA7B2p/C/d4
         weJw==
X-Gm-Message-State: AOAM533EYS7OjALyOO5mVw4t9cEJ6lnLFZLJIm83oXQ0GAHA11nXGOTz
        VsvBS2GfNHjk2bo+oLeR9W1fLVRhlp/x6MgF8fM1SQ==
X-Google-Smtp-Source: ABdhPJxfZVZGlvjYE4w1eUlkiH9HxbazLSoZW7O6i7wGbNkeA/3aiPhaXhS5SKok6B8zD3jEVpSvW8WE2PiDcXvPKDQ=
X-Received: by 2002:a2e:b0fc:0:b0:255:6f92:f9d4 with SMTP id
 h28-20020a2eb0fc000000b002556f92f9d4mr21901545ljl.92.1654776203624; Thu, 09
 Jun 2022 05:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-5-elver@google.com>
In-Reply-To: <20220609113046.780504-5-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 14:03:12 +0200
Message-ID: <CACT4Y+YHp1mxxGNuGke42qcph0ibZb+6Ri_7fNJ+jg11NL-z8g@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
>
> Due to being a __weak function, hw_breakpoint_weight() will cause the
> compiler to always emit a call to it. This generates unnecessarily bad
> code (register spills etc.) for no good reason; in fact it appears in
> profiles of `perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512`:
>
>     ...
>     0.70%  [kernel]       [k] hw_breakpoint_weight
>     ...
>
> While a small percentage, no architecture defines its own
> hw_breakpoint_weight() nor are there users outside hw_breakpoint.c,
> which makes the fact it is currently __weak a poor choice.
>
> Change hw_breakpoint_weight()'s definition to follow a similar protocol
> to hw_breakpoint_slots(), such that if <asm/hw_breakpoint.h> defines
> hw_breakpoint_weight(), we'll use it instead.
>
> The result is that it is inlined and no longer shows up in profiles.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/hw_breakpoint.h | 1 -
>  kernel/events/hw_breakpoint.c | 4 +++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> index 78dd7035d1e5..9fa3547acd87 100644
> --- a/include/linux/hw_breakpoint.h
> +++ b/include/linux/hw_breakpoint.h
> @@ -79,7 +79,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
>  extern int dbg_release_bp_slot(struct perf_event *bp);
>  extern int reserve_bp_slot(struct perf_event *bp);
>  extern void release_bp_slot(struct perf_event *bp);
> -int hw_breakpoint_weight(struct perf_event *bp);
>  int arch_reserve_bp_slot(struct perf_event *bp);
>  void arch_release_bp_slot(struct perf_event *bp);
>  void arch_unregister_hw_breakpoint(struct perf_event *bp);
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 8e939723f27d..5f40c8dfa042 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -125,10 +125,12 @@ static __init int init_breakpoint_slots(void)
>  }
>  #endif
>
> -__weak int hw_breakpoint_weight(struct perf_event *bp)

Humm... this was added in 2010 and never actually used to return
anything other than 1 since then (?). Looks like over-design. Maybe we
drop "#ifndef" and add a comment instead?

> +#ifndef hw_breakpoint_weight
> +static inline int hw_breakpoint_weight(struct perf_event *bp)
>  {
>         return 1;
>  }
> +#endif
>
>  static inline enum bp_type_idx find_slot_idx(u64 bp_type)
>  {
> --
> 2.36.1.255.ge46751e96f-goog
>
