Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C26622
	for <linux-sh@vger.kernel.org>; Fri, 17 May 2024 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715908319; cv=none; b=VEmN/NtNC9jxUjRtUbQOcgidbEvESkNCgzePUUkgQktwoQhJR0+UdXyedGhFp3YkbYydVkgbRqJp6sCxIDNe1uDPivby7zS/a3iX4nBYU/K4Hl+2/8Izl9Y5eg2ykMg+eu3mUfjmucF2I/HiIBdQmBthU2IMGcboTxvCed2BTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715908319; c=relaxed/simple;
	bh=AuYRAylKkV/HN0SZhDOF5G13bZ5TFSDnA2nhwsuBR7I=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=JG1GdKnCKfZvAaam8YgkChF/F7JonPTpmbRVNJyBh/W210PU4t9GHCNmzpmx9fqBLXkoV1OSTBnOicdTQIPkCA5ANtvCZKwGP+GxKsHXDign3AJkr6A8u7Ek9sPiRLYP/7KjLsv8HO6lEow0Ypo3ZZeDlihuCwJ3XUOVmZOV0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXWPq4po; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXWPq4po"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f447976de7so789330b3a.1
        for <linux-sh@vger.kernel.org>; Thu, 16 May 2024 18:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715908318; x=1716513118; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuYRAylKkV/HN0SZhDOF5G13bZ5TFSDnA2nhwsuBR7I=;
        b=SXWPq4poBbX63KpTmU4Q9eo1HKiFSpfsG9d9Vp7JUT4iMw9g+tTEuVl8R6CJjWU3FA
         1Jz7e17pj0fUdGttluSkGZSdOgErS0tFGziPS3O7CLLFnPbABlJVN2hTjlV4J119ldKa
         4yeN6XKHmHNxGp3P/L19eqc2d13JilcJK/8T57XoykpG4J/qZvxcN2w03GUa+1JqM8Au
         9qav6KVJf8B9pBEsnEwZv/IAlmJ/9TrfwX+mXqOMy/V7yKwXNCFtCMZevrUxavOIYDQu
         MbcDcQsUUCAacNpTXTVSmjtzfGMMf9TjZnLyei/oGU8Mz3jEO/EjG7J9hu22UV+jRKwI
         8Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715908318; x=1716513118;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuYRAylKkV/HN0SZhDOF5G13bZ5TFSDnA2nhwsuBR7I=;
        b=JmKNZfbbnVBCHX1llM/ZclQdfPb1I9tupeqXosIBDLv5u3aiC5qOj3OWYg1zA4lGpd
         pxYX/20mdb0Klqnq05tIS/fohWjgqwI+vkECdKajtIwxm61eWsEWUBmNlBmO9WC0Z8OA
         UEwLnxzNO7jzlq0ChX6YVlKqPAypFfUTd1L2K4WTpQza/A1Q5MaOo8YVasiUfycG8UbR
         sKHm0YqNCC4qlLD15rw9gw8xX60INljHKRguh/9B105mgFQcX1w2TiQBp50Pf/nmOjof
         3KIRblZQbBqh7cFcGGUEvLnF42yrHkmXa76txjFt+End1p7he9q2Aoni11S16OH/Tj0V
         So1w==
X-Forwarded-Encrypted: i=1; AJvYcCU5YkoThM/aRyM564KA8N4MZqLVSJ15r0yD4IzMy0sQqKrywScE77Ce75ysT7oDSWl9+oz9ECDz1FNVMJKVxKKbUZbuBMeNf8s=
X-Gm-Message-State: AOJu0Ywctdnp/QnuCvVEPwSaQ0WzEyTFWknaI3sA8z8tGsvmB5lU53hS
	YJiO5I/LRewsn10RwS7tQYMeVd+gvDMU86qsjEzH2/cbATTZWtxa
X-Google-Smtp-Source: AGHT+IER/jgl4yKbzqN7COdwShFJdDFW3ZPliivrjMi+NDinHi6on4651gf3ybqCFQTTm2PWrzcnXg==
X-Received: by 2002:a05:6a20:9f0b:b0:1af:df89:4e6a with SMTP id adf61e73a8af0-1afdf895185mr18882990637.51.1715908317956;
        Thu, 16 May 2024 18:11:57 -0700 (PDT)
Received: from smtpclient.apple (g1-27-253-251-207.bmobile.ne.jp. [27.253.251.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136843sm145728025ad.235.2024.05.16.18.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 18:11:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: "D. Jeff Dionne" <djeffdionne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: drop memory-hotplug on superH
Date: Fri, 17 May 2024 10:11:45 +0900
Message-Id: <C7951B02-F75A-44C3-A3F4-F57EA05CDE94@gmail.com>
References: <ZkZruHmlKd7GaRHs@localhost.localdomain>
Cc: glaubitz@physik.fu-berlin.de, geert+renesas@glider.be, david@redhat.com,
 linux-sh@vger.kernel.org
In-Reply-To: <ZkZruHmlKd7GaRHs@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Mailer: iPhone Mail (21E236)

On May 17, 2024, at 05:25, Oscar Salvador <osalvador@suse.de> wrote:

Agree

> we no longer support memory-hotplug on 32bit platforms, so let us drop the=

> memory-hotplug code for superH because it is a no-op at the moment.
> If there is ever a 64bit platform again, we shall re-implement it, and we
> shall do it on CONFIG_SPARSEMEM_VMEMMAP, since we plan do make memory-hotp=
lug
> dependant on that, and drop support for CONFIG_SPARSEMEM &&
> !CONFIG_SPARSEMEM_VMEMMAP environments.
