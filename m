Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F92BC433F5
	for <linux-sh@archiver.kernel.org>; Tue, 15 Feb 2022 19:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiBOTQX (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 15 Feb 2022 14:16:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiBOTQW (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 15 Feb 2022 14:16:22 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C19F108BD4;
        Tue, 15 Feb 2022 11:16:12 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A03A268AA6; Tue, 15 Feb 2022 20:16:08 +0100 (CET)
Date:   Tue, 15 Feb 2022 20:16:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: Convert nommu io{re,un}map() to static inline
 functions
Message-ID: <20220215191608.GA25076@lst.de>
References: <4ed0a7a0d3fa912a5b44c451884818f2c138ef42.1644914600.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed0a7a0d3fa912a5b44c451884818f2c138ef42.1644914600.git.geert+renesas@glider.be>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Feb 15, 2022 at 09:51:05AM +0100, Geert Uytterhoeven wrote:
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: 13f1fc870dd74713 ("sh: move the ioremap implementation out of line")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> ---
> This is actually the third time this change was made, as Christoph
> converted iounmap() to a macro before in commit 98c90e5ea34e98bd ("sh:
> remove __iounmap"), reverting commit 733f0025f0fb43e3 ("sh: prevent
> warnings when using iounmap").
> 
> Probably sh-nommu should include <asm-generic/io.h>, but that would
> require a lot more changes.

I don't think it would be all that bad.  But between the breakage and
the fact that sh is almost unmaintained let's get the quick fix in if
we can..
