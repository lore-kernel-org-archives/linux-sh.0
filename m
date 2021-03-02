Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595A3C4332B
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178C964E6B
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhCCD0X (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:26:23 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:41044 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448593AbhCBPGI (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 10:06:08 -0500
Date:   Tue, 2 Mar 2021 09:48:05 -0500
From:   Rich Felker <dalias@libc.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>
Subject: Re: SH patches for 5.12
Message-ID: <20210302144803.GK32655@brightrain.aerifal.cx>
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
 <20210223005608.GB6965@brightrain.aerifal.cx>
 <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
 <20210302140308.GJ32655@brightrain.aerifal.cx>
 <CAMuHMdXEbD13AG9m1PJVyVpg3=QUDMHG_LQuEyYc2bwrLHU-xQ@mail.gmail.com>
 <CAK8P3a1oCxj411vPQ9HiZpXBRQt3evP0o9RiFv6DPd9Ru2UHWQ@mail.gmail.com>
 <CAMuHMdU4t1Dek6me6crjFYqnNUUTwOwrXxwScPLc6mB35XxGbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU4t1Dek6me6crjFYqnNUUTwOwrXxwScPLc6mB35XxGbg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Mar 02, 2021 at 03:33:58PM +0100, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Tue, Mar 2, 2021 at 3:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Mar 2, 2021 at 3:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Mar 2, 2021 at 3:03 PM Rich Felker <dalias@libc.org> wrote:
> > > > On Tue, Mar 02, 2021 at 09:51:23AM +0100, John Paul Adrian Glaubitz wrote:
> > > > > On 2/23/21 1:56 AM, Rich Felker wrote:
> > > > > > Thanks! The last one seems to be upstream already and the rest LGTM.
> > > > > > I've applied them and will do some smoke checks now and then prepare
> > > > > > for -next.
> > > > >
> > > > > Any timeline for when the PR is sent to Linus?
> > > >
> > > > They're in next but I got a warning from the bot on one (7ec713058f21)
> > > > and haven't checked it in detail yet. In case you have a quick idea:
> > > >
> > > > [linux-next:master 11837/12788] arch/sh/boot/compressed/../../lib/ashldi3.c:6:11: warning: no previous prototype for '__ashldi3'
> > > >
> > > > Maybe it's just a duplicate of a warning that was already there and
> > > > that should be dealt with too.
> > >
> > > I think that can be ignored safely: similar functions like __ashrdi3()
> > > also lack forward declarations on SH.
> > >
> > > Looks like only microblaze and powerpc do have forward declarations
> > > for the gcc helpers:
> > > arch/microblaze/lib/libgcc.h
> > > arch/powerpc/include/asm/asm-prototypes.h
> > >
> > > One day we may move them to asm-generic, and start using them
> > > everywhere...
> >
> > I thought these were fundamentally architecture specific. Is it even
> > possible to declare them properly?
> 
> AFAIK their asm implementation, and if the compiler generates calls
> to them, is architecture-specific.  The C versions are identical.
> 
> In fact we do have shared C implementations in lib/.
> And at least __ashldi3() and __ashrdi3() are identical for SH and lib/,
> so the latter should be used.

I haven't looked at the code, but are you sure this is okay? C
implementations of variable bitshift seem subject to the compiler
auto-replacing them with <<n and >>n, which would then create a
recursive definition on archs (pre-sh3 only) that don't have a barrel
shift instruction and need the library calls.

Rich
