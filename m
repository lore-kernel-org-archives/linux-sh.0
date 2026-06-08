Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19562F8E8B
	for <linux-sh@vger.kernel.org>; Mon,  8 Jun 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928895; cv=none; b=QBvY3bKM2xou2vdxanHiFDgyU34FbKjltUC1UWMHyvGWBtmdWaybe8gt2337AWkRBctYKDV4EMPkXFbn+d4RmI7IieiRWsm5u3seeHHFLIsYBMoTxsajGbPT7Nvixt6b0ZhhCLAVnvvnlTg0es8psL/czk5bx7qjWRcZbWyukmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928895; c=relaxed/simple;
	bh=+ZZ7cFq5dwFJfX2qzMhubJAhfsGyZm3Hq/4kBQpei7Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=D3/lKpyeeCFCLYEfnY1w0QXD0ECQ8tAZ2Rt8eBuyS4XFfvnxlN1IDSFAivEFvz66ldNrKp5LS9ZWsqoT/rB0tJ56ELE4C5MQKUdrHDm8L4QTXiMlCxXOyizYAF6BNXs67JRbnJJa1HNSaVb9nm/+NUqoaQ4q5DE8/CxUPKAUUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoIQwmOp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoIQwmOp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4905529b933so47641115e9.0
        for <linux-sh@vger.kernel.org>; Mon, 08 Jun 2026 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928892; x=1781533692; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmsMCsySwkboeE/wYirejWrkdI8tJ+BFCA1yM7dXRi4=;
        b=IoIQwmOpitYCWf1Fbq/XWSjEnmtqWy4WXJRV4UN6yIJ5GWSUFJws3A7IwzfWhpdftL
         JgOL/KyS9Sw5/u9nUsO7EMDSPgfSKsfPtp2SPsqamtDKMKuxn+OhLLMQtr2i90ZVNbGx
         282TxW+4AhVX2BGZWk4Rs1uIin8GHedGz7HVe+hI3o7UxXfG9Fxip5UTQWBU4H8RQUhw
         LS9LxIRYsO+wsEBgCemOvhV+l3addkWQtYKeFEQ/5stpUyd2l1daoTBnvrB4sbKyJoqh
         nZOLx4dizF6Fk6e1kSZP+ijixSkkaWjnvNavI0dmbc4WlwPxj+ost+X/pfBuiookxr+8
         1wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928892; x=1781533692;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmsMCsySwkboeE/wYirejWrkdI8tJ+BFCA1yM7dXRi4=;
        b=LKPT7UIkkYthyMPUk8DbOQW5GbBBAJzq+Z50DbzPZl0t8106P/jkxjPB47QV9+SKk/
         OSkchgtRKDDhpli6t8CW5QTCUN+4rYA54g0c1zXJCElfN8UD9qwAxBbeoTBY6DfBRgBX
         8V+MpzyGHRrlJD2VOeZZCBCEUnmelFaZ8c8hOCDelY1PsXpaNaMhA/skFe2XQIoumhsH
         kD9A1q1pu/F8liPOujymq5OReda8O2n74a7UcfKTUsd1XM1FmvVALU4IFfu/1BdM6boT
         /wuMQZtzr7s+EsQQg/FzjbZ4Ly011K7g+CsOP2Z3Fx7zLg6cU9O9oYMkzm8PhhURxoSb
         52lw==
X-Forwarded-Encrypted: i=1; AFNElJ/vw6EiFLmGufmGoeKeQsOMW/RDjXwqzPInMh/ARmsMg64LEJCla+pbMILRfyAGBTmBWLSB9hacSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdgGJXafblWSh5VtyEV8zSGBCxWmMvfhP7KyxC07GOGCKQQ3T
	nuTBLDsRot1GtRz/RlRnHDGdnu91AFP7Z4zOAJyJ/2NAp90//xjx4pJ2
X-Gm-Gg: Acq92OFyEipeqaIotvuXq5ciNbV1DAohJ1LwqKo5eBftn+AjLHJ/29ubI3/sih9gAI/
	j+8v2fiVtlepqvNNWQCagZgLeVzxFLrWMmQ1QvkexCF1sohKNV3IBofDg7wEnwo0wVJXx77D9mt
	g2eJ5gINRVHyTQq3yLJw1rmSd3yu9ru3ZGoTUqwFlW5LFGyQNvdQLdc8fDB6B+lqkectGYgdQC8
	wDczdfy5UL1ZTMKS1kSXotFU1kdNnVnduFKUgFSbaTzUt/r6Ypty8D40aPaBCAUqYKbEwLXCJ9I
	AxkWLMNtTEd5Le+kljyQ27DiJ81PUa1rrYLjVUgujjcleP9woOGsnbLP4RyD/uzmaFKiRoE6Ivz
	CNFXMylP9z5IqovIkQvnnqetkoGIeVqqlyaW1iUrqpGUjnFpYsreLb2GJqc54IUB6/B3tzVrMDO
	pwVAym23VQ33E14Dd3yis83wI7Hc6ZvJPw
X-Received: by 2002:a05:600c:8b0c:b0:490:ba61:7981 with SMTP id 5b1f17b1804b1-490c25c1e4amr261216285e9.23.1780928891973;
        Mon, 08 Jun 2026 07:28:11 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm384624305e9.7.2026.06.08.07.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:11 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Subject: [PATCH v4 0/5] Remove remaining references to the pktcdvd driver
Date: Mon, 08 Jun 2026 17:29:15 +0300
Message-Id: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/43Ny4oCMRCF4VcJtbaGXCoBe+V7yCxiUtHM2BeSn
 qBIv7u0LkZmIbM8cPj+G1QumSt04gaFW655HKATtBEQTn44MuYInQAttZPWSCzcj41x+p5DbBE
 LJy48BK64jTY447S3kWEjYCqc8uVh7z+fu/4cvjjMK7g+TrnOY7k+4k2tv/90mkKF3lu3JRXJK
 Ls79j6fP8LYw9pp+ldy0ryTNCoMRFIrS9Ea/1cyrxK9kwxKZJ2kSwdiTvQqLctyB3V1sixoAQA
 A
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
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=+ZZ7cFq5dwFJfX2qzMhubJAhfsGyZm3Hq/4kBQpei7Y=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1i/vDZ3kkXfQ6eyQ6d6J4Eb/bGbG7W3VcZA8ZBvt2Z
 ezoy9vWUcrCIMbFICumyPLi3PW2DXvOBNxLsmuBmcPKBDKEgYtTACbCm8rwTy9bLUjZ98ixmcoV
 jbfvrmcqDFy6bsHa0zufu5kynAsrNmP4xbxzhuSHTS1CS8RM37mtmmTYV/139uHnc4rvTq8MNdx
 RzwQA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Found this incidentally while looking at kernel sources to understand
what pktcdvd is

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
Changes in v4:
- Combined the removal of the export and moving the declaration to the
  private header info the same patch as requested by Bart. No code
  change.
- Link to v3: https://patch.msgid.link/20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com

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
Catalin Iacob (5):
      scsi: core: Remove export for scsi_device_from_queue()
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
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260530-remove-pktcdvd-references-9d5c6362a5de

Best regards,
--  
Catalin Iacob <iacobcatalin@gmail.com>

