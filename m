Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC24C4332F
	for <linux-sh@archiver.kernel.org>; Thu,  9 Sep 2021 08:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A9F61139
	for <linux-sh@archiver.kernel.org>; Thu,  9 Sep 2021 08:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhIII0q (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 9 Sep 2021 04:26:46 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:33189 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230250AbhIII0p (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 9 Sep 2021 04:26:45 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1mOFNF-000FqC-RW; Thu, 09 Sep 2021 10:25:33 +0200
Received: from p57bd9adf.dip0.t-ipconnect.de ([87.189.154.223] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1mOFNF-001UAH-9r; Thu, 09 Sep 2021 10:25:33 +0200
Message-ID: <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
Date:   Thu, 9 Sep 2021 10:25:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.154.223
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Randy!

On 9/8/21 22:19, Randy Dunlap wrote:
> What is the status of arch/sh/ in general and
> of these patches in particular?

I've also been trying to reach out to Yoshinori and Rich. I know that Yoshinori is
currently busy with other work but he can be reached over Twitter [1]. I don't
know about Rich though.

There are quite a number of patches on the mailing list that need reviewing and
I fear if that doesn't happen in the foreseeable future, the SH port is being
kicked out which would be a pity given that we're still maintaining the port in
Debian and given that there is new hardware available with the J-Core board [2].

Adrian

> [1] https://twitter.com/ysat0/
> [2] https://www.cnx-software.com/2017/03/13/turtle-board-is-a-raspberry-pi-2-like-fpga-board-for-j-core-j2-open-source-superh-sh2-soc/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

