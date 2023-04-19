Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44285C77B75
	for <linux-sh@archiver.kernel.org>; Wed, 19 Apr 2023 12:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjDSMCo (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjDSMCn (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 19 Apr 2023 08:02:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2839E1447C
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 05:02:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p8so28544421plk.9
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681905739; x=1684497739;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7bCYt4QTThKP4lUKSKFITfGxPU1GjnIUDicO4OQOLc=;
        b=jcTT+2+NFE9DNcCw9lKomcxpIl2XLWDO/0g77WCqpnLQ4Ov36+zcQqEal5HvkcnZOM
         0sOe3A08V8mROFSvpj4CNgViGWfVU2cux17BaixIRCC9YY7CtrUvJO7KNKMIdZuxqCdG
         XouhLv0nD7dXfOPyI8jfxl2W3nJcrkX/8RwrNpCDDwH2uuCYFxvYBbXFJET57DBQSaTn
         32mBBMtc4/lnscYwr+F7Y0ruSfIJgvnLFA65tydFKcYoNFht1UB1PNBq/1e/u7XIV581
         D+IEdW17HSS9gd2KVbqOUHSDcRHxd+tVstCNIpLozDHNVyig04fjXfm5nWvrovAlPEfT
         XcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681905739; x=1684497739;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7bCYt4QTThKP4lUKSKFITfGxPU1GjnIUDicO4OQOLc=;
        b=BcdnxMSXwqUkRx8UhYsy1jfZqxYWYm4r7N0PCkxhrglbAVi1MgAOUzjF5QQ+CHsKtO
         TT8Yyy1jcwDYlIGGBLdsqpIb0f81BaEp8KVx/7oOaQqZrN67g91kvKMEzzXJfNg0IbdM
         Fcxka0KCcQQ/UZGQTdFJDvqY91C2CiXotEJUd/eV5+FDdb0WB/Gp0nTtg9UiduRsuEQ4
         OHSXQaCMDmkPcN0ZCq3Rn+vwmUIaAEDNk4k6Y/YNQNDuv/kaYUNhKjfkeTGHjMvt3g76
         EWITxr1r4zth1zna89AZjb9JJq8V1HdQzVgWWWCa3qBQNSiB23AqzNy3X8bFRxXPHP4y
         oYEQ==
X-Gm-Message-State: AAQBX9fqOPz+qi4tY3BjXP/wjAAIBMzOdbgwj/OzEpXRjOMChYB3hNS1
        ypO8jYlZi3RyY33JOv+zubAeldoxyhRyvQ==
X-Google-Smtp-Source: AKy350ZVMHOecHPClgVGumUhXELS5n8RRlsiWPGTExmRZYElivfPFbHHkJWCYwMxt/trU9eXiKrYtg==
X-Received: by 2002:a05:6a20:158e:b0:ec:6039:f76f with SMTP id h14-20020a056a20158e00b000ec6039f76fmr4139989pzj.11.1681905739518;
        Wed, 19 Apr 2023 05:02:19 -0700 (PDT)
Received: from [192.168.43.232] (M111108020212.v4.enabler.ne.jp. [111.108.20.212])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79210000000b006328ee1e56csm10909731pfo.2.2023.04.19.05.02.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2023 05:02:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH] Fix J-core aic warning spam
From:   "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <CAMuHMdVoH+V4hL_D=4YuoBFq3MYm==X1if3mXyAZdWy5un+Ufw@mail.gmail.com>
Date:   Wed, 19 Apr 2023 21:02:15 +0900
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rob Landley <rob@landley.net>, Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FDBEA4E-8D0B-4866-AD17-3749221057D8@gmail.com>
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
To:     Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Apr 19, 2023, at 20:53, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
> On Wed, Apr 19, 2023 at 12:25=E2=80=AFPM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> I just wanted to perform a test build of the J2 kernel, but I'm =
getting lots of error messages
>> from the assembler about unknown opcodes when trying to build =
j2_defconfig.
>=20
> Looks like upstream gcc does not support -mj2, and thus the build =
fails
> with "unknown opcode" due to the use of "cas.l".
> Disabling CONFIG_SMP in j2_defconfig fixes/works around that.

Rich was mainlining the GCC patches out of tree.  Most of that can be =
found here:
=
https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-9.4.=
0/0007-j2.diff

We need to look a bit more at the code generator before we upstream the =
J-Core patches, since the CPU roadmap does extend SHcompact.

Cheers,
J.

>=20
> Just checked with Arnd on IRC, who says opcodes/sh-opc.h was last =
updated
> in a meaningful way back in 2005...
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

