Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DF3BB115
	for <linux-sh@vger.kernel.org>; Fri,  5 Jun 2026 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645150; cv=none; b=mrACmiFdn1dvEIYzuakV0btKwHzdgihqiKa2O6URy9R9J3nP0AwqBv/PqeYM68u0cIdQsna4R/Ey9u3SPpoyxDsYBLPJotIQ71puoiOyWBY5uS6MsPuNEea8EIiJjNtQVBcKwF/2e8C6JkG2O8k37q+8GAXPuHspgXucWCr6uns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645150; c=relaxed/simple;
	bh=5W/tWie+s0GyiFfiVzYnA5c+lJxiUZ1i+gzNpq+8JKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8RtOXYYFWCkUFPmM9G0fn1cWNBr7jeSzaCgLgjATBZnT/3ep6Lh8YjewJw7wxh7n0ZSy19qd+YJvVla8UzTQiQzzxjZ6avVc3agliRFKnqDiUvJOwB87SrnJ/TXwy62Fpk4niXDbIA2JwXWj+CLLrK9b2Mk+EW2u60cU9lS46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-96358d0a024so1172910241.3
        for <linux-sh@vger.kernel.org>; Fri, 05 Jun 2026 00:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645147; x=1781249947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJPTFXFfEVfaClOO5icEXfzsJcEhxZLVJwj7hX3l3SM=;
        b=mX4PF6zydqWYzZmQIu//vDMUzCBYZBLJ4vGAtpPvObscCLQFooVdgXHOcja5JOA143
         UuDfTh00xQhyhx99YAFxL1AWQfzNKdqBKS8Aj6X0/Q1EXhE+DKDFPkDZvfHWcHYf9Fe6
         b/wp4BK5Rpa0mBSGo8A2QBMuIpQuH0PdYfj9wgBhMQKE+hVjideixz6olTnEk0v0W9Xu
         m1srv9iW70wXT/PBuY6kxkeaWQ4PkZzA5ZOg+vqtszALdIwvYy4TJ/eMGRpMkZVFSI9N
         T5FeQoG6UIx0rjSPtSq0AJM0NwjrfrV+asTgefR2i8iMM2M36WIbu9TRgHeUNc4TV6LL
         vfkw==
X-Forwarded-Encrypted: i=1; AFNElJ+spQTHIHGwVQkhLN5jC+Txj0E9Rvi1JW1h8S6V/yez4/AzBGwGf+8nBPFMBPt4w8HP2MJaf6CsTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWTzdtcedaSAf+ALGTnW0jNSxZl12g8a2WkhBnJmJHfDmYCWg
	kiYYj8CZLdYXCCqBlk/aWi6pPDZJIAZwAS7SISlSferezKQICRxXpbub182Gt+cFBlA=
X-Gm-Gg: Acq92OHRLjSAI9laIV2+3m1nvqT4Xo0LxCapDkhdIKHFYNMHtatcWpc/JoTYgRfhsfN
	P9eBrHAcU+UqJ4v53k1JEj2J6q5LWACBF5Ng7qlyVWa/XQaEH1xIaHJNlvbbG2U1AzA8DMQ065x
	xAOzEiKRo0LjArbWU+uKHV2hrkGCvOCgUR5UJtUgBXpdcMuIplvoknDF3aWsuk5Ye7F0oUHYUp7
	nVpqwH49V9QdRaJgsbEXr6AO9SSCt7xqQI9QfbVrvRsR7uNHW6HPPEumXB01sRQvF36rsmzp0Xn
	TA1SvG2gmNjRCpkGr8iwNvokGzjxnJc/xIYOmeTcigMoobwZhX2qzM5nJuNEQeq2CSKjTDyYORo
	yGwSNZ9oVp0VP1xpz7UHq1RaSZYodHc12OXT5FKXyX/i9MgRaKzqhG52gL5Dvd3lePqi9sE7baB
	cIB8N2h/kNZ+8KD5e275uZGYoWJ/7LtVVrxdsUi/2q9OsKqAXUPAmkq1AGel8zhtBquG5/YdU/w
	q/ddJkTlg==
X-Received: by 2002:a05:6102:4191:b0:6cf:f288:f372 with SMTP id ada2fe7eead31-6fefd72e0b5mr992167137.28.1780645146676;
        Fri, 05 Jun 2026 00:39:06 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9641414e1d7sm6196260241.12.2026.06.05.00.39.06
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 00:39:06 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6c4db0bf752so1087687137.0
        for <linux-sh@vger.kernel.org>; Fri, 05 Jun 2026 00:39:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+k0ZJ3cDdOiLCvSNEYXliQ9XpvHPlVfuC51q2ljDuHFecmjkDkzvTgzbpYvFYqD28mXEOxmbUz9w==@vger.kernel.org
X-Received: by 2002:a05:6102:cc8:b0:62f:3abe:907f with SMTP id
 ada2fe7eead31-6feed1adbffmr1189675137.4.1780644646130; Fri, 05 Jun 2026
 00:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
 <20260604-remove-pktcdvd-references-v3-1-e2f06fb4eef4@gmail.com> <88d9bb41-e51d-4b71-a6d9-f1b79eccd496@acm.org>
In-Reply-To: <88d9bb41-e51d-4b71-a6d9-f1b79eccd496@acm.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jun 2026 09:30:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVhjYBhKUPzx-FAKWAAkUwcpYh0v2V5w64OMJtREZr4PQ@mail.gmail.com>
X-Gm-Features: AVVi8CdzPUN0PjO13sCwZaAxIjLcvwA5tXzyJ1zGjjn5YbgvhAb6LM_UbfPQhv4
Message-ID: <CAMuHMdVhjYBhKUPzx-FAKWAAkUwcpYh0v2V5w64OMJtREZr4PQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] scsi: core: Remove remaining reference to the
 pktcdvd driver
To: Bart Van Assche <bvanassche@acm.org>
Cc: Catalin Iacob <iacobcatalin@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hoi Bart,

On Thu, 4 Jun 2026 at 18:01, Bart Van Assche <bvanassche@acm.org> wrote:
> On 6/4/26 6:20 AM, Catalin Iacob wrote:
> > Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind an
> > export that is now dead code. Remove it.
> The subject should say something like "Unexport
> scsi_device_from_queue()".

<pedantic>
But that is not what it does: the symbol is never exported, as
CONFIG_CDROM_PKTCDVD_MODULE can never be set?
</pedantic>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
