Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD583C77B71
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 09:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjDRJm4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 18 Apr 2023 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjDRJmS (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 18 Apr 2023 05:42:18 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AA62107;
        Tue, 18 Apr 2023 02:42:10 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pohqe-003U8u-HX; Tue, 18 Apr 2023 11:42:04 +0200
Received: from p5b13a017.dip0.t-ipconnect.de ([91.19.160.23] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pohqe-0022J9-9Z; Tue, 18 Apr 2023 11:42:04 +0200
Message-ID: <d341bd38a304b4ca9b703073a658f312b1fa6657.camel@physik.fu-berlin.de>
Subject: Re: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Apr 2023 11:42:03 +0200
In-Reply-To: <837e9f5e-ca8d-4c93-9a89-d7bdb9bb0240@kili.mountain>
References: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
         <b5fea49d68e1e2a702b0050f73582526e205cfa2.camel@physik.fu-berlin.de>
         <14788dbc-c2a6-4d1d-8ae3-1be53b0daf17@kili.mountain>
         <837e9f5e-ca8d-4c93-9a89-d7bdb9bb0240@kili.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.23
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Dan!

On Tue, 2023-04-18 at 12:39 +0300, Dan Carpenter wrote:
> On Tue, Apr 18, 2023 at 10:30:01AM +0300, Dan Carpenter wrote:
> > I have some unpublished Smatch stuff which tries to track "variable x
> > is in terms of bit units or byte units etc."  I will try to make a
> > static checker rule for this.
> 
> Attached.  It prints a warning like this:
> 
> drivers/net/ethernet/broadcom/cnic.c:667 cnic_init_id_tbl() warn: allocating units of longs instead of bytes 'test_var'
> 
> I'll test it out tonight.

Nice job, thanks for creating this very handy script!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
