Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D7CC433DB
	for <linux-sh@archiver.kernel.org>; Sun, 24 Jan 2021 22:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB63E22BF3
	for <linux-sh@archiver.kernel.org>; Sun, 24 Jan 2021 22:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhAXWID (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 24 Jan 2021 17:08:03 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:40123 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbhAXWIC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 24 Jan 2021 17:08:02 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l3nXS-000sYY-Lu; Sun, 24 Jan 2021 23:07:18 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l3nXS-001YZX-2I; Sun, 24 Jan 2021 23:07:18 +0100
Subject: Re: Pending patches for linux-sh
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Rich Felker <dalias@libc.org>
Cc:     Rob Landley <rob@landley.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <133f8171-09ec-39b3-0660-de780cd879d6@physik.fu-berlin.de>
Message-ID: <f14d4205-2031-7727-e013-7f75d17d4656@physik.fu-berlin.de>
Date:   Sun, 24 Jan 2021 23:07:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <133f8171-09ec-39b3-0660-de780cd879d6@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rich!

The following patches are still missing after the 5.11 SH pull:

> - [PATCH] [sh] fix trivial misannotations
> - https://marc.info/?l=linux-kernel&m=160945707001399&w=2
> 
> - [PATCH] sh: check return code of request_irq
> - https://marc.info/?l=linux-kernel&m=160867050030140&w=2
> 
> - [PATCH] sh: boards: Fix the cacography in irq.c
> - https://marc.info/?l=linux-sh&m=160578410511403&w=2
> 
> - [PATCH 1/2] sh: boot: add intermediate vmlinux.bin* to targets instead of extra-y
> - https://marc.info/?l=linux-kernel&m=161088234517301&w=2
> 
> - [PATCH 2/2] sh: boot: avoid unneeded rebuilds under arch/sh/boot/compressed/
> - https://marc.info/?l=linux-kernel&m=161088245817344&w=2
>
> - [PATCH] maple: fix wrong return value of maple_bus_init().
> - https://marc.info/?l=linux-kernel&m=160635878212678&w=2
> 
> - [PATCH] sh: kdump: add some attribute to function
> - https://marc.info/?l=linux-kernel&m=160758311622653&w=2
> 
> - [PATCH] sh: kernel: traps: remove unused variable
> - https://marc.info/?l=linux-kernel&m=160760435528709&w=2

Shall they go in for 5.12?

They all look fine to me as they're either trivial fixes or I verified that they
don't cause any regression on my SH-7785LCR system.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

