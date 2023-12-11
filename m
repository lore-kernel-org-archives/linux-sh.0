Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="m5XmGUXn"
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6830CCD
	for <linux-sh@vger.kernel.org>; Sun, 10 Dec 2023 22:24:09 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ba0dfc9001so57291b6e.2
        for <linux-sh@vger.kernel.org>; Sun, 10 Dec 2023 22:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1702275848; x=1702880648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0baGklg81z4hbrRW+wcTSEXHa8S+7HSPypVCUaOF5uk=;
        b=m5XmGUXnNJnA4jaB3Dgx38ChuZVIh3GwWrSx/Qih0+XKSwL+uot9xuLUtgSX3BhXN/
         zVpOr9EzqAFsASV9pgtPtqztNpcg9rfVAdL1Qdy0Ox8npGvS6YE72mLVCpQcc70E+krU
         vGhR2KEL2bzSjVP9r7cNH7Q7GuxQMzsr/Af3jcpSBT6nKVIsFzbEYJfgnGbsWYYSm/7J
         6DtQdQfJdJ9WkW75nRYFd5BxdKfcrB7HBi/EFBhmv9v6/3bd4O0LnUItm/22eZqNrlIz
         ChLtxdiUoQprxoXlSSdH0qUAUOpknlFocdo1vNjJNxzPl/sEp3Tvl0FioFER1iXFfRqw
         B6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702275848; x=1702880648;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0baGklg81z4hbrRW+wcTSEXHa8S+7HSPypVCUaOF5uk=;
        b=jky4PcGAQReUritpGTVwhKH17WSN+P55MSLbGBjorHurtUyePNQs1HpQTE59pd5W3E
         47GajeyTVe79VvDJV36CRliZJJgKrggQx1xpMUpe7FXzgxA/UMzx+A+1HxQsq8DN57JJ
         PPNhgIVWXBlDxk+8UP7a0ZDJqD98c2Q3W3qW6HX519IonfUPaLF5nrBPDst4sw0/qwPw
         Aza3xSR0N3bYDJ9iAOE94eti8qce+SS0csbn6406dmVoJQ1EiyYHVtKnELKmGF3M3aY1
         p+gYfc1ZkaUDgVMy6kEIFiBIl6MnkKXV6HFV0mTq+bpt8ZyNKhEx1Znm81XNki0cxLM+
         u69A==
X-Gm-Message-State: AOJu0YzL5I6tsQXKfD54SdIx2XhAhe0jC+ee47wRf1dtrDa8myeNrPzY
	tcQ3yMA0lANAEG1EuhTDRxUU/Q==
X-Google-Smtp-Source: AGHT+IGe45IML5eSHGATOicKvjaUjG7IF//Gy8r5qsZwNAmZVBGtX7GSR5mEcuMhJ1lNC0cBbNtaOg==
X-Received: by 2002:a05:6808:148a:b0:3b2:e9ad:c01f with SMTP id e10-20020a056808148a00b003b2e9adc01fmr2234331oiw.44.1702275848714;
        Sun, 10 Dec 2023 22:24:08 -0800 (PST)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id bh20-20020a056808181400b003b83c516e62sm1694401oib.51.2023.12.10.22.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 22:24:08 -0800 (PST)
Message-ID: <15441b8a-57fb-6212-9f99-3f3d6f75ac8f@landley.net>
Date: Mon, 11 Dec 2023 00:29:49 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Rob Landley <rob@landley.net>
Subject: Re: SuperH: fs/namespace.c: In function '__se_sys_listmount':
 syscalls.h:258:9: internal compiler error: in change_address_1, at
 emit-rtl.c:2275
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
References: <CA+G9fYvcaozQvas-h55FPjXk+uomF2CyeYbWGCsXM8yGo4SZgA@mail.gmail.com>
 <b78e0487-d9e7-4584-8d6b-7de119ee7769@app.fastmail.com>
 <bca7f1cc90f20cfc8ad719a518cb1254582287f4.camel@physik.fu-berlin.de>
Content-Language: en-US
In-Reply-To: <bca7f1cc90f20cfc8ad719a518cb1254582287f4.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/23 09:09, John Paul Adrian Glaubitz wrote:
> On Tue, 2023-11-21 at 16:05 +0100, Arnd Bergmann wrote:
>> I also see that the defconfigs work fine, so it's probably
>> just hitting some weird corner case. You could try opening
>> a bug report against gcc, but I'm not sure it's worth it.
> 
> Please do and CC me and Oleg Endo who is still taking care of the backend.

Speaking of which, has anybody tracked down why building the sh2 big endian
compiler breaks?

make OUTPUT=/home/landley/mcm/musl-cross-make/ccc/sh2eb-linux-muslfdpic-cross
TARGET=sh2eb-linux-muslfdpic 'GCC_CONFIG=--disable-nls --disable-libquadmath
--disable-decimal-float --disable-multilib --enable-languages=c,c++
--with-cpu=mj2' 'COMMON_CONFIG=CFLAGS=" -g0 -O2" CXXFLAGS=" -g0 -O2"
LDFLAGS=" -s" CC="i686-linux-musl-gcc -static --static" CXX="i686-linux-musl-g++
-static --static"' install -j2
...
"TARGET = sh2eb-linux-muslfdpic" \
"HOST = " \
"MUSL_SRCDIR = ../../../musl-1.2.4" \
"GCC_SRCDIR = ../../../gcc-11.2.0" \
"BINUTILS_SRCDIR = ../../../binutils-2.33.1" \
"GMP_SRCDIR = ../../../gmp-6.1.2" \
"MPC_SRCDIR = ../../../mpc-1.1.0" \
"MPFR_SRCDIR = ../../../mpfr-4.0.2" \
 \
"LINUX_SRCDIR = ../../../linux-6.6" \
...
/home/landley/mcm/musl-cross-make/build/local/sh2eb-linux-muslfdpic/src_gcc/libstdc++-v3/../libgcc/unwind-pe.h:
In function 'const unsigned char* read_encoded_value_with_base(unsigned char,
_Unwind_Ptr, const unsigned char*, _Unwind_Ptr*)':
/home/landley/mcm/musl-cross-make/build/local/sh2eb-linux-muslfdpic/src_gcc/libstdc++-v3/../libgcc/unwind-pe.h:270:25:
error: '_Unwind_gnu_Find_got' was not declared in this scope
  270 |               result += _Unwind_gnu_Find_got ((_Unwind_Ptr) u);
      |                         ^~~~~~~~~~~~~~~~~~~~
make[6]: *** [Makefile:769: eh_call.lo] Error 1

That's the newest versions in musl-cross-make. It worked with earlier package
versions...

Rob
