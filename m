Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89208EB64D9
	for <linux-sh@archiver.kernel.org>; Fri,  7 Jul 2023 09:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjGGJyP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 7 Jul 2023 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGGJyP (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 7 Jul 2023 05:54:15 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC44B90;
        Fri,  7 Jul 2023 02:54:13 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qHiA1-000b6e-Nz; Fri, 07 Jul 2023 11:53:57 +0200
Received: from p5b13afb1.dip0.t-ipconnect.de ([91.19.175.177] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qHiA1-002xAJ-Gf; Fri, 07 Jul 2023 11:53:57 +0200
Message-ID: <0a7c60cebf41e781f5c8f04d85dfba9e31e61e2b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Jul 2023 11:53:51 +0200
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
> > I can reproduce the issue with rts7751r2dplus_defconfig, but I may
> > not be able to look into it today...
> 
> Disabling CONFIG_USB_OHCI_HCD fixes the hang.

I picked rts7751r2dplus_defconfig, disabled CONFIG_USB_OHCI_HCD but it still
hangs for me. Are you sure it's CONFIG_USB_OHCI_HCD and not something else?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
