Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBB0C072A2
	for <linux-sh@archiver.kernel.org>; Wed, 15 Nov 2023 21:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbjKOVGQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 15 Nov 2023 16:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbjKOVFv (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 15 Nov 2023 16:05:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01751BE6
        for <linux-sh@vger.kernel.org>; Wed, 15 Nov 2023 13:05:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B31C433CA;
        Wed, 15 Nov 2023 21:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700082347;
        bh=egxvH2XG9LDoDq47Fol/6TIXEWGkYeLTKwc2y9QaQWg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DuW5ClTsUeZpSCNYzoEf8nf38d3XEwIBHZuDdM+NbMDkWrrvjTwtlQAXP49QzNZnP
         G+OqcCWZSex18UlpPBfg4FYoofvvh7uwUDoYmsS4kSA1gDPNPkyQs2/zCweA55ang+
         H57UipUE1cl8B3l18xvbZPpmn5dObcJf8DguhVAsndf76ounAYUzN5GnBVivNghQnl
         E7leGxALIVMfepp8SevZKKip6NtFWqAAJSc3kLEFHmiHrfMWFgc7gihsF3cumSd7Md
         CY/v18u69UIyhN3NAMqsdaM/xpVzyL+O0PaKExG3dBulevChppeDstij8RFRpDpPdo
         iep31KFlEvgew==
Message-ID: <f5449de0-64d2-47cf-976b-91d305c4f146@kernel.org>
Date:   Wed, 15 Nov 2023 22:05:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/37] dt-bindings: timer: renesas,tmu: add
 renesas,tmu-sh7750
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
 <31c717c18bd94839d46c4de726cc573ff563b3e1.1699856600.git.ysato@users.sourceforge.jp>
 <c7202095-1219-4cbd-ace4-23b6e7784f11@kernel.org>
 <CAMuHMdV-B1DY2kqSo+J_p8enzQxUkWzhL1x+HEC+52PoKHR33Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAMuHMdV-B1DY2kqSo+J_p8enzQxUkWzhL1x+HEC+52PoKHR33Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 15/11/2023 09:17, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Tue, Nov 14, 2023 at 10:26 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 14/11/2023 09:00, Yoshinori Sato wrote:
>>> Add SH7750 TMU entry.
>>>
>>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
>>> diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
>>> index a67e427a9e7e..925c2a691b25 100644
>>> --- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
>>> +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
>>> @@ -21,6 +21,7 @@ properties:
>>>    compatible:
>>>      items:
>>>        - enum:
>>> +          - renesas,tmu-sh7750   # SH7750
>>>            - renesas,tmu-r8a7740  # R-Mobile A1
>>>            - renesas,tmu-r8a774a1 # RZ/G2M
>>>            - renesas,tmu-r8a774b1 # RZ/G2N
>>> @@ -46,7 +47,14 @@ properties:
>>>
>>>    interrupts:
>>>      minItems: 2
>>> -    maxItems: 3
>>> +    maxItems: 4
>>> +
>>> +  interrupt-names:
>>> +    items:
>>> +      - const: tuni0
>>> +      - const: tuni1
>>> +      - const: tuni2
>>> +      - const: ticpi2
>>
>> Other variants should be constrained to three items.
> 
> Actually that is not true: the number of interrupts depends on the
> instance, not on the SoC.  The fourth interrupt is present on some
> instances on other SoCs, too, but was never described before, as the
> driver doesn't support it yet (I know this is not a good reason).
> Of course none of this is obvious to the casual reviewer if it is
> not mentioned in the patch description...
> 
> I'm working on making this more clear, and adding support for missing
> variants.

OK, thanks for explanation.

Best regards,
Krzysztof

