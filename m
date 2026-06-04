Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B4A47DF86
	for <linux-sh@vger.kernel.org>; Thu,  4 Jun 2026 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579197; cv=none; b=CEtiR9KrdF6vDrsxaE5DJTxvBCajQbBgSDCbUHIRyTS6A5NF30d8QgiXoaOMt5yenMvIOIfDDFAQYQSJDmGPcT9ahMh5/Ak+R7/fFN/6g83E+dIChTgNWUfh45bqV1YvTcWmRYfC3EX7z0+iOa4QRRssvmvLvhoqgbNR+Xuhp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579197; c=relaxed/simple;
	bh=R4we36p9qeb3bR5yeLPjWMa3iuESdosoLdNbQrwnbbw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=RBdlnA5deFnQ4R8I4PwfiIqYw6ju8Js+qS5Xp+0Bh7CXlW0MZFmxHB7x8hPBNpk97NYBcV05fcz28plueryFRdefcjdcYmOvNCd3SqscOYxFPOLHjwuPrwsxtfVgijPQCjKbNt0bQDn50EyJ20iP0ox/JSAaKZGka62vRVb0qSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf2b2OD9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf2b2OD9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46019edc13dso358539f8f.1
        for <linux-sh@vger.kernel.org>; Thu, 04 Jun 2026 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579188; x=1781183988; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xn1l2TJuksG9hWrI7UNiVITikDxe2DLajifMmxjpHU=;
        b=Pf2b2OD9pC8hs0fTQ+5aZmCNFECAqCJHP0dDB3926pvRYhjmjWMF0IwmMjR1tOGle3
         u2bJegNtAVZFAm5R6mJTR0+CVjqjTpxf4ffevMgM9C2KMpkeF7PIG8cpa7dY1wePxJxP
         IJ08WL0XZ4Cautw9u4DYVWpC2WzedNfTrIZ2BR+MkDhwLhj3sW7JWigw4aS4Rr12YFLP
         SzOCko8R9LPxsLCE6ImAfixwF9gE1W1HP3AxBxNx9mOCdbqpnoKMAUJcvLCGl0cHUfrz
         0ol0OKJyzeAxSTJ/fiPRQAyvidQpArRn9MNrRzBL7kdCsP80jfX7bxX5/dB4jfrfE1Wb
         GSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579188; x=1781183988;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xn1l2TJuksG9hWrI7UNiVITikDxe2DLajifMmxjpHU=;
        b=d8IVB5AxqyhpcwFfuhcH/uyt1EgrjvFKl5eXNDsrFK5/pb8wMswBDRAzIiR8TQuRGO
         FogqWlg9N1WxtGA5ppNrtjRIk3GZ7qphhKO+MrkOP01Nd5c+hknon4DqwEEAdfLCUh0P
         jWsGgItdoqOSQkuPkFd8wqcsNacFF6U8e+rU4mWOZaD3nu1HFdSujxKT4e0c6bjQDHYh
         Leb7/uOuzQdjlTdxxflpVKoqdjo6MNer6JnoHKwkjeuOzXBcix51ULVf/25U32/Mk2YS
         mZ/W5y5vODfCXIOWIo0uRhFOZuguVRRL5d4TCfchVMVj733/q7S7ytORr0P7+Rbsn/Oc
         rz9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+hFl0Rzitn0rVSfLtht7P84GyG5gI73GwP7IY1FbZGUL+GpIqdNG5jbsv9HouEcVMsn2JqcMOugA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVTr1uEQ5vdSUFoaIi37ek/AK+u7QdTXnjjCTrAxa3ZKrQtcm
	obcfSngKCxvRPdin67AOXQhZP1XaNEMhJ2UclYVO1gOR/zagT+zx+fQr
X-Gm-Gg: Acq92OFVRe73Xyh8x7tI1q4E2q0nEeWDDse31/EM2zWEbpqc76FVQyPCYJWvapoj9TK
	3Xga3h75Kzi1Gzm+VYXWw7EHQMbnqWLZsHZhPp7Z6q4ytEMGFsJDvFdmdSGLSf288r6QjMM9jQ7
	jjSfGy/qpWljbYcYsRmnLfHErs4VcY4QoNQjcJPfMR7WKOa7IJv9Q54YTNIN6aZuhb4KzaNpuS9
	VI/CA0tPYocgrO5arYZc2UyCSN7itbYtwnJNUTxafzPRAiWNZ/ClGu7jnC4Z9n0GR/Cd0u1uurD
	XkG+IrBl6C0Adb78TJBgge5hEcQt4mBya1TWwMDlo6Mutd2XPYVdNDxZtnppIWKZOA370D/49wD
	Plq6NVDTPYBvx7ygPLDCN++prPWPP8wZFOOPPzTo37pb056bKLbBcpMTVfuoxjavMx2r7+EE3/6
	1Ta7nNUA4a0/YtVmnOLdok7NMleteiF2IA
