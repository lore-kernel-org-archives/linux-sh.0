Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F040BC49EA6
	for <linux-sh@archiver.kernel.org>; Sun, 27 Jun 2021 03:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1290610E5
	for <linux-sh@archiver.kernel.org>; Sun, 27 Jun 2021 03:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhF0DKk (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 26 Jun 2021 23:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhF0DKk (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 26 Jun 2021 23:10:40 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B9C061574
        for <linux-sh@vger.kernel.org>; Sat, 26 Jun 2021 20:08:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o6so23805664qkh.4
        for <linux-sh@vger.kernel.org>; Sat, 26 Jun 2021 20:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=va7DUf7TkXKN4fGyuUyT1CmYtjFdZYEFkc1gybWvP9A=;
        b=ppJ0df1a19HDyhHqUN5M17coWm4A57ArzQBCgyDxiasYI0xaQXnt6tnd9LtaI6Lj0P
         2EOv1I8I65YQ4LItGEj5PKTQMJ4nwGnTJjVkUY3HgNdLuuFc+rszBENYw8/zipJWnZWg
         409qDuu4bYe33lOMdiX0+1xYMgDlJAnOQ68CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=va7DUf7TkXKN4fGyuUyT1CmYtjFdZYEFkc1gybWvP9A=;
        b=FG9cqWUVAwTJ5Da6huZCvrkIhP2X6tSj01BWto5xwcb9T0Ans7ADfrfdFqjmcq/E6a
         sVdwpc472wGVO3zFRfOWha+3LCSXHYtMIwuX0xj2yOCJPPVeWEzMIUxjCmNN5AOYlLDS
         zI0tIEUCfxJ9ZPZPL2Sm7/GRmLqUZTiLNlnQrHHbotcyitnP4GFUrlh7tEM3Pc/ddZD0
         hTLBVAM7xclK54Xo3y5un5ouGS4DbEBWqUgqoGxjW+mQK98BYXsviqoIt+SuSX9BzSfP
         JDMdX5AqRL9sPVVNJ8XedAjx+QzWLWusCwHMd1h+jhwvIbCjprNMJf0e7YmgpiJzVJg5
         iQhw==
X-Gm-Message-State: AOAM530LTH4SjE5znG4qjSfRmYw7L9BeFeLN4duSIUF/iSyLGF4pc1DZ
        LquOf88irPNcNoinZVtdwgcNHd3WlaTWqhuBTXCEQW14kZNpTg==
X-Google-Smtp-Source: ABdhPJxwixlFZPCwI9ScZryjo8y3l9Oo1pN2NyhH9TZFK0lqEnxLiMeO4M5fIdxyb8Nh6BAn2llfbxBuYyCEmYzucTs=
X-Received: by 2002:a05:620a:a57:: with SMTP id j23mr14653961qka.443.1624763294748;
 Sat, 26 Jun 2021 20:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210623133205.GA28589@lst.de>
In-Reply-To: <20210623133205.GA28589@lst.de>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 27 Jun 2021 12:08:04 +0900
Message-ID: <CAFr9PXk84aejj186UNizftwK_w5G1RXLMsSvAEVEYsXi8=yCoA@mail.gmail.com>
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, 23 Jun 2021 at 22:32, Christoph Hellwig <hch@lst.de> wrote
> I have a vague recollection that you were planning on dropping support
> for non-devicetree platforms, is that still the case?

Are there any SH4 boards that actually support DT?
I'm still using an ecovec24 board(SH7724). I'd love to use DT if
that's possible.

Cheers,

Daniel
