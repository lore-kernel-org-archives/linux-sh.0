Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671403;
	b=DMGMuWED/8bMmpE7hIYAnElMkirvqYL6adUXHYEme0wZqyop6ICCsHsoj0VIJungB4W3
	 c8S1exfRmg21Ng4xlzptaf50pphmbw0TmS52HeOCVYruQhuqUcCaD8y+LmsD4nGfFIqwb
	 fWbiBW9ekKOJDauwrU5+0EOwnxYVRsJYcRkH2Q0v02J+vcsTf3OJfnniIyqGUUFwj6x3K
	 Q8PJrqRUSEeWbLfLcbApEJBKvfPoKj8mpZ4iRPjJv2Ys9Vzn0uQZniU8hqWiQYoCwIfuH
	 GsX3lBn9FK0ljCxTazWaM05eVxmTr+HxXhjqsbFI/rmrttuCoc6/84jAm1C0/2sjHsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Q+4wFXj/scRyLRETk+4as5GVEAcw3ae5bD/5VEbfu74=;
	b=Non/BgQ3hwu8gt8Re18F1aP6qBtVtD5Kj81eecYN05sPpkegoftBNE9tB7x4UTleri+n
	 Bcmz0b3Tn4nQEQnHEf9cCQjk8pr/Dwz/1ZNb2PJ8zquq0ZqanXlQgbn9LEoLeYFU0fatY
	 MJVpyLzdI+DyGKkI2vUT19bvhMOkJTN+rEVyahgHHK/SD3HS5rdgFYjMzxc8fijg4VXbW
	 ILzOsI+u4OCPj8Wh65ZJvRXyX2hKGzT193qLWFqi7O3zjzBLptfO60IGfBn585mV/0qs9
	 J+ixEbFBZtTJ7xsKlfpAyea1kSIFhcJuDOTU52nYDHZWt89zAnBmMHAR57R76Jy8gGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EApHrOKE;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02A7606A31C
	for <linux-sh@vger.kernel.org>; Thu, 26 Nov 2026 05:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A02A7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EApHrOKE
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso6123233a91.0
        for <linux-sh@vger.kernel.org>; Wed, 25 Nov 2026 21:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671402; x=1796276202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+4wFXj/scRyLRETk+4as5GVEAcw3ae5bD/5VEbfu74=;
        b=EApHrOKEzIMdhiS7qR3/q0y/NFQKxz59xXy5PqAaSwCYqXSUQlcLANUFQwYZ5v6U1K
         GY5d/sUnJ0RRtqBWIOTpF4uWdaJ4dnd9HiGBCRviupnNLga2TlJMtCPeKAywz5nbcm7w
         MSwvnFglsmunh1pB4e7jJHlVZmhmqX/J6gnu8ExUf9+JY0TZaeV6GNrSYrfcmjrvTymg
         1JQdvIk4tri9r8+YAyvQ/Fqjo62xPwMVdRM8phPh9dAIsHUOZFRl5lESssHhdVa9La7G
         oj6WtQKSUWsUl6kbibVy0SihTw/c+uvOj0/HYVtqCiciMWFhibgjknYl8mdsZeq7fZO2
         CvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671402; x=1796276202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+4wFXj/scRyLRETk+4as5GVEAcw3ae5bD/5VEbfu74=;
        b=aUCTnV3SOic4VUGYmaQnS4J6b9IdcgWA44ZzRNTZc1YWUsfAlNAxPDrlRICQxLLaH+
         8xEWLClH/WidUR5AxDpKNw4yBa73bqdUSk+haYx1ry0ntQyg1WCuUrH2B1yh9GWDxVeW
         siOtr5+WDPNHBDZcXjR1C9F6COMVwDOExt4I5+eUzbQAHPU7s+miCE0WpCVdJbxbZyRL
         Nz/cSwoLQJTwYS4PFI1DymG6gF6Y8JEj+GHAxBvgxPf2FfpQ5Yp5MxfCvCwMp4qSAr82
         COl7PhW0cj3VN+AgWOADcX9tEh0WaIKLawdTFbKpZWEVnUx7LeNYnsRBrUFn201vvDva
         DBJg==
X-Gm-Message-State: APuU4Z/XKm2wIkS6ziEa4pyKvCFHvAEOUgWTOYcqoCbz7ZBiKFiE6MBf
	bnIWWKUlNSMSyCVXFfQtOOf7IHM/NJJ7eoDJseXbK5qPfgH9PfgRBBR9
X-Gm-Gg: AZFdTZfRhdVni7LcWFfDsU9p2ubtZJpzkqEJvrBa/RvShCQndd9HASfdevTGlh9oK1E
	ursKLgGr/H1UzV+qyEWPquzD5eaA1/YT7UFaap4T2Cj2qzUi5P8XrwJ/tO0aTwAGM4KmQVIlWBA
	E67lwWdYcU0MHzUs99mtboCK+GUzXB7mEezhTRHVux6FYyuV8ojizbX334oDHF0lnUSVPlXbBEj
	tC6VZXu5xQV0GxdjzanYw8Xpq+tomRityplw/kp6C1UVqv4UT9A7EG1laPP/zbGBpWqqa0Y9IAR
	e0kqT7i92HehnqGZ7NG8o6kFQEbreLCpumHw9fFXPrNQxTdEw2jl20HqpdH+SNkuz3S3nVFk/zx
	FJzpgNqi6eLbyyZV/AqiyPooKC/l2kpSynjuYQ6AAfhKz5uZvPrFfo7qjASchIjrwN3MMnRaIJX
	tMH7iqgT9HJpcd9r7m6T2xy0vk/jogVn9G0R0z+fMzx8SShnVVPsaWl3OliBztphwePlhaaWShH
	7fUL2kyduK5oprnMpsvRdMnE4k0DcBjJ+BmAVgpXWzGNdlu6Hkn0HC1ti09jEWn5hGtYDTrYx1G
	/O7GGH3OYJ4rS15nXIFlOHu30HCP6OpHW1uG6pblMk1qSlcN9TOcjLw1bbzuwtKAMD3wgMU=
X-Received: by 2002:a17:90b:2e4b:b0:3ab:330d:6e47 with SMTP id 98e67ed59e1d1-3b41c8e0ce5mr12480480a91.10.1795671402029;
        Wed, 25 Nov 2026 21:36:42 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcafe0sm33096242a91.16.2026.11.25.21.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:36:41 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] sh: mach-se: clean up IRQ table whitespace
Date: Wed, 25 Nov 2026 23:36:26 -0600
Message-ID: <20261126053626.18680-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Remove trailing whitespace and fix comma spacing in the SH770x IRQ table.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/boards/mach-se/770x/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-se/770x/irq.c b/arch/sh/boards/mach-se/770x/irq.c
index 66e2c8aa0b69..d1978b3a52be 100644
--- a/arch/sh/boards/mach-se/770x/irq.c
+++ b/arch/sh/boards/mach-se/770x/irq.c
@@ -40,7 +40,7 @@ static struct ipr_data ipr_irq_table[] = {
 	{ 2 , 4, 8,  0x0f- 2, }, /* PCIRQ2 */
 	{ 6 , 4, 4,  0x0f- 6, }, /* PCIRQ1 */
 	{ 14, 4, 0,  0x0f-14, }, /* PCIRQ0 */
-	{ 0 , 5, 12, 0x0f   , }, 
+	{ 0, 5, 12, 0x0f, },
 	{ 4 , 5, 4,  0x0f- 4, },
 	{ 8 , 6, 12, 0x0f- 8, },
 	{ 9 , 6, 8,  0x0f- 9, },
-- 
2.56.1

