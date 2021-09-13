Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53881C433F5
	for <linux-sh@archiver.kernel.org>; Mon, 13 Sep 2021 11:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4014960F92
	for <linux-sh@archiver.kernel.org>; Mon, 13 Sep 2021 11:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhIMLwl (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239682AbhIMLwk (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 13 Sep 2021 07:52:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795BC061760
        for <linux-sh@vger.kernel.org>; Mon, 13 Sep 2021 04:51:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i4so3391229lfv.4
        for <linux-sh@vger.kernel.org>; Mon, 13 Sep 2021 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcxL95DIl7E0Surm2fYVh0FLQdkw8xdl/2I8gB6Ck0A=;
        b=F/FAqgSC2yHhGt81eMsu5irZzsSG7lnTScaJlLQars0vcimQ5j+chCBZ/sqyDjOVaw
         zszBu+9roSDnBN6pLYP9I9oePiq0cMyRp8H4tQOYuzrHPrLmUFng3Qz3sElUBeK3X4AH
         4WS1j8hhHZyjGQMijZ25Y0LF9sNe21zcaq2Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcxL95DIl7E0Surm2fYVh0FLQdkw8xdl/2I8gB6Ck0A=;
        b=lxvhzRCxXpXrsfjlO/Rrd6kTA0W5kEvhbda68QP9jPP87gpoOUVk+AENrjLs7+Edgl
         UFw6lio3p7a/SnEAQ71UCzgFOFRa8EW5P6RGfYsjtOox7yGFRkjUXJSTls9Zv0x7Pvi1
         y0wZmqHfEHu+Vau/h7Tmryh/IwG6n4JfZPpxb5i6pGUIHfmQws0SQj0wiEh/ftfQzXFr
         CEMRo14hc4RWhY/dDO9s7HuFPX2kKzcO/F6j9I60kXKDQeTnQ+HgSyXyK/dzxthfn/IC
         RUqlwBEBjCO6j2juEzwyocHBkWbVUU+zdcJ7VEKg2VWFj+ThcBb6j3xuFy7ycIpkzhrU
         yPIQ==
X-Gm-Message-State: AOAM532NVyWRJ/TWdL76iWafiCrttVKO8C5GuGUZqUMfgEIRUjlp/Rqf
        r3sXsPv1KMlRJDmxsycHxDPiJRNJy5aXkH2ME9F6zg==
X-Google-Smtp-Source: ABdhPJzQUy1rsa2nwHauTUnzipk89JG7Ch4EPsaNLW/0YP4N/Py2u4+AEqdTBjHV7GUlDd2hGYO0QrK02PPjy89yJfM=
X-Received: by 2002:a05:6512:118e:: with SMTP id g14mr8493571lfr.661.1631533883167;
 Mon, 13 Sep 2021 04:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210627220544.8757-1-rdunlap@infradead.org> <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
 <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com> <20210912015740.GJ13220@brightrain.aerifal.cx>
In-Reply-To: <20210912015740.GJ13220@brightrain.aerifal.cx>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 13 Sep 2021 20:53:42 +0900
Message-ID: <CAFr9PXk_w_+4mec1OfQLzsYHta2P4rEFGwsJJv+LSQo+hzKGeg@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
To:     Rich Felker <dalias@libc.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rich,

On Sun, 12 Sept 2021 at 10:57, Rich Felker <dalias@libc.org> wrote:
>
> On Thu, Sep 09, 2021 at 06:08:58PM +0900, Daniel Palmer wrote:
> Hi. I see there's a situation that needs my attention here. I will
> plan to review and merge anything important/blocking that doesn't have
> problems this week.

Great. If you want to have it tested on real hardware please let me know.
I have an ecovec24 (SH4A) board connected to CI so I can easily build
and boot test.

> At the same time, I am open to the possibility of a new maintainer or
> co-maintainer if that ends up being what makes sense. Are there any
> candidates?

I think the problem is that while there are hobbyists out there the
number of people that are still familiar with how the SuperH stuff
works is pretty low.
I don't have the debug dongles etc anymore so if some treewide change
breaks everything then I don't know how I'd debug it.
Maybe we could add a few people that still have working hardware as
reviewers so they see patches and build test them for you?

Cheers,

Daniel
