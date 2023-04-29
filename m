Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E66C77B60
	for <linux-sh@archiver.kernel.org>; Sat, 29 Apr 2023 20:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjD2UHQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 29 Apr 2023 16:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2UHP (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 29 Apr 2023 16:07:15 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D911B7
        for <linux-sh@vger.kernel.org>; Sat, 29 Apr 2023 13:07:13 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1psqqb-001Wid-0R; Sat, 29 Apr 2023 22:07:09 +0200
Received: from dynamic-077-013-005-103.77.13.pool.telefonica.de ([77.13.5.103] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1psqqa-000VYO-QG; Sat, 29 Apr 2023 22:07:08 +0200
Message-ID: <c72b94655a26cf69ad0ed4ec586cdb062c24ac93.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Fix J-core aic warning spam
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Date:   Sat, 29 Apr 2023 22:07:07 +0200
In-Reply-To: <b2415afc-5df9-cd95-9dd5-b31a3f9db6fc@landley.net>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
         <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
         <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
         <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net>
         <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
         <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net>
         <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
         <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net>
         <b6ba777419f0d94c5f39cfc4698e2dd4f7319e16.camel@physik.fu-berlin.de>
         <b42c6496ffb531459eb7995fd4b5e828f599b4fe.camel@physik.fu-berlin.de>
         <b2415afc-5df9-cd95-9dd5-b31a3f9db6fc@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.13.5.103
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rob!

On Wed, 2023-04-19 at 20:24 -0500, Rob Landley wrote:
> J-core binary toolchain tarball:
> 
> https://landley.net/toybox/downloads/binaries/toolchains/latest/sh2eb-linux-muslfdpic-cross.tar.xz

OK, I can actually build a J2 kernel with that. Are there instructions somewhere which explain
how to boot such a kernel on a Turtle board? Then I can give it a try on my personal one.

And do you have a root filesystem available for J2 that I can use?

> Feel free to peel out simpler compiler toolchain builds if you've got a
> preference? The interesting bits for your purposes are probably:
> 
> https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-9.4.0/0007-j2.diff
> 
> https://github.com/richfelker/musl-cross-make/blob/master/patches/binutils-2.33.1/0001-j2.diff

Do you know who authored these patches? We should get these merged upstream which should be
easier these days since the FSF has lowered the barriers regarding the copyright assignment.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
