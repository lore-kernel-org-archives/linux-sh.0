Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010030B514
	for <linux-sh@vger.kernel.org>; Fri,  1 May 2026 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777607105; cv=none; b=V2HDgf9iQMamM7qX8+LNyfLjQlBM6hWCg9oNixrnpkBbGCmp3O0Dw49reAcW0VvOS+FUbxhCuVs3NU/9o5g2EtHj0MvxYfPTIFsXzXCqJHiCp/OUrXjekEStTotO+VBNkvE9D62f/c4f2z/dzhWWZ/QwiWGnJj9pYQjB1JPTwEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777607105; c=relaxed/simple;
	bh=1NLfq2K0MfXp0Amb74hl9vd6qXVKKtoXkunJ5DEV7xM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aPWckmHOej+69YYA9aWVV7k1eLSCW9R+aoJdZP07jjxrZMqv5+KASrgSpB8ZiNvZm4nYksytNBajeZxJ2NPD3BqmT9ZpDMwo/hmtdaZlW4LTSCMp/DxZtp4B+JBD1h73elN/3UbrvUgFaopuhNSLPDuB/gO4o+fzGmuB65wRlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovWqqmHO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovWqqmHO"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-364eef1891dso169824a91.1
        for <linux-sh@vger.kernel.org>; Thu, 30 Apr 2026 20:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777607104; x=1778211904; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEb7IloI2vBghm3zlyBW5gBxZr34u4UoH64QKXjYHwo=;
        b=ovWqqmHONEIVjt9zyX077g+bcKZ5GJq5GUbPgCjO1B2XWjXSHjU/j0TSWw7dMmBdaN
         uRENalE3BlI5HhzU3xFElPbGRZg+V4Mb7lhyz0TIBVlRWIWK6mJkEUIzmj7eZ0GfhTiA
         YlbfcVU8xfvc3XTA7pYK8BNvAuFqASk3Sup0yL5/LyyaMzBRwH9Nc6rbS3uDx6Hrnc0N
         E9MNn5WppcTIu6fBjdq3V7njsBMKgSPzC6C0pBT3iIykx6rZWG08W2WFQ+0A+ig+gJLZ
         nBCrVOyPUo6406I67CA2+vOF/LHnpKsdm0LAbUID0cpnE8OSF6fHtaaLcFz3q4ysW00M
         U37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777607104; x=1778211904;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEb7IloI2vBghm3zlyBW5gBxZr34u4UoH64QKXjYHwo=;
        b=X948tCDCrHZXKH9KxGPkSzV0rQFvO/u5uCtB1ZhgJtahVS4SKFURs3cskv8GWHDaXi
         1dQGw0mKSd+c3E/60D+M6D1yzOEyoQJlUaW2GnsVhrtuAokdmhuszeLuiDEYq6VjSg1w
         xntd+KvBG4yZHjo4rIENvpDhZ8ajgBQQWIIhkwhRBZkfDWG9uFFGUh2NA+636+gaz60v
         26SkHcNXwnTpVOZD5ON0os6kzYcCazXIiRn+JYOtjysrl+MVY4FHOHbCnX7kucI6JIkk
         WzinRZHvjP+609cSXqnT1IKu+H+RZWqaHMcatVUe1SKV7U9eKEhBEiGu2fr7GhCps/Tv
         i3nw==
X-Forwarded-Encrypted: i=1; AFNElJ8LgUbR2IlvFjfYU8pbVTZT/YQXRzdC2mYAZqVo18FAWTEHUJC5iZLGw/RhDHW2dRed5gJa3J+wOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfcM5T4lfGRUP39pEYN+Xt85SJoVEp/oHSfc8gX4u3JkJjuLm
	SmN4dtvx48LkM9xI5/R2MzkzaWR+QCfUVfTT4h5362jmshRmnod/qrkk
X-Gm-Gg: AeBDievFm3QAMpry+/l9gsHZ4M3P/DT+vJ/b7PTWDrv+RmjTlQvXmaqagoBUBbWemLB
	dyyvyayXw0asZ08bDl/qhEWNNbohvc1CgTotqnpE9yl5S4Y6bOc6SfoPa8MupXhec99H5XcghLS
	m1xyYYQXLqfmKM7dOaOuw2NoIeehGc/xBwaPBgEs0THEFsVD0cT41EVD8GHiz7KAYH3tdFI++aq
	z63goRgesFY+u/xJNhyAsH2GabDZ5R6A/ZAuMZ/B+cGt6qMRBQxs8j+W4Q26kyIW4G6ylby6Fte
	JJwWgcXKk2YpjMCuxbsKwGWdP9mO8gK/4i3s0ZJJiLjS+AzgIQs/vlvDuYoHhOg3yUs4Mv6Mgck
	/QqotTo7KLupnswfcfjJJwU4ba9+np4LbZl1XKrG7dA0973sp/IbwhAfWUwAG1XxGEg/usv/Hqs
	iBFYaAO0umvWJSlnVvWl71fx9QQVKTxNrb+8Klya3GXIh1c8bctgLQVuaY4dc0OZEb8D1eKiz7S
	29BqxXn+AYfl2bTW6l25l1CFQM=
X-Received: by 2002:a17:90b:2d8c:b0:35f:c0d7:ac54 with SMTP id 98e67ed59e1d1-364c3004653mr5981129a91.12.1777607103763;
        Thu, 30 Apr 2026 20:45:03 -0700 (PDT)
Received: from smtpclient.apple (p121132.f.east.v6connect.net. [221.113.121.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf54419sm4398738a91.8.2026.04.30.20.45.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2026 20:45:03 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: Toybox make root no longer works as expected
From: "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <e24b35682248a0e9b3f7592e5ba999ba387b740f.camel@physik.fu-berlin.de>
Date: Fri, 1 May 2026 12:44:50 +0900
Cc: Rob Landley <rob@landley.net>,
 linux-sh <linux-sh@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "D. Jeff Dionne" <jeff@coresemi.io>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C047C85-A557-4804-A531-57A98F7D569F@gmail.com>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
 <c1cbf376-9bd2-4c2b-aed4-e7c378ac7301@landley.net>
 <e24b35682248a0e9b3f7592e5ba999ba387b740f.camel@physik.fu-berlin.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

On May 1, 2026, at 07:46, John Paul Adrian Glaubitz =
<glaubitz@physik.fu-berlin.de> wrote:

> Could you maybe build an updated toolchain for sh2eb which is based on =
a more recent GCC version?

The main problem here, I think if it=E2=80=99s a version issue, is there =
is breakage in the GCC optimiser when used against the SH backend.  But =
it could also be the J-Core instruction set variant of SH2.

GCC 9.4 is probably what you need, we don=E2=80=99t actually use GCC =
11=E2=80=A6 Rob uses a different work flow methodology, with the goal of =
self contained builds.  Most of us benefit from 'golden compilers' on =
the path, and for J-Core that been GCC 9.4 series because of similar =
problems.  This choice came about after some testing, so it=E2=80=99s =
what Rich Felker=E2=80=99s musl cross make still does.  The results of =
that build script are used in every day work.

Yeah.  There is a need to properly fund work on the embedded compilers, =
and I don=E2=80=99t mean LLVM, which again has different goals.  I see a =
lot of folks and project suffering from the limitations that come from =
using =E2=80=98Linux=E2=80=99 compilers as if they were a generic cross =
compiler.  Retro BSD comes to mind.

Let me pull a kernel and see if I can reproduce your build failure.  =
I=E2=80=99ll try and do that over the weekend, or at least over Golden =
Week.

Cheers,
J.

>=20
> Thanks,
> Adrian

