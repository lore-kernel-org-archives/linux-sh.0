Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C710C4743C
	for <linux-sh@archiver.kernel.org>; Wed, 23 Jun 2021 13:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F3B6100A
	for <linux-sh@archiver.kernel.org>; Wed, 23 Jun 2021 13:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFWNe2 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 23 Jun 2021 09:34:28 -0400
Received: from verein.lst.de ([213.95.11.211]:50914 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhFWNe1 (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Wed, 23 Jun 2021 09:34:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95D9567373; Wed, 23 Jun 2021 15:32:06 +0200 (CEST)
Date:   Wed, 23 Jun 2021 15:32:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: dma_declare_coherent_memory and SuperH
Message-ID: <20210623133205.GA28589@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi SuperH maintainers,

I have a vague recollection that you were planning on dropping support
for non-devicetree platforms, is that still the case?

The reason I'm asking is because all but one users of
dma_declare_coherent_memory are in the sh platform setup code, and
I'd really like to move towards killing this function off.
