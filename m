Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD2AC433F5
	for <linux-sh@archiver.kernel.org>; Tue, 11 Jan 2022 11:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349497AbiAKLbx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:31:53 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:59855 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349484AbiAKLbx (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 Jan 2022 06:31:53 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1n7FNX-003WFv-U4; Tue, 11 Jan 2022 12:31:51 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1n7FNX-0011Io-Os; Tue, 11 Jan 2022 12:31:51 +0100
Message-ID: <c947a46b-7c5e-6ca3-fabe-ce648d9c182c@physik.fu-berlin.de>
Date:   Tue, 11 Jan 2022 12:31:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Fwd: Debian on Linux-SH4
Content-Language: en-US
To:     =?UTF-8?Q?Robert_=c5=9awi=c4=99cki?= <robert@swiecki.net>
References: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
 <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com>
Cc:     linux-sh@vger.kernel.org, debian-superh@lists.debian.org
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Robert!

On 1/11/22 12:23, Robert Święcki wrote:
> Recently I tried to create a working modern disk image for Linux-SH4.
> There were many problems, but I finally managed to pull it off.
> 
> If anyone needs a working Debian (unstable/experimental) + kernel
> 5.15.0 - here're the images/kernels/scripts

You could also create a Debian unstable environment for the sh4 architecture
using debootstrap:

suse-laptop:/tmp # debootstrap --no-check-gpg --arch=sh4 --foreign unstable debian-sh4-root http://ftp.ports.debian.org/debian-ports
I: Retrieving InRelease 
I: Retrieving Packages 
I: Validating Packages 
I: Resolving dependencies of required packages...
(...)
I: Extracting login...
I: Extracting logsave...
I: Extracting mawk...
I: Extracting mount...
I: Extracting ncurses-bin...
I: Extracting passwd...
I: Extracting perl-base...
I: Extracting sed...
I: Extracting sysvinit-utils...
I: Extracting tar...
I: Extracting util-linux...
I: Extracting zlib1g...
suse-laptop:/tmp #

Then run "./debootstrap/debootstrap --second-stage" on the target system.

If your qemu-user is properly set up to use binfmt (which is currently not the case on my
system), you can omit the "--foreign" option and get a ready-to-boot chroot for Debian sh4.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

