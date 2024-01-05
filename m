Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D722EE6
	for <linux-sh@vger.kernel.org>; Fri,  5 Jan 2024 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e745891a69so13482907b3.2
        for <linux-sh@vger.kernel.org>; Fri, 05 Jan 2024 01:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704446012; x=1705050812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+lpnBDaDmZh9hYlPdWVI3VgnOiKs6ssQbDJtTiE9Hk=;
        b=evbeybzypkeufw3sXeJgVrNSMZ/fLs59Q68lY65XzsxjYsVy16EU3axj4hS5OHEF80
         2EMd8Ek0g9MmmIO+M0+re1V0nuaj2/r83Mo+GGZpUVOa2bBwUwuCmP2DgDMXRZKpmk2h
         ZvN40PxQZ5WjDdx+cKjAbLky9O9j62J7uAKVnrDIKNTfN1sa7rLa2iPEV/h4CHhpTlGk
         yZHff5cE3dPTscJtsPmoUl4lVger7tJbqGheoVuiiy79n6L5j/+1UYnvY2VU+RqqE8r9
         eKQz525BhGPe6zKxi07XphfltfXFwY2J7lDV1jWRXfcD2n9gInT9UOY1J/FB04m4/AIJ
         F0jA==
X-Gm-Message-State: AOJu0YzTZC+kkNcw21CPS7eKZbqFh0GeySX0oBCE+YO6KGO/yun3Ho5z
	r8p1kIpeLK136pciNTwvad3YRW1moQFazg==
X-Google-Smtp-Source: AGHT+IGuLYPSUJltUQoPy4vR/8Jt+VhjMHoZbMDvXQDCfdNur6M/oNVQJhRmcZgAugCuqFvXuYWBWw==
X-Received: by 2002:a25:2e07:0:b0:dbd:4dd8:427b with SMTP id u7-20020a252e07000000b00dbd4dd8427bmr1550824ybu.81.1704446012616;
        Fri, 05 Jan 2024 01:13:32 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id j143-20020a25d295000000b00dbe9ee7be15sm333688ybg.14.2024.01.05.01.13.32
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 01:13:32 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e745891a69so13482817b3.2
        for <linux-sh@vger.kernel.org>; Fri, 05 Jan 2024 01:13:32 -0800 (PST)
X-Received: by 2002:a0d:e385:0:b0:5ed:c874:dcea with SMTP id
 m127-20020a0de385000000b005edc874dceamr1932813ywe.24.1704446012129; Fri, 05
 Jan 2024 01:13:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024010439-cauterize-trash-b603@gregkh> <7bdec121c0ce916f4589dd4247f9482704373aee.camel@physik.fu-berlin.de>
 <2024010406-country-entire-262d@gregkh> <810666aa13f5309d52d47109d20c4cf511a628e7.camel@physik.fu-berlin.de>
 <2024010428-crank-snap-8ff8@gregkh> <8652ad54d8d15dbb52f8feec69bde939409ae18c.camel@physik.fu-berlin.de>
 <CAMuHMdW6rhSBD2JQrS6nE=3xEQk7nCJW-TEH8Nw64BPtjzoqEQ@mail.gmail.com> <33944cd25cbeb4f9d88ebf81f3b0cb8d368f742b.camel@physik.fu-berlin.de>
In-Reply-To: <33944cd25cbeb4f9d88ebf81f3b0cb8d368f742b.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jan 2024 10:13:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=sCNZ2KdSb8B66wYYbNMjNEm6quRRbVMZVRVJ3npJ9A@mail.gmail.com>
Message-ID: <CAMuHMdV=sCNZ2KdSb8B66wYYbNMjNEm6quRRbVMZVRVJ3npJ9A@mail.gmail.com>
Subject: Re: patch "maple: make maple_bus_type static and const" added to char-misc-testing
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, dalias@libc.org, linux-sh@vger.kernel.org, 
	ysato@users.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Thu, Jan 4, 2024 at 7:44=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2024-01-04 at 17:01 +0100, Geert Uytterhoeven wrote:
> > > I don't understand the hurry.
> >
> > You really should aim to have your for-next branch ready by rc7, so
> > testers can find and report most issues, and you can get them fixed,
> > before the merge window opens.
>
> Do testers not go on holiday vacations? I was just on vacation for two
> weeks and I find it irritating that my work is now overridden because
> of that.

Everybody goes on holidays, once in a while.

But, you are unhappy about Linus Torvalds announcing during your
holidays that there would be an extra rc, postponing the merge window
by one week? And without this postponing you would have missed the
merge window for sure, so this delay is actually beneficial to you?

The merge window is the period when Linus Torvalds merges new
developments for the next kernel release.
The merge window is not the period when maintainers review and collect
new developments for the next kernel release.

If you are on holidays just before or during the merge window, you
should prepare your branches, and send pull requests, before the merge
window opens.  Several maintainers have already sent pull requests
(the first arrived almost 2 weeks ago).

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
