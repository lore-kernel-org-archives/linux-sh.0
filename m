Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EC5C6FD18
	for <linux-sh@archiver.kernel.org>; Wed, 19 Apr 2023 12:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjDSMEn (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjDSMEm (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 19 Apr 2023 08:04:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E319215633
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 05:04:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id hg12so13712917pjb.2
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681905869; x=1684497869;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJBwof53rTlxyaI5NB9mDm/Fc/zIIAa+wYsw3JCOktM=;
        b=WBSUDgpMwpP6L1MN3WnCzQyWvN/YoPlT+pJwaafYE+c+NBHo1+ZICN2H6gBD6q7PjL
         rIl0GMz1pwH70H4fnZQXgB+8HV2TEmA5dsBQ3AlQTwoYDz8Pgv1ql4WfSwJVaScdsQJV
         Eb6aEi718ukIduKcbXlUepK8FPf8DlIpWB6aqozQTQrYF/Ch60kZWtEVAfCbzaa7ATog
         Wmr8v2CAzXgQEsUpgXDkM8xn85ZdOieOAVNjHX4sC07hc/axvA10dCdNp7kEjxJNHT8o
         0metnvWnCzU5OPXoz/noZCAZBzuVsLN7yA5xwKdsnnbQgzwo/J7/Gzs0W2PE2nGMDwIW
         dkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681905869; x=1684497869;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJBwof53rTlxyaI5NB9mDm/Fc/zIIAa+wYsw3JCOktM=;
        b=Er7TYicrVoZc14ieVjETyH7tUYt6ojMYNWF5aoyzrKUCOHfKpp16ZDNA3nszlR1EWA
         n1O0fdwdbrRtZFBLnCfgQET/OHfBfjJdlgCnyekJD7428Edf3h4rZb8TA6lZIDbNWCNW
         oHAAil6ZYGycYCJ7v7qOBb9eIhhZLsibtJUuRyU1WGE/RrahDbP4fd+e6157lygiR5wE
         o30pKBjBgzoxa7Nskl1O1JEd1tKc6S62idTApuihwznGfixS1PJ/c1NtVkrAvl/I6mx3
         y214TuTTe/d2yR/NjWigNa/GymctEnxSbnnOD4kwWhffmpC1iYwFJ5Twxt+CqPeVuhzc
         AVDQ==
X-Gm-Message-State: AAQBX9cvwu4MGuoC7kopQA54UYO4wkNRQBVwwh4zddgwAnLIxnp8X2q+
        7y/J+fcE/5g6V0L2Fo+MwsKKeSihu7y1Ew==
X-Google-Smtp-Source: AKy350awIDaqvWd2v8wdlroZNvR1DuppqMrlCUyKodbE9J8HiHiR4Qe+7kl95DPobSlxpj6xkfC23Q==
X-Received: by 2002:a05:6a20:ba20:b0:f0:929c:e8c5 with SMTP id fa32-20020a056a20ba2000b000f0929ce8c5mr2524346pzb.35.1681905869357;
        Wed, 19 Apr 2023 05:04:29 -0700 (PDT)
Received: from [192.168.43.232] (M111108020212.v4.enabler.ne.jp. [111.108.20.212])
        by smtp.gmail.com with ESMTPSA id c14-20020a62e80e000000b0063b6cccd5dfsm8890389pfi.195.2023.04.19.05.04.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2023 05:04:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH] Fix J-core aic warning spam
From:   "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <3FDBEA4E-8D0B-4866-AD17-3749221057D8@gmail.com>
Date:   Wed, 19 Apr 2023 21:04:25 +0900
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rob Landley <rob@landley.net>, Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <054D443F-BB20-4109-9B34-639E9104FD34@gmail.com>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
 <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net>
 <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
 <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net>
 <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
 <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net>
 <b6ba777419f0d94c5f39cfc4698e2dd4f7319e16.camel@physik.fu-berlin.de>
 <b42c6496ffb531459eb7995fd4b5e828f599b4fe.camel@physik.fu-berlin.de>
 <CAMuHMdVoH+V4hL_D=4YuoBFq3MYm==X1if3mXyAZdWy5un+Ufw@mail.gmail.com>
 <3FDBEA4E-8D0B-4866-AD17-3749221057D8@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Apr 19, 2023, at 21:02, D. Jeff Dionne <djeffdionne@gmail.com> wrote:
> On Apr 19, 2023, at 20:53, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>> On Wed, Apr 19, 2023 at 12:25=E2=80=AFPM John Paul Adrian Glaubitz
>> <glaubitz@physik.fu-berlin.de> wrote:
>>> I just wanted to perform a test build of the J2 kernel, but I'm =
getting lots of error messages
>>> from the assembler about unknown opcodes when trying to build =
j2_defconfig.
>>=20
>> Looks like upstream gcc does not support -mj2, and thus the build =
fails
>> with "unknown opcode" due to the use of "cas.l".
>> Disabling CONFIG_SMP in j2_defconfig fixes/works around that.
>=20
> Rich was mainlining the GCC patches out of tree.  Most of that can be =
found here:
> =
https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-9.4.=
0/0007-j2.diff

Binutils side =
https://github.com/richfelker/musl-cross-make/blob/master/patches/binutils=
-2.33.1/0001-j2.diff

Other versions are also in the same repo.

J.

>=20
> We need to look a bit more at the code generator before we upstream =
the J-Core patches, since the CPU roadmap does extend SHcompact.
>=20
> Cheers,
> J.
>=20
>>=20
>> Just checked with Arnd on IRC, who says opcodes/sh-opc.h was last =
updated
>> in a meaningful way back in 2005...
>>=20
>> Gr{oetje,eeting}s,
>>=20
>>                       Geert
>>=20
>> --=20
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- =
geert@linux-m68k.org
>>=20
>> In personal conversations with technical people, I call myself a =
hacker. But
>> when I'm talking to journalists I just say "programmer" or something =
like that.
>>                               -- Linus Torvalds
>=20

