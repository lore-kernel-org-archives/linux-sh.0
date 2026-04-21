Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968740DFC6
	for <linux-sh@vger.kernel.org>; Tue, 21 Apr 2026 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755171; cv=none; b=JLUGEeYIHWavqfbZkQtbU7kVK5dENkCaheuzStmryWtZICeD0cNBFH29+YmfEo9nbmORh6/fyU4nUlrWcmUizLOmCcEywHuHI6q0tB6g0gHPrKZQxIQVdkqZqisuKvATS/usCRnHEs4RiaExUrYNmn7tXAQh0qdLog9wvGP81Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755171; c=relaxed/simple;
	bh=a4VcVjKnpHksuLbndpargdkacUzAGEyCI0c1eHsHhfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT+HWV8jjo8w/3tpROruIBVLiM1HifPghB7rZdddBKv0pDscLj2Rse/E4UcMJlirSzWiwg+nByxlTngdmv8XDlj7zf+W7YB757y0cztYCmXg8ibMTnX5rJSng7/wcaiE2STopskYOJ7FJNMr8mFZKWNz9srcjNOFE7MIzfs2KUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-954997c9014so1843731241.3
        for <linux-sh@vger.kernel.org>; Tue, 21 Apr 2026 00:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776755169; x=1777359969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yJdlvUCofJcQ2iUok2F0O9FuV2JXFzCIoWepj+5ivw=;
        b=Q+NRV0m5sp3MgaEEGSZk0X4/AFu8mnVzRUOJKGJMKUS6WsDaIf/KjwtykgY2BWuBck
         OvoonyDiojIpn44IBkUt4ENsutWCRy0Vi9Y79Ji+4faWfXH1MwdI1zdv3Lz6kbQaB4Tu
         nC2Zge6G2fMntvpe/j3DYLfm3IIfa6OqJyowBH1BQtlJ21NL8LOQ8VSiJ+5KmS3Ziktt
         64C2XiY6Jg2em87L4km3YsIu8TYKUTef9tR3ewzof9Bc3bsupBeIf5C59QFZ25uEFEE2
         V5G+q9tu4JJ4D5+Vm1HbvfU33y4x9Tnj6tKPX2sUY3qVZLQJWSqYGqmkl7efSbmnMhMt
         1wDg==
X-Forwarded-Encrypted: i=1; AFNElJ/NnBkjRv5o3ODmgY/0NWqFBaXRlF7YYnDOd1rWa10oYFyZaaFnKc+/xREhFjaGE1LGgE2/8MboIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKELtrqtgEzVT594+tpc9k5NA4p3+txmvn19I0+HfRZJXVjE0A
	JkkYUdjqYv50n3wEOIJHRHs+t1HCrr1Faih86Z3nst5n1RIvV/yQtm+eYr/mWWiEb/M=
X-Gm-Gg: AeBDiesCkJp90xngb8QewWN5nQEyqdU/t5HWf/AGBpB9F412XNwg11OA+EIMfkAW4s0
	blHvrfhgahRwO7YEbmKgUUa+qHnPWkWpWrEi6g5ed+BOsCMKlS8IG1Afwcej8QooqjYimj4LrrQ
	VLXelb0C7Ja3nlZZmI3/HF6RQ3VRQXn2ltJqdtP66Ur12qk1ekQ7xieM4Ag4100TXiFXcDqyO0N
	28jh8qHwIj3xpOQXSPUmYThm4OxMeH3HvrohJVapRu9HyE5avtIfiovzZ3pQyPNsT99qkvGOb3I
	sF5w6t4+nbw2Kr7y8rYOqqbWKbX3fhF5ixNyGhHnmQ7XamtqLbvMHcVStKf4QXW5TjC8Z9ETiYR
	7+/fXXSFm2lYndcewqbcGa5huQhvj3OxV30FoZlgN+SNzn8JY8eJgSiP6D7DoziAnZ0ZKhJelxx
	oEoJhGIjtazP21xMnWNzu5gg7Ewhai4IcZZlBTcil+Q1DU9Gy6jKNaB9o4RgowCEFBIjVv8DcQC
	Qv+ALoV+w==
X-Received: by 2002:a05:6102:441d:b0:609:6aa:3c1a with SMTP id ada2fe7eead31-616f7611e8emr6724664137.21.1776755169293;
        Tue, 21 Apr 2026 00:06:09 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95890c61fb4sm5775675241.13.2026.04.21.00.06.08
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 00:06:08 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-954997c9014so1843723241.3
        for <linux-sh@vger.kernel.org>; Tue, 21 Apr 2026 00:06:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9/wJjagJOLTsCrZols2sf6q34Inxc06aeohHBwoggZi4B+HuR2liflPB909IgiDIvvtSYoRqbEAA==@vger.kernel.org
X-Received: by 2002:a05:6102:160d:b0:607:a3cb:4573 with SMTP id
 ada2fe7eead31-616f7d6405dmr7627516137.26.1776755168428; Tue, 21 Apr 2026
 00:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420150958.17072-5-thorsten.blum@linux.dev> <20260420150958.17072-7-thorsten.blum@linux.dev>
In-Reply-To: <20260420150958.17072-7-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Apr 2026 09:05:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWHv+BFMro=pM=PKR_1gya0HXEowMAzq8vGb4bPVvp6cg@mail.gmail.com>
X-Gm-Features: AQROBzBcBOXWZod3KGgbbQOfGr-2yghg9qTMl42BA54ceLxKAsFrHB3XfVYPr_I
Message-ID: <CAMuHMdWHv+BFMro=pM=PKR_1gya0HXEowMAzq8vGb4bPVvp6cg@mail.gmail.com>
Subject: Re: [PATCH 3/3] sh: dma: drop redundant size argument from strscpy in request_dma
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 17:28, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> The strscpy() size argument is optional if the destination buffer has a
> fixed length. Use the two-argument version of strscpy() to copy 'dev_id'
> to simplify the code.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
