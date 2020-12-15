Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B133C2BB48
	for <linux-sh@archiver.kernel.org>; Tue, 15 Dec 2020 21:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F75022A99
	for <linux-sh@archiver.kernel.org>; Tue, 15 Dec 2020 21:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgLOVwt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:52:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:40992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbgLOVwp (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Tue, 15 Dec 2020 16:52:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D4C3AD87;
        Tue, 15 Dec 2020 21:52:00 +0000 (UTC)
Date:   Tue, 15 Dec 2020 22:51:57 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH] treewide: remove bzip2 compression support
Message-ID: <20201215215157.GJ6564@kitsune.suse.cz>
References: <20201215190315.8681-1-alex_y_xu.ref@yahoo.ca>
 <20201215190315.8681-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215190315.8681-1-alex_y_xu@yahoo.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hello,

On Tue, Dec 15, 2020 at 02:03:15PM -0500, Alex Xu (Hello71) wrote:
> bzip2 is either slower or larger than every other supported algorithm,
> according to benchmarks at [0]. It is far slower to decompress than any
> other algorithm, and still larger than lzma, xz, and zstd.
> 
> [0] https://lore.kernel.org/lkml/1588791882.08g1378g67.none@localhost/

Sounds cool. I wonder how many people will complain that their
distribution migrated to bzip2 but got stuck there and now new kernels
won't work on there with some odd tool or another :p

> @@ -212,11 +209,6 @@ choice
>  	  Compression speed is only relevant when building a kernel.
>  	  Decompression speed is relevant at each boot.
>  
> -	  If you have any problems with bzip2 or lzma compressed
> -	  kernels, mail me (Alain Knaff) <alain@knaff.lu>. (An older
> -	  version of this functionality (bzip2 only), for 2.4, was
> -	  supplied by Christian Ludwig)
> -
Shouldn't the LZMA part be preserved here?

Thanks

Michal
