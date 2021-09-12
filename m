Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E17CC433EF
	for <linux-sh@archiver.kernel.org>; Sun, 12 Sep 2021 10:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F1D610FD
	for <linux-sh@archiver.kernel.org>; Sun, 12 Sep 2021 10:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhILKiC (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 12 Sep 2021 06:38:02 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:60463 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229597AbhILKiB (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 12 Sep 2021 06:38:01 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1mPMqn-001CK5-Ip; Sun, 12 Sep 2021 12:36:41 +0200
Received: from [46.183.103.8] (helo=[172.18.187.1])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1mPMqm-001cbG-TO; Sun, 12 Sep 2021 12:36:41 +0200
Message-ID: <5aa5301e-9b01-4e96-e185-13c2d4d7b675@physik.fu-berlin.de>
Date:   Sun, 12 Sep 2021 12:36:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
Content-Language: en-US
To:     Rich Felker <dalias@libc.org>, Daniel Palmer <daniel@0x0f.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
 <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com>
 <20210912015740.GJ13220@brightrain.aerifal.cx>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <20210912015740.GJ13220@brightrain.aerifal.cx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 46.183.103.8
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rich!

On 9/12/21 03:57, Rich Felker wrote:
> Hi. I see there's a situation that needs my attention here. I will
> plan to review and merge anything important/blocking that doesn't have
> problems this week.

I'm glad to here that you're still active. I will try to help assembling
the list of patches. I won't be able to test them though as I'm not at
home so I'm unable to reset the machine in case it crashes due to a bad
kernel patch. So, basically, I just have one shot free.

> In the bigger picture, the past few weeks and even months I've been in
> a sort of "avoid burnout safety mode". :-) Probably partly on account
> of this pandemic still being a thing because people insist on being
> stupid. I'm not gone and won't be, but some things that haven't seemed
> as urgent, including kernel stuff and especially piles of email of
> mixed importance levels, have gotten pushed back to reduce stress.
> Please don't hesitate to wave a "hey this is important, come take a
> quick look!" flag at me if needed.

We definitely need to get all those patches merged that fix warnings as Linus
recently moved to building with -Werror by default.

> At the same time, I am open to the possibility of a new maintainer or
> co-maintainer if that ends up being what makes sense. Are there any
> candidates?

I would generally be interested to help although I'm not as knowledgeable
when it comes to low-level kernel development.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

