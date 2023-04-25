Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F55CC77B61
	for <linux-sh@archiver.kernel.org>; Tue, 25 Apr 2023 16:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjDYQKt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjDYQKr (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 25 Apr 2023 12:10:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13BE16197
        for <linux-sh@vger.kernel.org>; Tue, 25 Apr 2023 09:10:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2aa39ce5d26so50464111fa.1
        for <linux-sh@vger.kernel.org>; Tue, 25 Apr 2023 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1682439033; x=1685031033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzBCWhkUry18zVOWXW5QyNYiFJMq+EJv8KjCsvLzxVI=;
        b=QMkIWwlSa1dFqjZNAvY1XABYARSvvJqstr6B3FBYxnYeEZbMDFWIcbcX289rr+ND5z
         ZQJCn1lqGn87wlPR/gIR1F+JWxMSOcLRF2PDHJ6MJTwRrd7AutqRm+TTOaEeBT3sRMYQ
         yzPmvWLbEoY0UXf2J2QHnMJHIPXTROKg9jOH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682439033; x=1685031033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzBCWhkUry18zVOWXW5QyNYiFJMq+EJv8KjCsvLzxVI=;
        b=Oqsg82B/M5MbNQzd4WfK8muIinik1J1C7sMzhAr4vlEEk7Wyz60OhpsWCQvub91Us6
         dsq4C5dDcadSBBdjlqpiNlNmL72tw25tOkP6ZV73GwuHKbby8CpZt7wN0Ayfyzk3YkJp
         hAh9czLr7rIq2AAR9zA952ltTh05Z84T88Bf1vfdFKZLeo4SHUtb6gNuY4wLtCjowqhp
         tLJBZj5y7XQKCvWnTn9f75AoVsebJ2C44a6BwfKuRP72WQwFpvdm0sqaaLcJr+cJSQrR
         stAVyk3PBqrr0a1tOe53No19FKlp+0eZEX9AGtr9I2FsL4Ws1na80v2HAKpe6wsVHCqi
         +2HA==
X-Gm-Message-State: AAQBX9dXoJM2jC/K8vOU9P8Rdwn3ZDvtTRiHZwg16KVqccSTUhlU9O6c
        thpVYWCK1RIWbE3QdGUG00004WDzDnSXUrnDRfbZjzoq
X-Google-Smtp-Source: AKy350ZOZ/yZ7B6fMyOxlP9ychViPWdg1WR/+cHqdfssZw7yKyps+lDXsK5UF1hjvDF/PSmNcDaRRg==
X-Received: by 2002:a2e:7003:0:b0:2a8:d3bb:2d83 with SMTP id l3-20020a2e7003000000b002a8d3bb2d83mr3283548ljc.42.1682439032930;
        Tue, 25 Apr 2023 09:10:32 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8455000000b002a8e8c776e9sm2147654ljh.56.2023.04.25.09.10.31
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 09:10:32 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4efefbd2c5eso3191180e87.0
        for <linux-sh@vger.kernel.org>; Tue, 25 Apr 2023 09:10:31 -0700 (PDT)
X-Received: by 2002:a05:6512:145:b0:4d7:44c9:9f4c with SMTP id
 m5-20020a056512014500b004d744c99f4cmr4233943lfo.4.1682439010843; Tue, 25 Apr
 2023 09:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230325060828.2662773-1-rppt@kernel.org> <20230325060828.2662773-3-rppt@kernel.org>
 <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
 <ZCvQGJzdED+An8an@kernel.org> <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
 <ZDbp7LAHES3YFo30@arm.com> <20230418150557.ea8c87c96ec64c899c88ab08@linux-foundation.org>
In-Reply-To: <20230418150557.ea8c87c96ec64c899c88ab08@linux-foundation.org>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Tue, 25 Apr 2023 11:09:58 -0500
X-Gmail-Original-Message-ID: <CAFbkSA2hU+2V0i5OG0BBD-s3yNOAZwBmyGmxMLkbzoWZK6cxOQ@mail.gmail.com>
Message-ID: <CAFbkSA2hU+2V0i5OG0BBD-s3yNOAZwBmyGmxMLkbzoWZK6cxOQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Apr 18, 2023 at 5:22=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 12 Apr 2023 18:27:08 +0100 Catalin Marinas <catalin.marinas@arm.c=
om> wrote:
>
> > > It sounds nice in theory. In practice. EXPERT hides too much. When yo=
u
> > > flip expert, you expose over a 175ish new config options which are
> > > hidden behind EXPERT.  You don't have to know what you are doing just
> > > with the MAX_ORDER, but a whole bunch more as well.  If everyone were
> > > already running 10, this might be less of a problem. At least Fedora
> > > and RHEL are running 13 for 4K pages on aarch64. This was not some
> > > accidental choice, we had to carry a patch to even allow it for a
> > > while.  If this does go in as is, we will likely just carry a patch t=
o
> > > remove the "if EXPERT", but that is a bit of a disservice to users wh=
o
> > > might be trying to debug something else upstream, bisecting upstream
> > > kernels or testing a patch.  In those cases, people tend to use
> > > pristine upstream sources without distro patches to verify, and they
> > > tend to use their existing configs. With this change, their MAX_ORDER
> > > will drop to 10 from 13 silently.   That can look like a different
> > > issue enough to ruin a bisect or have them give bad feedback on a
> > > patch because it introduces a "regression" which is not a regression
> > > at all, but a config change they couldn't see.
> >
> > If we remove EXPERT (as prior to this patch), I'd rather keep the range=
s
> > and avoid having to explain to people why some random MAX_ORDER doesn't
> > build (keeping the range would also make sense for randconfig, not sure
> > we got to any conclusion there).
>
> Well this doesn't seem to have got anywhere.  I think I'll send the
> patchset into Linus for the next merge window as-is.  Please let's take
> a look at this Kconfig presentation issue during the following -rc
> cycle.

Well, I am very sorry to see this going in as is.  It will silently
change people building with oldconfig, and anyone not paying attention
will not notice until an issue is hit where "it worked before, and my
config hasn't changed".  If EXPERT is unset, there is no notification,
just a changed behavior.  While it would be easy for me to carry a
patch dropping the if EXPERT, it will not help any users building on
upstream with our configs, whether for their own regular use, or while
trying to debug other issues,  I expect it will result in a reasonable
amount of frustration from users trying to do the right thing and
bisect or test patches upstream.

Justin
