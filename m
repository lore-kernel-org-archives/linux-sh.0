Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E7CC4338F
	for <linux-sh@archiver.kernel.org>; Mon, 16 Aug 2021 07:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA366139E
	for <linux-sh@archiver.kernel.org>; Mon, 16 Aug 2021 07:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhHPHFb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 16 Aug 2021 03:05:31 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:34877 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233349AbhHPHFb (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 16 Aug 2021 03:05:31 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1mFWg6-000Oy1-DC; Mon, 16 Aug 2021 09:04:58 +0200
Received: from p5b13a086.dip0.t-ipconnect.de ([91.19.160.134] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1mFWg6-001jRq-6V; Mon, 16 Aug 2021 09:04:58 +0200
Subject: Patch formatting - Re:
To:     zhao xc <xinchao.zhao.kernelz@gmail.com>,
        ysato@users.sourceforge.jp
Cc:     dalias@libc.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAP7CzPfRFSfUka1Wjo1+KNSdhYjR2n59g2yvEFGRyfYwNFNy1A@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <fbd17d71-91e8-fb0c-f621-ee41787e4bad@physik.fu-berlin.de>
Date:   Mon, 16 Aug 2021 09:04:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAP7CzPfRFSfUka1Wjo1+KNSdhYjR2n59g2yvEFGRyfYwNFNy1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.134
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Zhao!

Thanks for your patch!

However, the patch has not been properly formatted and needs to be resend.

Could you follow this guide [1] and send your patch again in the correct
format?

Thanks,
Adrian

> [1] http://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
