Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BF6C38145
	for <linux-sh@archiver.kernel.org>; Thu,  8 Sep 2022 12:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiIHMRg (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 8 Sep 2022 08:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIHMRf (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 8 Sep 2022 08:17:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BF97F0AF;
        Thu,  8 Sep 2022 05:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F05DFB820D5;
        Thu,  8 Sep 2022 12:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A68C433C1;
        Thu,  8 Sep 2022 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662639451;
        bh=U+m20oGd1WXi1p3qjhr+V8CEhvl5olo9r3blmj6bFF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TuCSzOV4DfRNUAJ2PTEFp6RQaFJPFNZhK+8NWHk7+ErJZRBPoepW3nvJRD/MptPwP
         c881KcYLFjlaHtkbv4m6RsurKHamz7eaOJRgMcM8WwDCLq0wquvYlw+5Faj1VRHUY1
         r2GwtcKitojOIYKmg/MkRwMuRpmewC76MiEbSXnCM4Ls6tdn2AK9MLjPwbee9jSSsa
         e/0HEm7iE+n6ny04lBMTW3Uq0hdSRlRrxEr0cUOUDcA5iweIE7RM1wp1lnPq1FV5v7
         i5wrTQkwaPIacX6ZPasLmhsRqZLdRz0MO74z/2wJZpWD0Dx2Py38VBpTaEYdD7eND4
         hszoLVya7BiVQ==
Date:   Thu, 8 Sep 2022 13:17:25 +0100
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sh: machvec: Use char[] for section boundaries
Message-ID: <YxndVYLcqFPbIRZz@work>
References: <20220907234345.96798-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907234345.96798-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Sep 07, 2022 at 04:43:45PM -0700, Kees Cook wrote:
> As done for other sections, define the extern as a character array,
> which relaxes many of the compiler-time object size checks, which would
> otherwise assume it's a single long. Solves the following build error:
> 
> arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg/
> Fixes: 9655ad03af2d ("sh: Fixup machvec support.")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo
