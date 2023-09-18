Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E02DCD37B0
	for <linux-sh@archiver.kernel.org>; Mon, 18 Sep 2023 15:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjIRP0R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjIRP0Q (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Sep 2023 11:26:16 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF9710CC
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:24:24 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-274b9b3e0e1so990032a91.1
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050536; x=1695655336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIKetutJMTD4QkVTYRX+bu1GkPZ+G9/ZV1OTwDnSMF4=;
        b=O3y40ZGjvOnTcRAo1Bzi1a6HAwgaJVRS+TXcvLfWUY/sIJvH1nI0CKYqlqty8epVc7
         yupoERHYPin0LPw68QvMShk3X+Rtt7eL4sIpq0Ufe6MZwyLaWDjlrJYDNFAmOgMX9zRz
         BNQSmoaVQxSCyF0vwBkQOavMGzvl207cD31ARm0X5AcD7TdD1sUei2xXVDLY2I3+rwuH
         b9DDyX8tOtHaaCuyBbar/u3AOVTvzhRx3ci2lty99gXNpDl2n1aCEdPQQVU0uFdVRDRq
         LDca2apHj2zrbEx06w5mO9dW8jSj0aSEYwjYoHt/1e6gVFcJd/mr8vNqeLmIbuNeTQCo
         vBPA==
X-Gm-Message-State: AOJu0YzXd2rPH32YHnBgC1hImI2VtmRDitwSb5vQKrNhMtlmt25w2HjR
        MukJaz0i5hlZPCfllGFUuIYZcdK8gzWHfQ==
X-Google-Smtp-Source: AGHT+IFjlOnvY+YQKn6XScCEJT8wSIcT06Pqe53Nbc0+P6rz3BY6oFhocr8BoJRMK/zoOb0gbtqNJg==
X-Received: by 2002:a05:6358:9910:b0:142:efb8:5295 with SMTP id w16-20020a056358991000b00142efb85295mr11656495rwa.19.1695050175600;
        Mon, 18 Sep 2023 08:16:15 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id j129-20020a819287000000b0059b3c406af3sm2631073ywg.82.2023.09.18.08.16.15
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:16:15 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59e77e4f707so18454227b3.0
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:16:15 -0700 (PDT)
X-Received: by 2002:a0d:d585:0:b0:59b:51d9:1d6e with SMTP id
 x127-20020a0dd585000000b0059b51d91d6emr10842071ywd.6.1695050175142; Mon, 18
 Sep 2023 08:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <8004923e733fcc4adb930c7dfb6b0ca3fff42177.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <8004923e733fcc4adb930c7dfb6b0ca3fff42177.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 17:16:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRsQYMnTJHPTJAYLRzKH=abz4AQ4KxNCutTDdCPdhHtg@mail.gmail.com>
Message-ID: <CAMuHMdXRsQYMnTJHPTJAYLRzKH=abz4AQ4KxNCutTDdCPdhHtg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/30] arch/sh: head_32.S passing FDT address to
 initialize function.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Sep 13, 2023 at 11:24 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> R4 is caller saved in SH ABI.
> Save it so it doesn't get corrupted until it's needed for initialization.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
