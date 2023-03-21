Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E811C7618D
	for <linux-sh@archiver.kernel.org>; Tue, 21 Mar 2023 08:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCUIin (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 21 Mar 2023 04:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCUIil (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 21 Mar 2023 04:38:41 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9C59742
        for <linux-sh@vger.kernel.org>; Tue, 21 Mar 2023 01:38:18 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by albert.telenet-ops.be with bizsmtp
        id aweA2900R1C8whw06weA6A; Tue, 21 Mar 2023 09:38:17 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1peXVS-00E6Yd-Pu;
        Tue, 21 Mar 2023 09:38:10 +0100
Date:   Tue, 21 Mar 2023 09:38:10 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: renesas: r8a7779: Add bias pinconf support
In-Reply-To: <20230321083033.1830063-1-geert+renesas@glider.be>
Message-ID: <d6141970-297-717a-38a-7753698aa61@linux-m68k.org>
References: <20230321083033.1830063-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, 21 Mar 2023, Geert Uytterhoeven wrote:
> Implement support for pull-up handling for the R-Car H1 SoC, using the
> common R-Car bias handling.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

My apologies, this patch was meant for a different audience.
Please ignore.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
