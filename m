Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9739AC77B72
	for <linux-sh@archiver.kernel.org>; Thu, 20 Apr 2023 07:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbjDTHMN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 20 Apr 2023 03:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjDTHMM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 20 Apr 2023 03:12:12 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC677189
        for <linux-sh@vger.kernel.org>; Thu, 20 Apr 2023 00:12:10 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-555bc7f6746so29014817b3.6
        for <linux-sh@vger.kernel.org>; Thu, 20 Apr 2023 00:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974729; x=1684566729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaSejvUsTD7Xsl5QiW6KjFrJGBa/a4Hdjtjtw1bUJlo=;
        b=BbMoRyPLANa/+wqCrtNv8L53pEdHQdr26PAh58p4U4/ROaFjR3or23QZ/G4I1TmUqL
         aqfvIObnLdkye74yrNOVp2fwVaeWsTYCZUpV0Q68MHeEVehvvhD9sxAZRFMYdWJxC8RG
         QWpE0mv9CHE9732wgAIAMg0foHQbfehCPPlSlf+XLkzp2Ks1OdCPI+4RFACwHUnXp10g
         1nIx7DLOT8hazip+BioN1h6TeoYH7UOCD5XuitW8fbTerSeSpJrHGa/K51JfgB3bYDIX
         uLp4y6/sGz6VXaJYpgSjdPyDAA2Qm5dOsq9V7LbEjN1lmpx0BFGI53+PSpbLetMxz7Zi
         EimA==
X-Gm-Message-State: AAQBX9f3AJxz4lEzKxhtEvj9ZxQZJ1MtP4PEelHktZcviyOZTzfHQzVe
        3WQNiN41Jo9fzZ2vuyHcpf0mvZUAa9OtWQ==
X-Google-Smtp-Source: AKy350b3oJVhN4aABYOSAJlGePh3md91SceV7PnUD5mYd4xYhK2Sh2tpYu7N+ybvHIOCCVkr9y7fgg==
X-Received: by 2002:a0d:e081:0:b0:552:c391:7262 with SMTP id j123-20020a0de081000000b00552c3917262mr96813ywe.50.1681974729311;
        Thu, 20 Apr 2023 00:12:09 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id t190-20020a8183c7000000b0054c26b34e8bsm174142ywf.144.2023.04.20.00.12.09
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 00:12:09 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-555bc7f6746so29014437b3.6
        for <linux-sh@vger.kernel.org>; Thu, 20 Apr 2023 00:12:09 -0700 (PDT)
X-Received: by 2002:a81:4888:0:b0:54f:b857:7fdc with SMTP id
 v130-20020a814888000000b0054fb8577fdcmr121045ywa.17.1681974728876; Thu, 20
 Apr 2023 00:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
 <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net> <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
 <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net> <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
 <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net> <CAMuHMdX5Hn2QR127M4NjNLWJMrEVUQK5ApCkeb2nDuSid1o90g@mail.gmail.com>
 <fb177f03-9b6f-adca-4fd2-475df82f0a2d@landley.net>
In-Reply-To: <fb177f03-9b6f-adca-4fd2-475df82f0a2d@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 09:11:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwwkNLqRmx6jD8Trbx67roMqaApVF4Ee7F6+5zUDKWFw@mail.gmail.com>
Message-ID: <CAMuHMdUwwkNLqRmx6jD8Trbx67roMqaApVF4Ee7F6+5zUDKWFw@mail.gmail.com>
Subject: Re: [PATCH] Fix J-core aic warning spam
To:     Rob Landley <rob@landley.net>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rob,

On Thu, Apr 20, 2023 at 2:51 AM Rob Landley <rob@landley.net> wrote:
> On 4/19/23 02:27, Geert Uytterhoeven wrote:
> > One other thing to consider when sending a v2: v1 lacks an SoB
> > from the original author.
>
> Last I heard Rich and his family were on sabbatical in Indonesia. He pops up
> from time to time but hasn't answered the last couple pokes I made at him.
>
> He handed this patch off to Jeff Dionne who handed it off to me. Here is the
> patch publicly posted on Rich's website two years ago:
>
>   https://git.musl-libc.org/cgit/linux-sh/commit/?h=v5.16%2bj2&id=beb1f3ae8ad6
>
> Does Linux require copyright assignments now? I thought even the FSF had finally
> dropped that requirement...

No, it doesn't, Linux just uses the DCO:

https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L379

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