X-Received: by 2002:a05:6000:40c8:b0:460:1d74:a1b2 with SMTP id ffacd0b85a97d-460216e681dmr12313234f8f.16.1780579187766;
        Thu, 04 Jun 2026 06:19:47 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm16337889f8f.9.2026.06.04.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:47 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Subject: [PATCH v3 0/6] Remove remaining references to the pktcdvd driver
Date: Thu, 04 Jun 2026 16:20:23 +0300
Message-Id: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NzQ7CIBAGX6XhLIb/pJ58D+MBYW1RWxpAomn67
 kI96Ml4nOy3MzOKEBxEtGtmFCC76PxYgG8aZHo9doCdLYwYYYpITnCAwWfA0zUZm23BMwQYDUT
 cWmkUV0xLC6j8T+XmHqv7cHxzvJ8uYFIV1kXvYvLhucYzrbt/OpliirWWqhXUCk7lvhu0u22NH
 1DtZPYxKcJ/mVgxGSEIo1JYyfW3aVmWF8+MvUgeAQAA
X-Change-ID: 20260530-remove-pktcdvd-references-9d5c6362a5de
In-Reply-To: <20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com>
References: <20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=R4we36p9qeb3bR5yeLPjWMa3iuESdosoLdNbQrwnbbw=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6nWWTd8PNG5pa6ncseOD6qKrzIFOLXtr1v1hfSnD2
 7Kir3BaRykLgxgXg6yYIsuLc9fbNuw5E3Avya4FZg4rE8gQBi5OAZhIsCAjQ2tH5sHzGVb84Zqa
 1vs95lneP3w/Z7cBZ+JTpWcfsk4JCDAy7BLNvOpwTvaV8Czn9C3Pz2uIy76cJe3ct+IVW8sRo1U
 f2QA=
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Found this incidentally while looking at kernel sources to understand
what pktcdvd is

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
Changes in v3:
- Split the defconfig changes in one patch per arch
- Add patch to move the declaration of scsi_device_from_queue to the
  private header as suggested by John
- Link to v2: https://patch.msgid.link/20260603-remove-pktcdvd-references-v2-1-c4402154d53a@gmail.com

Changes in v2:
- Reworded commit message on John Paul Adrian's suggestion to be about
  the removed references not the export symbol
- Link to v1: https://patch.msgid.link/20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com

To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
To: Rich Felker <dalias@libc.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "David S. Miller" <davem@davemloft.net>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org

---
Catalin Iacob (6):
      scsi: core: Remove remaining reference to the pktcdvd driver
      scsi: core: Move scsi_device_from_queue() to scsi_priv.h
      mips: Remove remaining defconfig references to the pktcdvd driver
      powerpc: Remove remaining defconfig references to the pktcdvd driver
      sh: Remove remaining defconfig reference to the pktcdvd driver
      sparc: Remove remaining defconfig references to the pktcdvd driver

 arch/mips/configs/fuloong2e_defconfig    | 1 -
 arch/mips/configs/ip22_defconfig         | 1 -
 arch/mips/configs/ip27_defconfig         | 1 -
 arch/mips/configs/ip30_defconfig         | 1 -
 arch/mips/configs/jazz_defconfig         | 1 -
 arch/mips/configs/malta_defconfig        | 1 -
 arch/mips/configs/malta_kvm_defconfig    | 1 -
 arch/mips/configs/maltaup_xpa_defconfig  | 1 -
 arch/mips/configs/rm200_defconfig        | 1 -
 arch/mips/configs/sb1250_swarm_defconfig | 1 -
 arch/powerpc/configs/g5_defconfig        | 1 -
 arch/powerpc/configs/ppc6xx_defconfig    | 1 -
 arch/sh/configs/sh2007_defconfig         | 1 -
 arch/sparc/configs/sparc64_defconfig     | 2 --
 drivers/scsi/scsi_lib.c                  | 8 --------
 drivers/scsi/scsi_priv.h                 | 1 +
 include/scsi/scsi_device.h               | 1 -
 17 files changed, 1 insertion(+), 24 deletions(-)
---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260530-remove-pktcdvd-references-9d5c6362a5de

Best regards,
--  
Catalin Iacob <iacobcatalin@gmail.com>

