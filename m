Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0eUIQ7y"
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43711D6A;
	Tue, 21 Nov 2023 05:43:07 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5b383b4184fso61241677b3.1;
        Tue, 21 Nov 2023 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700574186; x=1701178986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2jFoW0wBrxwvC3UXYdoI7e4rK6JjoL9RV6ETRvSTJs=;
        b=D0eUIQ7yctSuBZfEjSKxJnHVFfz7lYp1J9acKXYD0Ouwo3eAFp7aOvThGu6xz75Xk6
         IRSwlmUIi0gK0iWVo5TqI5BiPpwXPaPDZQ6W6AUY4UWVP1pykWDxZKlpEcQbQjzjmau9
         ZBSfXRnzoDdCsY7hlyR+i2R0Ew20Fjjo3uUKuBqk5d450aN3o+p9vYeV8vcqdZlH63WF
         jv00KgQYryWegThy0XYS49Ol0njsfl9hNmkTdeuGULFpMOjMGM5QNO/Cn4bTnITytzih
         DZcXrQ6SiDwIXb8YpLsurOLP6MhViD7D8VCSevHJ8ZsYAt0U03cEiGux8wj+AHr+zvim
         nRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700574186; x=1701178986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2jFoW0wBrxwvC3UXYdoI7e4rK6JjoL9RV6ETRvSTJs=;
        b=hV3HhXT9vLiTkmZ4liBU9DJGZVxxqh6p83SVs34ToCCfrMg1/LLXh4/lZ2/BLIBlpj
         NrkJz+b+g/EdrfiLLFXpiVRtnizVKzsW4jQDK5Q9Q+VXJiDG5VZpZe8i0jvMquaUn09l
         Gsozx5Nbt8tDFiYclTDKB5NHwgiXf9DAiToFXHsxRpEIUlA1dlTaY7ffOK9qfE0ND7j6
         2UBH+eJHZMBmtEmFljI3PRFabkcNo6w4e7eHHemlmupRO9XK2v63PTOAgh4+Lx0O6ox7
         tHqvNGeWQLgELcreWILjwK1B6iG/rGKt/gV8JZsxMJs83fX2AIzlrH6n+oFqyNNdV059
         4Sfg==
X-Gm-Message-State: AOJu0YzcqB7jNLW8UsveMzUekA0tExCkDtVlmlox2VFvxtJGdb9nktBy
	902qYQnlz5hbJ+2IMyiemrs=
X-Google-Smtp-Source: AGHT+IE7zExNj2xD3/09eeu2XxcaCzvGOCX3w8yszWNCW6JxpL819+KOWL2DAlSHRSD2xYNRXLB8Dg==
X-Received: by 2002:a05:690c:80a:b0:5cb:95e8:16ba with SMTP id bx10-20020a05690c080a00b005cb95e816bamr1655104ywb.46.1700574186241;
        Tue, 21 Nov 2023 05:43:06 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e005:b808:45e:1b60])
        by smtp.gmail.com with ESMTPSA id x83-20020a814a56000000b005bf57ef572dsm2975977ywa.140.2023.11.21.05.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:43:05 -0800 (PST)
Date: Tue, 21 Nov 2023 05:43:05 -0800
From: Yury Norov <yury.norov@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 34/34] sh: rework ilsel_enable()
Message-ID: <ZVyz6ctZVcDVM0N4@yury-ThinkPad>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-35-yury.norov@gmail.com>
 <6d29ae1cd7b20668b5307eb4292155bc59dad8ef.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d29ae1cd7b20668b5307eb4292155bc59dad8ef.camel@physik.fu-berlin.de>

On Sat, Nov 18, 2023 at 05:15:57PM +0100, John Paul Adrian Glaubitz wrote:
> Hello Yury!
> 
> On Sat, 2023-11-18 at 07:51 -0800, Yury Norov wrote:
> > Fix opencoded find_and_set_bit(), which also suppresses potential
> > KCSAN warning.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  arch/sh/boards/mach-x3proto/ilsel.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/sh/boards/mach-x3proto/ilsel.c b/arch/sh/boards/mach-x3proto/ilsel.c
> > index f0d5eb41521a..7fadc479a80b 100644
> > --- a/arch/sh/boards/mach-x3proto/ilsel.c
> > +++ b/arch/sh/boards/mach-x3proto/ilsel.c
> > @@ -99,8 +99,8 @@ int ilsel_enable(ilsel_source_t set)
> >  	}
> >  
> >  	do {
> > -		bit = find_first_zero_bit(&ilsel_level_map, ILSEL_LEVELS);
> > -	} while (test_and_set_bit(bit, &ilsel_level_map));
> > +		bit = find_and_set_bit(&ilsel_level_map, ILSEL_LEVELS);
> > +	} while (bit >= ILSEL_LEVELS);
> >  
> >  	__ilsel_enable(set, bit);
> >  
> 
> The subject should mention the subsystem, i.e. "sh: mach-x3proto:".

OK, will do in v2
