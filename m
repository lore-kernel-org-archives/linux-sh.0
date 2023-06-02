Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5DDC77B7A
	for <linux-sh@archiver.kernel.org>; Fri,  2 Jun 2023 09:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjFBJBg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 2 Jun 2023 05:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjFBJBN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 2 Jun 2023 05:01:13 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054CE51;
        Fri,  2 Jun 2023 02:01:11 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q50eh-001crI-3l; Fri, 02 Jun 2023 11:01:07 +0200
Received: from ip5b40320d.dynamic.kabel-deutschland.de ([91.64.50.13] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q50eg-0036yt-To; Fri, 02 Jun 2023 11:01:07 +0200
Message-ID: <1df63fac0075558850331210c28cb8fa534dc116.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v6] sh: avoid using IRQ0 on SH3/4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Date:   Fri, 02 Jun 2023 11:01:06 +0200
In-Reply-To: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
References: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.64.50.13
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sergey!

On Thu, 2023-06-01 at 23:22 +0300, Sergey Shtylyov wrote:
> IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
> return -EINVAL instead.  However, the kernel code supporting SH3/4 based
> SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
> IRQ #s from 16 instead.
> 
> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> indeed are using IRQ0 for the SMSC911x compatible Ethernet chip...

I don't have time today, but I will look at all current SH patches over the
weekend. Thanks a lot for being so persistent.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
