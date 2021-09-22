Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC9EC433EF
	for <linux-sh@archiver.kernel.org>; Wed, 22 Sep 2021 02:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA076112F
	for <linux-sh@archiver.kernel.org>; Wed, 22 Sep 2021 02:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhIVCrN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:47:13 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:55592 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhIVCrM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 21 Sep 2021 22:47:12 -0400
Date:   Tue, 21 Sep 2021 22:45:41 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
Message-ID: <20210922024537.GA27465@brightrain.aerifal.cx>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
 <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com>
 <20210912015740.GJ13220@brightrain.aerifal.cx>
 <5aa5301e-9b01-4e96-e185-13c2d4d7b675@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aa5301e-9b01-4e96-e185-13c2d4d7b675@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sun, Sep 12, 2021 at 12:36:38PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> On 9/12/21 03:57, Rich Felker wrote:
> > Hi. I see there's a situation that needs my attention here. I will
> > plan to review and merge anything important/blocking that doesn't have
> > problems this week.
> 
> I'm glad to here that you're still active. I will try to help assembling
> the list of patches. I won't be able to test them though as I'm not at
> home so I'm unable to reset the machine in case it crashes due to a bad
> kernel patch. So, basically, I just have one shot free.

I didn't get through that yet, but I have rebased the patches that
were pending in for-next onto v5.15-rc1 (no conflicts) and
smoke-tested that a sh4 build runs in my qemu environment. linux-next
pulled them 27 hours ago and hasn't complained yet either.

I started going through the list/patch backlog, but didn't make it
nearly as far as I'd like yet. If you have even a vague list of what's
important (warnings breaking the build, unapplied changes blocking
removal of cruft from other parts of the kernel and making people
unhappy with us, etc.) that would be really helpful.

I'll follow up again soon.

Rich
