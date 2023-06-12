Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6C0C7EE23
	for <linux-sh@archiver.kernel.org>; Mon, 12 Jun 2023 11:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjFLLNR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 12 Jun 2023 07:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjFLLND (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 12 Jun 2023 07:13:03 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18687A93;
        Mon, 12 Jun 2023 04:01:59 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q8fIS-00164Q-JP; Mon, 12 Jun 2023 13:01:16 +0200
Received: from p57bd9486.dip0.t-ipconnect.de ([87.189.148.134] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q8fIS-00087K-EX; Mon, 12 Jun 2023 13:01:16 +0200
Message-ID: <cf997239b624431486ecba90a1f67d81d6c3fb13.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v6] sh: avoid using IRQ0 on SH3/4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Jun 2023 13:01:15 +0200
In-Reply-To: <f32a649e-3563-2485-234e-640f9dace105@omp.ru>
References: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
         <983d701befce7fc0010c53d09be84f5c330bdf45.camel@physik.fu-berlin.de>
         <837a586e-5e76-7a5b-a890-403ce26ea51b@gmail.com>
         <3fff103bcea3874cc7fd93c3a765ca642aa7f632.camel@physik.fu-berlin.de>
         <f32a649e-3563-2485-234e-640f9dace105@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.134
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sergey!

On Mon, 2023-06-12 at 13:56 +0300, Sergey Shtylyov wrote:
> > Applied to my for-next branch.
> 
>    Note that this was positioned as a fix.

Hmm, it will be at least backported to the stable trees.

>    Where is your tree, BTW? :-)

https://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
