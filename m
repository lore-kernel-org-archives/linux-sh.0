Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37949627
	for <linux-sh@vger.kernel.org>; Mon, 19 Aug 2024 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098951; cv=none; b=jL4YSNaxjMWi/XMs/YHfNMNCMuGBNoYtGeVnKafNSLSfdklA/FzsoISYvtKJJqwQ5DlftzeE23e1/rQMRhI7R56FCVUYcGO8+8D6R27UZmopHzKPEJFQMst3JnwGqfF2BX1I4/q4x3DFtHuEjFj6DJW76/nb8GDN1ytkZxNvJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098951; c=relaxed/simple;
	bh=MP2kPJdQKYK5hGOu9VTob2QU2S+5BQfmeHYP4bjRtok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Svw8e+PRHHoBbrGl6p35Oymp3WA4YZfDnwCu6TKDV+SHDOqJ4NKTOe6IWF/ZLlguHA/ezhOsoK+Pqmm41GvLzFDNuihrZYoNZcDOGlZaN+5kLvEOlbqWe9fQTn0yHxw2vse3swoMSPb1oKOjApGAOWxQp1mb2qb88jyAdacSf3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e9vhhCXD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e9vhhCXD"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a975fb47eso549691466b.3
        for <linux-sh@vger.kernel.org>; Mon, 19 Aug 2024 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724098946; x=1724703746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6kUf3JuaMLYYiOtuZKtyG5uHrd9gw9QQ5nZ3PFBxZMk=;
        b=e9vhhCXD/SRK4/+tMOjclJf7MoMeQAwCSUSdfzXLTW7vOZjZHMUNpCBvEeTiclUBhK
         srTRW0pJ0p8Ki9c9qiKjKf5maRrVqcCrY/h7QYBMysHQ0w4kiCE12jc9kfvr1Eyn9irq
         c29d7fAHmo7Ui9SdkJFtKHE/+2u/kHYmNCIeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724098946; x=1724703746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kUf3JuaMLYYiOtuZKtyG5uHrd9gw9QQ5nZ3PFBxZMk=;
        b=PBaPf46b3yUnApH5VyLlMi8leTmSxSDfLZQQkCOEjo0H1L3TCG09hR/lsNjuNRJ9OP
         EF9PAxzOEim4Y20hRTnS6qAU/zdOOwvS7KBSJ6c7CFRV6Y1IfwHm+xrADc3N4cSIrBU1
         mk2BKxl1v5iDfBdJffpMHng7EASU5aIdHsCU/WrgAxl4xDg4EXmHyX/hJl7PJM/I4lHE
         bThyrsG+YXO6V9Mu/2CJNcI7zZXwAO79Vr7qterxVHOFp7TkGhorkA1X9F2+btEr/OH4
         WssCOCGR1UegoKX6WRDEV+uvGSVLhF5rvteMerEJ80M7GPaPXvpag51PPIWLGWRsXDpr
         Z0fw==
X-Forwarded-Encrypted: i=1; AJvYcCVg8erZtc2KsRGVWmIfBiKFHOf2DRvEXMTejL11b3xRxKgRIWQTbfjZwqOvZN3q221PgpPcVa+FMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIfI/qka6Gt0ziEoozOcZm9xeCR58+7boiCjiYq8CGSF0TpG7
	DKgBlShcyQYINug54mvZ3gWKUOrWRJ1Fwbqi+VdgkATE98w5MxWG6AYDnkc7QGTxBhqgGLTVQ0Z
	httzgOQ==
X-Google-Smtp-Source: AGHT+IFViXevkckKT0RBGfojOhZ8bUIlidoGhRiYij3/36t+o+QkDlYjfqUmRaYI64DvVrxHtRrs+A==
X-Received: by 2002:a17:907:e298:b0:a7a:a7b8:ada7 with SMTP id a640c23a62f3a-a839292feeamr870146666b.24.1724098946143;
        Mon, 19 Aug 2024 13:22:26 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83aeb6eb4dsm374598866b.35.2024.08.19.13.22.25
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:22:25 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so3729746a12.2
        for <linux-sh@vger.kernel.org>; Mon, 19 Aug 2024 13:22:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3a9KsHbJWcFM4NPyfhMV98F4etD0RPDLqsd6vHElVOrj2pff5RTJhkErOA2LzKsEPDVkKp6vKCw==@vger.kernel.org
X-Received: by 2002:a50:c8cb:0:b0:5a3:a9f8:cf20 with SMTP id
 4fb4d7f45d1cf-5beca8c7c0dmr6123102a12.34.1724098565883; Mon, 19 Aug 2024
 13:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com> <20240819195120.GA1113263@thelio-3990X>
In-Reply-To: <20240819195120.GA1113263@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 13:15:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
Message-ID: <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	akpm@linux-foundation.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 12:51, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Yes, that appears to fix it for me. I don't have much to say about the
> rest but others might :)

Ok, I did a quick hack-job to remove that disgusting
install_special_mapping() legacy case.

With this, the old "install_special_mapping()" mess no longer exists,
but I haven't even attempted to compile the result, because I don't
have cross-compile environments for any of the affected architectures.

Except UML. I did at least build it there, but it's not like I tested it.

Adding architecture maintainers and more architecture lists to the
participants. It would be good to actually get this patch tested.
Context for newly added people:

   https://lore.kernel.org/all/CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com/

NOTE! This patch is against my current tree, not the linux-next
changes. But it should entirely remove the case that caused problems
in linux-next.

                      Linus
