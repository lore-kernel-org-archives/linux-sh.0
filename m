Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0F9C433F5
	for <linux-sh@archiver.kernel.org>; Sun, 12 Sep 2021 02:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1CB61208
	for <linux-sh@archiver.kernel.org>; Sun, 12 Sep 2021 02:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhILCQJ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 11 Sep 2021 22:16:09 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:34972 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhILCQJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 11 Sep 2021 22:16:09 -0400
Date:   Sat, 11 Sep 2021 21:57:41 -0400
From:   Rich Felker <dalias@libc.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
Message-ID: <20210912015740.GJ13220@brightrain.aerifal.cx>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
 <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Sep 09, 2021 at 06:08:58PM +0900, Daniel Palmer wrote:
> HI Adrian,
> 
> On Thu, 9 Sept 2021 at 17:25, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > There are quite a number of patches on the mailing list that need reviewing and
> > I fear if that doesn't happen in the foreseeable future, the SH port is being
> > kicked out which would be a pity given that we're still maintaining the port in
> > Debian and given that there is new hardware available with the J-Core board [2].
> 
> This really is a poor situation. The fact that there are patches means
> that it's not totally dead but no one ever looking at them really puts
> people off bothering in the future.
> I might have a go at getting OF to work on the SH4 hardware I have but
> knowing that the patches will probably never get looked at is very
> demotivating.
> 
> Can we get a new maintainer from somewhere?

Hi. I see there's a situation that needs my attention here. I will
plan to review and merge anything important/blocking that doesn't have
problems this week.

In the bigger picture, the past few weeks and even months I've been in
a sort of "avoid burnout safety mode". :-) Probably partly on account
of this pandemic still being a thing because people insist on being
stupid. I'm not gone and won't be, but some things that haven't seemed
as urgent, including kernel stuff and especially piles of email of
mixed importance levels, have gotten pushed back to reduce stress.
Please don't hesitate to wave a "hey this is important, come take a
quick look!" flag at me if needed.

At the same time, I am open to the possibility of a new maintainer or
co-maintainer if that ends up being what makes sense. Are there any
candidates?

Rich
