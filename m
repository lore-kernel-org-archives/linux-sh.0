Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063FAC433DB
	for <linux-sh@archiver.kernel.org>; Tue, 12 Jan 2021 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B190F2312F
	for <linux-sh@archiver.kernel.org>; Tue, 12 Jan 2021 22:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436979AbhALWq7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 12 Jan 2021 17:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438429AbhALWq6 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 12 Jan 2021 17:46:58 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606CEC06179F
        for <linux-sh@vger.kernel.org>; Tue, 12 Jan 2021 14:46:18 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id p13so386567ljg.2
        for <linux-sh@vger.kernel.org>; Tue, 12 Jan 2021 14:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g5sjkYmyNIlLJA59o61REHb8AKH1ySCBTcd6TLDoHDc=;
        b=xk4F4JXWKJvoVpvkPcSF5eOSsKbrWU8dsBWmaz4aN0AbwvRerrH5HBxxf1LHNcBIGw
         QhkRj0JMG3aU9rPaPuRZAbObV5TkPpyUjtw9Atlzn4WvUP/tOd7Qvu3iEP6FF0YSPnjz
         yxorRvN3uiBmfI4ZHIvy5wSjUoAMzaKln49FJjB4+1y0WhrIgn+zw0LEFpuJAK1kOGjk
         r3xeX+Zii+h4Tl0n3Tz8DkUcXZWP93xTFyEmftDLFhsDxQfgncMphsP7ACU0SaSXAQHl
         J80ndUCEZfp2SvAiNRhNy8aBidHGFJ8u/EN1yXphTHrlSc+qcgh8Mv89Knes1Te+jiIv
         WBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g5sjkYmyNIlLJA59o61REHb8AKH1ySCBTcd6TLDoHDc=;
        b=ZD6dastad6D4hqjm/Li/q+VLV7MHN6vudfjl1Flpt2G2f93ykhRcclzz4/gm4H2KGW
         /ZUroFnXE/cFxWPxgXhzZTBa1mdvoNkNQwSPVkaZvPZOxMenQ0fJkQp+OARA7NkEQQtX
         BMvrso7rTlP5+GZ+SMnqXdbwtz3oQ8ciogJfHbpRG7ZHQusYgyWY70eCG9BoyBFdWbTh
         wy4Hy7xLxdhk8xBfN7oVx3mmkgKDqcj+Ibx/x9Hb0ifNRneb7fmkK3vuqn/c/OjFnAjq
         V2OePyFKXBAvH2gcYpE/evBalhJyPY0PXLVwc2csqz8yEYp+K+I/M+kFu/tRTMceSfth
         tGLg==
X-Gm-Message-State: AOAM531sZFNJoNyQU6wVwSl+VoFWM/Usc/eJA5to1DReQUOLINiEX4y8
        iyfR+ZphmdmWz2XUa/sQVdbkmWY2HZ7Wr87jvLJ6uQ==
X-Google-Smtp-Source: ABdhPJwB3XyCjodEyq4bELvSnFhLnKRKxthkfxIxeufYbeb5jjdzhJQrfu4eGAlRygt4g3EP31A/7cLluJ99FomQpIc=
X-Received: by 2002:a2e:586:: with SMTP id 128mr634078ljf.273.1610491576669;
 Tue, 12 Jan 2021 14:46:16 -0800 (PST)
MIME-Version: 1.0
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
In-Reply-To: <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Jan 2021 23:46:04 +0100
Message-ID: <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Gerhard Pircher <gerhard_pircher@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:

> Yeah, I have the same impression that's the strong commercial interest pu=
shes
> hobbyist use of the Linux kernel a bit down. A lot of these changes feel =
like
> they're motivated by corporate decisions.
>
> There has to be a healthy balance between hobbyist and commercial use. I =
understand
> that from a commercial point of view, it doesn't make much sense to run L=
inux
> on a 30-year-old computer. But it's a hobbyist project for many people an=
d hacking
> Linux stuff for these old machines has a very entertaining and educationa=
l factor.

This is actually one of the most interesting things written in this discuss=
ion.

I have both revamped and deleted subarchitectures in the ARM tree. We
never deleted anyone's pet project *unless* they were clearly unwilling to
work on it (such as simply testning new patches) and agreed that it will
not go on.

At multiple occasions I actually found it easier to fix stuff than
delete it, both because it is a nicer thing to do and because it
simply creates less social problems, often to the point that the time
(man hours) spent trying to solve the resulting social problems from
deleting a platform would be longer than the time spent actually acquiring
the physical platform and fixing it.

Corporate entities can be a bit deletionist (using Wikipedia terminology)
and as in this thread there is always a strong inclusionist stance pushing
back to that.

The explanation is in my mind very simply that running Linux
on a 35-yo or so Amiga, Atari or Apollo Workstation is pretty impressive an=
d
fun. And I think that fits Mr. Torvalds own sociological-or-something
explanation in the autobiographical "Just for fun" as to why to write it
in the first place. And we are very protective of that quality of the
kernel. (At least I am.)

That said there are a three things that people should really be doing if th=
ey
want to keep their pet archs/subarchs around as good community
members, and they are in essence to:

1. Test and review/ack patches that others make

2. Migrate existing drivers to newly appeared and
    appropriate subsystems (I think there are some hacky heartbeat LED
    drivers down in arch/* for example) there is also the feature matrix
    core maintainers like and which appears if you type
    Documentation/features/list-arch.sh <archname>
    would be nice if you work on them if you can support them!
    Or at least take a look.

3. Migrate old systems to use the
   contemporary hardware descriptions (such as device tree or ACPI)
   because it makes things so much easier to maintain. Some
   upfront work, but a great win for everyone. Especially for
   subsystem maintainers.

And if your arch uses highmem then please get rid of highmem. I'm
trying to do this a bit right now for ARM let's see how it goes.

I understand that for some maintainers time is a factor and this list
feels stressful. I'd say relax, but it'd be nice if you have a TODO that
you cross items off of.

Just my =E2=82=AC0.01
Linus Walleij
