Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCAEC433EF
	for <linux-sh@archiver.kernel.org>; Wed, 15 Sep 2021 13:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED8D60EE0
	for <linux-sh@archiver.kernel.org>; Wed, 15 Sep 2021 13:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbhION6J (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbhION6C (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 15 Sep 2021 09:58:02 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFCAC061768
        for <linux-sh@vger.kernel.org>; Wed, 15 Sep 2021 06:56:41 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id f6so2831255vsr.3
        for <linux-sh@vger.kernel.org>; Wed, 15 Sep 2021 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mML+2SpaZvN+C4X1Q9Xwc9NyLF8uokM0dm+tKkmfvHs=;
        b=meJOGsdogwgZsB6R11lVk9UtJCTanNRPaTxTcJXCZtls+nrdarVse8YthJXkk97nPr
         oQ0hfwFK4VSPx0YH+urLRnSQgf9qePEBj4IsZ0tg8sRBN4v0uTr3sQ5r6Sq45HdAr72O
         ealcrUYO5/+XPrmWlhHkwbPhBG/K5216R1H20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mML+2SpaZvN+C4X1Q9Xwc9NyLF8uokM0dm+tKkmfvHs=;
        b=ruevwBEnVan2mg0TVgXexvQdlmTgpzrWJDiMqCexjimzio4y8kj1HBYevgb7D5rqgA
         DwRXpoiNn5BllGJRKfbrvYu5YYyFvgDexz/tzWUNRwciVGllykcIPvND0AU/9vtl0bNC
         ieCQoh+D7ujFq8d7JAZn1udXT6quXj1De+JTa/+/9ST0tia67nRtKftxpFZ4AX9AJuXV
         H0/5uV0FMArasfNAzj987DacPxLMI2jxibR/DYIkd5Lh2Lco9jJwEmPeql3pXNaOpj7Z
         YXhTqbhhBuqVPmwyjyl6ysUpobvE7vyw2Tg/tOsX7HkpkznZyidswxUgEYXouBW5rmnk
         0yww==
X-Gm-Message-State: AOAM531H/V4OHa2pUfW3NUvZTWmfWI1x4J05ew6bQNIo75mOx3CTV7IB
        YT59qIMZWJNuziL40VQJNhFYggQZE/DJbscGoiC8Qo6DCOo=
X-Google-Smtp-Source: ABdhPJym/MN/iKoDHA5No4vLA0dpAD/NrCewprRlJBvTD4aVKjY6mrkPoRM1VpdXKR8MFqDOsyB9oDk0rQfSxks2Xnk=
X-Received: by 2002:a05:6102:3f12:: with SMTP id k18mr3440411vsv.14.1631714200375;
 Wed, 15 Sep 2021 06:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
In-Reply-To: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 15 Sep 2021 22:58:57 +0900
Message-ID: <CAFr9PXk4baxbfNDwRMBD-++8KkuTn=d1buNwvmMy_zCSdURwEA@mail.gmail.com>
Subject: Re: [PATCH] sh: pgtable-3level: Fix cast to pointer from integer of
 different size
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Linux-sh list <linux-sh@vger.kernel.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Geert,

On Wed, 15 Sept 2021 at 22:52, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Compile-tested only, as the remote Migo-R is MIA.
> Anyone with e.g. a Migo-R or Ecovec to boot-test?

Yes. It's 11pm here right now so I'll do it tomorrow and get back to you.

Cheers,

Daniel
