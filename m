Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663342;
	b=MNCPb+4ttCGWboJDGPn+YzgRiKzNyWL4FJP+7yKr/o3MxJKrO3tIhwaTORO+GBabcCis
	 c76l8Lw6c0DB0sTUGiJPvwW11qJMyWLBhlJpInHGSGlKzWSsliA8kQuARjDp7r+a02b9y
	 Q+FTSUeunavOLNSSw+PRADxaE53rzY5dY+0UZLe+a0v8kVH0CwUFcjlvaLbN7T+YH9LMZ
	 i02QgKHK0Z3ZeNun5L3h6V0Uargh/rNamaRj3/DJoc12W8MdJJFQFIrhPC5FJvyQa0pwU
	 QdbnC9DcA5VRHO8je9DfAVUU44vcg/Z5Mh8uDCeL1YmXAMQdVaeSm0KCuLz8EZTYwBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UV+/ZRWPXj5zR9R7iNbWuT2HN4DRi1qwj4JLYShBPJQ=;
	b=ifxBma73PmCfrBDw1BHA7Y6ng8ut1X2tgdbKWlykfiPkLF4Ig7WrcfUxjBA4Tj3hEydk
	 acOSGxkDQH4pqVOgvwyLkjnS7w6ipZ7uHx+NvDq8nmgU5Hzs5PX/VmVyhME/Tx4w+Mni9
	 NEgKOQ3bLQ8n5fomdDmP5GoYF++TWa+T4DnUSyYRPuocq3udn8Wdm+sIFdwFY4odqvWik
	 h1m848VwPdR0vzEmfjFYkxokpUf1DBlHuCeGazfdziWkukNfGGkkjLilMSX3q2pI3wkFU
	 pU619+TYMBPA3ujE4xEW0/kvOr4xFsE4NNbpw2SwwbquCPEyNYQI8YH2fu92CjGufig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=v7JBj9En;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945C606A319
	for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 10:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4945C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=v7JBj9En
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1c9879395so602781a12.1
        for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792663342; x=1793268142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UV+/ZRWPXj5zR9R7iNbWuT2HN4DRi1qwj4JLYShBPJQ=;
        b=v7JBj9En9corg9JMqvldew0g1TqTCr9QMVtHlvvmfIGL84VmjslOqirYe6wfuvnLgh
         Ee1SMADjjpmS+4Zn1MEy8j+Ao43psUbjZlEs68dp/AvIwQNdJVbxcHClkjbaKKEm13ss
         oE4NaMn0WUc3KOodboBrBbM9odmg6I27NSOAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663342; x=1793268142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UV+/ZRWPXj5zR9R7iNbWuT2HN4DRi1qwj4JLYShBPJQ=;
        b=Lxj/n0CnrmyzFdRVgoZMJ806gSSBR5bNtWrtmCHh0+hLuf02JiBLwsevRZhA0UEmdN
         r6i9sNOmfuMrxf0gVA1GJcqNAhSwpBGP+7LMY52sXdWaHhxYqXjswV9PripPP2gzIrOE
         rTU9BVpiGOOzv10ldClr4ASZAUZ4mLdMnCrkAKKX92SMwntAc7JNpaRi0Mg60TUyxn7f
         R8iIaIh+Q/M1Ctu/hGszmPpItr3UMGSWbp0/IsucR8b7sFksyoDtN4clUnk8WaeQDNHh
         cGpIq3CLNsEGPQjeOIO+uTDGmlIbV71mTv8uJO9tYES1PCK+NVQaUBAf+wdiwRyvtWnJ
         XtLg==
X-Forwarded-Encrypted: i=1; AKwUvBxi3ZfWu6Zj+nMV512x8iOy/fti0p5CdoU41pcfkE22xgO2U1QGG5aJndQ3SrWDsgGxiF3fdJtXxg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIwhvg4b3ZeyUjShmDmtl3HMhz8u/gkT86B2HNhoALT4wRQBXE3
	s/SaoilNLbPwFCK8yey/oYFOD06C+GxBMZ8/pXa8QR5IxXHSudNJzDHV8tGLMGr2pH7xuRRHK6c
	haEor
