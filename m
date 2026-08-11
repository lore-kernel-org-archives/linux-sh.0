Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF113A9615
	for <linux-sh@vger.kernel.org>; Tue, 11 Aug 2026 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431149; cv=none; b=ioh8aRnMBRGCtK1dMvJV7kwKn/OeKNNYQbduKhy3dkPrSaBpIeyABbjloJ7MIN4cNVXzV77nvnX6R1cEpJYC00YUU5WmWNb/KvaRKdevJY6MHnHc0DDdDyXx70za2J5PNhMqgA71Z/eV9d+hAvz7gat4Mqmw2eplJkBHk8FiJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431149; c=relaxed/simple;
	bh=NXuh4k3BVwSe/SB4k5mip7uJDnPZ/AU54LI8GzcuC2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbfXskEjIzZlkRLBXKp2KikvIYMoWD1CULwh+aAb1iqak6AZ48sPn0qCqyy0CZj31j6QPvPnMyCO/US8tZRZTULl2Sna/Ugrvnofs3vqyb1zV67ZmXOz+u66bFQNUJW+zJLF1gegPXFbUEJvrL8x49hE7bGGrVZbQBlJ0fRPcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXX7mwTp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXX7mwTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A851F00ACF
	for <linux-sh@vger.kernel.org>; Tue, 11 Aug 2026 06:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786431147;
	bh=M/kxU0ciBkg+f+v1Rlo/isFgwwqPaorb4ouuY8L2kTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AXX7mwTphUjF4p8TJoP5z+hk5upx/E4Rpg0tVbEkNfqQBW64JEU/FnISeBtJyJSvG
	 0xt8Xn6T7Xa/vi3WBMhKMJd11f1tToY+DYmP9jCzwHK0NdE3gvtldeNUyNnRek08xm
	 PqLioUinhYeiihM7+hFW+CJns0VGUwrV5ETsXt1N2N3/bjtWohDE31IQ69hyhn17fV
	 MHnr25CvRtBC9X7tW2gaGYMuEE2ryJrDErLPkwWyl4RmlO9tZV79on/SeuKJJ3Yd24
	 AMV8a0sPExcNxW11zCE+OI0GrBsWCZM8O6T3BQiE4DQZJ4UtbzaFAY1NhO2Rfb10Tg
	 ANXLNh7uLUlkA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so2435541e87.3
        for <linux-sh@vger.kernel.org>; Mon, 10 Aug 2026 23:52:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp66S7ItEXsudPOpVJ7XQHd7K8efx+dyrtR1drlBIpgp4OI8nRIfJ8Cg4+4DkMDcV/IyPbI3A+66w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNPVMioraVNy6INuUooZqNRWw0mrgylENb4xVV5wiCpDgWoGs
	be9Zhe8xjnRLh+njE55cRaO5vTNjSQ+3Nhx/zzkBM3V9vNOUuftcnxX5Aewx24asuF2ZgK9j5ro
	xWvx2JjgWQo9iZ0MuZk/Zc7qcLeQcdgk=
X-Received: by 2002:a05:6512:3b10:b0:5b0:22a6:6b13 with SMTP id
 2adb3069b0e04-5b4485aaf7bmr184734e87.0.1786431146560; Mon, 10 Aug 2026
 23:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
 <32a0d810bfc56029453aa72cefa49cb40466f64e.camel@physik.fu-berlin.de>
 <anAvJM0u_TIgL4ck@google.com> <70cb2e4d8a6fd11cbeb534dbf269f67148a00a8d.camel@physik.fu-berlin.de>
 <CAD++jLkxXYfZadV26956yMAaCtZYr7mRGPA8_kixufbXFW1B=Q@mail.gmail.com>
In-Reply-To: <CAD++jLkxXYfZadV26956yMAaCtZYr7mRGPA8_kixufbXFW1B=Q@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 11 Aug 2026 08:52:13 +0200
X-Gmail-Original-Message-ID: <CAD++jLmNry6DwjDm490_n1Z2AmBb7viaOTEv_Ntnsc77dBHmJQ@mail.gmail.com>
X-Gm-Features: AUfX_myP9ycRl6EKwwU2Rl-2jzLaOookIMohV7p6sZTzXVjLLQ-PeHBAsVlQYjA
Message-ID: <CAD++jLmNry6DwjDm490_n1Z2AmBb7viaOTEv_Ntnsc77dBHmJQ@mail.gmail.com>
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: avoid using inline compound literals
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 12:05=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:

> 1. (easiest): tell me to just revert this out of my tree.
>  Deal with this whole ordeal later.

The merge window is coming up and I can't send a broken tree
to Linus so I went with this option now.

John: the patches are all yours, I have dropped them from my
tree.

Yours,
Linus Walleij
