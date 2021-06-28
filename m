Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35581C49361
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D03A61C69
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 13:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhF1Nl3 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 09:41:29 -0400
Received: from verein.lst.de ([213.95.11.211]:36508 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231955AbhF1Nl1 (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 28 Jun 2021 09:41:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 258586736F; Mon, 28 Jun 2021 15:38:59 +0200 (CEST)
Date:   Mon, 28 Jun 2021 15:38:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Landley <rob@landley.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: dma_declare_coherent_memory and SuperH
Message-ID: <20210628133858.GA21602@lst.de>
References: <20210623133205.GA28589@lst.de> <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sat, Jun 26, 2021 at 05:36:08PM -0500, Rob Landley wrote:
> On 6/23/21 8:32 AM, Christoph Hellwig wrote:
> > Hi SuperH maintainers,
> > 
> > I have a vague recollection that you were planning on dropping support
> > for non-devicetree platforms, is that still the case?
> 
> We'd like to convert them, but have to rustle up test hardware for what _is_
> still available. (There was some motion towards this a year or so back, but it
> petered out because pandemic and everyone got distracted halfway through.)
> 
> (We should definitely START by converting the r2d board qemu emulates. :)
> 
> > The reason I'm asking is because all but one users of
> > dma_declare_coherent_memory are in the sh platform setup code, and
> > I'd really like to move towards killing this function off.
> 
> Understood. Is there an easy "convert to this" I could do to those callers?

Well, the replacement is to declare the device memory carveouts in the
Device Tree.
