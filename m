Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28174C2BBD4
	for <linux-sh@archiver.kernel.org>; Tue,  8 Dec 2020 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CC023A7B
	for <linux-sh@archiver.kernel.org>; Tue,  8 Dec 2020 20:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgLHUUG (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:20:06 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:60734 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgLHUTW (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 8 Dec 2020 15:19:22 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 0937180622;
        Tue,  8 Dec 2020 20:00:42 +0100 (CET)
Date:   Tue, 8 Dec 2020 20:00:41 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sh: Fix set but not used warnings with !CONFIG_MMU
Message-ID: <20201208190041.GA167310@ravnborg.org>
References: <20201208182117.163642-1-sam@ravnborg.org>
 <20201208182117.163642-2-sam@ravnborg.org>
 <07774d98-ada5-ecc6-229b-d5a2a60f86ee@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07774d98-ada5-ecc6-229b-d5a2a60f86ee@suse.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=7gkXJVJtAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
        a=hAG5_4vcAAAA:8 a=VwQbUJbxAAAA:8 a=yC-0_ovQAAAA:8 a=JfrnYn6hAAAA:8
        a=Z4Rwk6OoAAAA:8 a=7eLJprumqljJaB3VfTUA:9 a=QEXdDO2ut3YA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=cvBusfyB2V15izCimMoJ:22
        a=8Bh8Pg2EFav9IBZ9i9Tn:22 a=AjGcO6oz07-iQ99wixmX:22
        a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Thomas.

On Tue, Dec 08, 2020 at 07:52:49PM +0100, Thomas Zimmermann wrote:
> 
> 
> Am 08.12.20 um 19:21 schrieb Sam Ravnborg:
> > Building fbdev drivers for sh with W=1 produces the following warning:
> > 
> >      tmiofb.c: In function ‘tmiofb_remove’:
> >      tmiofb.c:805:21: warning: variable ‘par’ set but not used
> > 
> > This is with allmodconfig and ARCH=sh
> > 
> > This boiled down to iounmap() defined as empty for !CONFIG_MMU.
> > Fix this by by adding "(void)addr;" to tell the compiler the
> > argument to iounmap() should be considered used.
> > 
> > v4:
> >    - Fix build error of ethernet driver (kernel test robot)
> >      Added missing () around macro parameter
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: kernel test robot <lkp@intel.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

The ack is added in my commit, but I forgot to refresh the patch :-(
Thanks for noticing.

	Sam

