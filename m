Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB175C43334
	for <linux-sh@archiver.kernel.org>; Mon, 20 Jun 2022 07:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiFTHGN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 20 Jun 2022 03:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbiFTHGL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 20 Jun 2022 03:06:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FB89FF3;
        Mon, 20 Jun 2022 00:06:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1260868AA6; Mon, 20 Jun 2022 09:06:07 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:06:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] sh: Convert nommu io{re,un}map() to static inline
 functions
Message-ID: <20220620070606.GA11361@lst.de>
References: <8d1b1766260961799b04035e7bc39a7f59729f72.1655708312.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d1b1766260961799b04035e7bc39a7f59729f72.1655708312.git.geert+renesas@glider.be>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Jun 20, 2022 at 09:01:43AM +0200, Geert Uytterhoeven wrote:
> Recently, nommu iounmap() was converted from a static inline function to
> a macro again, basically reverting commit 4580ba4ad2e6b8dd ("sh: Convert
> iounmap() macros to inline functions").  With -Werror, this leads to
> build failures like:

Stupid question:  Is there any reason sh-nommu can't just use the
generic nommu ioremap from asm-generic/io.h?

Then again how long it takes to to fix any sh bugs I'm still wondering
if we shouldn't just drop sh entirely given how much of a drag it is
on everyone.
