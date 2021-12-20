Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A57C433FE
	for <linux-sh@archiver.kernel.org>; Mon, 20 Dec 2021 10:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhLTK2V (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 20 Dec 2021 05:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLTK2U (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 20 Dec 2021 05:28:20 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A14C06173E
        for <linux-sh@vger.kernel.org>; Mon, 20 Dec 2021 02:28:20 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id m6so15099581oim.2
        for <linux-sh@vger.kernel.org>; Mon, 20 Dec 2021 02:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L4Sw67BXpIx21OZ/G/pQTCNTjSKUb09oaSZld1KnM60=;
        b=wc4jConf2OyeQ5jgnUR8S55Kdd7aN73I/SDTcr37sMq7QH1MkC+Yq/9MVRpd4661HX
         2LIG+VhT3VNMC7Pk+04MoTAxamrok6ffsbp7fYGsmcWMljKvDwqCKkcRjAi8n2y9HWqg
         YsNR+DDAdompWe1+Y5WHRvLmdmXE9wDYMw51M/fPwgW+uZd10DY5mH4H7ikf0OCDNBvv
         kremqXx8AB5QFabeF25for/DsWbViQfkOeFUsRKWBK7DHq2QLZMzBCOT0UUceCfJTJpA
         UuoT2HxozkknP4jf8xZEyMOCyqltfd/+1u3L4gbRoWNQWoOJkOpzZfV5TXchc8EYWgHt
         m5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L4Sw67BXpIx21OZ/G/pQTCNTjSKUb09oaSZld1KnM60=;
        b=Yq/ZdlZUwlbfh2W7s1/IIn2P2Qw/vcDkYh24GwIGfY8zyVm+B60NsP8c2N4OSlETt0
         XjVNVyFOz2+NEnuzFM4/ZxSaUtStsfLgUo5WFiL5n4MUbTteMJe5xwAEENzF06nBVXY0
         EBhJYgnqi4Z0sQu0RSwOUMZCc3Y7MpUCDWRVwh8ppqG+j5kEuAfifXlDHa5+FYRqg7D8
         JBjrkGk3etcw6/T/y4HTIiqHrZg35r+G6TzdOXw3zNQoR82ODzLYUYZP2CZNAEG+CK6h
         5X98F8E17m6mM7Q9wnjjSKGalEn/cigKPJHQ4mszrDjBfKDILe1ffK+tiSPbZleQ1Pdy
         6Oaw==
X-Gm-Message-State: AOAM533uuvhGGPgIXfnE/3lrvMwGBcxZqytKluHb500xBaKSauCmymle
        iu0g5IbErOwMBTgkeI4lMt1U+w==
X-Google-Smtp-Source: ABdhPJxM7qO+4A2xJGs0I+14CmJKtx1V0TJOtS9RMiaqVDw4lLLizmC2YIlgoVc5+2YSj6Smi0rxqw==
X-Received: by 2002:aca:230b:: with SMTP id e11mr17073975oie.22.1639996100050;
        Mon, 20 Dec 2021 02:28:20 -0800 (PST)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id 9sm3263578oij.16.2021.12.20.02.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 02:28:19 -0800 (PST)
Subject: Re: [PATCH 0/3] serial: sh-sci: Clock handling improvements
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Magnus Damm <magnus.damm@gmail.com>
References: <cover.1639663832.git.geert+renesas@glider.be>
 <7cbec488-01d1-1ee2-006a-a3835d42a0a7@landley.net>
 <CAMuHMdUYu4hOjZMHy+bPrLpJ6=3tja0kJ7WwJ5TFhHivvi0DNQ@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <ffd9ed49-69eb-0508-d2fa-5585a1421d78@landley.net>
Date:   Mon, 20 Dec 2021 04:29:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUYu4hOjZMHy+bPrLpJ6=3tja0kJ7WwJ5TFhHivvi0DNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 12/19/21 4:53 AM, Geert Uytterhoeven wrote:
>> By the way, did you ever figure out how to get the first serial port to work on
>> qemu so qemu-system-sh4 doesn't have to "-serial null -serial mon:stdio" to get
>> a serial console?
> 
> Nope, same as last time you asked ;-)

Well it had been a couple years, you never know...

> However, upon a fresh look at linux/arch/sh/boards/mach-r2d/setup.c,
> I noticed something I missed before: the SCI port is not available
> as a UART, as it is used to talk SPI to an RTC.

/* Single Epson RTC-9701JE attached on CS0 */

Huh. That does explain the CONFIG_RTC_DRV_R9701=y in rts7751r2d*_defconfig.
(And also SPI SPI_SH_SCI MFD_SM501 RTC_CLASS and RTC_DRV_SH RTC_HCTOSYS which
I've never gotten connected to QEMU.)

> So that means qemu
> has the hardware description wrong?

It would be nice if qemu-system-sh4 grew an RTC. Looks like Sato-san and Magnus
Damm are the qemu-system-sh4 maintainers? (cc'd)

Thanks,

Rob
