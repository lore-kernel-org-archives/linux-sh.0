Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883FDC433F5
	for <linux-sh@archiver.kernel.org>; Wed, 20 Oct 2021 19:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA24610EA
	for <linux-sh@archiver.kernel.org>; Wed, 20 Oct 2021 19:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhJTUAf (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhJTUAe (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 20 Oct 2021 16:00:34 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F12C06161C
        for <linux-sh@vger.kernel.org>; Wed, 20 Oct 2021 12:58:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id g8so158377ljn.4
        for <linux-sh@vger.kernel.org>; Wed, 20 Oct 2021 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sg0o6MwSr5cVKhIKZL14YkinrZh0wp6xkfDKA7tp+7w=;
        b=FLcpWYGZhutnNkkuvkw53ygCMmmg9LwqTbT6ZB9EQ+0BzZdpzhVrWJpY+Ah74l6Fo3
         fKf8k8NzXJylaUyv4Ra6xGmCX2vWkERwH8CUBgfCgiM8z7LawcVJNAlJdfqFLr3ydLCn
         VVaz28NJzgchYxZ7U6J+aXnVc+mjIfIDWQ7Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sg0o6MwSr5cVKhIKZL14YkinrZh0wp6xkfDKA7tp+7w=;
        b=Yeqncc1uyZSC8sx4M62o1/p2yldsZm1IB+aC0MuVtkGUBkbI/S6ythIWIMo6lhsq3E
         d371y/gyRwbbJ/jCnpMs/ZWOtYJNPcTc5DdPJ3EOIgmGa/PfAjfREU9lBRJw9g/nQt7z
         YNkpZ8D/DqtBLYMlZ4hO7eh1hjERAkfoSFJQoFqAZOBU/jUr1PuiyDttz7RNmwENR/1s
         GsE9BG0RGdJx67ci8tBxDk0geZE+vFEccH39XDn96QsRjqxAtvjKo4VMBtUheWy8PZlL
         GXF8Ksmp3KRwz85IdTQiT4jHrDxCwoB68kwq9d2cZZipPdUZFhO5uFHyYmmjmbqdIV3W
         Xd0g==
X-Gm-Message-State: AOAM532I3Hx+/u+bwqHdpe7Vx5aRNS0WM8At3c/hrmyIQg8c1FrzD1+y
        S8QbUcu5ql/+xfXRuY85tP9xnHZuJVlpqds/
X-Google-Smtp-Source: ABdhPJzeLSl9Rqf/H53kiX8GuKB3pCDajiD8tlxPJ5XnJp1fRUNNYNas5IUxsd49r/Tr1R62h7mVUQ==
X-Received: by 2002:a2e:9751:: with SMTP id f17mr1127463ljj.343.1634759897311;
        Wed, 20 Oct 2021 12:58:17 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r2sm265586lfi.152.2021.10.20.12.58.14
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 12:58:15 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id e19so12564ljk.12
        for <linux-sh@vger.kernel.org>; Wed, 20 Oct 2021 12:58:14 -0700 (PDT)
X-Received: by 2002:a2e:934d:: with SMTP id m13mr1155978ljh.191.1634759894116;
 Wed, 20 Oct 2021 12:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-6-ebiederm@xmission.com>
In-Reply-To: <20211020174406.17889-6-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 09:57:58 -1000
X-Gmail-Original-Message-ID: <CAHk-=whjqWwo16jtLduxb+0nbNetp8jNAz+go01wB4HGKX=jEQ@mail.gmail.com>
Message-ID: <CAHk-=whjqWwo16jtLduxb+0nbNetp8jNAz+go01wB4HGKX=jEQ@mail.gmail.com>
Subject: Re: [PATCH 06/20] signal/sh: Use force_sig(SIGKILL) instead of do_group_exit(SIGKILL)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Oct 20, 2021 at 7:44 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> +                       force_sig(SIGKILL);

I wonder if SIGFPE would be a more intuitive thing.

Doesn't really matter, this is a "doesn't happen" event anyway, but
that was just my reaction to reading the patch.

            Linus
