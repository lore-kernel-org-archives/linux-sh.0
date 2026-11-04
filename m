Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793752864;
	b=bbSK+1gb97l8tI3iiRJRWW0U4YQjknnf3xntHGHF8waDtna/puTVcqWHhPNUSWAt6EFt
	 rFaTyyz0U7A+QCujiEt7BJb9AwsH1+9SW5aS+GGovu18yJeb/bgYlj2W5TB7UfBuIpbgP
	 uIkBirMvOHOHi9/pOVx//FNwULuBZyJQVZxKWYlWzNtMjKOe/QKli9td4JGNinP/PH+/9
	 Yhd/5obfWQNmiO7TRS+52WSPBe7SrCVpK6jl+fqwXRd6J/xjJFbdHYwvq466oh5Y3qa66
	 57TPHutHlndF1iDMSskljOFk7wwwHPrvolxUw9eGAphedQPb0GHK1rQkCOvZqovxaFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
	b=2VRjvdDgzYTU821rJFvyWzDenWQx31lQFYbT7Nn2cW0bXiVmZeiZtVBL+0paGofmtlUL
	 9MmqW/1pBcpxJRqSTLAd/8weTFA52URDN3AnwXGhtn9UgoUjMybtnLxrXjKCDgGJV4y8i
	 W4uaJoZ7OIUe5H0mtZP8bhUPMEJTy9W5Z2PYqYXAAReKc5RU8GFprEdcszjCWsQHpkq1g
	 EjU0M6bZw7+jxTAZb4CdFaPmHSsJfLs5FfttRIQKTxfdRJr2xXn+Ran6Lh9G9nqsnlPSk
	 YI4yA76r96XW1KR0Gi00uswhpYNhV1rGIsGsLhVYsZmzK2bcq/uFCzvDkVZ+JztKNnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PTPniKxw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C4606A331
	for <linux-sh@vger.kernel.org>; Wed,  4 Nov 2026 00:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B7C4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PTPniKxw
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a05b210703so114367b3a.0
        for <linux-sh@vger.kernel.org>; Tue, 03 Nov 2026 16:41:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793752863; cv=none;
        d=google.com; s=arc-20260327;
        b=c0F+YPLeQPcMRo8BMrbFByHUwU08LHlKz5uxDHdm5Lq43TH1+IDY+U7ASYNHCehBGU
         fwHHRlZymThoc+C9JKMwk+0ijsw99l+4yg6DRWXep/6sfgP0JzoMIJAHwB/xGOIT4HVH
         XIIoVE14ZiEVcPf7r9IbHuGHsxHZDkSE2zUi7jHcHgZYzEj5yGPgQSBmtluQk6iudo/u
         jPivPYGfUOKZeIrzNP70wSl2ap5U1JjW7ne+ttZI4O7I1m68f375XEL24fPF4052DWxS
         JVeEto20hNmSUlUYCizpJHuvpqhxUW8dCY1kCFjaQIATKLsSKPbeLEclbbwhgsehKdIV
         T+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        fh=jZ2kwB53YwTd5cB3OLu/sQ7VTrrpTR17XlPLWYlZ4KM=;
        b=CyItosyi170Hgy09ShQnfa1eQIgwtPCIdVO1K4TMHFpSXQtfAaQGnWPHW0Cmbw9ow6
         aQ7mxAbOluk2jHgdORL4LtWgxmwovtmefWmcVeNxVOa167RJR+iojw2eEcl8JepCiPtT
         N5sqg8tD5RIeljvLsF6NlXyScOOhKfrMkn052ZIm90xKi0k7mCEdjQzkNb7gO7lc0asK
         yAdgJIfAajtQlm6iItU8tnC8PyYZtCMVQFr/bFUEqdjk0Eu4zM1NcBzrIQOxg8MuuQWi
         ZK0VRpZ3bOxeDqfkG15rp84dreuQVqsGb6bKN4iHBNiYbuaIXzgsJJ0VNQm6nASJ/jPJ
         cheQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793752863; x=1794357663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=PTPniKxw8lSLWSxMbmhmXVodXffwfFqC3M3cDEPYPvY1SsBjNOjXXv95CLFg3rVQFu
         x1tdyRAr0bqYQ6HVqsjHpfPPU10/1FhE3kd/CHXKlKRa2s8Jf9/RWGaRvSd9s3tWp3+h
         Tji6Btj/3XlTUrwGPe+aphN7moDM3Ujmyews2MtwEsOdhWo9d1B27IQnIAXxeCj/AgoF
         TwCZd9YYNW98ENSoBC4GvFAhash4XN0WeHulLfX/snYculqtKEVgWcaAWPf68LjYBfvq
         i5NzGzwAog4kKLckyYK3n2IY4tOHLEWiT5cJSG6dbW9SW1FZ4MjXmEMstZ0yw7BaSVW5
         5qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752863; x=1794357663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=xuvDNNFeP2VvPYdU3td1M308hOFmMYrZ+FB1qCzv+VEn5YNS/PEk/P8jiR5kouJM+6
         Pwvkco2mvvf8olA4sdTMjHg+cK4xN9R6gAdNb6RgIL2eY+m1aSpR8WIJAk/vhfgEqxh5
         a2+dWOvEdjGr+PB1UWTzX5791cBy0yeZWuGhvPINzURLo3hipgUxrrBoNyDkJrrN+1eo
         Bd8ytgU625U1u/ThuOqdrBznGQfSL3Y/EZubQeFF7BaKZU1ViRV6enyOhaKzEU9jxrCS
         4FSPQLg4lef97XGg4uAzaWl6UvUagLg4OArEo4AJPXU0Gi62LwPmgDgPaSm/EroigjXn
         Jnmw==
