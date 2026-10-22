Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651187;
	b=n7FGfg0wMDzgmxiHo5N51kosb2zIQn4z88K3lVoQ7q4KXgtHyjPG7HNt0w24Y1SHqfR6
	 2GSOiH1jDuGviNC+i8ntHXcW0Gej7GObLvoU1+T+kFOGOWcw4XkB44QgKj3ehzr0aod90
	 lDyR+9obWDZTBTd6nBv52T5siB5soJ8NoE827kRlBCnPiCR2lmAw/338V49toDic6PyRo
	 HLvPXui/daN1b8QVDyBEcC5Ubu4vPu9w3mvimN+9Dw9uTbrzQmJitEEtb3YuMiU3iS4rR
	 j95BFcYCFuUe4lJ+8KNpycICylgD9unuEXBaZGpmphwj2Cj31ytd+1SrNmvAZX6E0QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y11+vQFhjlxB59vrk3lIlPH7Q0J3elq3CyLWDXfXi9Q=;
	b=kXU3OO6mRLurVrIwpde25hgvVaK/dU6k6JA9cH9ukqFZFBTjVZTAW+VCWvy9PLWsaqnB
	 2nReQLo7CDGame8KLZe+xhOpkAdJJBmVSo30CXrOFPs7oXgIDuIRMUqbuMGpmEm94aDGc
	 0WYc+Dki1groB+WWJod5BZP4zCvNHFIx7LbH5VqkT865TIINFahAAyloHQqLW2G+cl/BR
	 DnD9ncMi4qHMq3OVN8SfavNMLBmO2Z1BuyrZr4J3+W+Vg0S5JE1wcvbpuRDHLAuKLa4lI
	 N31laTTpVw8j3OBgNFdjfqAqZ9T1FAV5rR0OgnPLMAN2+6taSyzWqhveXZUwb9i3Dsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="aHs/ahGq";
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9B606A31B
	for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 06:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E9B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aHs/ahGq
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso572012a12.0
        for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 23:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792651186; x=1793255986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y11+vQFhjlxB59vrk3lIlPH7Q0J3elq3CyLWDXfXi9Q=;
        b=aHs/ahGqZyXXT4FbFzTeZgubCwrmTF9x/WM3CtgJe1RjqeLT/GAHGwu3JDhmBEpPyz
         SYaKQzS/1qziyP2DLcPGGYvukoUmJOYQ4ucM/r9EaFK959YVM5T8NdhuFBzgOBjKW1Vm
         3jjkeofb/uHBoU93cdU7WKVVXWCKpO+DWHCQcCuQ1vFafzySGDPW4CgWqngIALrG1xtr
         GJiUuGN2UfWbTia0MdEU/g4VOaPUiH14BK+oVe9pWzll3o6e4RS3YiHwNPE2I2Hf7z4e
         ayFMKitEjV3MQeXsr609PdJf8VCAguvvifme+HETjTHCAGEWRUT6boqgjw2Wf98GGkN4
         MTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651186; x=1793255986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y11+vQFhjlxB59vrk3lIlPH7Q0J3elq3CyLWDXfXi9Q=;
        b=LjneITZwZQa2ajnrY6LJQeqoJpVnHd09pEqXYOrJku6qaSME6XVh0xP29Ic1aa51hz
         WFrsCgSzU7UlsMPXREfLdlusmlJ3Nc1FUgaWEtVxrU62wXiadsncWv4vf0DwOLHvhDzw
         ayjqaFbGQUJLV3u1SfhEFvBA2m3PL9u1y2UNoOEKZQwJK7o4dnzJxaFH0fImxHmdUt4Q
         35Vg4N5287yg+Bt+FJr6KrQjp7eppCCQLnlUR0oCrntYhM1UW1ZM1BExtdghwVo121En
         rEm7Lcx/OTJXVQiryrbFZkhGjj+I/Z55TXMcxu7b0hq2ZhVP4uai4f1nb5KM3ChoX08v
         XXHA==
