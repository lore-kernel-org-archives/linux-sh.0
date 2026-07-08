Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201A372EDD
	for <linux-sh@vger.kernel.org>; Wed,  8 Jul 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525626; cv=none; b=QigNPuAne7796QeB989du9LWuR2DxTCVzkbeP6hzB1gq7/46ESrc1FP3mfmWAEuI3W/Ky//2e6d0AlAB0Xs2kPa0oxEpQowab0IdrZSqJd5sgtlf0NY6EOGvRtE+aALe+sxZvZf0IT3GDsr+YDeICXpv3ckHDxsbeU9iRn+SivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525626; c=relaxed/simple;
	bh=Va2IGzeVOAPTHMa4DaH+yWHwp2fTjUY5mobPTHVuW/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=t9Z+v6T1kqLEaeHQ79IKWrCS9c8mzjpxdwKK0BsIqF5aYlfJjQxsO83I6Eh4jgkWK8HOp1OlO5jOcyyH6Y8ZTUmI09po5e13vjXgY3G9KgtMMJCP3DXhMyGr6dJ5r7HqFJUYVgmChg5gd5TdxbOB4xFwBRBFmoef4FvUrMnir8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDKGisZ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDKGisZ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783525623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Va2IGzeVOAPTHMa4DaH+yWHwp2fTjUY5mobPTHVuW/k=;
	b=GDKGisZ7tRx/ACD9ETXSaJGFF0oG7rImnn27ivc+mEJm6bIwablasI5js1yBAYafaMayvX
	z400iNdCON6c+FEznJ7B2q7dVN13Bk3ekPTbTjSL40zcScMX0e1Y9i0OAP03IzElvowxKW
	m5C5lSUvLnyuykUBAme5LlFnj4NFq0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-M2lrH6tYOsC5ufvFITf8jA-1; Wed,
 08 Jul 2026 11:46:57 -0400
X-MC-Unique: M2lrH6tYOsC5ufvFITf8jA-1
X-Mimecast-MFC-AGG-ID: M2lrH6tYOsC5ufvFITf8jA_1783525612
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 391341956060;
	Wed,  8 Jul 2026 15:46:48 +0000 (UTC)
Received: from fedora (unknown [10.44.33.83])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 668DD31D2;
	Wed,  8 Jul 2026 15:46:27 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Jul 2026 17:46:47 +0200 (CEST)
Date: Wed, 8 Jul 2026 17:46:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 12/18] ptrace, treewide: Rename
 ptrace_report_syscall_entry() to ptrace_report_syscall_permit_entry()
Message-ID: <ak5w0KB_x2P4G3rd@redhat.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.280015701@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260707190254.280015701@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: wkVZwo1J2j52T9r4OudlYLJ3e36bCtCb9uhXNE9JCLY_1783525612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 07/07, Thomas Gleixner wrote:
>
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
>
> Rename the function so the purpose is clear and make the return type bool.

Just in case,

Acked-by: Oleg Nesterov <oleg@redhat.com>

