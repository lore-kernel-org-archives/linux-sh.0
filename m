Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42637635;
	Mon, 26 Aug 2024 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637787; cv=none; b=T26xRxqoUo/wnDpjtaxVCGsQ+B+NS4k7VwM+Qv9o42gwMWK/gZKYk66lnCFiB0HhMpUkLyR9BoWbU92DOuDFCxjE+hRH0MtRpvAUxgyD08Q/y7Artme+06TthJsxwc4sqH4rwx30rZbmOKVI87jG3WVLQbj6HwyDDUmLt/3KVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637787; c=relaxed/simple;
	bh=iZPTkUdRtMyV1BqTXCZaiKhLQDTQ3GiPB+uOmVL19ks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ElthGle/SITd1XpwTH2viBNpNwLiuifKMoRO36QgjsGciCpKhuSestyhDYE2UlVYphmZ8gqnngbMbjIkXeWJLWXELLxCKtdX6YgPdNO8maJILbQxh8hybmmGtu86R71gZAw940i4dyBN1xiwzSDvVtR+hSpCA+rSeK451ocLaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=VHGPtgj3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VHGPtgj3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724637782;
	bh=dZljPhuAr0mbkeN13uZvN48XWKzlLsshYIWJUncVcO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VHGPtgj3ZZH12Ev7NLX3TF4pSlkYdY9+3Nos8qj7Ugrk3Qd7UBTWOtWCw67MgXYWv
	 Qf2bSQC2kE+6RnAmHrsiymxESd/vrerKgDKnxQbFnzMGj9QoZhKM4BG813fBkW7/oy
	 z6/RR90YfTlKCPEcpUglj1BtK76nlsKyI9rwR+9dNJFdSKB9WERcPawXYYaYWesu3G
	 qO2lMQfKPcsW0jJphnqBQ0sQ9kXdFOOxx2o6xJ+jdhIoe3PL2bPg8u7lSQ8ia2DLv4
	 1IKHQh9Xc0kwVaDtqJFt7AUOf/uVLWHWmUo277slyXLTsvcl221QRZpYtO03eTe8IU
	 rQ67+TcLWw9cw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WsYq848z1z4wbR;
	Mon, 26 Aug 2024 12:02:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Dave Vasilevsky
 <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Reimar
 =?utf-8?Q?D=C3=B6ffinger?=
 <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
In-Reply-To: <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
Date: Mon, 26 Aug 2024 12:02:59 +1000
Message-ID: <87frqsghws.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Hi Dave,
>
> On Fri, Aug 23, 2024 at 2:54=E2=80=AFPM Dave Vasilevsky <dave@vasilevsky.=
ca> wrote:
>> Fixes boot failures on 6.9 on PPC_BOOK3S_32 machines using
>> Open Firmware. On these machines, the kernel refuses to boot
>> from non-zero PHYSICAL_START, which occurs when CRASH_DUMP is on.
>>
>> Since most PPC_BOOK3S_32 machines boot via Open Firmware, it should
>> default to off for them. Users booting via some other mechanism
>> can still turn it on explicitly.
>>
>> Also defaults to CRASH_DUMP=3Dn on sh.
>>
>> Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
>> Reported-by: Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
>> Closes: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html
>> Fixes: 75bc255a7444 ("crash: clean up kdump related config items")
>
> Thanks for your patch!
>
>> --- a/kernel/Kconfig.kexec
>> +++ b/kernel/Kconfig.kexec
>> @@ -97,7 +97,7 @@ config KEXEC_JUMP
>>
>>  config CRASH_DUMP
>>         bool "kernel crash dumps"
>> -       default y
>> +       default ARCH_DEFAULT_CRASH_DUMP
>>         depends on ARCH_SUPPORTS_CRASH_DUMP
>>         depends on KEXEC_CORE
>>         select VMCORE_INFO
>
> IMHO CRASH_DUMP should just default to n, like most kernel options, as
> it enables non-trivial extra functionality: the kernel source tree has
> more than 100 locations that check if CONFIG_CRASH_DUMP is enabled.
>
> Letting it default to enabled also conflicts with the spirit of the
> help text for the symbol:
>
>           Generate crash dump after being started by kexec.
>           This should be normally only set in special crash dump kernels
>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>           which are loaded in the main kernel with kexec-tools into
>           a specially reserved region and then later executed after
>           a crash by kdump/kexec. The crash dump kernel must be compiled
>           to a memory address not used by the main kernel or BIOS using
>           PHYSICAL_START, or it must be built as a relocatable image
>           (CONFIG_RELOCATABLE=3Dy).
>           For more details see Documentation/admin-guide/kdump/kdump.rst
>
>           For s390, this option also enables zfcpdump.
>           See also <file:Documentation/arch/s390/zfcpdump.rst>
>
> What is so special about CRASH_DUMP, that it should be enabled by
> default?
=20
The reality is that essentially all distros enable it. Because they
don't want to manage separate kernel / crash-kernel packages.

So IMHO having it enabled by default in upstream does make sense,
because it more closely matches what distros/users actually run.

cheers
