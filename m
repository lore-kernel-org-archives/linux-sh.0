Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71181C433DB
	for <linux-sh@archiver.kernel.org>; Sun, 24 Jan 2021 10:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A02D227BF
	for <linux-sh@archiver.kernel.org>; Sun, 24 Jan 2021 10:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAXK5J (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 24 Jan 2021 05:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbhAXK4x (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Sun, 24 Jan 2021 05:56:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9A6D22CA2
        for <linux-sh@vger.kernel.org>; Sun, 24 Jan 2021 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611485772;
        bh=sXOYjWWJeZ3S2dFau4v3bbTo4aAn3WbPDjVTb2dxazY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IN9G0qZYYKXWUTUoFkfVEn8c3IMbjcom6GAVA75PuPax7YyS6Z8nxEqVZx9D1p3uz
         iYuAGgXS7SJE1wK+YerapOQF22pTI4ASxsI3iJzq3kf52DTwT6WFTIVNmzyVigd+vc
         jc54N0uDZiidtsQPEi439cKqkIHDfwTHJhkOEf/qDrGHNQ54le2hocwkMy6xkNl9+L
         mSJpiAWTl8QGuCV3NWOrdBquCKEX0sIRjftpyfSU/pmDpOMu6dxFUm0Y6Fh22F41AF
         iDBER3/1oeTRxj/EMj33A2oxQhC5EN8fGxG0D+9mIPQ4g6xW6LfwpXiXQA2h/Kp0Bq
         Uomjxvb2G3tKA==
Received: by mail-ot1-f54.google.com with SMTP id h14so9861364otr.4
        for <linux-sh@vger.kernel.org>; Sun, 24 Jan 2021 02:56:12 -0800 (PST)
X-Gm-Message-State: AOAM530THQw1TcSTwcUwKNdGQoUZpkPCl0OTSP0f2Re80JnKkrKKqGyF
        83j0w24nuNkpmhZYk1PMRAonZ40A/vq3U/84IPc=
X-Google-Smtp-Source: ABdhPJxduR7C2kimPVIdaxHqB5ts+HElAgiCncL7JEYNFVLwFGy8jimVm+VDJKxrCoGxP0belOTK9nZ0eCl62vJkB0Q=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr503604otk.210.1611485772024;
 Sun, 24 Jan 2021 02:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20210123165652.10884-1-geoffrey.legourrierec@gmail.com>
In-Reply-To: <20210123165652.10884-1-geoffrey.legourrierec@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 24 Jan 2021 11:55:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a30O6=0TeNJK1qq-k5gj-CXXaD=vvJqiHFSi8HVaurHzg@mail.gmail.com>
Message-ID: <CAK8P3a30O6=0TeNJK1qq-k5gj-CXXaD=vvJqiHFSi8HVaurHzg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use types.h and not time_types.h in sockios.h
To:     =?UTF-8?Q?Geoffrey_Le_Gourri=C3=A9rec?= 
        <geoffrey.legourrierec@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sat, Jan 23, 2021 at 5:56 PM Geoffrey Le Gourri=C3=A9rec
<geoffrey.legourrierec@gmail.com> wrote:
>
> I did a quick header dependency analysis starting from __kernel_time64_t
> (one of the offending types), but could "follow up" to linux/time_types.h
> as expected; so I fail to understand how this could break. What's even
> more confusing is linux/time_types.h includes linux/types.h itself.

Could you try producing a preprocessed version of the source file using 'gc=
c -E'
instead of 'gcc -c', using the same arguments as in the failing command?

The output of that should help pinpoint what is going wrong.

I'm fairly sure the patch you sent gets you back to the original problem:
Since it avoids including linux/time_types.h, the compiler no longer
sees the line that fails to build, but at the same time you can not
actually use the SIOCGSTAMP_OLD and SIOCGSTAMPNS_OLD
constants any more, as the structures will be undefined.

      Arnd
