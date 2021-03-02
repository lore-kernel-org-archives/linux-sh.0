Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29889C433E0
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D0264E1F
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhCCDRV (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:17:21 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:41381 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377990AbhCBIwi (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 03:52:38 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lH0kX-0017cq-1K; Tue, 02 Mar 2021 09:51:25 +0100
Received: from dynamic-089-012-163-039.89.12.pool.telefonica.de ([89.12.163.39] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lH0kW-003yN0-Qg; Tue, 02 Mar 2021 09:51:24 +0100
Subject: Re: SH patches for 5.12
To:     Rich Felker <dalias@libc.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
 <20210223005608.GB6965@brightrain.aerifal.cx>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
Date:   Tue, 2 Mar 2021 09:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223005608.GB6965@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.12.163.39
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi!

On 2/23/21 1:56 AM, Rich Felker wrote:
> Thanks! The last one seems to be upstream already and the rest LGTM.
> I've applied them and will do some smoke checks now and then prepare
> for -next.

Any timeline for when the PR is sent to Linus?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

