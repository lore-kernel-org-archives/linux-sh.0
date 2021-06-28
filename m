Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1839FC2B9F4
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 16:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5996198D
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 16:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhF1QcF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 12:32:05 -0400
Received: from verein.lst.de ([213.95.11.211]:37954 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233115AbhF1QcC (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 28 Jun 2021 12:32:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 342566736F; Mon, 28 Jun 2021 18:29:34 +0200 (CEST)
Date:   Mon, 28 Jun 2021 18:29:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dma_declare_coherent_memory and SuperH
Message-ID: <20210628162934.GA29578@lst.de>
References: <20210623133205.GA28589@lst.de> <CAMuHMdUOaRiJcO1fq3u4tgeB0aUbfn_qn7DEZtW4BC+7ECcx4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUOaRiJcO1fq3u4tgeB0aUbfn_qn7DEZtW4BC+7ECcx4Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Jun 28, 2021 at 04:29:18PM +0200, Geert Uytterhoeven wrote:
> On Wed, Jun 23, 2021 at 3:33 PM Christoph Hellwig <hch@lst.de> wrote:
> > I have a vague recollection that you were planning on dropping support
> > for non-devicetree platforms, is that still the case?
> >
> > The reason I'm asking is because all but one users of
> > dma_declare_coherent_memory are in the sh platform setup code, and
> > I'd really like to move towards killing this function off.
> 
> I guess you mean drivers/remoteproc/remoteproc_virtio.c?
> 
> BeagleV Starlight Beta will be adding two more in
> drivers/nvdla/nvdla_gem.c.
> https://github.com/esmil/linux/commit/ce5cffcc8e618604a0d442758321fc5577751c9d

As clearly documented adding new callers is not acceptable.  But I
don't really care about of of tree code anyway.
