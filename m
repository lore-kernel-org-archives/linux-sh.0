Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68897C77B73
	for <linux-sh@archiver.kernel.org>; Wed, 19 Apr 2023 11:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjDSL2K (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 19 Apr 2023 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjDSL2J (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 19 Apr 2023 07:28:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF54225
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 04:28:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sz19so23702054ejc.2
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1681903685; x=1684495685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N99yfKqkNg/PzVluqPrnuo7/UXaVkUZ4pARZeRWAW0=;
        b=h+3Tomy+fZrVXH6RN/babMfjC3kI4c/tjjs+upF4u2X/jkiM2Y88CL0+Ndyv402wRA
         ZN8jK2RJQPiW1OrNQGOz0lJxhdDo0VxjNTL6Wi/rxTAXStbwCZ3oB5IF1CRRLFVGQxbQ
         T9gYcbmXuvxaBPI1B259kNHR7vtJA9q3ZKhrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681903685; x=1684495685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8N99yfKqkNg/PzVluqPrnuo7/UXaVkUZ4pARZeRWAW0=;
        b=N3ffGrz8KwmX5T1DB6+tI0u3KJHfHCxK3a4MA/eNYzjYGHLAs/fh7+ZQ9Sso8yUgJy
         NLtq9OmOJBK8mDjn9YmZfd/DoGmeBj9HMBmOZ9sLg7tL8fl/7A6ASLpzwoMrCbCbwpcp
         LfZNYAn2LI4iTY/TsmvO6PNrnxBNUjwfmlrNpKWtcZjNUYvqcLUtC0FgsZgUC2TnbD3F
         A0Uect1eR4Wjch4diHZhXqioV0OIVa90jw92nP+2yvqeC7PapqbKdSPO6Wui7R407LHn
         iwWFfFo59K4nyBtxpddOXhXCjbkEI1tl1LJjbkdkmtgg/BqYbx1DKJWBIy7vDnguFKEP
         SOVQ==
X-Gm-Message-State: AAQBX9f8NEXkaBR5VoxX7vMDwoDjedC2F9RBkJ3J4/xtorXzI1XPl11p
        7z4Bl/lhkCFHFNOu5uTbGRPSQTiq4kvxuDpjW2eG+sif
X-Google-Smtp-Source: AKy350bjrWU5Ysaiz3CJ73Q+g4hS1Mx6WhhaXRo0ZFWsO9FZ4wrjvs3xX6g0r/hql9FtB/KgkR8B+w==
X-Received: by 2002:a17:906:3ce9:b0:947:c8d5:fb2a with SMTP id d9-20020a1709063ce900b00947c8d5fb2amr18483495ejh.48.1681903685135;
        Wed, 19 Apr 2023 04:28:05 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id m5-20020aa7c2c5000000b00506987c5c71sm4827611edp.70.2023.04.19.04.28.04
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:28:04 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-506c04dd879so1149145a12.3
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 04:28:04 -0700 (PDT)
X-Received: by 2002:a2e:7012:0:b0:2a5:fe8f:b314 with SMTP id
 l18-20020a2e7012000000b002a5fe8fb314mr1874851ljc.5.1681903663880; Wed, 19 Apr
 2023 04:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230325060828.2662773-1-rppt@kernel.org> <20230325060828.2662773-3-rppt@kernel.org>
 <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
 <ZCvQGJzdED+An8an@kernel.org> <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
 <ZDbp7LAHES3YFo30@arm.com> <20230418150557.ea8c87c96ec64c899c88ab08@linux-foundation.org>
 <ZD/K+Mof/Dx5yzjQ@arm.com>
In-Reply-To: <ZD/K+Mof/Dx5yzjQ@arm.com>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Wed, 19 Apr 2023 06:27:31 -0500
X-Gmail-Original-Message-ID: <CAFbkSA3yn_4Monrnk2u3CzfJ934Hy15rjAJ85AdFU40nV7KTkQ@mail.gmail.com>
Message-ID: <CAFbkSA3yn_4Monrnk2u3CzfJ934Hy15rjAJ85AdFU40nV7KTkQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Apr 19, 2023 at 6:12=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Tue, Apr 18, 2023 at 03:05:57PM -0700, Andrew Morton wrote:
> > On Wed, 12 Apr 2023 18:27:08 +0100 Catalin Marinas <catalin.marinas@arm=
.com> wrote:
> > > > It sounds nice in theory. In practice. EXPERT hides too much. When =
you
> > > > flip expert, you expose over a 175ish new config options which are
> > > > hidden behind EXPERT.  You don't have to know what you are doing ju=
st
> > > > with the MAX_ORDER, but a whole bunch more as well.  If everyone we=
re
> > > > already running 10, this might be less of a problem. At least Fedor=
a
> > > > and RHEL are running 13 for 4K pages on aarch64. This was not some
> > > > accidental choice, we had to carry a patch to even allow it for a
> > > > while.  If this does go in as is, we will likely just carry a patch=
 to
> > > > remove the "if EXPERT", but that is a bit of a disservice to users =
who
> > > > might be trying to debug something else upstream, bisecting upstrea=
m
> > > > kernels or testing a patch.  In those cases, people tend to use
> > > > pristine upstream sources without distro patches to verify, and the=
y
> > > > tend to use their existing configs. With this change, their MAX_ORD=
ER
> > > > will drop to 10 from 13 silently.   That can look like a different
> > > > issue enough to ruin a bisect or have them give bad feedback on a
> > > > patch because it introduces a "regression" which is not a regressio=
n
> > > > at all, but a config change they couldn't see.
> > >
> > > If we remove EXPERT (as prior to this patch), I'd rather keep the ran=
ges
> > > and avoid having to explain to people why some random MAX_ORDER doesn=
't
> > > build (keeping the range would also make sense for randconfig, not su=
re
> > > we got to any conclusion there).
> >
> > Well this doesn't seem to have got anywhere.  I think I'll send the
> > patchset into Linus for the next merge window as-is.  Please let's take
> > a look at this Kconfig presentation issue during the following -rc
> > cycle.
>
> That's fine by me. I have a slight preference to drop EXPERT and keep
> the ranges in, especially if it affects current distro kernels. Debian
> seems to enable EXPERT already in their arm64 kernel config but I'm not
> sure about the Fedora or other distro kernels. If they don't, we can
> fix/revert this Kconfig entry once the merging window is closed.

Fedora and RHEL do not enable EXPERT already.

Justin
