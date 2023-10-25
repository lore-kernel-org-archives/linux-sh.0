Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68816C0032E
	for <linux-sh@archiver.kernel.org>; Wed, 25 Oct 2023 12:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjJYMez (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 Oct 2023 08:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbjJYMey (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 Oct 2023 08:34:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199F13A;
        Wed, 25 Oct 2023 05:34:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c434c33ec0so38943065ad.3;
        Wed, 25 Oct 2023 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698237291; x=1698842091; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsDxx842Vh1lbgmxJbbVurYHlLK+5bkeIBGgQTHiyQc=;
        b=CKUNQxSjtrPpg5VTfLnOdOmcVhPkXayERwvDsQett7otiw1JyzNtoyP0ILaQV/waYr
         qxHpF45JmX6YkV7RMiidJUm1b0YltMQE8vmtpxyJhHHO+9uj17eqm56D9rfsl/CPCTHB
         IjUcM2fnTsaQHoWXSzYYHWcsVuWcc3ckhu+/BUGpAq4D91qtYLmS6LIgXKZUrRRCa75g
         c8xNaIKJWXMmrV4daSZLv5v3ZsKNk3TK/Qz5f/A2KFu4covEeAgUt29fyuQLdOwoGgqW
         UESnbsRat2WpyVo39AfcG+r/eAjOjpI25sS/L62m0AyWMF0mAGFQxvb+kLVfjkHdXyQl
         wKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698237291; x=1698842091;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsDxx842Vh1lbgmxJbbVurYHlLK+5bkeIBGgQTHiyQc=;
        b=cwxFV7Z2QP3JLWZIU/9O1XRAfdSnuKq9AyVXbHir36SwItamRZAd+HxI+wETsRDKua
         E50gZTw5w4aSyhtmYkD5QGHTVOzbgN3NS+9uneHRkwnfBkIYZ63hzIJDF5SzmstJKZYK
         sVT90DiWKSQ9PMXy0yKNxE370YX52JDJRpWWdPLFVpEN5puT65xBPn8hKIxL/OEoKtT7
         iVbhAjQz6M3Mbo0o44dj3HV8tVpG874u1RLb1cMtGna/CASexUA9+VxeudgmvO6vkKzb
         k6q4QHYhWsO8caF9QNhstZsyeeEAG8hD/v/51bDw+sj92zLCvqMVb7Leg5SiwUnZzY+P
         58Pg==
X-Gm-Message-State: AOJu0YzaIT1pkg4xftK73YgEDreiOp4Q76/i9rFo+JTbyj/Yo5Ja65wT
        tOtibp3KTXCqAZfN1ceLYCw=
X-Google-Smtp-Source: AGHT+IGxDRMB9twDQqv3BHPmlvSOnwkQxL3nyUwxZxuFEbpaADNMEeeqfDwrvUuYAXcqnJjI1xUYnw==
X-Received: by 2002:a17:903:6cc:b0:1bb:f1d9:432e with SMTP id kj12-20020a17090306cc00b001bbf1d9432emr11070365plb.37.1698237290823;
        Wed, 25 Oct 2023 05:34:50 -0700 (PDT)
Received: from ibuprofen.lan (202-79-124-123.east.xps.vectant.ne.jp. [202.79.124.123])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ea8a00b001c20c608373sm9099756plb.296.2023.10.25.05.34.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 05:34:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [RFC PATCH v3 25/35]
 Documentation/devicetree/bindings/sh/cpus.yaml: Add SH CPU.
From:   "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <CAMuHMdV1+Ec=23pGrN-ZMDwx9xXgEeUs827J4768wmgfaOeCWg@mail.gmail.com>
Date:   Wed, 25 Oct 2023 21:34:46 +0900
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2ED29F7F-5DC0-43C6-B125-795D9DA6567B@gmail.com>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <46ef748dd27127ef9b39fa6c97fe51e8d3422a4f.1697199949.git.ysato@users.sourceforge.jp>
 <CAMuHMdU5brBPGuCaMra6pS4MRFvBFQ5vF9tEFVre=-032xuuMg@mail.gmail.com>
 <87ttqf6jjq.wl-ysato@users.sourceforge.jp>
 <D779B53C-D508-4112-8340-CB11F35EBACA@gmail.com>
 <CAMuHMdUpwdmOGB6BRfWFcd3NJ5Gigui7JpsX_RzMJPT5fsNyyA@mail.gmail.com>
 <38FB33F7-7740-4181-9F0F-902AC7D7C11C@gmail.com>
 <CAMuHMdV1+Ec=23pGrN-ZMDwx9xXgEeUs827J4768wmgfaOeCWg@mail.gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



> On Oct 25, 2023, at 21:17, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>=20
> Hi Jeff,
>=20
> On Wed, Oct 25, 2023 at 2:10=E2=80=AFPM D. Jeff Dionne =
<djeffdionne@gmail.com> wrote:
>> On Oct 25, 2023, at 21:04, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>>> On Wed, Oct 25, 2023 at 1:33=E2=80=AFPM D. Jeff Dionne =
<djeffdionne@gmail.com> wrote:
>>>>> On Oct 25, 2023, at 20:14, Yoshinori Sato =
<ysato@users.sourceforge.jp> wrote:
>>>>> On Wed, 18 Oct 2023 23:27:43 +0900,
>>>>> Geert Uytterhoeven wrote:
>>>>>> On Sat, Oct 14, 2023 at 4:54=E2=80=AFPM Yoshinori Sato
>>>>>> <ysato@users.sourceforge.jp> wrote:
>>>>>>> Renesas SuperH binding definition.
>>>>>>>=20
>>>>>>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>=20
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/sh/cpus.yaml
>=20
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    items:
>>>>>>> +      - enum:
>>>>>>=20
>>>>>> Missing
>>>>>>=20
>>>>>>  - jcore,j2
>>>=20
>>>> We must not imply that Renesas is responsible for J2, or that it is =
a sanctioned SH core.
>>>=20
>>> Compatible values do not declare any such endorsement.
>>>=20
>>>> J-Core has the responsibility for maintenance of those SH ISA =
compatible cores.
>>>=20
>>> The question is: does J2 implement the same instruction set as SH2,
>>> i.e. can it run unmodified SH2 code?
>>=20
>> It can run all SH2 code, but an SH2 cannot run all J2 code.
>=20
> This is exactly what
>=20
>    compatible =3D "jcore,j2", "renesas,sh2";

Oh, yes.  I agree, this is correct.  Once this is settled upon, we can =
change new J2 cores so they will export their ROM device tree with the =
sh2 fallback.

Down thread, Sato-san proposes =E2=80=9Crenesas,sh4=E2=80=9D, =
=E2=80=9Crenesas,sh=E2=80=9D  I=E2=80=99m not sure I understand what a =
=E2=80=9Crenesas,sh=E2=80=9D base fallback is.

J.

> represents.
> Cfr. Section 2.3.1 ("compatible") of the Devicetree Specification
> https://www.devicetree.org/specifications
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

