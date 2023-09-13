Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764EECA5534
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 10:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbjIMKpx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 06:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjIMKpx (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 06:45:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEE619AF
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 03:45:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFD3C433C7;
        Wed, 13 Sep 2023 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694601949;
        bh=xz+TSBXwaol5ODF/YeBxK+i/iuC9BE8qjUuVWDJiM6Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FnkqOT3vWZKMWLeUfi6vJ06CfjKZ5kgnLbzIZ300vGNd5k+dMs0ahxCwACuJSL3TW
         lg+NID/g/eJ6ymluE3mlCxN4xrr3LyQKxnQaTaaIjzFMQq9eHF+Lh9xpmfFKKVk9bk
         Wxka+dF6hxWlX0CYhkebFl6PkbibPb94cN6B/Zm9cCqZDM2SqSrsbs9tNrvlsj8Qc9
         hy3glvTccjhoyhWIhFo6zpst7mHM8EOhLLGZ+kDD1/3dFh24Ds/u1Xy3TDQGlFGpou
         2EgdZdldaSO3a8ctTOGx8YGc9VgZfc0GhYQy9F5aqdevB3pLHgBlyubnnvPSHOaZZQ
         +2e8xgrlqG7iw==
Message-ID: <f0a58f37-94da-d4c5-727a-f8fc9a5b7448@kernel.org>
Date:   Wed, 13 Sep 2023 12:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 17/30] Documentation/devicetree: Add
 renesas,sh7751-irl-ext binding document.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <edb561b3738e9e6317857683c9350c078d370aa1.1694596125.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <edb561b3738e9e6317857683c9350c078d370aa1.1694596125.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 13/09/2023 11:23, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---

Same comments as for other patches :(


Best regards,
Krzysztof

