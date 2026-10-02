Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82D51A3166
	for <linux-sh@vger.kernel.org>; Fri,  2 Oct 2026 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976762; cv=none; b=TERNJESVdl/rwQj6FkY6mtNgWCuxQk+0+KqGb8eeI4chK/1NnqC1auZJ3v1EbxkU0JZL05hEuacqaPDSVKdfkzyFf07n9ePSkc6CYNnALSkP75LbBSdligZ0t7CfRCSmtl7D46ZzYZZd54GAUz37HmuWHPsDzTKm7C3pp9srtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976762; c=relaxed/simple;
	bh=x/M1kcpxvSKi4krGnkQAPZbV9dIa2IiLAsV2NlsNxjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtNumoQvxl5fzHK5mKTShGFtWch6uir6HMb/Y/DxJlmjj04CRvHiFQJ9aQ1kTUDTehSx5WMZ9mdzJE/xNASyEG/WPvmGBlTEngri4Lh7S0d+N1ksaN3twkgHPyrgyKIn+bCJAx4Zw7Mm4jYLqDxL1gsY5dvrlFuP2K8BxPWS3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0dvm9IX; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0dvm9IX"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a1681949b8so1076215e9.1
        for <linux-sh@vger.kernel.org>; Fri, 02 Oct 2026 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790976759; x=1791581559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fRbVgDYdNJlvmRSpYo0bQrmNNcQh1akysnltqtNjmKU=;
        b=n0dvm9IXxRkHyw2nrayYWRhRnTRGel8oMBmH5wRCXBdq8opmgXOF3dEBkLmT6TOrdL
         D80zPuTF9h2mW5x36GlIl0efMdbMvOpE8upjGEnXGFb1n/+j7GyWS7Oe46t6dCBjQBu9
         EhTM53Az+R4LMTWgjfLUH4HT7t7XVNHZ0rMvTeUWFlZ7XjxI0XPffZB59PkUlvVe5ehK
         DCYH+3lqVnjskdl6kX+rmf2wjERrYE0XanzJiI38kpDL1UA96Klzsj/3XVpUhX+0EOof
         BaTMaGAFFFDgIVaL0j7j3mVQf2k0KEqzgDuW3OVrsdrk08oPbSk53h47D7aGigcdS5dn
         YRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790976759; x=1791581559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fRbVgDYdNJlvmRSpYo0bQrmNNcQh1akysnltqtNjmKU=;
        b=2OR/TaRnuSteF5SJZUAmsq0yKFOc3vZOna+aZfKTYH2TxGycc7gU6D7RfXNxBc7NJA
         MfTYYGK0mRdkyUBOvMWJVF9a8kJRWh0xw12lFastBA/nK9Mr+isFfnr0Ewx3dgh7fnEZ
         IUNADATCVf9I58bkpoGlGIGP+vh98R5Nqp2y2lJPa+/KP6V3d+4u66iyi3ON7unpCryX
         bSY3h5CTCiZ1r7RKtoE0is0MKpX7SmBSWqJQSVlEXqPfztwaL9e7HeOHCApLGzPRIyQM
         AjZdDg9EzPBueiGQe6qtvoaShfMyfHpckpQK9Q/xch4tATTofoxUbvScP5JpKcw+WEXv
         R+sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWH4Tfxz3pebKpO4oJM63SA3PCFT1co5KN3k0PaXm42UtnNT2BjAIG0XoB8j+BNZ0TOzKVO0Ztxw==@vger.kernel.org
X-Gm-Message-State: AFuF++l7ZSPLAH/tB4CIx2XtobWmhw47MQKu09wO0HfyomMjmzZDxSRd
	pj/PSLMe+g2KkOMFXNov3Lf96XkoW5ps6+HUw1KQNhrHrDNKS6I6ZW9M
