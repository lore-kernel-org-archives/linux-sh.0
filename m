Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95666C433DB
	for <linux-sh@archiver.kernel.org>; Thu, 21 Jan 2021 03:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7C82071C
	for <linux-sh@archiver.kernel.org>; Thu, 21 Jan 2021 03:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbhAUDvt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:51:49 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:49868 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392380AbhAUBnT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 20 Jan 2021 20:43:19 -0500
Date:   Wed, 20 Jan 2021 20:42:23 -0500
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rob Landley <rob@landley.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Pending patches for linux-sh
Message-ID: <20210121014222.GM23432@brightrain.aerifal.cx>
References: <133f8171-09ec-39b3-0660-de780cd879d6@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133f8171-09ec-39b3-0660-de780cd879d6@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Jan 20, 2021 at 12:32:16PM +0100, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> I have tested or acked the following patches which are fine from my point of view.
> 
> "Tested" means I have built and booted a current kernel with the patch in question,
> "acked" means, I have looked over the patch and consider the changes to be correct
> in the case where testing was not possible since the changes affect other SH hardware
> I cannot test at the moment.
> 
> Here the list:
> 
> - [PATCH] [sh] fix trivial misannotations
> - https://marc.info/?l=linux-kernel&m=160945707001399&w=2
> 
> - [PATCH] sh: check return code of request_irq
> - https://marc.info/?l=linux-kernel&m=160867050030140&w=2
> 
> - [PATCH] sh: boards: Fix the cacography in irq.c
> - https://marc.info/?l=linux-sh&m=160578410511403&w=2
> 
> - [PATCH v1] sh: Drop ARCH_NR_GPIOS definition
> - https://marc.info/?l=linux-sh&m=160578410511403&w=2
> 
> - [PATCH 1/2] sh: boot: add intermediate vmlinux.bin* to targets instead of extra-y
> - https://marc.info/?l=linux-kernel&m=161088234517301&w=2
> 
> - [PATCH 2/2] sh: boot: avoid unneeded rebuilds under arch/sh/boot/compressed/
> - https://marc.info/?l=linux-kernel&m=161088245817344&w=2
> 
> - [PATCH] arch: sh: remove duplicate include
> - https://marc.info/?l=linux-kernel&m=160488997017438&w=2
> 
> - [PATCH] maple: fix wrong return value of maple_bus_init().
> - https://marc.info/?l=linux-kernel&m=160635878212678&w=2
> 
> - [PATCH] sh: kdump: add some attribute to function
> - https://marc.info/?l=linux-kernel&m=160758311622653&w=2
> 
> - [PATCH] sh: kernel: traps: remove unused variable
> - https://marc.info/?l=linux-kernel&m=160760435528709&w=2
> 
> - [PATCH] sh: Remove unused HAVE_COPY_THREAD_TLS macro
> - https://marc.info/?l=linux-kernel&m=160247465514800&w=2
> 
> I will check later whether there are more patches we might have forgotten.

Hi! Thanks for the list. From the names, I think some overlap with the
pending set in linux-next (ending at a118584e7e60) that I'm about to
send as a PR.

Rich
