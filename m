Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC14BC0032E
	for <linux-sh@archiver.kernel.org>; Wed, 25 Oct 2023 12:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjJYMKr (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 Oct 2023 08:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjJYMKq (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 Oct 2023 08:10:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201FB0;
        Wed, 25 Oct 2023 05:10:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fb85afef4so4832831b3a.1;
        Wed, 25 Oct 2023 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698235843; x=1698840643; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVRjJE3hwKNPZE3XQmsxuwp3mMYFAy3llPXqqRxtOD0=;
        b=PJ2NFFFNa5jZMVkOcs5PoH7S9jxjMZmBevu0joBzKco2WnxP4UPHW51/GKBYbE5Rvk
         AZ0cBTtHecp+Ev4yvQYtmYgUyYPCFecoAQr8lLpCL1gjUlVkRGkJPVh1EOAgzvHI+3uB
         FYcHLBuM29c9ZDjE9J7LTglJQYOxgltI44VlUCT0HyLbx0ooqlFNAF+yzyAWAlEBuz4i
         UD2vWBzyiC69rJi8sEOwYVv8Nr+PsbkD3LCvTq6BJTk8CvLh19hunpkIIFGorE5l2d8L
         Qpe1xRPwSBRxFg0ubRGfTw+gIJasou9cjQ2pPiJ/+Mg/Ruu6m4Ixdi2dqKPDx4I+l4wc
         yf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235843; x=1698840643;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVRjJE3hwKNPZE3XQmsxuwp3mMYFAy3llPXqqRxtOD0=;
        b=kgfEuRDlhH1AS0tzrrhrQwfIyYE1vmOp426y8Qy1//hCi+sblKPtm8bCbgCONq47OB
         yWaDHuo7Ix/0+tqSUrAJGrrEWCKmqXmJpN75/FCwsxl6r9njF/DuaPkmZGIUlCACGAXM
         z9AhkdwCrgWb+J3AGtqjPZ78Jl393GYw04fVhPl1xS1vZttHGR8EYfSgekbzr+xt8ZCH
         8PWzlYeJK06QMeBMyXGu2oGFqmJQlFxVOfIfrYKx3iUEj3MO7ZdeGsLpUv36ZyqG4yEN
         2xxv3y+oMw2C97nU9U9xmEP6TyVhOcwzcgZreRwZ2TYn/0au0xFVUlyBSo3w1MjX4BBS
         ZL9Q==
X-Gm-Message-State: AOJu0YwQt0pSYb5o36eFulxRghkxmFSWbLcmJ+tW7jsCrEO8migoM38a
        b9Y0efcznfSBk1myfmHQEe8=
X-Google-Smtp-Source: AGHT+IF8PPKnpu/s9bXQ5UkN74I5wasJ4XlOQB5Xn0oedpc8mvJ+XCWWO5jtGn4xym0m19TeLNHx8w==
X-Received: by 2002:a62:f24c:0:b0:690:d620:7801 with SMTP id y12-20020a62f24c000000b00690d6207801mr10514512pfl.11.1698235843219;
        Wed, 25 Oct 2023 05:10:43 -0700 (PDT)
Received: from ibuprofen.lan (202-79-124-123.east.xps.vectant.ne.jp. [202.79.124.123])
        by smtp.gmail.com with ESMTPSA id k11-20020aa7972b000000b0068bbd43a6e2sm9524762pfg.10.2023.10.25.05.10.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 05:10:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [RFC PATCH v3 25/35]
 Documentation/devicetree/bindings/sh/cpus.yaml: Add SH CPU.
From:   "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <CAMuHMdUpwdmOGB6BRfWFcd3NJ5Gigui7JpsX_RzMJPT5fsNyyA@mail.gmail.com>
Date:   Wed, 25 Oct 2023 21:10:38 +0900
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <38FB33F7-7740-4181-9F0F-902AC7D7C11C@gmail.com>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <46ef748dd27127ef9b39fa6c97fe51e8d3422a4f.1697199949.git.ysato@users.sourceforge.jp>
 <CAMuHMdU5brBPGuCaMra6pS4MRFvBFQ5vF9tEFVre=-032xuuMg@mail.gmail.com>
 <87ttqf6jjq.wl-ysato@users.sourceforge.jp>
 <D779B53C-D508-4112-8340-CB11F35EBACA@gmail.com>
 <CAMuHMdUpwdmOGB6BRfWFcd3NJ5Gigui7JpsX_RzMJPT5fsNyyA@mail.gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Oct 25, 2023, at 21:04, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>=20
> Hi Jeff,

Hi Geert,

>=20
> On Wed, Oct 25, 2023 at 1:33=E2=80=AFPM D. Jeff Dionne =
<djeffdionne@gmail.com> wrote:
>>> On Oct 25, 2023, at 20:14, Yoshinori Sato =
<ysato@users.sourceforge.jp> wrote:
>>> On Wed, 18 Oct 2023 23:27:43 +0900,
>>> Geert Uytterhoeven wrote:
>>>> On Sat, Oct 14, 2023 at 4:54=E2=80=AFPM Yoshinori Sato
>>>> <ysato@users.sourceforge.jp> wrote:
>>>>> Renesas SuperH binding definition.
>>>>>=20
>>>>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>=20
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/sh/cpus.yaml
>>>>> @@ -0,0 +1,45 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/sh/cpus.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Renesas SuperH CPUs
>>>>> +
>>>>> +maintainers:
>>>>> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
>>>>> +
>>>>> +description: |+
>>>>> +  The device tree allows to describe the layout of CPUs in a =
system through
>>>>> +  the "cpus" node, which in turn contains a number of subnodes =
(ie "cpu")
>>>>> +  defining properties for every cpu.
>>>>> +
>>>>> +  Bindings for CPU nodes follow the Devicetree Specification, =
available from:
>>>>> +
>>>>> +  https://www.devicetree.org/specifications/
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>=20
>>>> Missing
>>>>=20
>>>>   - jcore,j2
>=20
>> We must not imply that Renesas is responsible for J2, or that it is a =
sanctioned SH core.
>=20
> Compatible values do not declare any such endorsement.
>=20
>> J-Core has the responsibility for maintenance of those SH ISA =
compatible cores.
>=20
> The question is: does J2 implement the same instruction set as SH2,
> i.e. can it run unmodified SH2 code?

It can run all SH2 code, but an SH2 cannot run all J2 code.

The GCC compilers we use for J2 generate J2 code, not strictly SH2 code.

The main difference is SH3 dynamic shift, and (S390 derived) Compare And =
Swap.  The new FPU is in testing now, and AFAIK there is no FPU for SH2 =
but I=E2=80=99m not sure.

Cheers,
J.


>>>>=20
>>>>> +          - renesas,sh4
>>>>=20
>>>>=20
>>>>> +      - const: renesas,sh
>>>>=20
>>>> I see arch/sh/boot/dts/j2_mimas_v2.dts lacks the fallback to
>>>> "renesas,sh", though.
>>>> Is there a common base of instructions that are available on all SH =
cores?
>>>=20
>>> The base instruction set is sh2.
>>> Before that, there is sh1, but this is not compatible with Linux.
>>> I think it would be a good idea to change this to "renesas,sh2",
>=20
> Gr{oetje,eeting}s,
>=20
>                        Geert
>=20
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- =
geert@linux-m68k.org
>=20
> In personal conversations with technical people, I call myself a =
hacker. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
>                                -- Linus Torvalds