X-Gm-Gg: AYBFou2x5xnYV5Mslrj/wFX5/OpDfQGSMC3RoA1mwc1gxtCsPYXpELogytZUXHHEDa7
	5++QR46oMzoLMvqbMlzqte8Rw2/KAyJUKxYCaUx+qlIq7sWzOtxnyl0Y5KO/Wb7apSlRWAyjiTN
	yOISRW1ON8riYqJBxtQTb9WQlrZqKf7gdyn9JW96Hr3/0TebJxlisj/Yv7f/nn+buZL3sb5qsh0
	8NFIj4cYB0rvFBK0EUvqQ+wX3tmWnmahNBA0W6249vRChlD6Yjp068auf+uovQF7JoU12+dS7pp
	ixkxS+IHH0w52ACLCenk6ncOaNHjw7HojDEoaWIuFPal9ylpTZ6Fw2l8taquujRXJ0v2lvqjRWU
	Y+YJoFg9/pwR3rYo7qb3Ic6lbXX2ykQijUOE2qVlbDeLalih4+Pk79jqW4sE4RigmhV9uXMUuwE
	p8AwCwnEGO5SO7FNKAQxmPDY2nU+3GaVHRmyiERduSWTfJKoMNn6hloPOIDEjWeyT+ZCe0iQ8kn
	v+TSUHgGuLH/IFE529Q1VituGXoyU1AHVBNh68XyeZPsuop9DRSdpcKmsvs1zIT13hCTx5YIvrK
	/YZOOSF9Nd82Uyo5PbUFfiNHrmsfHeA3kZmyxhLMOLUMOkNHLOMHKcUX6R+/Tjd5QWYRF21UsYy
	Xzg==
X-Received: by 2002:a05:600c:310d:b0:49f:c18a:61c8 with SMTP id 5b1f17b1804b1-4a027598d30mr79255705e9.29.1790976758917;
        Fri, 02 Oct 2026 14:32:38 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-af35-1901-81da-eee8-c2d0-ee3b.310.pool.telefonica.de. [2a02:3100:af35:1901:81da:eee8:c2d0:ee3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff56136sm41162795e9.3.2026.10.02.14.32.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 14:32:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-usb@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: r8a66597-hcd: fix buffer overflow on odd-length FIFO reads
Date: Fri,  2 Oct 2026 23:32:25 +0200
Message-Id: <20261002213225.27834-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For an external R8A66597 (pdata->on_chip is false), the driver accesses
the FIFO 16 bits at a time. It rounds an odd byte count up to the next
word and passes that word count to ioread16_rep(), which stores both bytes
of every word in the caller's buffer. The final word therefore writes one
byte beyond an odd-length read, past the end of the buffer when the read
fills it.

This is visible while enumerating a USB device on an SH7785LCR. The USB
core allocates nine bytes for the configuration descriptor header, and
the controller driver stores ten bytes in it. SLUB reports the first
redzone byte changing from 0xcc to 0x09 in usb_get_configuration().
Odd-sized HID report descriptors trigger the same overwrite.

Section 2.8.5 of the R8A66597 datasheet requires software to discard the
excess byte after a 16-bit FIFO read when DTLN is odd. Read the trailing
byte through a temporary word and copy only that byte.

Fixes: 5d3043586db4 ("USB: r8a66597-hcd: host controller driver for R8A66597")
Cc: stable@vger.kernel.org
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/all/3bd32eaf159db61ed1d423e1d52a869b3689c682.camel@physik.fu-berlin.de/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Reproduced with 32-bit and 29-bit SH7785LCR kernels against a local
R8A66597 QEMU model. Before this patch, slub_debug=FZPU reports overflows
for the 9-byte configuration header and the 63-byte HID report descriptor.
An A/B test of this patch with the 32-bit kernel enumerates the keyboard
and removes both reports.
Testing the fix on real hardware is welcome.

 drivers/usb/host/r8a66597.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/r8a66597.h b/drivers/usb/host/r8a66597.h
--- a/drivers/usb/host/r8a66597.h
+++ b/drivers/usb/host/r8a66597.h
@@ -178,8 +178,15 @@ static inline void r8a66597_read_fifo(struct r8a66597 *r8a66597,
 			       len & 0x03);
 		}
 	} else {
-		len = (len + 1) / 2;
-		ioread16_rep(fifoaddr, buf, len);
+		count = len / 2;
+		ioread16_rep(fifoaddr, buf, count);
+
+		if (len & 0x00000001) {
+			u16 tmp;
+
+			ioread16_rep(fifoaddr, &tmp, 1);
+			memcpy((unsigned char *)buf + count * 2, &tmp, 1);
+		}
 	}
 }
 
-- 
2.53.0
