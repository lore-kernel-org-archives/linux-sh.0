Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB6ECDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 08:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjJRISs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjJRISq (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 04:18:46 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B161B6
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 01:18:45 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a7dafb659cso79962367b3.0
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 01:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697617124; x=1698221924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzaSUBMbuDsSw89OA2XAqrF7uwbAxmLDyra+rcdggYg=;
        b=h2zkMRxK9NX5OaBHsi0Je+5X7m58/AWdPqksfck9+wB+ZmmQOd810K9Tyk92wLs4/s
         UDdpT7Y8C7GyEgjukG/Om6dKFXvaAS5A0yZdt+NduvHl2QrNw78vL8wH4Ao9xU58vHrX
         NYzlI1yFUQhDFP+oHPvx5gLafgLmfL/bXO7DSpaBx221w77gyZWIWWvMPOo01oVZknYs
         QC4v6mtZHuYAAy8oEvOyerzNxPgscWx82R7Qa2Gmq4ng6SOCuQ8Ai9gD/2zvmpD9XLXQ
         JU/Rvfv/ScriJSQnSDhf2qdnfgt5SMMI6JL3XhSj1Al4KwYYCiOK2sw3UJs/6A0AeWuW
         fWMQ==
X-Gm-Message-State: AOJu0YyuxJDxqQOiPPM0YMu1jQfNk1d4O5FtcaOxyvxa7e41Q9tnf+t7
        BfdhCY/SAj79ubKy9DMIjil/fQyaB7kH5Q==
X-Google-Smtp-Source: AGHT+IELKDYv6QeDEBj/CGGOH9oS8V3pSDWxqpWochXXr603D6SaFwgBtKayKVlQy84LKagqj5WIRQ==
X-Received: by 2002:a05:690c:14:b0:599:da80:e1e6 with SMTP id bc20-20020a05690c001400b00599da80e1e6mr5540017ywb.34.1697617124133;
        Wed, 18 Oct 2023 01:18:44 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id i132-20020a0ddf8a000000b0059f650f46b2sm1313155ywe.7.2023.10.18.01.18.43
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 01:18:43 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7b91faf40so79600577b3.1
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 01:18:43 -0700 (PDT)
X-Received: by 2002:a0d:d802:0:b0:5a7:af7d:cee7 with SMTP id
 a2-20020a0dd802000000b005a7af7dcee7mr4866556ywe.6.1697617123100; Wed, 18 Oct
 2023 01:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <b7d3002d7033a94a57577af68a13f4cfc3a88947.1697199949.git.ysato@users.sourceforge.jp>
 <87v8b44au2.ffs@tglx>
In-Reply-To: <87v8b44au2.ffs@tglx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 10:18:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVZaaoD8HEYzOSDjZBXiGj2M9srFHewfO=YrfgF-zc5aQ@mail.gmail.com>
Message-ID: <CAMuHMdVZaaoD8HEYzOSDjZBXiGj2M9srFHewfO=YrfgF-zc5aQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 14/35] drivers/irqchip: Add SH7751 Internal INTC drivers.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Oct 18, 2023 at 10:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sat, Oct 14 2023 at 23:53, Yoshinori Sato wrote:
> > +config RENESAS_SH7751_INTC
> > +     bool "Renesas SH7751 Interrupt Controller"
> > +     depends on SH_DEVICE_TREE || COMPILE_TEST

> > +static inline void set_interrupt_registers(int ip)
> > +{
> > +     unsigned long __dummy;
> > +
> > +     asm volatile(
> > +#ifdef CONFIG_CPU_HAS_SR_RB
> > +                  "ldc       %2, r6_bank\n\t"
> > +#endif
> > +                  "stc       sr, %0\n\t"
> > +                  "and       #0xf0, %0\n\t"
> > +                  "shlr2     %0\n\t"
> > +                  "cmp/eq    #0x3c, %0\n\t"
> > +                  "bt/s      1f      ! CLI-ed\n\t"
> > +                  " stc      sr, %0\n\t"
> > +                  "and       %1, %0\n\t"
> > +                  "or        %2, %0\n\t"
> > +                  "ldc       %0, sr\n"
> > +                  "1:"
> > +                  : "=&z" (__dummy)
> > +                  : "r" (~0xf0), "r" (ip << 4)
> > +                  : "t");
>
> Why has this to be ASM and cannot be done in C with the existing
> accessors? Also this really lacks a comment what this is actually doing.

This will play not very well with the "|| COMPILE_TEST" ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
