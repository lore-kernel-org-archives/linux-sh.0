Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F56C433EF
	for <linux-sh@archiver.kernel.org>; Tue, 28 Jun 2022 10:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbiF1KzK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245037AbiF1KzK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 28 Jun 2022 06:55:10 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFA33193A
        for <linux-sh@vger.kernel.org>; Tue, 28 Jun 2022 03:55:09 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31bf327d4b5so23254847b3.13
        for <linux-sh@vger.kernel.org>; Tue, 28 Jun 2022 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bx+nn3bN9pkcTAPrSO8SXuVhJpjdYzH6Wim9ZDKKiAY=;
        b=SgjVnFGomlUOotY/gew1wOdWrD475NDkUK1mb2rUT0EFvD8XhhNOIIykcSWEEL6YxM
         jJinJuo/gJhCW+dtmxOqBXMPReGrI3zwNRZ+WxliSN7Qpbi3jNvVW6ZwIMhSLVwOZY6t
         ByNEzLBuoiVfE3KB4iqfCywFWucy1UDCjq2jhO+UJZFD+1vUpogEWe/tfIk+C9HEG//B
         dURvYRrCbZJjIctxYxYIMKq5CBmVom2p/kc915BHwbw1lCKYOEFZKDEsHmdfX9irHD7j
         F1llsAgUDsNOJIVYDHW7Qal7uXAZjI8v4vAgdaHAB1+k39/T1eUyg4VTTYoCAmCLSqV5
         va5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bx+nn3bN9pkcTAPrSO8SXuVhJpjdYzH6Wim9ZDKKiAY=;
        b=i7lf7IY9PIAeoIH7osGeTo1l/8G6L0fCjTxbHYFaVtNcGVaS6wDQ0oDhP6ZZMv88/I
         LauUCt8KqXCToe54e2eshmbu4k6z8WFOwXwVl5EBZCbE7wHIXAIjPXnTNqsiCas7J3RT
         dzz4KCSGlpnSnyGC3zZewQupU0yuvOntLvi5EaZZUuhvFZScvipzyzXArVLzq0RWwjL4
         cDk7OrpX2aY/epMrIHajh2z3j0IQSdQ0z40A2N6lVpAM7/m1OVKjIPaoTI+0aqBYGD/1
         ppzlXXGtwtC2JpjmbtRjXCMlAFkFtvq11xA2kHq2WvcdYTPokslSWbsnc/d1oeWY3as5
         OmMQ==
X-Gm-Message-State: AJIora8ngTdE9af+X+IeO9h6sp2FOP9WPDgwpPl61e9xGBd2iQ9GQlzk
        22Qx9bk4pkdsnLEilhvoZEvsp+sxG6FGzLnCY63zEw==
X-Google-Smtp-Source: AGRyM1vz2ZG/AOoQ4vBN8VmbUXJLQvwRbaY4tA5etmPkx+EhZBLBb/NNp85KWwxKWmdK+O/VbOcVkqR614Ti4viQrKI=
X-Received: by 2002:a81:1a42:0:b0:318:3915:57d7 with SMTP id
 a63-20020a811a42000000b00318391557d7mr19561304ywa.327.1656413708510; Tue, 28
 Jun 2022 03:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-14-elver@google.com>
In-Reply-To: <20220628095833.2579903-14-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jun 2022 12:54:32 +0200
Message-ID: <CANpmjNPapZ9p3dSB1RC-cBoJ588XkRxJRzbhxx4THLZ9aWsx=A@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf/hw_breakpoint: Optimize toggle_bp_slot()
 for CPU-independent task targets
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, 28 Jun 2022 at 11:59, Marco Elver <elver@google.com> wrote:
[...]
> +       /*
> +        * Update the pinned task slots, in per-CPU bp_cpuinfo and in the global
> +        * histogram. We need to take care of 5 cases:

This is a typo: "5 cases" -> "4 cases".
