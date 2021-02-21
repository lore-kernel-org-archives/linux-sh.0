Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CF1C433DB
	for <linux-sh@archiver.kernel.org>; Sun, 21 Feb 2021 09:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60A764EB2
	for <linux-sh@archiver.kernel.org>; Sun, 21 Feb 2021 09:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBUJnl (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 21 Feb 2021 04:43:41 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:50079 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229844AbhBUJnh (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 21 Feb 2021 04:43:37 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lDlGP-001eYC-QS; Sun, 21 Feb 2021 10:42:53 +0100
Received: from x4dbf9e82.dyn.telefonica.de ([77.191.158.130] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lDlGP-003mvi-HH; Sun, 21 Feb 2021 10:42:53 +0100
To:     Linux-sh list <linux-sh@vger.kernel.org>
Cc:     Rob Landley <rob@landley.net>, Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: SH patches for 5.12
Message-ID: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
Date:   Sun, 21 Feb 2021 10:42:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.191.158.130
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi!

Could we get the following patches picked up for 5.12?

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
>
> - [PATCH] scripts/recordmcount.pl: support big endian for ARCH sh
> - https://marc.info/?l=linux-sh&m=161296964604229&w=2

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
