Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A73C77B7C
	for <linux-sh@archiver.kernel.org>; Thu, 11 May 2023 20:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbjEKUMF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 11 May 2023 16:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKUME (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 11 May 2023 16:12:04 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A462D6A;
        Thu, 11 May 2023 13:12:00 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pxCdk-001kHF-Gk; Thu, 11 May 2023 22:11:52 +0200
Received: from p5b13addc.dip0.t-ipconnect.de ([91.19.173.220] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pxCdk-0022mr-8U; Thu, 11 May 2023 22:11:52 +0200
Message-ID: <4358d6ccca2d4e915e07a6e89d2d281e1299fbe5.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg`
 macros
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 May 2023 22:11:51 +0200
In-Reply-To: <ef8a4c361255303359b003185e50f47cf3b422f0.camel@physik.fu-berlin.de>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
         <20230506141703.65605-2-contact@artur-rojek.eu>
         <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
         <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
         <ef8a4c361255303359b003185e50f47cf3b422f0.camel@physik.fu-berlin.de>
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

On Sun, 2023-05-07 at 12:32 +0200, John Paul Adrian Glaubitz wrote:
> > I also wondered that. On SH7709 it's a hard panic, it should be the same
> > elsewhere.
> 
> I will give the patch a spin on my SH-7785LCR and see if it breaks anything.

I have successfully booted a current kernel with both patches applied on my
SH7785LCR board and will let it run for a few days to make sure it runs stable
and then apply the two patches to my sh-linux tree.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
