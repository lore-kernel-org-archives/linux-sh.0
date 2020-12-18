Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9656C4361B
	for <linux-sh@archiver.kernel.org>; Fri, 18 Dec 2020 22:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8479B23406
	for <linux-sh@archiver.kernel.org>; Fri, 18 Dec 2020 22:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgLRWHL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 18 Dec 2020 17:07:11 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:43733 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgLRWHL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 18 Dec 2020 17:07:11 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kqNtN-000lvr-5o; Fri, 18 Dec 2020 23:06:29 +0100
Received: from p5b13a238.dip0.t-ipconnect.de ([91.19.162.56] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kqNtM-003y4R-VQ; Fri, 18 Dec 2020 23:06:29 +0100
Subject: Re: Kernel crash when syncing to usb-storage
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Linux-sh list <linux-sh@vger.kernel.org>
References: <d89a074e-c0ed-5d8b-a58e-ce3d420f579e@physik.fu-berlin.de>
Cc:     Rob Landley <rob@landley.net>
Message-ID: <c0e24242-ecd3-b73e-03e1-1b5e59ee19b0@physik.fu-berlin.de>
Date:   Fri, 18 Dec 2020 23:06:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <d89a074e-c0ed-5d8b-a58e-ce3d420f579e@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.56
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi!

On 11/17/20 10:39 PM, John Paul Adrian Glaubitz wrote:
> Recently, I have started to see crashes when I try to sync a FAT filesystem
> on a USB pen drive. The crash is reproducible and seems to have been introduced
> in the 5.10 development cycle. I have not bisected the issue yet.

I can no longer produce this on Linus' latest tree (v5.10-11864-ga087241716a6),
so it looks like the bug got fixed in the meantime.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