X-Gm-Gg: AYBFou0vSvkgsTZ4irK79ThJmYKPycg7jnpSQaaisObUunAB8osIOB/6+GKaEa2TeBf
	scH7yiYz71rAtoqHsomMfIjMH4O1E0qy4ySzs+Z27qbrndBX8NAPtPfW9i1v/ssiW1MRZfF66RR
	SMTmBG1sEJy2oLR44XJjwWks3Fxipn+nvrjrK3FExiKv0EyYXLXP38t5HKCI97pxh8q8e0Xli/4
	i/qImK7vYVCKsUfrAWkVk6RcQqTERpPjXOIIbT11vCDmMkCq27e0JJoDoYoB1+6it40nRw9DKSV
	O8KobS4kdwDW+yc9TrshE2aNaYC5pYG5PJSVtiaP32Ui0aGGDV30v2QgqZBktJvPavTODN6B3kN
	gRlr07feie6bLkPrrIcJOLqbaa0i8chXW6ApbL4NewNxDo+QeCIyhbDZmw5l48i3HaVWCw3SM4l
	5FbpYLIYRXAgPyv/zhfijbSXH2uwy5SQI3Rv3Ck5Dz2O5LFYVTX8LFYET9cKOvFiwq7e8ASIa3u
	FrtSL3SGvIcGVwYu8LGTrWT60IFWF61W3iqUHkPRQN0yesatr3rshT2X3jkOFjM5tSJSHl4vbuF
	DB54ppKilLPrjDoM/wmTTg==
X-Received: by 2002:a17:90b:514d:b0:3ac:9ed8:f309 with SMTP id 98e67ed59e1d1-3ad86ce7ca2mr4173183a91.29.1792663341710;
        Thu, 22 Oct 2026 03:02:21 -0700 (PDT)
Received: from shiro (p1722188-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.166.142.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3ad85f856fcsm3971440a91.2.2026.10.22.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:02:21 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: w@1wt.eu,
	linux@weissschuh.net
Cc: linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] tools/nolibc: sh: enter _start_c with jsr instead of bsr
Date: Thu, 22 Oct 2026 19:01:59 +0900
Message-ID: <20261022100159.525910-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
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

bsr has limited displacement and cannot reach _start_c if its
more than +/-4KiB away.

This starts to show up if you have big programs (static binary
of the game Quake in my case) and/or use LTO and things get moved
around.

Replace bsr with a calculation of the effective address of
_start_c and jsr.

Tested on QEMU and real SH4 and SH4a machines.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---

I'm no SuperH asm expert but this works for me. :)
Maybe there is a way in C to get _start and _start_c to always
be close together that would avoid this entirely?

 tools/include/nolibc/arch-sh.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-sh.h b/tools/include/nolibc/arch-sh.h
index 996cfbe1bee3..7318f52dcba9 100644
--- a/tools/include/nolibc/arch-sh.h
+++ b/tools/include/nolibc/arch-sh.h
@@ -154,8 +154,13 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __nolibc_no_stack_prote
 		"_start:\n"
 
 		"mov sp, r4\n"               /* save argc pointer to r4, as arg1 of _start_c */
-		"bsr _start_c\n"             /* transfer to c runtime                        */
+		"mova 1f, r0\n"              /* load the effective address of 1: into r0     */
+		"mov.l @r0, r1\n"            /* load the distance to _start_c from 1:        */
+		"add r0, r1\n"               /* calculate address of _start_c                */
+		"jsr @r1\n"                  /* transfer to c runtime                        */
 		"nop\n"                      /* delay slot                                   */
+		".balign 4\n"
+		"1: .long _start_c - 1b\n"   /* Distance from here to _start_c               */
 
 		".size _start, .-_start\n"
 	);
-- 
2.55.0

