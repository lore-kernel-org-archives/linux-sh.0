Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72639C4332E
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4E264E74
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhCCD0i (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:26:38 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:43129 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1573848AbhCBPNq (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 10:13:46 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lH64T-003pNJ-0f; Tue, 02 Mar 2021 15:32:21 +0100
Received: from dslb-092-078-035-231.092.078.pools.vodafone-ip.de ([92.78.35.231] helo=[192.168.178.45])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lH64S-000cCH-QJ; Tue, 02 Mar 2021 15:32:20 +0100
Subject: Re: SH patches for 5.12
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rich Felker <dalias@libc.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>, Arnd Bergmann <arnd@arndb.de>
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
 <20210223005608.GB6965@brightrain.aerifal.cx>
 <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
 <20210302140308.GJ32655@brightrain.aerifal.cx>
 <CAMuHMdXEbD13AG9m1PJVyVpg3=QUDMHG_LQuEyYc2bwrLHU-xQ@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <66978ea5-dce2-0501-677d-7d10d8674bf9@physik.fu-berlin.de>
Date:   Tue, 2 Mar 2021 15:32:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXEbD13AG9m1PJVyVpg3=QUDMHG_LQuEyYc2bwrLHU-xQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 92.78.35.231
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 3/2/21 3:17 PM, Geert Uytterhoeven wrote:
>> Maybe it's just a duplicate of a warning that was already there and
>> that should be dealt with too.
> 
> I think that can be ignored safely: similar functions like __ashrdi3()
> also lack forward declarations on SH.
> 
> Looks like only microblaze and powerpc do have forward declarations
> for the gcc helpers:
> arch/microblaze/lib/libgcc.h
> arch/powerpc/include/asm/asm-prototypes.h
> 
> One day we may move them to asm-generic, and start using them
> everywhere...

OK. Then let's send the PR for 5.12 and tackle this for 5.13?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

