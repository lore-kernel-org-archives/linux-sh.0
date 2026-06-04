Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17347D954
	for <linux-sh@vger.kernel.org>; Thu,  4 Jun 2026 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579199; cv=none; b=G/Tsfxw7EpdfI3FoRiu6/mLPvPk26vfE2KIqiXe2GIxrdIekpAMoAgX/4KYSLfiy4wj0O9PJQw2zP6DnmseLzUjyw5RDvN4VT3FFWw9BMqjaXsiFPnrhMnm+I5XlSUK0CKlm8xLZOHbdiccIeJbYfewabEGlM4GS6Szi2HSzG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579199; c=relaxed/simple;
	bh=9eVs5ZEWu5PvYIeNWvEPYnAIntZhT6pYVPj8oRQzPMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trAl9JDA8vtEy2+PdDyZIdSJmjFfofyyc/5TL5KRCkfnHq16aMVT/fFdV7liwHctOCRN0/UOFo2J9hrLkT4o26ezr7DIL93cfLP4ZYjfFekWt2ONUm0/+cL8qL2xoC6ifoAl7kR365aLvtG86dTqp3Spsb4XHhx/en3mYKg1HUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpZ3l25S; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpZ3l25S"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-460166910e6so414822f8f.2
        for <linux-sh@vger.kernel.org>; Thu, 04 Jun 2026 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579193; x=1781183993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaZcDuR1/GVoL4knmseDPUzz2J8S5y/tkogd7uxcn0M=;
        b=mpZ3l25SQenUDvGZoaVJnEVxe1HXEkFpGlBhLdeOckjQjtO/yH+NAuqA2SLfFJetF/
         ZyV2JCse2h7PtuwvqwcegCR6ZJxJHTSRACPG53tdpFoPHfPDja/mt2JhBUmQqkEOu57D
         CjV8usPRapvIKuOdiiOoj77OOl2JHfNJOOGZe5ba9Dp8rI58KP1ibBxgzWW0SYp+en+q
         Z1Nhq9YqFJWmXE0Mcb8LErX+EKAxZSz/8uMOzjPVwf+Xx5m4WkzCtXHIag9xR+50hHxZ
         zU3f7CLKizV6i6r0lqWN9tJUEPS/iMAK1dqqyzhsZT972JyNStQUEMtzRVjsTKxXbUfs
         pjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579193; x=1781183993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aaZcDuR1/GVoL4knmseDPUzz2J8S5y/tkogd7uxcn0M=;
        b=Lez9MN/ud/xhXZF23V+X3JG73aJM+ojhd/5Cf9QBCFs0g32jk4Q51XQcMqFOdOBpXA
         h3ftwKOqGPsTGwvtdOGrzKeaYVaYLqL9Gf+r/gCL3HfEwEe3YM8cUAOpNX9Nvjnkg5N6
         CpGG6gYY9DxcYLUffrXCLDCPJi2y6LXey5bKJfsDI1DWpRUwHjzidn2Ctgx+O09OaQFX
         M/L0tTGe8IwNU/cGxTSj+HdhBSBQtHZf3A1Ac416U4M4Jdl2zyFWAw41W3152XbBHNfE
         o2w9eWKWLNa8vpYBUS5sDIjWuZWw0DO1rfyAz3ls1x/F2P/8EQEOxfXRO8P8wUE4EUNs
         THWg==
X-Forwarded-Encrypted: i=1; AFNElJ8jdNrYnFsoS+C3eBECcPH1TKtY7Bwke+Z202GtoD6j/0HADTZAQ7Kkaxc8+z1LFf8jeOAI3Ee1Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FfWV3UYiIracLo9UaHjiScaV5Pc3umyEl5gT00ulKugVjz4i
	ty2ZkY4W5ia1mtsXrGaNB2Z5CZzonRbxpj1JbfsWA890CZ8MRLdMSr8R
X-Gm-Gg: Acq92OEpIZZWSEkBz7PX30S3KxzPl+uSEIjNQMUvRtacC7WEQlM2bIeFKNtLB2k1tF7
	5kwF3TW+jX9nMJ+B/ZYndys+X82qWRV+8ZHOriRZ4DMDTirTc+2zttn0n0RwODH0QtM90+fGKxk
	uS1qM6+XSaQr/szfp++v20FN/psbo0BsXySrnaqhpQd3i3e+R6KV3xthNhFZm8CYQaiKuPpd8QN
	cl3FojHSOVRsW/lOgkbwPur1xm3vodNKkV8YYt8GQppPuJiclpeFZA4onwKNL3z+Y/tzGNf2qba
	cAbadbcOABvI5IvZqDY5uYKrFc88bwpm1gYdDiRBzT4R05hyWCjb2fLEYtV/89Yml/cv+N/NKUG
	txAYMDqmniexcGQDgQoyGo5Lf9FZorpZO6c9uZMtSSFwHTRtscttCN90INCQbJxYH6mYbfs2gRD
	B+OWzaNW+/gtw7WuKbN+PZNFzVr0RQ27jh
X-Received: by 2002:a05:600c:a09:b0:490:958f:2a5c with SMTP id 5b1f17b1804b1-490b5ed6375mr133235845e9.17.1780579192962;
        Thu, 04 Jun 2026 06:19:52 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a52dacsm7715545e9.1.2026.06.04.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:52 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:25 +0300
Subject: [PATCH v3 2/6] scsi: core: Move scsi_device_from_queue() to
 scsi_priv.h
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-remove-pktcdvd-references-v3-2-e2f06fb4eef4@gmail.com>
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=9eVs5ZEWu5PvYIeNWvEPYnAIntZhT6pYVPj8oRQzPMQ=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vU3LqT3G94r9cqys+vtuZina/9q/t07UmFefy8un
 b3PXWxjRykLgxgXg6yYIsuLc9fbNuw5E3Avya4FZg4rE8gQBi5OAZiI+zSGf0qLXDQLS2uXPT03
 Kf2kWOsWYcVL01cdWXVcSm7NuVPX+4MZGWZd0Pu7+WuqS5Kxo3SX/azfa+t/Oh0x/i7Au8Di5/Q
 djEwA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

scsi_device_from_queue() is only referenced in drivers/scsi so move its
prototype to drivers/scsi/scsi_priv.h.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 drivers/scsi/scsi_priv.h   | 1 +
 include/scsi/scsi_device.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 7a193cc04e5b..37e5601be2b8 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -102,6 +102,7 @@ void scsi_eh_done(struct scsi_cmnd *scmd);
 
 /* scsi_lib.c */
 extern void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd);
+extern struct scsi_device *scsi_device_from_queue(struct request_queue *q);
 extern void scsi_queue_insert(struct scsi_cmnd *cmd,
 			      enum scsi_qc_status reason);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 9c2a7bbe5891..9f716497a959 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -407,7 +407,6 @@ void scsi_attach_vpd(struct scsi_device *sdev);
 void scsi_cdl_check(struct scsi_device *sdev);
 int scsi_cdl_enable(struct scsi_device *sdev, bool enable);
 
-extern struct scsi_device *scsi_device_from_queue(struct request_queue *q);
 extern int __must_check scsi_device_get(struct scsi_device *);
 extern void scsi_device_put(struct scsi_device *);
 extern struct scsi_device *scsi_device_lookup(struct Scsi_Host *,

-- 
2.54.0

