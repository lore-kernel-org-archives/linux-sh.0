Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2229AEB64D9
	for <linux-sh@archiver.kernel.org>; Tue,  4 Jul 2023 05:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGDFpi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 4 Jul 2023 01:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGDFph (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 4 Jul 2023 01:45:37 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D971BAB;
        Mon,  3 Jul 2023 22:45:36 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qGYqx-000NmI-2S; Tue, 04 Jul 2023 07:45:31 +0200
Received: from p57bd997f.dip0.t-ipconnect.de ([87.189.153.127] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qGYqw-000fD4-RD; Tue, 04 Jul 2023 07:45:31 +0200
Message-ID: <485e9274ebf29da4075b40c2888f95a6cdc6d4ed.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 3/3] sh: dma: Correct the number of DMA channels in
 SH7709
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Jul 2023 07:45:30 +0200
In-Reply-To: <CAMuHMdV=kc1sZfsBad99ofbUBUyuZ_fAekdkFJYp9Rhskf9xWg@mail.gmail.com>
References: <20230527164452.64797-1-contact@artur-rojek.eu>
         <20230527164452.64797-4-contact@artur-rojek.eu>
         <CAMuHMdV3gn8g-gKam71K=WfT3CVNwvz5eKPSh2Fqi3wVg7ZwNw@mail.gmail.com>
         <f7b9ceb9739f8ae5cbee4f6073ce3af3921a2540.camel@physik.fu-berlin.de>
         <CAMuHMdVFBo+KMNQ6gzh3rZrZ+_Wfg=UJ4XOW4Uqibnjm6T7CdA@mail.gmail.com>
         <8205bc2cb9f983914ff6920deed3f54893713ba0.camel@physik.fu-berlin.de>
         <d5667e9675bf8be35b1a5414d443b8f371b1bd9e.camel@physik.fu-berlin.de>
         <CAMuHMdV=kc1sZfsBad99ofbUBUyuZ_fAekdkFJYp9Rhskf9xWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.153.127
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Geert!

On Sat, 2023-06-17 at 13:09 +0200, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> On Sat, Jun 17, 2023 at 9:32 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Thu, 2023-06-08 at 12:03 +0200, John Paul Adrian Glaubitz wrote:
> > > > > > That is actually safer, as the user can override NR_ONCHIP_DMA_CHANNELS
> > > > > > when configuring his kernel, thus breaking DMA  due to an incorrect
> > > > > > value of SH_DMAC_NR_MD_CH.
> > > > > > 
> > > > > > Unfortunately we cannot protect against that when using a single DMAC,
> > > > > > as SH_DMAC_NR_MD_CH can be either 4, 6, or 8.
> > > > > > 
> > > > > > Perhaps this configuration should be moved from Kconfig to <cpu/dma.h>,
> > > > > > to protect against a user overriding this value?
> > > > > 
> > > > > Isn't SH_DMAC_NR_MD_CH already hardwired to the SoC being used?
> > > > 
> > > > It depends on CONFIG_NR_ONCHIP_DMA_CHANNELS, while it
> > > > should be fixed based on the SoC.
> > > 
> > > I agree. However, I would be fine with merging this patch set first and fixing
> > > this particular issue in a follow-up series.
> > 
> > So, my suggestion is to take this series as-is for 6.5, then get the other issues
> > you mentioned fixed for 6.6. I think it's already a gain when these issues are
> > fixed and the kernel boots on the HP Journada 680 again.
> 
> Sure, I don't want to block the acceptance of this series at all.
> Thanks!

Apologies for the late reply. Would you mind adding your Reviewed-by to this patch
before I review and apply the series?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
