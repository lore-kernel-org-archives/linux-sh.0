Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E347C433F5
	for <linux-sh@archiver.kernel.org>; Mon,  8 Nov 2021 13:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D6C6124D
	for <linux-sh@archiver.kernel.org>; Mon,  8 Nov 2021 13:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhKHNwZ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:52:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45032 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237802AbhKHNwY (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 8 Nov 2021 08:52:24 -0500
Received: from zn.tnic (p200300ec2f33110093973d8dfcf40fd9.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:9397:3d8d:fcf4:fd9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 467971EC0464;
        Mon,  8 Nov 2021 14:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636379379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rKv0RtlSLo3j/2hTxdXNr6Rql/ET5rRqLoq4AI6m/cg=;
        b=iYTDXbpYg9a2gtqmYlY4XP7MM39DNh4FCx9OFVWowie0Z5HxAnSB/na2Gj3dQrxt0efOZr
        KBnyTmpi7qVEquTydmA9RQJX9cp3wt2QPeJvnC8UueJ0cyUP5W3iGMt1qITSW0ZkJvDggY
        rteuXDaJZhJ6Xbm8KjNI1Lft43gSrsc=
Date:   Mon, 8 Nov 2021 14:49:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v0 35/42] sh: Check notifier registration return value
Message-ID: <YYkq7WbmNXNgiqv9@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-36-bp@alien8.de>
 <CAMuHMdW4fv4LN6oDS6qgYodf74_NvbzMxQfRbtnS-mn_D+u7Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdW4fv4LN6oDS6qgYodf74_NvbzMxQfRbtnS-mn_D+u7Kg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Nov 08, 2021 at 02:31:41PM +0100, Geert Uytterhoeven wrote:
> Do you think these can actually fail?

Hmm, maybe you missed the 0th message. Does this explain it:

https://lore.kernel.org/r/20211108101924.15759-1-bp@alien8.de

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
