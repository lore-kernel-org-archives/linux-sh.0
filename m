Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB3AC43381
	for <linux-sh@archiver.kernel.org>; Tue, 12 Jan 2021 00:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1A22253A
	for <linux-sh@archiver.kernel.org>; Tue, 12 Jan 2021 00:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbhALAvl (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 11 Jan 2021 19:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbhALAvk (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 11 Jan 2021 19:51:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7FEC061575;
        Mon, 11 Jan 2021 16:50:59 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d17so1026190ejy.9;
        Mon, 11 Jan 2021 16:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5DIxSZetsXeR2X3GAYIsmKuc4e0LX+pB1h8al42nGA=;
        b=j+w8cAPmi1ouSNkB0JqJUkdXD2VJoqYoycV8eQYOpVz5VF8TwAYOQnJu4l6qSpe1TP
         l7cC9+RmbUcKXbqnWzgLDa+qn60MdYylKKNyOM2Y3aYHPOqg45Q7c2vcm5mofHVVOnWW
         BhwCQrkXbjWXz4C7+VJWYTGrFCHl2Onjd1rasxY4Tze0mPYJnVEeqWVwXrnP3jFbtpAG
         hhy+ITv2iGARdXt0IgayP4e7IkWKy/y1Qv/3GkoDzqJUyn1XKHXO+0D83Mz/Xr/TEUEd
         ee7W91Ay8q4dNbSafyg4ABdEc88Nh6n9FXIKHIe77FLIeiDzpDJ2KT9ADfJFVO1SEbQo
         KrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5DIxSZetsXeR2X3GAYIsmKuc4e0LX+pB1h8al42nGA=;
        b=cOUhRoc7NRNwlcEQZls6MRmBkwzFyvk5ArEZ4mPfezciLavdZ6fTzaBmsU5TaA5kBd
         6mYaJmX4gfJ3CYEflQbP7tCma0wNP8hp4JcZ7YtcU9qm/A7e2vfo2AhV9eQhiQpSXoTS
         S15+r7SiY1X1ZvgRSOcRMDWYAYKrk5UnvGgo5c4U3kzwi20B+NuUvujtb/P6rOe3bKOD
         Hs2klR5nOTrzc4meT2te+pvx15hgvYUXHdBRMK0mbJ6Oqmf8LvKbY7Yfg5eeZFQmdDap
         ZrSTC1Bv/ObLVUEFshCm7Y9dWYTBqYRC/BNh3YX4CFw6F+iuUjMaSzw0sadzqMujySlj
         VZlQ==
X-Gm-Message-State: AOAM533DctozyEpwyuf0BW8nb2itWlLwvtubQVT3Z6iDAFRW/fmh4XxE
        JazHxXIfNOisDxZjddBsD8FOoixlsYBumIwESsISUvapTus=
X-Google-Smtp-Source: ABdhPJzLOupF2EAqOuP41DKkzhcSVFM9yIFN4BjqQCM5peWAM46JF+3fPJTzZ1sn4B2uQLYl7RFtxyYMab7dSCaZUh4=
X-Received: by 2002:a17:906:7c49:: with SMTP id g9mr1408341ejp.185.1610412658411;
 Mon, 11 Jan 2021 16:50:58 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <20210110214653.GA1693373@ravnborg.org> <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
 <CACwypyNS+fVoPVspSr36v8YjFbkrnYb+amcYRqVmA2kD2uD1Wg@mail.gmail.com> <1f6e936c-4947-4952-fae2-c05d03e0cd2c@landley.net>
In-Reply-To: <1f6e936c-4947-4952-fae2-c05d03e0cd2c@landley.net>
From:   chase rayfield <cusbrar1@gmail.com>
Date:   Mon, 11 Jan 2021 19:50:48 -0500
Message-ID: <CACwypyNVibQby75dZek=P1oBkcHQYMx-kbria9Y6NnBpERh+qQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Rob Landley <rob@landley.net>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

> Sparc has a runtime relocation I've never understood but did manage to break
> once, resulting in a long thread to fix:
>
> http://lists.landley.net/pipermail/aboriginal-landley.net/2011-December/001964.html
>
> Between that and the weird save half the stack register thing with function
> calls on some sort of "wheel"... there's a _reason_ I haven't been able to talk
> Rich into adding support for it to musl.
>
Register windowing, with parts of each window overlapping for function
arguments etc... you can kind of think of it as a ring buffer of
overlapping register files that's an oversimplification but it was
originally intended to accelerate and improve register file usage.
MIPS and the rest of the industry abandoned this for improved compile
time allocation. I think you might be more likely on MIPS to incur
more interrupt latency though since you have to spill to memory (at
least on MIPS contemporary to Sparc V8) instead of just switching
register windows mileage varies greatly.... From what I remember
overflowing the register file is implemented with hardware traps that
spill to memory etc... since you don't know that information at
compile time. on Sparc so yeah it's quite involved to understand and I
certainly don't grasp it fully. So on MIPS you spill the register file
to memory, on Sparc you spill register windows to memory... if you
have exceeded the supported call depth (which is rather expensive
since all the register windows go at once). Note spilling a single
variable within a register window is a separate issue.

Amazing, a link that actually works and is informative:
https://blogs.oracle.com/d/flush-register-windows


Chase
