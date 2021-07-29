Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707EBC4338F
	for <linux-sh@archiver.kernel.org>; Thu, 29 Jul 2021 08:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570D560F23
	for <linux-sh@archiver.kernel.org>; Thu, 29 Jul 2021 08:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhG2I6c (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:58:32 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:60075 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235188AbhG2I6c (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 29 Jul 2021 04:58:32 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1m91s4-000LPQ-4P; Thu, 29 Jul 2021 10:58:28 +0200
Received: from p5b13a050.dip0.t-ipconnect.de ([91.19.160.80] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1m91s3-002WUb-UN; Thu, 29 Jul 2021 10:58:28 +0200
To:     Rich Felker <dalias@libc.org>
Cc:     Rob Landley <rob@coresemi.io>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Stalled patches for the SH tree
Message-ID: <3a14d8c5-45e4-84dc-32b9-0bb573ebc77a@physik.fu-berlin.de>
Date:   Thu, 29 Jul 2021 10:58:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.80
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi!

I was wondering whether there is anything I can do to help with the stalled
patches for SH? There have been a number of patches with improvements that
were sent to the list and I think we should pick these up, also not to discourage
external contributors in helping us maintain the SuperH port.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
