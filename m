Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C15C433DB
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2B264EA4
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhCCDZi (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:25:38 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:40998 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448449AbhCBOUe (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 09:20:34 -0500
Date:   Tue, 2 Mar 2021 09:03:09 -0500
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: SH patches for 5.12
Message-ID: <20210302140308.GJ32655@brightrain.aerifal.cx>
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
 <20210223005608.GB6965@brightrain.aerifal.cx>
 <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Mar 02, 2021 at 09:51:23AM +0100, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 2/23/21 1:56 AM, Rich Felker wrote:
> > Thanks! The last one seems to be upstream already and the rest LGTM.
> > I've applied them and will do some smoke checks now and then prepare
> > for -next.
> 
> Any timeline for when the PR is sent to Linus?

They're in next but I got a warning from the bot on one (7ec713058f21)
and haven't checked it in detail yet. In case you have a quick idea:

[linux-next:master 11837/12788] arch/sh/boot/compressed/../../lib/ashldi3.c:6:11: warning: no previous prototype for '__ashldi3'

Maybe it's just a duplicate of a warning that was already there and
that should be dealt with too.

Rich
