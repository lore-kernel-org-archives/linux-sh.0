Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07671C83F2B
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 06:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjHaGtB (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjHaGtA (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 31 Aug 2023 02:49:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17290A8
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 23:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AD8EB82011
        for <linux-sh@vger.kernel.org>; Thu, 31 Aug 2023 06:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9583FC433C7;
        Thu, 31 Aug 2023 06:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693464535;
        bh=BjgLHZxKqWMujUCPzT64BzO6BzgUOHzppIInrssfZs4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FOr6ExSm9AS3qr+N5UIKmqLsWh5dxDuuRvcrh7Uz8o1rkwNjAXrup0/vod50MXiUI
         GdS6CNYq3XS/BZFg8y94f0X/QRI90+YqsXub6xQ4nBlDDieV6w+A/DY2B/mcfAVxbm
         UBB69wxxKX054yQ0YBEt30GhUwgfsCfaaXoXPhibNtmfF4Vud9WihljFy51PpQzR7D
         Z1c0iH/lH2nl3l0y+sE1uiVGKRvHxwxQDi08KQF4pWTjq5JpA5GxDRpsEpsLxVTIQ5
         Yi+ADJXTCRDOZVSXoSNiRQIXo915GCv6Te0zCAi0BpYnMrhep6QI18T2nhlhuNm12d
         U3Jix0j8BWzxg==
Message-ID: <cec95643-c4b9-d3aa-14ca-d6a9264c7e8f@kernel.org>
Date:   Thu, 31 Aug 2023 08:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RESEND RFC PATCH 09/12] of: FDT vaddr support for SH.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
 <fb76aed2eb920d4f6accb67774103eb478fe25fe.1693444193.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <fb76aed2eb920d4f6accb67774103eb478fe25fe.1693444193.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 31/08/2023 03:11, Yoshinori Sato wrote:
> sh using virt address in FDT.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Best regards,
Krzysztof