X-Forwarded-Encrypted: i=1; AKwUvBxO++oO5yEhVwyt3G18JP7ZCyFN0dCKR2E8prvJhg0/eiMjpuLin9a857NrZM6JD0pn373ZNhyVVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9DCO5wZBOsfl2ZTB9d4U3v42DeQ1KTmb+aev/5E3NL9Qy0jmYT
	OJIwGsLrgMhZNKk6OpANkpaA2+B8sIM0XUao2MRGjPIiMNUZL8FKxOC79NEqQKsPUGaKllkbzl/
	YfyxUpVwuLLAZ2Tmcv7vsWG6CXnXT0T/l8WDC8tKO
X-Gm-Gg: AYBFou3njAPbKimcGv4GSgXhi790kx1XZDno/g1C6GHD5iK9ytbQzxAh5SG5iT41Cb8
	4kqlizQMXG61zDTs7WUM0q5KgbGOe+sthh/yMZSaD57CcakyFzajuoXuoUjFgMskGLfu3CRzk9+
	azvIc3gvcxZuLT1lp6l4NlG75FY8+PBuoJm9DFbdkCaZD48bsmJHGw9hyO3nL5AHiuRA3JCz52n
	J+DmFoGvUFyrW2g8p+DCxxZNebjnENhl/J08uweMV8bu/pqHGTM6CK/u0Nwxcz+ihJJ5eVfhiZQ
	rmnxPcU0/Sb8oSr6MU/+7Rpvd0FdsQEm1z7l9SLtjcPNSRbeTuD8Pm0vGyxJgFxmAdYJdqTqcuQ
	zHtJgGKpTQ02wZwO/4HS3xUS0zHUUjTLrwEJks14bfJx6w9Xcd2ctPbbcP+KVx6u9qS12
X-Received: by 2002:a05:6a00:2d96:b0:88d:4b30:1c11 with SMTP id
 d2e1a72fcca58-8a9ba703bc9mr11394030b3a.6.1793752863107; Tue, 03 Nov 2026
 16:41:03 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
 <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com> <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
In-Reply-To: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Nov 2026 19:40:51 -0500
X-Gm-Features: AclHuK_mzIhdjHPxjnkTYRthyfMgrzjS55JZuNf6mZPYYsQQvO81kKGlvJUv8_0
Message-ID: <CAHC9VhQ4U-Z2KkGurfMihJgzGgwD3miWSW4wWAjWvUdDxLpH7Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:45=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@r=
edhat.com> wrote:
> >
> > ...
> >
> > > > * As pointed out by Sashiko, when you were converting all of the
> > > > arches, it looks like you missed alpha.  I took a quick look and it
> > > > appears that it should be a pretty straightforward conversion like
> > > > most of the others.
> > >
> > > I've actually dropped the alpha patch as per Magnus's request [1].
> > >
> > > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phd=
BKy4BLWOvDTt92t5Eg@mail.gmail.com/
> >
> > The problem is that as things stand, this patchset breaks the build on
> > Alpha.  Perhaps this gets resolved during the current merge window,
> > but as you know we can't break the kernel build ...
> >
> > https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.c=
om
>
> Of course, you're absolutely right that we can't break the build. I
> was afraid that this dependency might cause trouble.
>
> I noticed Magnus posted a pull request a few days ago containing the
> "alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
> resolved during the current merge window.

... and it has, or at least it appears to me to be resolved.  I
rebased the audit/dev-staging branch against v7.4-rc1 and Alpha does
indeed appear to be using the generic syscall entry/exit code in v7.4.
I think we should be all set here wrt Alpha, thanks.

> For future reference, what's the best way to handle dependencies on
> other subsystem changes like this?

Generally speaking communication and coordination :)  Talk with the
subsystem devs/maintainers to understand what they are doing, let them
know what you want to do, and find the best way to order things so
that it all lands in Linus' tree without making a mess.  In this
particular case, with the syscall arg audit patchset not being ready
(missing maintainer ACKs) and the Alpha changes going into v7.4 it
turns out to be quite easy, which is an important lesson: sometimes it
is better to defer a new feature for a release just to ease the
coordination burden, enable better testing, etc.

--=20
paul-moore.com
