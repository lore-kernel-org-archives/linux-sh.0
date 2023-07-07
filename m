Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3008BEB64D9
	for <linux-sh@archiver.kernel.org>; Fri,  7 Jul 2023 09:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGGJaW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 7 Jul 2023 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGGJaV (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 7 Jul 2023 05:30:21 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFBA1BE8;
        Fri,  7 Jul 2023 02:30:20 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qHhmu-000Uby-0d; Fri, 07 Jul 2023 11:30:04 +0200
Received: from p5b13afb1.dip0.t-ipconnect.de ([91.19.175.177] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qHhmt-002u5A-OU; Fri, 07 Jul 2023 11:30:03 +0200
Message-ID: <a74a9c59173df4244b555d2f6691081303cb166e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Jul 2023 11:30:03 +0200
In-Reply-To: <CAMuHMdUzk8GuaqK6rBLaskVb=8Lsqe5hZ-=N=zqfWcxay-Euew@mail.gmail.com>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
         <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
         <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
         <CAMuHMdWLdJPC6oQ0P4_DVbPXrVjg=PMjTUdX4MD4+tmc3BW9sg@mail.gmail.com>
         <CAMuHMdUzk8GuaqK6rBLaskVb=8Lsqe5hZ-=N=zqfWcxay-Euew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.175.177
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Geert!

On Fri, 2023-07-07 at 10:48 +0200, Geert Uytterhoeven wrote:
> > I am not using rts7751r2dplus_defconfig, but my own[*] config,
> > which boots fine into initrd userspace.
> > 
> > I can reproduce the issue with rts7751r2dplus_defconfig, but I may
> > not be able to look into it today...
> 
> Disabling CONFIG_USB_OHCI_HCD fixes the hang.

Thanks, I was expecting a driver issue. I guess we need to look into the
OHCI driver or the SH-specific part and check whether the IRQ numbers need
to be adjusted there as well.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
