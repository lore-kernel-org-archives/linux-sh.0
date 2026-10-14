Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06355616A7
	for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996274; cv=pass; b=kixDuwTkzJ2zelRiaDaMjsR2mESJfyadHVEJJf2hd4Jpo0mHF9MgjQ6ouCPDbTl5Wkdxr0GEnZj8Ii5oWDFXG94ey2fSCm7KT0PffWJbO0aegbGWcYb6nz/QJ9nNsru3holXNYp4SmKW5RgpOKAkowTgP7O4nW9qC+wjEDJfXc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996274; c=relaxed/simple;
	bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBDomy56JEj/XYTvkoab6gapc5MTyaHl2+H8UD3EJi86JVzxmOxNMAUYGAqrBlhaj30CNaDYcwv2RTJXSJE0j/11xITf9XmsZsVBOMZF1hmkMXXe2gK+rBg7mZFjGrFZ5uOnb0ZICl+iJIdITfWrG8xtxYaLB3vwPEmisJSk0LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG5LMeCX; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG5LMeCX"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33e623bd651so514497eec.0
        for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 09:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996272; cv=none;
        d=google.com; s=arc-20260327;
        b=pHSvDuhOpyObnO/sAiXHt6ClyTEl9xh5o1H34+eWA1/vFH2LB8KwcrIl/jCdHqLm6b
         7dBOy9iTIPcM99CJbh/593KJduYeORy8FmgUfmMXwqZtO1bJBUgf8XB1V1IaqUYXsnVj
         c7u9YhQazqn80SI2kYKb6kQU5vP5pZmWoSbQTxr4cT2CGJN0Z8ywv2kRQ89XGiCpa0+U
         bLrKOOVHTEpd9SOcD6sw0B+oKFV+ATUBApr+/bSOEYZgMAH/Sj8dHhZGwevcC4F4bwhj
         GXMMyPF4mfyjD91PUdZhvXmHyK7AAa/n4sQt+uqfyIIVX2T4XkrH8wfLZhC0N9UJu9nR
         CQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        fh=dpC1HEAQBoQnx+1lqDsEoQOsspDjS2m6ILuN0rRrRFE=;
        b=NPAIYtmqJry6ZOdQKdLWu/R4Z7qnIp6s0IEb1kzKWZuL6tELm0OL54vGzoNKKW4jml
         KfjVARfXpbBn8MUivi3G0WVrBTIof06vMlv63Wh5pb/UcMyFlkmp8k9dTvDxnKDKezal
         ipM/i49PuUjelrRtX3StPngn06Ukn1s9aDVUgfGSFzSGf1IZ9xFWuoi82wKz5D3C1d98
         HcY09VfSbzhvSS7hFeuQHJfhpNFRhntHSod5GMFr/Qiwo6HxHPdCfwd6WMd9sWYKRkHd
         bGOCLefOs2OcRpprGHQwQexv9UV4S5gmpsfou9qH8DD65oaZNCwl5vgENJjnfH2l14O4
         jEXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791996272; x=1792601072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=dG5LMeCXSiSbpubk/BTMkvWJ2dvIK7jFfkGhSVKuiPvEccVQI9eRP/pY4aiG8kSDk8
         sybScDEKYa9pUjoob3fVfnbNdFtdkBXsSjpfjP+bPyBK5Chd00x6HJJ7X+HteLAY7JfU
         o4429zXiiE7e1UOccLBxgzcZh+G/nI2B8bjb9YKWi7iAEGL16Iblz9B6MpdkbUl3G+Fk
         3lPFokI++jDRZ0Cwvj1/64bOOygK5BR8VGYFxRHD7siF53FrkARVocKqUOcShcj0hkn2
         gYiKlI7ykCQvFk94TVoBL/XLbOsKN6gefpMbeBOS/eufSnZP21bV5ckiClL1WUdGnm6v
         +u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996272; x=1792601072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=S4v4OknWML8Xho++DwhFEcpGFQV/88MOk68yE8NjjoNsUkjkTp3igKXNnilW56b/AF
         fSuLfuvKNTQWA8Ht0+ESYwYkQ5Qw3YBtazu/uxZz+1GhNemWZ5gql0yq5UioMOSuIHPc
         CQUDR1cqJ1BV/0ojd0bVQfdlSzb6XcDGzmLDFJg1EF8skdSU1QGgtfOKsVoEdw6L7590
         Xs9OfhHIr1uu9xhMaK5HLmbnwtd3+2/+SdFdawH4DO6bz7dmWoce3rg/wsfI2K3SsXAK
         +WpDejckdkARuUD8cz8FlVOilYT40pdOBZCt5adYUR2kkQdFHKrv4DQIFutIzhlFRjBv
         aB7w==
X-Forwarded-Encrypted: i=1; AKwUvBzR1P8oWf78Qrqo2VUMvuHtulV4vuzU0GvPDDFcmIaIUv7pDT/7pJ0a8Hb6Oo8+0FCMuyzd/BGB8A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKgSO5ny4WGHCLhcV9Yr7pgzoTHIaHbFfFr82YsozTQ9Au3gxSp
	hE8okvvvNKwnLtpnBHM8ijonKSp3oiWLnP5pbdtgVj4QoqMOD6dGCHPgrwYiltlc3CIiYYQGTWu
	ggQIdsV3sXUCQ0P+fwa3IwqXVfYd+OUo=
X-Gm-Gg: AYBFou2HgDVFKelm9/BeVJS+8CK51peA/A1Fx3ndhorlxBJMdwR/5RpWdrX8y1lKTkj
	sxPwjVnQxMXRWZdo+JySK02zXiMZyByuJuzbBWXreVWiC4DrzA4dP3yJWGcYvpgXYhYkfyT/WHg
	7IAxYnxwGzNhcTzJpL8D9hskI4xWcDWDPPuWmjQwRzw4vsJEs/ZvPM4T3znLg+9f4FIFWWvQn8O
	KFaVU/JnFm/jPyz/bw2hDMeYrGS0Sbqc4JAYCWvFX5Aod8yKMOyjkH2t6KtV61cE+Tg87tdfHz2
	x+ZRRjUx5Zbc+683LvX7irI50GPQiIpkr2URGZ5DSHgV5TKFZjY4kE+u2/XdoSdHMI3EAg5ya63
	9C2f6swfBhK1i5bs2kr1Q5rT0eEa3RPDvLHv5e6AyDrwJc3/B6uqPJvK29KrxltZMABB+Jciw/j
	jEswmn8e4urwLNu80v60xKwKO/Hi7fzuTqJgaGmrBEMj242ysrqPI=
X-Received: by 2002:a05:7301:5413:b0:358:c9f3:b055 with SMTP id
 5a478bee46e88-358c9f3b260mr28158500eec.1.1791996271702; Wed, 14 Oct 2026
 09:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 18:44:18 +0200
X-Gm-Features: AclHuK_d31yoge0njHjovdIQh7JfJY6W-PLjzMLBq14NjY-schAqigzEJUAQwG8
Message-ID: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

Of course, please feel free to pick it up (with the small tweak I
requested) if you have a user.

And if you don't pick the user, I could still pick the first patch up
through the compiler attributes tree if you and other folks want to
use it after -rc1.

Greg: adding the attribute itself should be safe and would unblock
others that may want to "protect" themselves, without having to wait
for every potential user to get fixed (but of course I agree they
should get fixed -- we should not forget about them, if that is your
concern).

Cheers,
Miguel
