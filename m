Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7783BCE79CF
	for <linux-sh@archiver.kernel.org>; Wed, 20 Sep 2023 11:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjITLv7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 20 Sep 2023 07:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjITLv5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 20 Sep 2023 07:51:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C1612E
        for <linux-sh@vger.kernel.org>; Wed, 20 Sep 2023 04:51:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7830C433C7;
        Wed, 20 Sep 2023 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695210708;
        bh=opISQuNN+JEJdYngk6YSsUnRBzRxi2Sh58+gfP4ySzo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vAzwZj6i3JCFlN4gSkNyCIwbtvMIYpNb5OLngyjK61Zj73mz8djKadoECVOwx9+9N
         4WJHnX0F01A5Pd7IZ54SZnHQO5ITRdwgR+ZdkOzjrL6viPqG/kNVbZBsLsWlQR04x1
         UB4Y65jyxvNM1Ffw4+S/793FRJ/JMyJ/kge5m6x4fGp9YkE4vp0PzfWLwlTl9SOhCT
         Xr8fiWtaMZdGDKJ1EdX5ipgCGMB3ou0o/6eC8Ssc+KB9iyHupQhu/kUdkEoQ+ANbAT
         ribzGKpVUZ6k+zneGr+M2tNP8T90gUDCC/Xxd5dRqxNTvA/q9dXBZVFq2sZgRVx2Qr
         avinU+y/hloPA==
Message-ID: <25da64c6-cdb2-7758-71d3-fa8ae65de504@kernel.org>
Date:   Wed, 20 Sep 2023 13:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 25/30] include/dt-bindings: Add sh_intc IRQ - EVT
 conversion helper
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <e4dc419e3cc4f44d323aa3686333dafe83b68bce.1694596125.git.ysato@users.sourceforge.jp>
 <cabf9417-e264-fb23-ddd4-24f51f7e72a2@kernel.org>
 <CAMuHMdWeh2DjSR9-WdDUKJhG_KwDhjUk_e-H3D_gSzVZ16ys9g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAMuHMdWeh2DjSR9-WdDUKJhG_KwDhjUk_e-H3D_gSzVZ16ys9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 19/09/2023 15:02, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Wed, Sep 13, 2023 at 12:50 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 13/09/2023 11:23, Yoshinori Sato wrote:
>>> --- /dev/null
>>> +++ b/include/dt-bindings/interrupt-controller/sh_intc.h
>>> @@ -0,0 +1,7 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> + *
>>> + * SH3/4 INTC EVT - IRQ conversion
>>> + */
>>> +
>>> +#define evt2irq(evt)         ((evt) >> 5)
>>> +#define irq2evt(irq)         ((irq) << 5)
>>
>> No, that's not a binding. Drop entire file.
> 
> The issue is that the hardware documentation does not list interrupt
> numbers, but event codes.  The latter is a sparse address space.
> As the "interrupts" property needs interrupt numbers, we have two
> options:
>   1. Use hardcoded event codes and evt2irq() in DTS files.
>      This is the approach Sato-san took,
>   2. Use hardcoded interrupt numbers in DTS files.
>      This would avoids the need for the evt2irq() macro in the DT bindings,
>      but would make life slightly harder for the DTS writer and
>      for the casual reader, as the conversion needs to be done in
>      one's head.
> 
> Note that the documentation for later SoCs that contain both a SuperH
> and an ARM CPU core, usually lists both the event code and the interrupt
> number, although the latter may be offset by 32 due to the SPI
> interrupt base.
> 
> I agree we do not need irq2evt() in DTS, though.

Is the macro used by the drivers? I have a feeling that not, so it would
not be suitable for the bindings, but rather as a header included in the
DTS.

Best regards,
Krzysztof

