Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6876CD37B0
	for <linux-sh@archiver.kernel.org>; Mon, 18 Sep 2023 07:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbjIRHnT (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Sep 2023 03:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbjIRHmu (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Sep 2023 03:42:50 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D01A5
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 00:40:35 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3473:9bed:ded:69a5])
        by laurent.telenet-ops.be with bizsmtp
        id nKgY2A00A0oXixJ01KgYnY; Mon, 18 Sep 2023 09:40:32 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qi8rw-003wK3-6Y;
        Mon, 18 Sep 2023 09:40:32 +0200
Date:   Mon, 18 Sep 2023 09:40:32 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.6-rc2
In-Reply-To: <20230918072701.233203-1-geert@linux-m68k.org>
Message-ID: <956a7d16-13a9-2c7-c541-fcfb5d6d1be3@linux-m68k.org>
References: <CAHk-=whW=fV2tnAreSbtPVpJxq++pyBZa3g+cxX8_V__WSZzCg@mail.gmail.com> <20230918072701.233203-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, 18 Sep 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.6-rc2[1] to v6.6-rc1[3], the summaries are:
>  - build errors: +1/-0
>  - build warnings: +1/-0

   + {standard input}: Error: expected symbol name:  => 1095
   + {standard input}: Warning: end of file not at end of a line; newline inserted:  => 1094

sh4-gcc13/sh-allmodconfig

ICE

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ce9ecca0238b140b88f43859b211c9fdfd8e5b70/ (all 237 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0bb80ecc33a8fb5a682236443c1e740d5c917d1d/ (all 237 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
