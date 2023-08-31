Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B5C83F10
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 06:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjHaGsN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjHaGsM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 31 Aug 2023 02:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A03A8
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 23:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65D91628A9
        for <linux-sh@vger.kernel.org>; Thu, 31 Aug 2023 06:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9327C433C8;
        Thu, 31 Aug 2023 06:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693464488;
        bh=9v/02uLpeAhfiScVG5StYmIYxNvqDqqaXvSoKfBVTsM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P+WB4Fd/Uza8UiW9dq2XjYb/Etwc5Z9xDWACyppgzkim3Beoo7KWtH0sw5SIwFC0l
         gzdEXp1RcNR8p8TkbTEjhRHqbe94RgLkVao9m2a1f5dLyh4aPkWJhaOgN1WOGnrtts
         winamUMhk3aKbOXUuIeOlHUNeb72BSwmu56NObjgtZCnri2VNiBIurnFK98rmGddlF
         z8mmEfB2w4MyIHwBu8oA5SfvQAKj80MOaIfhqXjzsIvv1ZNUwDHYPYrYcH0LKxXymb
         BbD5DPEVBrgAFUl8wKrW9+NDifMbdHlnoK7PQmWy84ng96D3tYxgn6hcG8NkWAm7jy
         mBa1mybnDCfXg==
Message-ID: <81c8e89b-8136-6ccf-99c3-cd85866da4e2@kernel.org>
Date:   Thu, 31 Aug 2023 08:48:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RESEND RFC PATCH 07/12] clocksource: Update sh_tmu of handling.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
 <2d323328fba6ac55a1c3cdcefe909fad3ab0d9dc.1693444193.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <2d323328fba6ac55a1c3cdcefe909fad3ab0d9dc.1693444193.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 31/08/2023 03:11, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Subject: Everything is an update... Drop also full stop.

You also miss commit msgs here and other places. No, please write proper
messages explaining why you are doing it.




Best regards,
Krzysztof

