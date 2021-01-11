Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E0BC433E9
	for <linux-sh@archiver.kernel.org>; Mon, 11 Jan 2021 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A026722AAA
	for <linux-sh@archiver.kernel.org>; Mon, 11 Jan 2021 08:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbhAKIGC (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:06:02 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37163 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbhAKIGB (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 11 Jan 2021 03:06:01 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kysCV-003d9p-H0; Mon, 11 Jan 2021 09:05:19 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kysCU-001gTx-M3; Mon, 11 Jan 2021 09:05:19 +0100
Subject: Re: Old platforms: bring out your dead
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <20210110214653.GA1693373@ravnborg.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
Date:   Mon, 11 Jan 2021 09:05:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210110214653.GA1693373@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hello!

On 1/10/21 10:46 PM, Sam Ravnborg wrote:
>> I don't think this has reached any agreement yet. Multiple people want it to stay.
> 
> None of the people that replied have any real use of the sun4m port,
> they only wanted it to stay because they had some machines or such.
> In other words - people will be sad if we sunset sun4m, but it will not
> hurt anyone as there are no users left.
> 
> I will include the above summary when I post v2 of the patch to sunset
> sun4m and sun4d. Then we will see what we conclude in the end.

I'm not sure I understand the reasoning for doing this. The SPARC architecture
isn't going to see any new hardware developments in the future after Oracle
let go of most of the SPARC developers. So it's not that we need to make room
for new hardware.

And I also disagree with Arnd's stance that a port seems broken because it
doesn't see frequent or recent changes. As pointed out by Thomas Bogendoerfer
in this thread [1], missing updates don't necessarily mean that something
is broken but it can also just mean the hardware is fully supported and
working, so why fix something that isn't broken?

On the other hand, there are really serious bugs in the kernel that easily
allow crashing the whole machine (here on POWER [2] or here on SPARC [3])
that never get addressed.

We have a $10k IBM POWER server in Debian Ports which hosts a big-endian
PowerKVM build server instance and regularly hard-crashes because of the
bug in [2]. This bug has remained unfixed for almost a year now.

On top of that, some of the tree-wide conversions like [4] have completely
broken the Linux kernel on certain machines so that any larger ia64 servers
are stuck on the 4.14 kernel with no fix in sight. Before that, the kernel
worked perfectly fine on these machines.

I understand that cleaning up code and modernizing things is important, but
I think that the top priority should be to deliver something that is stable
and usable by the enduser.

But kernel development shouldn't be about scratching an itch which I sometimes
have the impression is the main driver behind some changes in the kernel.

I have personally invested a lot of time and effort in the past years to get
Debian into shape on exotic and older architectures and I feel all this effort
goes to waste when upstream projects just decide to kill of a certain platform
in the kernel or toolchain like it already happened with PowerPCSPE in GCC.

Adrian

> [1] https://lore.kernel.org/lkml/20210108234430.GA17487@alpha.franken.de/
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=206669
> [3] https://marc.info/?l=linux-sparc&m=160967865029609&w=2
> [4] https://marc.info/?l=linux-ia64&m=156144480821712&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

