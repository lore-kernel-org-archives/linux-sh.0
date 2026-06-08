Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA53D3012
	for <linux-sh@vger.kernel.org>; Mon,  8 Jun 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928896; cv=none; b=QIZuMQgbGZDMlEQEHdI9Bm+Dp7dXZTvJwx5lkwuld+EL0sM0ERCSyA5J/CdRwKtXpDORoVAjJTycu+BBaz2aa8I2B0k2t9VodSEBoeJCQLKuhaW6/vJYtt6Z9EGRFqvr5GuZ28kIxl1a9XSv80PZ8NJ6pm1xNBSCyYnyXgmvqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928896; c=relaxed/simple;
	bh=LvrQuMufMa2jstaWqw8VwauAYnxPiY07NBjKrPJoU1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCyJvBz8PN8gY6BW88kcBvOUH5hEwqk5tiKEm52vuRCnxD/8/zP3ahlKRCesninDCq1Fp3GQcnJOr3AKNu+9SlePRCU8nwZCRRp0nChPKdxxdJKivn95g4q/qNg0F7DxTnKKIUKzl4ueXXRSK9HmmXvIDpN5IxPokknxO/XZLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kv+vlgp5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv+vlgp5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so56886755e9.2
        for <linux-sh@vger.kernel.org>; Mon, 08 Jun 2026 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928893; x=1781533693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sp2ANuSp/GV260EEmEmdmugr8RRzCxVHzflIi+KBBt8=;
        b=Kv+vlgp5kdi2qYGCLYtSOBFY7632hpK3jtwqPAW3rjVhdTSXjkuwPcPfoc2xse+V+9
         cW76o1Lh7v/JipbCyAsL66ONeZJHBhFeCZljO35Gr/gEZxpKVK6jMCu5+LTx4OSeMuOj
         gx0YUwWfh6mD3MegG5aiiUIeYb9ioS4YNNvzIWwEc6NN4pCgkSRYF9eA98I7irQoxo+/
         vsOxcU37bAgn95imuybUkTQPx3CcSdZOL4XzewbY72e14h14I1r26VhyhFvyanZSmWOk
         tTN+j82/iNVdVXsjhLbUrltH1Izwl/aJ0i6iJHMAF3SMYQwH6dGQvfb32ayIKhM6CW4/
         OU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928893; x=1781533693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sp2ANuSp/GV260EEmEmdmugr8RRzCxVHzflIi+KBBt8=;
        b=pjos7kO5nEuE0owlWFB5mKSfIemfYuTIBSBxBX+q6s9S09HPBra8LBX7qnjq+RaXk0
         O+yWhQA42Wlh3vC3FlGvyuRi/7eujs6qpGsCfABb+8pRdbMQ3ZXhUSgcaHLbAdKX5q4/
         zUggvtiYmU6AQYuePRmUKV0YCRNAqloE5+sc+BJZX/nhlWOJi5sF48gz/Yb4hOwTvCU5
         72T2kogneNdduu1IL3kHZEy9Di62SqocLqY//pIqrRfIzvYSjQ299ajAhiT+97sryA7D
         C7n31e88f4g8ZqNPunddgANo+dgLzPGLSXp3J9eNj+Zj9hyguJsshWcgI8VcRF27Fzn+
         Ql9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9+ub5lYNH9SH+f5aLHGKu6auukvuqFw4nXrKB1lCNP+tq7AOj0lkLZudZzAykxS+Q+JzeZN9o4XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXniuMzBOPGrksXrMF3WJEwNdVOoF0nq0DZkZ9LjNlE7oqoezM
	K2CgcTky4cQTBmXVMpvBxTYEQteObRP/zpkipofJHrodAcLtxbi0rTHp
X-Gm-Gg: Acq92OGecIZsFge707knDQ29Dfyiekvdtoy9uILu1j5VgKlxYXs4Gfd4CGyqSoSgFdt
	FOwJDoC90p4tM4vKBFRLm+FXcpQ+wmzgcQv+QIaIi30SNarRORDqHt5mD7aQ36TgH5k+Wra4LSm
	6L6JVu52jCIZJUeyhEDw2tjPfjm8CITwqjvfe4+uJD8WVNAU4ataG6zbmNgpRODgdUrFSco4v/O
	ml4GhFXJ4m/ySaLjKK8rUnyDFjNkNNZajGl2468FF+qzmBe8b0q2SxCEA/K3Mr5a3lwmgMr/DMn
	JJkQaDoOemtpBBeGYUoaY+cwF/xtid1C7GVOFkPF23zgzT1SnY2qvfGXpFfAYgS6e++K4ZcxMsn
	TzV7l7c8j0ojuLCuaSrsJGkwj7+dSkPADdhdgGK32gaGEdDDLb8VfXLOxpP5CA1IYRPT8X9mQ0+
	edj0QhoJGzqPq1ucYLGUZl3oaNXDvdLW1q
X-Received: by 2002:a05:600c:34cb:b0:48e:6db3:ff3a with SMTP id 5b1f17b1804b1-490c25b09a2mr267979525e9.16.1780928893422;
        Mon, 08 Jun 2026 07:28:13 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm407415735e9.7.2026.06.08.07.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:13 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Mon, 08 Jun 2026 17:29:16 +0300
Subject: [PATCH v4 1/5] scsi: core: Remove export for
 scsi_device_from_queue()
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-remove-pktcdvd-references-v4-1-72f88b04cc87@gmail.com>
References: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
In-Reply-To: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=LvrQuMufMa2jstaWqw8VwauAYnxPiY07NBjKrPJoU1M=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1i/trmY8wXFU74qot2bFMQKYllkdpZl28/6LcZt/OR
 qdEq6qOUhYGMS4GWTFFlhfnrrdt2HMm4F6SXQvMHFYmkCEMXJwCMBGLYEaGGddjWhj5Nom9NZZx
 dnsg6qDb+vSPoVpBs3Rha/1MyRkLGBm+xtTJSfmev1K2/2Tr4t/P9C4Ibt+n+LLSJ2aHYv+PR4K
 sAA==
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind an
export that is now dead code. Remove it and move the declaration of
scsi_device_from_queue() to drivers/scsi/scsi_priv.h.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 drivers/scsi/scsi_lib.c    | 8 --------
 drivers/scsi/scsi_priv.h   | 1 +
 include/scsi/scsi_device.h | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 85eef401925a..b67f0dc79499 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2224,14 +2224,6 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 
 	return sdev;
 }
-/*
- * pktcdvd should have been integrated into the SCSI layers, but for historical
- * reasons like the old IDE driver it isn't.  This export allows it to safely
- * probe if a given device is a SCSI one and only attach to that.
- */
-#ifdef CONFIG_CDROM_PKTCDVD_MODULE
-EXPORT_SYMBOL_GPL(scsi_device_from_queue);
-#endif
 
 /**
  * scsi_block_requests - Utility function used by low-level drivers to prevent
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

