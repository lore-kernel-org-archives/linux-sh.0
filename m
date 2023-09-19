Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A4CCD5BAE
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 12:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjISMqi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjISMqd (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 08:46:33 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2283135
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:46:20 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59ed7094255so4636407b3.3
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127580; x=1695732380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2s3Ywt47rotnRewvt+puy/6mmr9MRTC6ZSkqSWl3Diw=;
        b=rGT97Dm234GCEDse76sAxhYOfPX+Ip6UADSp4UvQ+OzsD7gmdhl6cHXa4/gnvK82iH
         QasLKzlI9ZJX/UBR5XW+dKmYqFiPLTdrFNwIzvcVaS6iqzL7qNJc918EpfoJGO9MfF2x
         TTQIULz8/ce9xJ32rJA7YpKFdH6bPv+4GTuI4c/luQwsgelx6zb5EWYQ/1qm9rybKHFm
         WtafjEeGtCawtHYVfmPJwKNEbJEm7bxU2pPv6S1CNqeGNN82suP8H8tIp7rGTMPCFgU7
         XhR5+z1VeiUuWl+CB4Ag+D96qlwu0SQ9GlGm4FbFEmpV0do4BbHEyJ3m13YpegYdsaRz
         PfVA==
X-Gm-Message-State: AOJu0YwNtSH7dUKP5T9NejDnmvXAq5yaG9Npp3Q0gbtIhND6THW9CCNo
        0WjpHZ9urB3zk1E35F6EF80FAssdvDFNZw==
X-Google-Smtp-Source: AGHT+IHp0i0cbIcJj9gmfZsobM49rHpLPkVYU849S4/P1vwWP9M+0sDh2nveHSD4cTVRL4f2xp8s7A==
X-Received: by 2002:a0d:d74e:0:b0:59b:c805:de5d with SMTP id z75-20020a0dd74e000000b0059bc805de5dmr12854168ywd.16.1695127579982;
        Tue, 19 Sep 2023 05:46:19 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id w135-20020a81498d000000b00577139f85dfsm3136914ywa.22.2023.09.19.05.46.19
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:46:19 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59ed7094255so4636157b3.3
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:46:19 -0700 (PDT)
X-Received: by 2002:a81:52ca:0:b0:59b:bea7:29cb with SMTP id
 g193-20020a8152ca000000b0059bbea729cbmr11392663ywb.1.1695127579615; Tue, 19
 Sep 2023 05:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <7b5122f6252cf4ce563b2fab2ac61bd794876619.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <7b5122f6252cf4ce563b2fab2ac61bd794876619.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 14:46:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyP=A8A0C681iztB0tFzDT=a3KnkXbD4C6sfPGFBG+yQ@mail.gmail.com>
Message-ID: <CAMuHMdWyP=A8A0C681iztB0tFzDT=a3KnkXbD4C6sfPGFBG+yQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/30] include/dt-bindings: Add SH7750 CPG header.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:29 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

>  include/dt-bindings/clock/sh7750.h | 13 +++++++++++++

This is a dependency for both the clock driver and the various
DTS files, so it should be moved up in the series.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
