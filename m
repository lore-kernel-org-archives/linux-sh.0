Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795653033DF
	for <linux-sh@vger.kernel.org>; Fri, 24 Apr 2026 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015985; cv=none; b=t+ifOx5nZ9UC159Ed/dOKyipHkrBZdV1zusRVeEkeNyF41NVK1DPAWPcpj9OXVdePePClJDFYi4CvslRhpm9QPZiiXd6EDFIT/XCm/TDUE3bz9DUjrK4tBBd2FIjiVODDoi01sVqyf2xIrtJVQAmbGZnqUUNtZyIZKtcrkiTtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015985; c=relaxed/simple;
	bh=OwiB5xL70HUG2XBD1Qstzuk6LTv1Ph8boI/7kSdoh18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNcQNFrKhryKWOooFZxbsjmALlj1B7XeUqdrJvqzpGDaDJwPC18SoXZTsmc3OH/KPld1m640uoFgGxguzoO/95AgQub5gTxG/fppKNYILh/e41VdLSyZzkesQ9bGhWy8dO9ZiuflwPdo41BUyhVm5U0hYUNvmX0tOgYe5pvOTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56e91f17a99so4890715e0c.3
        for <linux-sh@vger.kernel.org>; Fri, 24 Apr 2026 00:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777015983; x=1777620783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtsbXOcyL1ibQALxU6C+oQAYrNmZZMuQ00aeNmrTt40=;
        b=ZVbHeN+JjxR391WfNRCQLF7BizACEI5jGQUsuoiztB18dBmqLy7ccUbPNSg9YKgNr6
         QBEB/wZe78g+1zDCgL43WOa6NoR4aiwmtJ4Nji0lrMsidOmL9cPRo2ZLobfoLv6Rfxm4
         i8PcNbA0YxnDm9ZWHF8bXox+E0jp72mu7Y/A2N1ikW3aAYHal8cBfJh6B8Z3RmhUEA9g
         88Pj+ymZWSREoKUAFBh+o6SLVgVQZ/a55ZUZvxe4mq8kybS410Kgrq1rQTCc6UnJMLLs
         YolTyVzBJQ1swwLb7Tng3dYeT7k5tI5hcGlPdBCy0DNTw74/XQofKrkP6CCy3dYDYoay
         Pi2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ZSjEGs3Knyy1Y7dqLejLCnm7Pn6vF26QB1YbJ3rGyIoGTyNwui7yJvZZUH7H2zP4gN6byXwRvZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyPGq8Xzv75A34MtbzbblpQsu73o0R29ez9+9DuKQGjN1Taag
	P8ItiNVIMYMZZbKT8jZxoZuSeIv367tUkjGlM/uK6w5QKsWqS9Kyo9j6erV9XwyKYmc=
X-Gm-Gg: AeBDieu9wlXuAvoP+gtJScpPbDP9cT1xqC0XIbcCHAQ6qYXa3Kk35KIF+4iuUleTssR
	cal0BY3dK9/rcqSLTufcmmkwi7kdEuNFHog4+7pOgdFvVHwvxPgJ6diesRoydR7dinScu3idJ+U
	3ld1zB8W1F8JWUBpHgl7OLwJMHTV0YQnT1OosWUqTb0wD6THyzhfJDL7344coVq4cG12WbEg2hi
	W3qWqH6C/GSon07B3pIDRdXxqyBJL8UUpIcOV2U3jT9mZ1/XUY/NVBS/a/utE8EDraSNjMDQkcR
	8xNWDgrcXcf8XwLDCbb6FeY9Bxsy9+8uq6bqeE4KUey0DOXOIO6tIIc6evB4F/bwkCb9JYqcAvc
	sDTSBAV/pm7NYFUjIp1vjYsu1cMHYJWJ2osux/p3AoSMrTWCOpjPoN4Fr3XrxSeK9zPi24qq0i+
	kwfi7aYfLcyhsN6xwyxeeaEFR5g4o3Jw5Vhn0i1EZ0Fazs0R7q11EGHEBiwQG/71Is0KuE9Fs=
X-Received: by 2002:a05:6122:4d08:b0:56a:f34d:f225 with SMTP id 71dfb90a1353d-56fa59d6e92mr17356885e0c.11.1777015983388;
        Fri, 24 Apr 2026 00:33:03 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91ed4e1sm14203541e0c.6.2026.04.24.00.32.59
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 00:33:00 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-605a3cff8d0so4550912137.3
        for <linux-sh@vger.kernel.org>; Fri, 24 Apr 2026 00:32:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/JirUtxGH6ekRlQzrCD/fUSoYfAZDJyr158N7SNSn88U0cbeLaykyoEaIs86L0Vu87RR6xausxbw==@vger.kernel.org
X-Received: by 2002:a05:6102:5801:b0:614:bef5:637c with SMTP id
 ada2fe7eead31-616f142f347mr16348590137.0.1777015979297; Fri, 24 Apr 2026
 00:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
 <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>
 <20260415144722.GB74178@macsyma-wired.lan> <f48c40f6-ae26-d16b-5332-554042cd85fa@kolla.no>
In-Reply-To: <f48c40f6-ae26-d16b-5332-554042cd85fa@kolla.no>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2026 09:32:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVouMXAvV-7xqSyCGYGjecoXp0dbZJc71ydTk1ZVjQFAw@mail.gmail.com>
X-Gm-Features: AQROBzCmvllIMxekOPEHB5GfKFLONKLmj3_0tjYr_UBw_DXckSWhX6-rJTkq5-Y
Message-ID: <CAMuHMdVouMXAvV-7xqSyCGYGjecoXp0dbZJc71ydTk1ZVjQFAw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Should we make inode->i_ino a u64?
To: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-m68k@kolla.no>
Cc: Theodore Tso <tytso@mit.edu>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-m68k <linux-m68k@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kolbj=C3=B8rn,

On Fri, 24 Apr 2026 at 08:46, Kolbj=C3=B8rn Barmen <linux-m68k@kolla.no> wr=
ote:
> On Wed, 15 Apr 2026, Theodore Tso wrote:
> > Like Debian, the Linux kernel development community is very much a
> > do-ocracy --- only more so.  If the 32-bit community really cares about
> > Linux support, they need to be providing volunteer labor to kernel
> > development, instead of demanding that everyone else pay the overhead
> > tax of supporting 32-bit platforms which are rapidly disappearing.
>
> This tells me that it is time for "the 32-bit community" (wtf) to either
> look elsewhere, or start thinking of forking the Linux kernel perhaps
> sooner rather than later, so we don't bother "the 64-bit community" so
> much.
>
> > I will note that Debian itself has made the decision to stop supporting
> > the Debian Installer for i386 and the 32-bit armel platform in Debian T=
rixie.

Note "armel", not "armhf".

> Which is why (for example) Raspberry Pi is maintaining their own Raspberr=
y Pi OS,
> as they have 32-bit systems that aren't EOL for another 3-4 years.

https://lwn.net/Articles/1051010/:
"In 204x, support for the last 32-bit architectures would be removed."

However, by then they will have all run out of memory.
E.g. we recently got 64 (128 on 64-bit) KiB of "gaps", cfr.
https://lore.kernel.org/all/20260415190454.2632348-1-geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
