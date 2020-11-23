Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B56C2D0E4
	for <linux-sh@archiver.kernel.org>; Mon, 23 Nov 2020 08:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803822076E
	for <linux-sh@archiver.kernel.org>; Mon, 23 Nov 2020 08:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgKWILn (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 23 Nov 2020 03:11:43 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:44073 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKWILm (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 23 Nov 2020 03:11:42 -0500
Received: by mail-oo1-f67.google.com with SMTP id i13so3750408oou.11
        for <linux-sh@vger.kernel.org>; Mon, 23 Nov 2020 00:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sLcuF1U5tPJBxktukhMBw/+FJHbnCMjwPuYvKHalhyk=;
        b=hrZsqrpOUKxuDgH7rGuNNTHa73dehci2bXVEHF0til2Sn9Ip6KuaCjACKUvd0NfoaX
         uxro2ZzHclRSFGEtr2eBMLyYIkbZxFiV5w1ycXJ1/4odsqGEwlbRG+YaIohh44sVQ0df
         tEKGfLPu7yB1svQ702v+75PE0h55MLjBoEKvhBapi9AMQ1Kdn33zqgofadzpY49sf9lN
         HH/Pb/mcUZWYaFDNc5aiTZpRW7EWQd5aXw8C9jwIcjq2nGF6AjTSL+X6LKCSqwCJ9zgv
         uEZbX7sa6aauQXnJ5AV4LwJi1dIc9lSqe5X93isWfs+8x4kmA/DdcArrlDZJlBw92zvr
         saog==
X-Gm-Message-State: AOAM531eoIVMt8PbIhdq48FneKkr9bU/yWJ5qf/yopg9bjZUGbZy5Qb5
        Slh3lv4dJYPoPbD+B9nd8+csZF3b/jpr6Dpr834yWP9c4JY=
X-Google-Smtp-Source: ABdhPJzRVHZ7I6K3bw6s/TPXfmuX8eoevWGKa8ZwWeXXEgtIVGSTVE0ROzJHqdfJew3ilGOTsAnaowpkcljoNTW6gTQ=
X-Received: by 2002:a4a:dc1:: with SMTP id 184mr646517oob.40.1606119102062;
 Mon, 23 Nov 2020 00:11:42 -0800 (PST)
MIME-Version: 1.0
References: <401c48c1-ccf1-8177-d45b-eb632ba799df@landley.net> <e43e6569-99bb-4e24-e9c5-45f9c3244d86@landley.net>
In-Reply-To: <e43e6569-99bb-4e24-e9c5-45f9c3244d86@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Nov 2020 09:11:30 +0100
Message-ID: <CAMuHMdVJFLhJtVCv+M1zxOu2DpGi3o5GAi4VTf7OQsx_gYypeA@mail.gmail.com>
Subject: Re: message ids
To:     Rob Landley <rob@landley.net>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rob,

On Sun, Nov 22, 2020 at 4:00 PM Rob Landley <rob@landley.net> wrote:
> On 11/12/20 1:47 AM, Rob Landley wrote:
> > Message-Id: <20200917154547.139019-1-fazilyildiran@gmail.com>
> > Message-ID: <93d98bab-01dd-5530-9fdb-76faf8dcdd41@infradead.org>
> > Message-ID: <20200919025206.17729-1-miaoqinglang@huawei.com>
> > Message-Id: <20200924043139.522028-1-hch@lst.de> # does not apply with git am???
> > Message-Id: <1602474624-3225-1-git-send-email-hejinyang@loongson.cn>
> > Message-Id: <20201012154050.68039-1-andriy.shevchenko@linux.intel.com>
> > Message-Id: <1604889952-30841-1-git-send-email-wangqing@vivo.com>
> > Message-Id: <1604889303-26722-1-git-send-email-wangqing@vivo.com>
> > Message-ID: <66582445-4ec9-86d0-e286-8e21590f608a@kernel.dk>
> > Message-Id: <20201110154939.3285928-1-geert+renesas@glider.be>
> > Message-Id: <20201110155029.3286090-1-geert+renesas@glider.be>
> >
> > I have no idea why the hch@lst.de one applies with "patch -p1" but not with
> > "git am", that's where I ran out of brain. But they all apply as patches and the
> > result boots.
>
> FYI here are the patches from this list I forwarded to Rich right after -rc3
> came out. They built in my local tree, the result booted, and I didn't spot
> obvious regressions.
>
> If anybody else wants to try them, I can put them in a -git tree or attach them
> to an email?

BTW, the modern way to refer to patches is by prepending
"https://lore.kernel.org/r/"
to the message IDs.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
