Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7563CC433EF
	for <linux-sh@archiver.kernel.org>; Mon,  1 Nov 2021 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D09260EBB
	for <linux-sh@archiver.kernel.org>; Mon,  1 Nov 2021 19:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhKATM7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhKATM6 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 1 Nov 2021 15:12:58 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E266C061764
        for <linux-sh@vger.kernel.org>; Mon,  1 Nov 2021 12:10:24 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id t1so11904555qvb.1
        for <linux-sh@vger.kernel.org>; Mon, 01 Nov 2021 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Yh5KAej115BOsmnCnzIqo/9ygAgu2wASV/OBA3KQsg=;
        b=NqfKD7yCrDyqZTAqLkfFLKlHoQpuxs9uJpelMw1xnHrchWNzWIp/ea8Yze1viJ/TMn
         KcB+8uaaJPnsstlTcnAZvZsI51p8dFpj8C3mHYQUUGUy8+zNacN16D1Lc6yJuz2Y3xiy
         wj0qigu7U6IO0fnmq70SneI9wX2FqqDpJevU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Yh5KAej115BOsmnCnzIqo/9ygAgu2wASV/OBA3KQsg=;
        b=fU+fk1Jw08OH7rIzSyGH4ZPGXekwYMxw4yrQ2V9GjbqokCxBhQtJp5VnfQy60haZHV
         22RS+kTus0iT7ioeDsL3zVD0SuC+cz2YDYrQyG7y4pi+n/m0xvpqH4yzD9aYJY9xoZ3l
         EqVg6lbhZc4vGs0wklTfAP9hIfmbpX4jmMsjo3hNyje/hfXE+s//iJ0D1Jxu4CK4Bbsh
         nxA++o81z+rL2o8gMQw02abVlM+Z5b1HGKZtNCcu0Thc8XKZCyqmTJnb3Bthq6VT2OGX
         kviErEDpXgigAQy3yPzQUuVB+h6cWNTSj1b7pcHniB/NM+B+xQMMY0Mj9bBl0xiSe2vf
         qPOA==
X-Gm-Message-State: AOAM532QYUs1Kw0Bk02wH4Ql5vIERQdGmlq3g75InJlvFxz2C4wZg6ae
        mwzBA2UVINRDltDPiH8YPhrHmg==
X-Google-Smtp-Source: ABdhPJxpBnWPwguqPFlWIYe36uOS4iP9xRrY7Mw/91d7GMwtvxUCMEDoyWLmmNZNaH8/dQEDvUjhGw==
X-Received: by 2002:ad4:5b86:: with SMTP id 6mr11153060qvp.25.1635793823542;
        Mon, 01 Nov 2021 12:10:23 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id br17sm10815417qkb.10.2021.11.01.12.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:10:23 -0700 (PDT)
Date:   Mon, 1 Nov 2021 15:10:21 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH 2/5 v3] sh: add git tree to MAINTAINERS
Message-ID: <20211101191021.h674kgeuqi4qyhdu@meerkat.local>
References: <20211005001914.28574-1-rdunlap@infradead.org>
 <20211005001914.28574-3-rdunlap@infradead.org>
 <20211027205431.GX7074@brightrain.aerifal.cx>
 <CAMuHMdWUQkhYxXfrG4MG-Ghi62P_XVxkCMb_6qijP-MMgn-JWg@mail.gmail.com>
 <20211028133049.GY7074@brightrain.aerifal.cx>
 <CAMuHMdUw=6RMF4gEhROMBwQALNmmKJgiKQLYymV4m75EZV+DJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUw=6RMF4gEhROMBwQALNmmKJgiKQLYymV4m75EZV+DJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Oct 28, 2021 at 03:37:47PM +0200, Geert Uytterhoeven wrote:
> > > > I'm omitting this for now since (as noted on the cgit description)
> > > > this server is not provisioned adequately for cloning from scratch,
> > > > and should only be used for fetch into an already-populated mainline
> > > > repo clone. If that's a problem I can see about getting it moved
> > > > somewhere more appropriate.
> > >
> > > Perhaps you can move it to kernel.org?
> >
> > I would love to. This was my hope years ago, but I got bogged down in
> > the GPG key signing requirements and folks not following through with
> > signing my key. Has any of that been streamlined since?
> 
> I'll let Konstantin respond...

We still require a valid web of trust before we can issue an account, so
things haven't really changed in that regard. You have to get a PGP signature
from at least 2 other people who already have an account on kernel.org.

If you just need to host your git tree for hosting and sending pull requests,
then there's really no lack of options. Any large commercial git forge will
do just fine, including github, gitlab, gitea, sourcehut, etc. There's nothing
really special about kernel.org in this regard.

-K
