Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790D4C433E0
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 15:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35900221E9
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 15:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbhAAPar (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Jan 2021 10:30:47 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:60515 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727223AbhAAPar (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Jan 2021 10:30:47 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kvMNS-001yFj-33; Fri, 01 Jan 2021 16:30:05 +0100
Received: from p5b13a2ad.dip0.t-ipconnect.de ([91.19.162.173] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kvMNR-003MzI-BN; Fri, 01 Jan 2021 16:30:05 +0100
Subject: Re: [PATCH] sh: add support for TIF_NOTIFY_SIGNAL
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-sh@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
References: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
 <ae29ab73-ee7a-2bb7-3fd8-3037f40c1cbd@kernel.dk>
 <5611bde9-67e7-6ff6-defc-9b02ea830fac@physik.fu-berlin.de>
 <9ea14eb3-d698-5499-ba4c-c6a3c35cd8d4@kernel.dk>
 <47f79645-53b7-b11c-167a-f5721b53df02@physik.fu-berlin.de>
 <9d9acec6-1e8c-2d68-5dfa-d58c11cf5cc4@kernel.dk>
 <070780c4-445e-6373-c8f4-1c72d0f3b4e0@physik.fu-berlin.de>
 <1047f3e5-4599-c34f-3176-9f41d2e1246b@kernel.dk>
 <31b34cfc-8d6e-d3b4-e29f-1ec485f5b368@physik.fu-berlin.de>
 <23bf4423-0987-c445-d5cd-1922e1e40820@kernel.dk>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <f95539e9-506b-c4d9-2861-f288e2d021df@physik.fu-berlin.de>
Date:   Fri, 1 Jan 2021 16:30:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <23bf4423-0987-c445-d5cd-1922e1e40820@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.173
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Jens!

On 1/1/21 4:08 PM, Jens Axboe wrote:
> On 1/1/21 7:06 AM, John Paul Adrian Glaubitz wrote:
>> Is there away to test the change itself?
> 
> The only user of TWA_SIGNAL, which uses TIF_NOTIFY_SIGNAL, so far is io_uring.
> You need something that triggers deferred task_work processing, which is
> basically anything that ends up being poll driven for data/space readiness.
> Here's a small test app from the liburing test suite, that'll trigger it.
> 
> If you install liburing, compile with:
> 
> gcc -Wall -O2 -o socket-rw socket-rw.c -luring
> 
> and run it without any arguments.

How long is this test supposed to run? It's already been running for some minutes
on my 600 MHz machine.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

