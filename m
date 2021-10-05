Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A963C433F5
	for <linux-sh@archiver.kernel.org>; Tue,  5 Oct 2021 07:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B8E61056
	for <linux-sh@archiver.kernel.org>; Tue,  5 Oct 2021 07:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhJEHXw (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:23:52 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:47029 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbhJEHXw (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 5 Oct 2021 03:23:52 -0400
Received: by mail-vs1-f47.google.com with SMTP id i30so1871564vsj.13;
        Tue, 05 Oct 2021 00:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4O4XIro868olf1wuylF9SCQXMXnh8ese50mqT6xsuuM=;
        b=7zdg6NHSO4bnlyBiuc/adFSZKXQn4L3LWssjs39cTje67fE8nxqHccr6DH1HPWLZcJ
         mx7EnXpoqb31yU8AAFcpPqWr3/Dsq391shRzbCu/KVDcyImKTfXE3Jeio/KiMPxgcqC0
         B+alUnVgcpX+YQhnAdrd82e9fwkA+NrNL2m1OJA38fsA09wLMsqyf+Pnaj5XnXLk/JJN
         wGfaGBpPHMNidyjW0h+Ov+rdpGH4T6sHDFpgkRArjVMJCBYRcpFvAUDue0NKaq+SZn+t
         0t4wOl8AIizUmVVNckHhXBvYHPR39AygkWqfEhqaZY4a9JOGc3V0Hz59D+vu7fGs398+
         /JNA==
X-Gm-Message-State: AOAM530TFNNsQvXB0Yq675GCQAcjGktLTgOkmu3xFqwVmgma6//jcqjy
        4M+zfFZt1mfsgmjcxq1+odE/2aK3DI1bt2JxoWDeABdD
X-Google-Smtp-Source: ABdhPJyqQC3Sn92Li8BRseG8K2kSDaj8wDlFVxxnje2BdMpIk7SgXWBAYO28JeecSeH/zE8VP00QTVA1KrTJ0pyUaz8=
X-Received: by 2002:a67:2c58:: with SMTP id s85mr16913385vss.35.1633418521843;
 Tue, 05 Oct 2021 00:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211005001914.28574-1-rdunlap@infradead.org> <20211005001914.28574-3-rdunlap@infradead.org>
In-Reply-To: <20211005001914.28574-3-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Oct 2021 09:21:50 +0200
Message-ID: <CAMuHMdUPDgZ3nVsMx4y2uqC6vLzOUYSeCucMO0_rRv73BSLnWA@mail.gmail.com>
Subject: Re: [PATCH 2/5 v3] sh: add git tree to MAINTAINERS
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Oct 5, 2021 at 2:19 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Add the git tree location for linux-sh.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
