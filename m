Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB63C4338F
	for <linux-sh@archiver.kernel.org>; Mon, 16 Aug 2021 07:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7DF61A8C
	for <linux-sh@archiver.kernel.org>; Mon, 16 Aug 2021 07:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhHPHXD (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 16 Aug 2021 03:23:03 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35412 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233725AbhHPHXD (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 16 Aug 2021 03:23:03 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 17G7MDgs013422;
        Mon, 16 Aug 2021 09:22:13 +0200
Date:   Mon, 16 Aug 2021 09:22:13 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     zhao xc <xinchao.zhao.kernelz@gmail.com>, ysato@users.osdn.me,
        dalias@libc.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Patch formatting - Re:
Message-ID: <20210816072213.GA13349@1wt.eu>
References: <CAP7CzPfRFSfUka1Wjo1+KNSdhYjR2n59g2yvEFGRyfYwNFNy1A@mail.gmail.com>
 <fbd17d71-91e8-fb0c-f621-ee41787e4bad@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbd17d71-91e8-fb0c-f621-ee41787e4bad@physik.fu-berlin.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Aug 16, 2021 at 09:04:57AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Zhao!
> 
> Thanks for your patch!
> 
> However, the patch has not been properly formatted and needs to be resend.
> 
> Could you follow this guide [1] and send your patch again in the correct
> format?

Adrian, it would be nice to give some hints about what has to be fixed,
because it's not necessarily easy to be able to figure this by comparing
one's patch to an example in a blog article.

Zhao, some hints:
  - the subject line doesn't make it obvious what subsystem is being touched.
    Often running "git log" on the file(s) you change can help you figure what
    others commonly use ;

  - the commit message is empty, it should carry a description of what you
    are trying to improve or fix, and when relevant, some indications about
    how you decided to address that. A good hint is to think that you're
    trying to "sell" your patch to someone else who will become responsible
    for maintaining it, thus put all the selling arguments there :-)

  - often a Cc list is desired if it touches areas that may impact others,
    as well as their maintainers ;

  - using git-send-email like in the article is generally preferred as it
    makes the process smoother on the receiver's end. It can look scary
    at first, making you fear to accidentally send poorly formatted
    e-mails, but in practice it's rare, and recipients are used to seeing
    this and are very tolerant to this :-)

And yes, reading Nick's article is definitely a good idea!

> Thanks,
> Adrian

Regards,
Willy
