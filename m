Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728F7C83F2B
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 06:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjHaGvW (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjHaGvW (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 31 Aug 2023 02:51:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF0CAB
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 23:51:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2A2BB82198
        for <linux-sh@vger.kernel.org>; Thu, 31 Aug 2023 06:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BEBC433C7;
        Thu, 31 Aug 2023 06:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693464676;
        bh=VAptNDz+UewGDSG7V22+PvberaDKD8dsSqkmrQFMtEE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uMeYoyfyTTpDVK8y5Pb3osTYZ7dWRiZgV16WqLux5c6S8BvJ/klGHmPUtHTnNAosj
         cAzA0yyYuGb5yVa2MSJo6Squ8e6g+c2cRccXVNou1qmJtomhxgNFK4BmCWCdqbTMoB
         /yyAsiA1hb0Va5GuI1aj/Z0YZjUV67owwbtOepBQqEMFVqkcKGQxK8Hgm7m+KsiC4c
         azwmCaCNNURBwXclrQEezyGLl8HZOnmgMey3cW+8EZ/iZ8fjxseicOdQzo8TGoyFND
         9VAWfzfTFkE0/gjvvluiCiYuMhQoT7+NH5KRSSOh5lCTr7DQEy9iSJGugDrFreAwjm
         o1ds/Q4Xn6/kQ==
Message-ID: <caa98bdd-3585-d19c-599c-7c3a6a6011d9@kernel.org>
Date:   Thu, 31 Aug 2023 08:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RESEND RFC PATCH 08/12] mfd/sm501: Add OF properties.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
 <f622670c0af1bf01bf7c2f16241db0c36233a7d9.1693444193.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <f622670c0af1bf01bf7c2f16241db0c36233a7d9.1693444193.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 31/08/2023 03:11, Yoshinori Sato wrote:
> Some parameters only platform_device.
> Added same parameters in OF property.

Subject: everything can be "add of properties". Is some next commit
adding properties to this file going to have the same subject? Please
write subjects matching changes.


> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../devicetree/bindings/display/sm501fb.txt   |  11 ++
>  drivers/mfd/sm501.c                           | 113 +++++++++++++++++-

Nope, bindings are never mixed with drivers.

And you clearly did not run checkpatch, so:

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


>  2 files changed, 123 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/sm501fb.txt b/Documentation/devicetree/bindings/display/sm501fb.txt
> index 1c79c267a57f..4c4920394431 100644
> --- a/Documentation/devicetree/bindings/display/sm501fb.txt
> +++ b/Documentation/devicetree/bindings/display/sm501fb.txt
> @@ -20,6 +20,17 @@ Optional properties:
>    set different foreign endian.
>  - big-endian: available on little endian systems, to
>    set different foreign endian.
> +- sm501,devices: select peripheral functions.
> +  available usb-host, usb-gadget, ssp0, ssp,1 uart0, uart1, accel,
> +            ac97, i2s, gpio and all.
> +- sm501,mclk: SM501 mclk frequency.
> +- sm501,m1xclk: SM501 m1xclk frequency.
> +- sm501,misc-timing: SM501 Miscellaneous Timing reg value.
> +- sm501,misc-control: SM501 Miscellaneous Control reg value.
> +- sm501,gpio-low: SM501 GPIO31-0 Control reg value.
> +- sm501,gpio-high: SM501 GPIO63-32 Control reg value.
> +- sm501,num-i2c: I2C channel number.
> +- sm501,gpio-i2c: I2C assigned GPIO.

Sorry, new properties are allowed only in DT schema format. Convert
bindings to DT schema first.


Best regards,
Krzysztof