X-Forwarded-Encrypted: i=1; AKwUvByktkvqsvEGQkVNov+FC+sLggQ2vUwPZgeYXN7jsiWmJKa573bNA7vAokz8NQDh9uPjIHmCj+XSJQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJAwB1nnQlZqsWQe197zBc3VwHb75tYOaMXIX2otaqgtbUpYiKY
	+l5AAI2wg9ADeU/+IvuAh+n5jAeEEjCofFgDcKb+YW0ZRDR6vM3eM5gw
X-Gm-Gg: AYBFou3rejKHh0K26MSO6OXVzN9C0wN14K6T+FpB2z2gWjTed3WESKtfAqFTTsBDDkM
	NqzFVHNShO8yKEcc46rx8/k14mvEvwwdi4cUJPhHo45prCZsZtU0F74E6STRT/VPqpU42l5k3wZ
	J3UjB+Ju5FWKeFFDd9lrkXR+IHno23rHsXd9zSzcd1ZlVLhSgyCRHWXiYoZwedlrfHlY+XWGMFA
	FDS6AzJctFRRqXIeK4J4ZYvqgFuG6xdR5JYkQYhOm/8g7pI7CC2ImSAjrC1CPgBemuCWAKOYP/3
	wKfJ8YyluGUnizy9pesCISfpj5kFMh3eTqMVkDOtEZTFkxin7R8c+CvkI06A9zFSBv7njJF/VNG
	ooxO1NTTqMm6l2ng+LJVtBcmoFRHeKSQgiPGANH4maPAF0HC8cBefZOt4KxJNKJkliF3TJ8TaFB
	AG+JB43SIyzrkniy/BpYw6oqNZtdMW6VAAZfrZo2NNdWek9FAWRY58P6wYIXsAyAJCBxh6S5yH8
	SyeX2laaqpalK6mVmHvYfRHc8GvN9iTL/m20B8M1VCywj/ztnsq+P2K0cABltqm6q+kVfa21W9L
	HlQ8p6DusVZR0l4=
X-Received: by 2002:a17:90b:5390:b0:3ac:9d83:8861 with SMTP id 98e67ed59e1d1-3ad86cdd7a6mr3323349a91.67.1792651186185;
        Wed, 21 Oct 2026 23:39:46 -0700 (PDT)
Received: from archlinux (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4887669sm2784741a91.2.2026.10.21.23.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:39:45 -0700 (PDT)
From: Artem Novak <artem122novak@gmail.com>
To: glaubitz@physik.fu-berlin.de
Cc: dalias@libc.org,
	ysato@users.sourceforge.jp,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	geert+renesas@glider.be,
	Artem Novak <artem122novak@gmail.com>
Subject: [RFC PATCH 0/2] sh: Add Casio fx-9750GIII board support
Date: Thu, 22 Oct 2026 00:39:34 -0600
Message-ID: <20261022063936.472520-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial board support for the Casio fx-9750GIII graphing calculator,
based on the Renesas SH7305 (SH4A) processor.

The series introduces the board Device Tree 
and minimal SuperH machine registration.

The Casio board Device Tree binding
has been submitted separately.

This RFC depends on SH7305 CPU and SoC support,
which is not yet available upstream.

The board Device Tree passes dtbs_check, and the machine vector compiles using
Casio GCC 14.3.0. The two patches also apply cleanly to Linux v7.3-rc2.
Hardware boot testing with an unmodified upstream kernel has not yet been
accomplished.

I need comments, they are obviously welcome.

Artem Novak (2):
  sh: dts: add Casio fx-9750GIII board
  sh: fx9750giii: add board support

 arch/sh/Makefile                        |  1 +
 arch/sh/boards/Kconfig                  | 12 ++++++++++++
 arch/sh/boards/Makefile                 |  1 +
 arch/sh/boards/mach-fx9750giii/Makefile |  2 ++
 arch/sh/boards/mach-fx9750giii/setup.c  | 14 ++++++++++++++
 arch/sh/boot/dts/Makefile               |  1 +
 arch/sh/boot/dts/fx9750giii.dts         | 15 +++++++++++++++
 7 files changed, 46 insertions(+)
 create mode 100644 arch/sh/boards/mach-fx9750giii/Makefile
 create mode 100644 arch/sh/boards/mach-fx9750giii/setup.c
 create mode 100644 arch/sh/boot/dts/fx9750giii.dts

-- 
2.56.0

