Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C55C00528
	for <linux-sh@archiver.kernel.org>; Mon, 24 Jul 2023 17:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjGXR3v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 24 Jul 2023 13:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGXR3u (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 24 Jul 2023 13:29:50 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4886598;
        Mon, 24 Jul 2023 10:29:49 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qNzNA-003ztw-8Q; Mon, 24 Jul 2023 19:29:28 +0200
Received: from p5b13a085.dip0.t-ipconnect.de ([91.19.160.133] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qNzNA-002BPR-0R; Mon, 24 Jul 2023 19:29:28 +0200
Message-ID: <31ad16fe8f1435805185ba8e889512ec181a867e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v1] sh: boards: fix CEU buffer size passed to
 dma_declare_coherent_memory()
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 19:29:27 +0200
In-Reply-To: <20230724171229.GC11977@pendragon.ideasonboard.com>
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
         <20230724171229.GC11977@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.133
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Laurent!

On Mon, 2023-07-24 at 20:12 +0300, Laurent Pinchart wrote:
> Thank you for the patch.
> 
> On Mon, Jul 24, 2023 at 02:07:42PM +0200, Petr Tesarik wrote:
> > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > 
> > In all these cases, the last argument to dma_declare_coherent_memory() is
> > the buffer end address, but the expected value should be the size of the
> > reserved region.
> > 
> > Fixes: 39fb993038e1 ("media: arch: sh: ap325rxa: Use new renesas-ceu camera driver")
> > Fixes: c2f9b05fd5c1 ("media: arch: sh: ecovec: Use new renesas-ceu camera driver")
> > Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")
> > Fixes: 186c446f4b84 ("media: arch: sh: migor: Use new renesas-ceu camera driver")
> > Fixes: 1a3c230b4151 ("media: arch: sh: ms7724se: Use new renesas-ceu camera driver")
> > Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> But given that nobody noticed for 5 years, maybe we should drop
> renesas-ceu support from those boards ? Or drop the boards completely ?

arch/sh is being maintained again, so it's save to keep these boards. At some point, we're
going to convert the architecture to using Device Trees which should reduce the maintenance
burden anyways.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
