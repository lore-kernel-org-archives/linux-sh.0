Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE87C7EE22
	for <linux-sh@archiver.kernel.org>; Thu, 11 May 2023 20:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbjEKUNH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 11 May 2023 16:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKUNG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 11 May 2023 16:13:06 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FF11BD4;
        Thu, 11 May 2023 13:13:05 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pxCeq-001kUB-5l; Thu, 11 May 2023 22:13:00 +0200
Received: from p5b13addc.dip0.t-ipconnect.de ([91.19.173.220] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pxCep-0022vC-Uq; Thu, 11 May 2023 22:13:00 +0200
Message-ID: <c7be097d21933c19c7338391cd6675d6757ad33c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] SH7709 DMA fixes
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Rich Felker <dalias@libc.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 May 2023 22:12:59 +0200
In-Reply-To: <20230506165642.GO3298@brightrain.aerifal.cx>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
         <3e9c027dd90ca9d4a02ba06714960ddcdae5fd2c.camel@physik.fu-berlin.de>
         <20230506165642.GO3298@brightrain.aerifal.cx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.173.220
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rich!

On Sat, 2023-05-06 at 12:56 -0400, Rich Felker wrote:
> At one point I tried to rebase these to run on what was (at the time)
> current, and had partial success -- I got it to start booting with DT
> under qemu, but my work rebasing the PCI stuff had problems and IIRC
> prevented getting virtio working -- it was crashing at that stage. If
> there's interest I can see if I can dig up that rebased branch in case
> it would be useful to look at. It probably has mistakes but might be a
> start for looking at what changed out from under the patches that
> needs to change.

Yes, there is definitely interest. Apologies for the late reply, I wanted
to send an answer earlier but it unfortunately went off my radar.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
