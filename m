Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003CFCA5534
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 10:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjIMKrF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 06:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjIMKrE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 06:47:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077E19B0
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 03:47:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC00C433C7;
        Wed, 13 Sep 2023 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694602020;
        bh=MnHJ6i1voHffwa/lgUDngquJ5+K46vqUjJyfkh3+fAg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qJ9UHJnJl1Uv0CsF4aAsTSVqNG6/2IeKHiSm76QQ55i/zKae9YET5UPEFe9cyHKQQ
         r+UQZj1UZ2UWAQfpf6vHJv0r8k09/RhqaNjX0SHeG9zEJ899iQ6fuvSgB70o8KNvyF
         8XVy/HaUJ6G82aVVMh/NFAovnDLqtZ6adO99+7DQBFB5dCPw7nZolZcVbxhJfmmWRH
         6UAJsuSSbm7nDFuNwUwNRh75R+ht7ijmxhOs1K6AoXjQOAoj+rP2hrmR6n2l0zpF0b
         CshrfZLleGNZNat13IAZVYcd3bSsUx0vxYdB7aiW79OYNmhUuTRcadoutj8ZBvprE7
         y1FgF03guZ9/w==
Message-ID: <84014955-92e0-bfd3-f4d3-0bfbf9f0dac5@kernel.org>
Date:   Wed, 13 Sep 2023 12:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 24/30] include/dt-bindings: Add SH7750 CPG header.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <7b5122f6252cf4ce563b2fab2ac61bd794876619.1694596125.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <7b5122f6252cf4ce563b2fab2ac61bd794876619.1694596125.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 13/09/2023 11:23, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Empty commit msgs are not acceptable.

> ---

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

>  include/dt-bindings/clock/sh7750.h | 13 +++++++++++++

Missing vendor prefix.

>  1 file changed, 13 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sh7750.h
> 
> diff --git a/include/dt-bindings/clock/sh7750.h b/include/dt-bindings/clock/sh7750.h
> new file mode 100644
> index 000000000000..88e60a9a01df
> --- /dev/null
> +++ b/include/dt-bindings/clock/sh7750.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> + *
> + * Copyright 2023 Yoshinori Sato
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_SH7750_H__
> +#define __DT_BINDINGS_CLOCK_SH7750_H__
> +
> +#define SH7750_CPG_FCK		0
> +#define SH7750_CPG_BCK		1
> +#define SH7750_CPG_ICK		2

This should be squashed with the patch bringing bindings for this
device. It does not make sense on its own.

Best regards,
Krzysztof

