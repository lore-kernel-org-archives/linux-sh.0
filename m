Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158D7C433DB
	for <linux-sh@archiver.kernel.org>; Sun, 10 Jan 2021 21:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE68D22AAC
	for <linux-sh@archiver.kernel.org>; Sun, 10 Jan 2021 21:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhAJVrp (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 10 Jan 2021 16:47:45 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:42334 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbhAJVro (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 10 Jan 2021 16:47:44 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id C1C3220026;
        Sun, 10 Jan 2021 22:46:55 +0100 (CET)
Date:   Sun, 10 Jan 2021 22:46:53 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210110214653.GA1693373@ravnborg.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=eJvET0_gvEmFwn2FNFsA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi all,
> Hi Arnd!
> 
> (Please let's have this cross-posted for more visibility. I only learned about this
>  while reading Phoronix news)
> 
> > I also looked at non-ARM platforms while preparing for my article. Some of
> > these look like they are no longer actively maintained or used, but I'm not
> > doing anything about those unless the maintainers would like me to:
> > 

> > * sparc/sun4m: A patch for removing 32-bit Sun sparc support (not LEON)
> >    is currently under review
> 
> I don't think this has reached any agreement yet. Multiple people want it to stay.

None of the people that replied have any real use of the sun4m port,
they only wanted it to stay because they had some machines or such.
In other words - people will be sad if we sunset sun4m, but it will not
hurt anyone as there are no users left.

I will include the above summary when I post v2 of the patch to sunset
sun4m and sun4d. Then we will see what we conclude in the end.

Right now in am in demolition mode as I have a new house that requires a
total refactoring. So linux stuff is lower on the priority list so v2
will wait until I have time to do any necessary follow-up.

	Sam
