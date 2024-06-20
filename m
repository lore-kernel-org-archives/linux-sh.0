Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0C3C6AC
	for <linux-sh@vger.kernel.org>; Thu, 20 Jun 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915986; cv=none; b=RA1PLeywZWCJuD8YmoOfg1fwdzKoRL0uEhdws/AvAw38JHXSD9QLR4Qmw3nXiROd5sTSoL/lvR9+fuhvNvxLTWQfFarsvAAE1ceQzlGUrwK+eXN8v2ZOjm3vKrUahhBJeixiIcTC66MZStkzzGRo/GNKqcv52MpEQX/D/sHNTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915986; c=relaxed/simple;
	bh=xe0CLiytQL+w07wMVqUc1rJS0v+e/Ti6ErqFWmVCp7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkrWnHDD9HIAj0bGwk+WdAiSkg+y8Wy0ZROlqnPZm/nLkrlFzrfE8iwb5/cwyAnD5QQNSlz+2d83pAeRRApFeaLPO06Pr08CrPO+OyoeIvOLYH4zIB6EuucuwTeIROjxMu4PVKKu+mrzCuhSDEXlz4VH6LOBYNu+WDkJBLTURRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AXeygLLi; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AXeygLLi"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso190204566b.3
        for <linux-sh@vger.kernel.org>; Thu, 20 Jun 2024 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718915983; x=1719520783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w6VZWpwlG7GhpGptpxtkhZuBw3s+vrw3bJ0KsbwAf6c=;
        b=AXeygLLid2UjyFOMGM3DVW0z7uuvg/mGQNsK+riTSpcOKO3voS31XR+tT6AJFNVflW
         w4CJSV/WEzf2Kb7pM4dI/Gkjym5xvsX65309glEnNeq/6QAKIhrh+pXTY9ozgDQsQCyX
         id/4/gIHgXpVVcy8HdgFRafbGqwx1JP/0+IFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718915983; x=1719520783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6VZWpwlG7GhpGptpxtkhZuBw3s+vrw3bJ0KsbwAf6c=;
        b=bvgQpdvZ1dMICA37CO8JAczCdRKGvSD9Suu4ywXxy3JVQ1peGmiLUpFOPDQpzMHJF6
         ZcnZv7DXffSBE2FuV61Yz6F1VWl0hp1Z0EZZLSoTsthPcMTl/+CdiCnbIpLJOqnKIYsa
         uU8whb1azJs+BAFpp0vqEzhdJ0w1dY65gV4QdVktv7WNJOPuMJKHeX9aZMOc6VVBkh64
         27CmT+UKQISoe6PlUgIYqW00gbvd2nityRuK6xdBiKTfptyyys6DRZMXiG1iLIMPuGzM
         2mzQfNWT/p31uPMl8GYnw/QKOvMf0OJjl33VNehhYj5bXUvCn9+TxSzwvAvmYa7kgafi
         36IA==
X-Forwarded-Encrypted: i=1; AJvYcCUdrpBycEUKAnIARzpk4iHPnltzZKIdwxku0bioRi6KMBrWC1P1TLV2exz6t6SLzgEmSR9lEUBi9dIAnf7w4B6+xemvRKvfwrQ=
X-Gm-Message-State: AOJu0YycJvv2+QOGlhWDk1bqmmFJ+0ZP0ODJgyD11m4qTkAyOtpFzOQj
	SBCEr2h+KX7oviQSvCbP4jH1jxUungXzIMKzJBCPZ/9hh6Wa6CUBq6OqPS7H7T6weo0ii++aTjV
	Pi/rRKP+M
X-Google-Smtp-Source: AGHT+IF/Trk6SitgoYHD1wFiJFDUdl5E029QfH8n7aF75jYFC4Sx93fkcnbYpUU6vfc1ipeMfjP18w==
X-Received: by 2002:a17:907:d043:b0:a6f:96ac:3436 with SMTP id a640c23a62f3a-a6fab602e81mr387871266b.11.1718915982834;
        Thu, 20 Jun 2024 13:39:42 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf5490f9sm7696266b.100.2024.06.20.13.39.42
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 13:39:42 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3645e9839b3so1042654f8f.3
        for <linux-sh@vger.kernel.org>; Thu, 20 Jun 2024 13:39:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmzwSxBK9Hn583RfQB2FYB48DkjzoOX1Ylq+AKlqWCq4PFQ9eCKnLNlV/62a+w4QkKzVYWF1MlEF9b102qC8kW+8fsCYH5P8A=
X-Received: by 2002:a17:906:1348:b0:a6e:2a67:7899 with SMTP id
 a640c23a62f3a-a6fab63aaabmr312193466b.35.1718915542284; Thu, 20 Jun 2024
 13:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175703.605111-1-yury.norov@gmail.com> <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
 <ZnR1tQN01kN97G_F@yury-ThinkPad> <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
 <ZnSPBFW5wL0D0b86@yury-ThinkPad>
In-Reply-To: <ZnSPBFW5wL0D0b86@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 13:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2R7-jyoOw27Svf1PmfDFQgBWVAH3DP5CXO+JF-BeFZA@mail.gmail.com>
Message-ID: <CAHk-=wi2R7-jyoOw27Svf1PmfDFQgBWVAH3DP5CXO+JF-BeFZA@mail.gmail.com>
Subject: Re: [PATCH v4 00/40] lib/find: add atomic find_bit() primitives
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Borislav Petkov <bp@alien8.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Disseldorp <ddiss@suse.de>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregory Greenman <gregory.greenman@intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, 
	Jiri Pirko <jiri@resnulli.us>, Jiri Slaby <jirislaby@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, Karsten Keil <isdn@linux-pingi.de>, 
	Kees Cook <keescook@chromium.org>, Leon Romanovsky <leon@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Neukum <oneukum@suse.com>, Paolo Abeni <pabeni@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ping-Ke Shih <pkshih@realtek.com>, Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	GR-QLogic-Storage-Upstream@marvell.com, alsa-devel@alsa-project.org, 
	ath10k@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	mpi3mr-linuxdrv.pdl@broadcom.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 13:20, Yury Norov <yury.norov@gmail.com> wrote:
>
> FORCE_NR_CPUS helped to generate a better code for me back then. I'll
> check again against the current kernel.

Of _course_ it generates better code.

But when "better code" is a source of bugs, and isn't actually useful
in general, it's not better, is it.

> The 5d272dd1b343 is wrong. Limiting FORCE_NR_CPUS to UP case makes no
> sense because in UP case nr_cpu_ids is already a compile-time macro:

Yury, I'm very aware. That was obviously intentional. the whole point
of the commit is to just disable the the whole thing as useless and
problematic.

I could have just ripped it out entirely. I ended up doing a one-liner instead.

                Linus
