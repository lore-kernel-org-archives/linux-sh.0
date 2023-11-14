Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D42C4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 18:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjKNSTf (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 13:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNSTe (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 13:19:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C9411B
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 10:19:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95752C433C7
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699985971;
        bh=Bao7Ji4ZCI2YZGYvodDtPfqdrOd2CVCuTB8FlVoS4/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DuXsfzhXYYUsJ0Q3O+CgRHnYGi5pTTd2vAGJzmJ49WiCGC5lLYX12o4YSL2Ztlwjp
         hwYPl8t/5cBmUrEWocS5icx8tJ03h+4PIFCVI219F0xjf3e8BazS8FtdDiPW4t3Qzy
         Mln8Q7OhnwyIHC2TH8BJMuUfRLQRqj9scZJivPApRCZtZohb7DPtE/IC1Lja1DjbmN
         wlqmoCh8FCWi2zJTP9o+0KxY6LXM5erIjNPxDf/x5hZtV3/39fgs9seIL+YjATGPLS
         hywGdSQMHtYLrvmykmHKB359Bfj4d8FixgQsFgxgw7XyxEYU5LlnlP2cnD9og+sqJ4
         TA7jSSqU6x+2A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-507c5249d55so9238688e87.3
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 10:19:31 -0800 (PST)
X-Gm-Message-State: AOJu0YxEel4vMlvXSiyNSxN5hmvwKH5se9lizZuBKIZ+tHfQ9DZpdBbB
        xzBGhPvsKE4XM0IX0psTC1kewq32JRGT1U1RxQ==
X-Google-Smtp-Source: AGHT+IHR65VGf6dw2QjY45gPTIdA9O7WkkhHlEx+QZ3uR0l2Q/Dfz0SLbdqLGh4ne73ZwyVTh8tEuhDLKtypOMO2+D8=
X-Received: by 2002:ac2:43a3:0:b0:509:3bba:e8a with SMTP id
 t3-20020ac243a3000000b005093bba0e8amr6657699lfl.39.1699985969765; Tue, 14 Nov
 2023 10:19:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699856600.git.ysato@users.sourceforge.jp> <9ffa722f185f05745e62b2120f7b0dc439a712f3.1699856600.git.ysato@users.sourceforge.jp>
In-Reply-To: <9ffa722f185f05745e62b2120f7b0dc439a712f3.1699856600.git.ysato@users.sourceforge.jp>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Nov 2023 12:19:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+sD8B5YHJoQ_v69=XVv1WhHBp5bYWTHyv6UM3Yz_6q=w@mail.gmail.com>
Message-ID: <CAL_Jsq+sD8B5YHJoQ_v69=XVv1WhHBp5bYWTHyv6UM3Yz_6q=w@mail.gmail.com>
Subject: Re: [PATCH v4 27/37] dt-bindings: ata: ata-generic: Add new targets
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Nov 14, 2023 at 2:01=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
> Added new ata-generic target.
> - iodata,usl-5p-ata
> - renesas,rts7751r2d-ata
>
> Each boards have simple IDE Interface. Use ATA generic driver.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  Documentation/devicetree/bindings/ata/ata-generic.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Please resend DT bindings to the DT list if you want them reviewed.
IOW, use the output of get_maintainer.pl.

Rob
