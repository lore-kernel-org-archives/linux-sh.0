Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24116C07545
	for <linux-sh@archiver.kernel.org>; Wed, 25 Oct 2023 11:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjJYLdR (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 Oct 2023 07:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJYLdR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 Oct 2023 07:33:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911AF111;
        Wed, 25 Oct 2023 04:33:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so4791015b3a.3;
        Wed, 25 Oct 2023 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698233592; x=1698838392; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtR8+pol7elmVxk3bknz5iDcdKupDssRkJxN7J6WSug=;
        b=WBN6Mv+PygBUmHX52A/Kfeto6O7a5q58tOZGLe4Ay0vO316/yptSyXGQAgL93QhQCp
         Awz+lwXj2bfaGimx8yBA8rUFFQ1M2p/Xws+ZoFhlUm5v+cdLxND04LoVOekGdWuFBqdj
         FXIfqmjCuTOBnj/lH1jtrFjVWwKyNL8BpNFxcqZXxVmFqcxb5FTh6zBuA4VDAA8AQm3f
         TUQVz93hvtFEZaJ/ATtJedLkzg3X4/ldUXAxHIVw5zzQOW5zT0yaTJcrzPBm1L6aALaN
         23TmfNmFQUAl8ikdgxWXw3PLdJgXuDeICAglwVqbsW3EbtrkovbtY1XSAJpdOJs/YweD
         WkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698233592; x=1698838392;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtR8+pol7elmVxk3bknz5iDcdKupDssRkJxN7J6WSug=;
        b=uwp+RSh97FCCVYt9c8/30b8GlE246NU3k/mqs5OZZGyy56wiOSYkNVXsIq+qyY35da
         nECyuuOYaHyOsPOGjG2cZs2W4+C/GrTjZoMvewDo0ff0yJ7H+1ECYtnGGt9no81J0YQl
         4SlmRKIhBIn/7JkpbGu63Td+UIQGEIquwjJgr3B9Z506feY9Ziei8Um4nCHHl9gANk+w
         ESztEUynenJRXLbkRTuyoe5x3z4KkCfGvZC9XA0/n7JHoLp7y+KBFW6TiNY1WjwbSiMP
         JZC9dyfolKUj6Vj4Z2Q1WqHBCzKwrdtJJNmr5THi5Isyy5nCoxp2cvyp+yK5jpkSz0pN
         nNUA==
X-Gm-Message-State: AOJu0YzcIhwlcCewHgfomSgjUZMi58g1cj/CK7avcqeR2Pb6TKQGL6g5
        Nzekq7Xo4jmH/lTWEBtBD90=
X-Google-Smtp-Source: AGHT+IGjZfCg8pmlT60VTHiYPBYhOlO18j8llgz7kZS2BiyZeFA6I9W1PDDA2ynL1uk6jNux851Nnw==
X-Received: by 2002:a05:6a20:8419:b0:16b:80b4:c39a with SMTP id c25-20020a056a20841900b0016b80b4c39amr7049225pzd.19.1698233591950;
        Wed, 25 Oct 2023 04:33:11 -0700 (PDT)
Received: from ibuprofen.lan (202-79-124-123.east.xps.vectant.ne.jp. [202.79.124.123])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090ab38c00b002776350b50dsm10254760pjr.29.2023.10.25.04.33.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 04:33:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [RFC PATCH v3 25/35]
 Documentation/devicetree/bindings/sh/cpus.yaml: Add SH CPU.
From:   "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <87ttqf6jjq.wl-ysato@users.sourceforge.jp>
Date:   Wed, 25 Oct 2023 20:33:07 +0900
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D779B53C-D508-4112-8340-CB11F35EBACA@gmail.com>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <46ef748dd27127ef9b39fa6c97fe51e8d3422a4f.1697199949.git.ysato@users.sourceforge.jp>
 <CAMuHMdU5brBPGuCaMra6pS4MRFvBFQ5vF9tEFVre=-032xuuMg@mail.gmail.com>
 <87ttqf6jjq.wl-ysato@users.sourceforge.jp>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

We must not imply that Renesas is responsible for J2, or that it is a =
sanctioned SH core.

J-Core has the responsibility for maintenance of those SH ISA compatible =
cores.

J.

> On Oct 25, 2023, at 20:14, Yoshinori Sato <ysato@users.sourceforge.jp> =
wrote:
>=20
> On Wed, 18 Oct 2023 23:27:43 +0900,
> Geert Uytterhoeven wrote:
>>=20
>> Hi Sato-san,
>>=20
>> On Sat, Oct 14, 2023 at 4:54=E2=80=AFPM Yoshinori Sato
>> <ysato@users.sourceforge.jp> wrote:
>>> Renesas SuperH binding definition.
>>>=20
>>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>>=20
>> Thanks for your patch!
>>=20
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sh/cpus.yaml
>>> @@ -0,0 +1,45 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sh/cpus.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Renesas SuperH CPUs
>>> +
>>> +maintainers:
>>> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
>>> +
>>> +description: |+
>>> +  The device tree allows to describe the layout of CPUs in a system =
through
>>> +  the "cpus" node, which in turn contains a number of subnodes (ie =
"cpu")
>>> +  defining properties for every cpu.
>>> +
>>> +  Bindings for CPU nodes follow the Devicetree Specification, =
available from:
>>> +
>>> +  https://www.devicetree.org/specifications/
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>=20
>> Missing
>>=20
>>    - jcore,j2
>>=20
>>> +          - renesas,sh4
>>=20
>>=20
>>> +      - const: renesas,sh
>>=20
>> I see arch/sh/boot/dts/j2_mimas_v2.dts lacks the fallback to
>> "renesas,sh", though.
>> Is there a common base of instructions that are available on all SH =
cores?
>=20
> The base instruction set is sh2.
> Before that, there is sh1, but this is not compatible with Linux.
> I think it would be a good idea to change this to "renesas,sh2",
> but the SH7619 (SH2 CPU) would look like the following.
> cpus {
> 	cpu: cpu@0 {
>        	compatible =3D "renesas,sh2", "renesas,sh2";
>        };
> };
>=20
>> Missing reg property.
>> Missing "device_type: true".
>>=20
>>> +
>>> +  clock-frequency:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      CPU core clock freqency.
>>=20
>> Perhaps a "clocks" property instead, or as an alternative?
>>=20
>> On sh7750, you do have
>>=20
>>    clocks =3D <&cpg SH7750_CPG_ICK>;
>>=20
>>> +
>>> +required:
>>> +  - compatible
>>> +
>>> +additionalProperties: true
>>> +
>>> +examples:
>>> +  - |
>>> +        cpus {
>>=20
>> make dt_binding_check
>> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/sh/cpus.yaml:
>>=20
>> Documentation/devicetree/bindings/sh/cpus.example.dtb: cpus:
>> '#address-cells' is a required property
>>        from schema $id: http://devicetree.org/schemas/cpus.yaml#
>>        Documentation/devicetree/bindings/sh/cpus.example.dtb: cpus:
>> '#size-cells' is a required property
>> from schema $id: http://devicetree.org/schemas/cpus.yaml#
>>=20
>>> +                cpu: cpu@0 {
>>> +                      compatible =3D "renesas,sh4", "renesas,sh";
>>=20
>> Documentation/devicetree/bindings/sh/cpus.example.dts:19.28-21.19:
>> Warning (unit_address_vs_reg): /example-0/cpus/cpu@0: node has a unit
>> name, but no reg or ranges property
>> Documentation/devicetree/bindings/sh/cpus.example.dtb: cpus: cpu@0:
>> 'cache-level' is a required property
>>        from schema $id: http://devicetree.org/schemas/cpus.yaml#
>>=20
>>> +                };
>>> +        };
>>> +...
>>=20
>> Gr{oetje,eeting}s,
>>=20
>>                        Geert
>>=20
>> --=20
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- =
geert@linux-m68k.org
>>=20
>> In personal conversations with technical people, I call myself a =
hacker. But
>> when I'm talking to journalists I just say "programmer" or something =
like that.
>>                                -- Linus Torvalds
>=20
> --=20
> Yosinori Sato

