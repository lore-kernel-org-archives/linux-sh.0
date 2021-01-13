Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB1FC433DB
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 10:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5E223122
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 10:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbhAMKk2 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbhAMKk2 (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Wed, 13 Jan 2021 05:40:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9707A233A2;
        Wed, 13 Jan 2021 10:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610534387;
        bh=4XG7y1VBPGl7jG0P2w9EDswQ9VedSZfg2eDSLDFC8CM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HxIK66UO9a/QH8CSj9DjuHrgi8ATLCtowiKjTb3wHq/GtvxkE7W4nCS6ADOgX+cm4
         Tj5BJZp3WZ1n4r+EqXfIyOVqHf27m2xIoYMuFU5TXBl0WA0f6cVY0KL6eSHImKjxyj
         GgZDTpUoyyRsX5NZSds1AuiCd93AxvYPsody/xngFSDxcLyzAIhRBgpP1XlB/lk/Sv
         h0Zq1foFu+6qecQ6OWAfA91m8H6DgxT8218OJu75mJfUvK8qaTqHpJ69a531Nnmxh/
         VpT+iZChdWp4WmX+v9AUBLvPG0JA4YEmXEuXfRqob0N8iaz1aJUgym5WJ4semSaBGc
         1xY4c44auJrQA==
Received: by mail-ot1-f48.google.com with SMTP id q25so1424018otn.10;
        Wed, 13 Jan 2021 02:39:47 -0800 (PST)
X-Gm-Message-State: AOAM531iZmRpLyqepimdYsitff8WOOtJNTTegHBA1u/RrPiFe9gFw/jx
        DPz3omOX7HF33JqWesqNbd+D4b76QVWbd4Hfh3Y=
X-Google-Smtp-Source: ABdhPJxAcIgx9kT+7MQRw8jch2NBgw6/I/5Hq0Yvch2nwTkrg84SnU3bFvE4E1ecVMrPTxEfUWq9LY1jxHYyFJN828c=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr765480otr.210.1610534386762;
 Wed, 13 Jan 2021 02:39:46 -0800 (PST)
MIME-Version: 1.0
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
In-Reply-To: <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 13 Jan 2021 11:39:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3hKSVXZEjQEbkOLhtAO0oR0+UP1dL10S3jQM72EsmsWA@mail.gmail.com>
Message-ID: <CAK8P3a3hKSVXZEjQEbkOLhtAO0oR0+UP1dL10S3jQM72EsmsWA@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Gerhard Pircher <gerhard_pircher@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Jan 12, 2021 at 11:46 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>
> > Yeah, I have the same impression that's the strong commercial interest pushes
> > hobbyist use of the Linux kernel a bit down. A lot of these changes feel like
> > they're motivated by corporate decisions.
> >
> > There has to be a healthy balance between hobbyist and commercial use. I understand
> > that from a commercial point of view, it doesn't make much sense to run Linux
> > on a 30-year-old computer. But it's a hobbyist project for many people and hacking
> > Linux stuff for these old machines has a very entertaining and educational factor.
>
> This is actually one of the most interesting things written in this discussion.
>
> I have both revamped and deleted subarchitectures in the ARM tree. We
> never deleted anyone's pet project *unless* they were clearly unwilling to
> work on it (such as simply testning new patches) and agreed that it will
> not go on.
>
> At multiple occasions I actually found it easier to fix stuff than
> delete it, both because it is a nicer thing to do and because it
> simply creates less social problems, often to the point that the time
> (man hours) spent trying to solve the resulting social problems from
> deleting a platform would be longer than the time spent actually acquiring
> the physical platform and fixing it.
>
> Corporate entities can be a bit deletionist (using Wikipedia terminology)
> and as in this thread there is always a strong inclusionist stance pushing
> back to that.

It's usually one of two things that happened before a platform gets
deleted for good:

* The platform port was (almost) exclusively done by one company
   with a commercial interest in it, and the company shifts its priorities
   for some reason (acquisition, bankruptcy, product cancellation,
   accidentally laying off all competent developers, ...) that causes it to
   stop working on it. Sometimes the previously paid maintainers
   keep up their upstream position, but without someone pushing the
   last missing bits into an official release, users are stuck on an old
   BSP kernel.

* A platform port is done in the open and actually works for upstream
  users, but over time the last active maintainers move on in their
  lives. Complex platforms inevitably break when a treewide change
  goes wrong, so we rely on users that are able to bisect and report
  bugs when they happen. After a platform has been broken for
  too long, even competent users may decide to just give up and
  stay on their last working kernel. Some of these platforms eventually
  recover when a new maintainer steps up or someone discovers they
  depend on newer kernels for products, but after a few years it's
  usually beyond repair.

      Arnd
