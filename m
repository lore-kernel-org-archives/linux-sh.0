Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84895C433F5
	for <linux-sh@archiver.kernel.org>; Tue, 11 Jan 2022 19:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbiAKTJ4 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:09:56 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:58829 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243166AbiAKTJ4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 Jan 2022 14:09:56 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1n7MWo-002RS1-Qq; Tue, 11 Jan 2022 20:09:54 +0100
Received: from p57bd9010.dip0.t-ipconnect.de ([87.189.144.16] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1n7MWo-002AmC-79; Tue, 11 Jan 2022 20:09:54 +0100
Message-ID: <cd2f52e3-6db4-9034-a671-3111596a32d4@physik.fu-berlin.de>
Date:   Tue, 11 Jan 2022 20:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Fwd: Debian on Linux-SH4
Content-Language: en-US
To:     =?UTF-8?Q?Robert_=c5=9awi=c4=99cki?= <robert@swiecki.net>
Cc:     linux-sh@vger.kernel.org, debian-superh@lists.debian.org
References: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
 <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com>
 <c947a46b-7c5e-6ca3-fabe-ce648d9c182c@physik.fu-berlin.de>
 <CAP145pjQJkgHx0AhGvDp9Rg0x0KfN1utxMaehrqp8sWNSR4x0g@mail.gmail.com>
 <985011f6-c0b8-947f-7ebf-6d27c59ba219@physik.fu-berlin.de>
 <CAP145piu0gURojU7TvU7XeDybVczQZDVYqT8th_1f4EcknDF1Q@mail.gmail.com>
 <fa9bdc51-42ee-5eb9-75a3-f46706bcf1a9@physik.fu-berlin.de>
 <CAP145piHFa=MLfXACWZcU3-1BP3o+Wf_AwawDV55kbFGxQm3Xg@mail.gmail.com>
 <8a33f049-90b2-3bc2-4594-229a1a9d9dff@physik.fu-berlin.de>
 <dfcad748-fe68-c4a4-d5ec-a04f17923c21@physik.fu-berlin.de>
 <CAP145pjWrPSqX0g9oJoqU57+S4OziHQt8=ZDrQVq8pD5CzAyiw@mail.gmail.com>
 <24eae22e-2b28-c1e4-468a-f7d0ada564a8@physik.fu-berlin.de>
 <CAP145pjFkwvMfwhrTRJpBL=uJLGHcZTegrb4rRwGtrR2Q=AK-Q@mail.gmail.com>
 <CAP145phP-Rmqo3cthcXsYB7O2gC8EfpXMneH+wjv7P4qVtOqNQ@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <CAP145phP-Rmqo3cthcXsYB7O2gC8EfpXMneH+wjv7P4qVtOqNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.144.16
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Robert!

On 1/11/22 20:05, Robert Święcki wrote:
>> makes it boot. I'll check which option is responsible exactly.
> 
> It seems that pretty much everything must be disabled in this menu - except
> 
> "Create a snapshot trace buffer"
> 
> in comparison to the default Debian config. All other options (enabled
> by default under Debian) seem to enable "yet another options", but my
> Kconfig foo is too weak to understand what's going on there.

Thanks! You already pointed me into the right direction. I will keep digging
to figure out what broke the tracing.

I'm not sure why I didn't find the issue with the tracing options although I
was comparing configuration files as I also had another kernel configuration
that one of the QEMU developers gave me that actually worked.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

