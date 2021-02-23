Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66CEC433E0
	for <linux-sh@archiver.kernel.org>; Tue, 23 Feb 2021 00:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74ED264E2E
	for <linux-sh@archiver.kernel.org>; Tue, 23 Feb 2021 00:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBWA46 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 22 Feb 2021 19:56:58 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:35734 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhBWA45 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 22 Feb 2021 19:56:57 -0500
Date:   Mon, 22 Feb 2021 19:56:08 -0500
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: SH patches for 5.12
Message-ID: <20210223005608.GB6965@brightrain.aerifal.cx>
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sun, Feb 21, 2021 at 10:42:52AM +0100, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> Could we get the following patches picked up for 5.12?
> 
> > - [PATCH] [sh] fix trivial misannotations
> > - https://marc.info/?l=linux-kernel&m=160945707001399&w=2
> >
> > - [PATCH] sh: check return code of request_irq
> > - https://marc.info/?l=linux-kernel&m=160867050030140&w=2
> >
> > - [PATCH] sh: boards: Fix the cacography in irq.c
> > - https://marc.info/?l=linux-sh&m=160578410511403&w=2
> >
> > - [PATCH 1/2] sh: boot: add intermediate vmlinux.bin* to targets instead of extra-y
> > - https://marc.info/?l=linux-kernel&m=161088234517301&w=2
> >
> > - [PATCH 2/2] sh: boot: avoid unneeded rebuilds under arch/sh/boot/compressed/
> > - https://marc.info/?l=linux-kernel&m=161088245817344&w=2
> >
> > - [PATCH] maple: fix wrong return value of maple_bus_init().
> > - https://marc.info/?l=linux-kernel&m=160635878212678&w=2
> >
> > - [PATCH] sh: kdump: add some attribute to function
> > - https://marc.info/?l=linux-kernel&m=160758311622653&w=2
> >
> > - [PATCH] sh: kernel: traps: remove unused variable
> > - https://marc.info/?l=linux-kernel&m=160760435528709&w=2
> >
> > - [PATCH] scripts/recordmcount.pl: support big endian for ARCH sh
> > - https://marc.info/?l=linux-sh&m=161296964604229&w=2

Thanks! The last one seems to be upstream already and the rest LGTM.
I've applied them and will do some smoke checks now and then prepare
for -next.

Rich
