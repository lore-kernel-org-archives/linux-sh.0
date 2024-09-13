Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426840C03
	for <linux-sh@vger.kernel.org>; Fri, 13 Sep 2024 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726196157; cv=none; b=LlZ9umliAgN+lpL2Df2NDAeZmB0w8JcqsHZCPYooeefk3ls00Wqay4EA618ImlADJdmIV4OE3MYR2FXRMDUyJH4y3Cg2IxD2WGbKBhsVd/UvPMCErHk4LdHOK1/4t9HmrbdJz1KFsym/MOrR/Bn4gWJzjNYqroY0GcBkEjNiHtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726196157; c=relaxed/simple;
	bh=4pCVVm+IdujmarRypHhg7gVqX0USvdIt9y+qYTPMzBM=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=TcCDQqoSq+EHq6WP2supQPf4Gdc/tJ/5LpMHttRUiPWzvCwcrvk5xyfi0oxpNCsoesGuCSIXVG0QNX5RUfhP2gp7MCC7kKQk5///YXZSAiVwO+327y2e9xXfD8kvsVMi/xs6CXJ750zhNvg8xl1WpRzE7UY8a3LKmE/8CLc7N10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=gbiGRPb2; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="gbiGRPb2"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-710daaadd9bso906306a34.2
        for <linux-sh@vger.kernel.org>; Thu, 12 Sep 2024 19:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1726196154; x=1726800954; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y084YwtBrAeQYeNJK2R/sPLBTQOclA0VaE5hZrR2JB0=;
        b=gbiGRPb2DfZS6kKzts59BwIcJTTzkk6tpYsf0LYJb1eojOeOTFaMPJuHJavqWgvSRh
         fvuyVOztacB0YIOrFNEMGrCLer85OMhuooQGZqXxD48zy/f7Ey/pxGnfOeOIgA5gVS4y
         OOllNPGnpvG24YTjqeBYC88o+NgUgdG3D6r46fpeg530K+7UVBQEq/Gk5wAaRWfytK/h
         KMTYTA6P1o0vZZYmGGNy2GprBnPnSfsmaDweGk6g1X1/e2/DOaF+GNvaMgpkZy7821jd
         0MkIfxED1+00i0cOYVsAnOxXcFYMHQrABioVhWkR22X8BQTR3xIjqXDv4mJRSY228ZV0
         BiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726196154; x=1726800954;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y084YwtBrAeQYeNJK2R/sPLBTQOclA0VaE5hZrR2JB0=;
        b=Y+TSRzHcuVdsRcnwO9x2n9cxD0HdlS0OhCd82igslmNb4CPXIyoUAq7LdF2QxnV+NI
         LdCKUGMXGYHHsBfQ1DywvwbYpo0S2JKifwvV8UfR59FIX/7U6J4CNKpu6s4nrOhjDrxj
         G9zltldBFUx/9JakhtwEzyMbtC5q0LYVCFyQZXmW/s4Vx4/2E+jyj1FqnloAaelSgoF4
         2JNGEz6fJBTSMdT/GwCZUy9es6NVTdF/KJyMScij7nFZaoXvoUfmlCFAnTqY47zAj6a1
         oodawGLPoS0ndVHetEDvyW0bCrQndX+0qiW3P4UxIddnMcKJoudR7xCjF9z2UgIUw1OU
         OK6g==
X-Gm-Message-State: AOJu0YzJ9jRNqw73kJ/Y4+kj4d6ZLWZjPl7nd/XMMohSdr0JafQT9unB
	IXjQI/fmSXTtp2Y6hbLpsuIGmXDkG2YcOiNz9y8vy7qYv8x9oc4fTCCURmPq8qJOE//0bzyvzid
	fjek=
X-Google-Smtp-Source: AGHT+IGpkjbuRRaIJOfIAgRMplHhAw4QILDcXNWhHIPunPyVjId7QFt3mde/VJY3KJZArEzwX9e/Kw==
X-Received: by 2002:a05:6830:65c6:b0:710:eb9a:f8d1 with SMTP id 46e09a7af769-71109486190mr5708798a34.17.1726196153681;
        Thu, 12 Sep 2024 19:55:53 -0700 (PDT)
Received: from [192.168.43.7] (M111108020212.v4.enabler.ne.jp. [111.108.20.212])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbbf69csm2428531a12.44.2024.09.12.19.55.52
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 19:55:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------9XcUTwgllYyIEUT0TdW1gO0I"
Message-ID: <02cb40b3-ca86-5402-34e7-501331e00a09@landley.net>
Date: Thu, 12 Sep 2024 22:10:37 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Linux-sh list <linux-sh@vger.kernel.org>
From: Rob Landley <rob@landley.net>
Subject: 6.11.0-rc7 sh4eb "irq 123 nobody cared" panic?

This is a multi-part message in MIME format.
--------------9XcUTwgllYyIEUT0TdW1gO0I
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Anybody else see this? I have it in the boot log of a test system from monday,
just got around to looking closer and the boot failed with...

printk: legacy console [netcon0] enabled
netconsole: network logging started
Freeing initrd memory: 560K
irq 123: nobody cared (try booting with the "irqpoll" option)
CPU: 0 UID: 0 PID: 19 Comm: scsi_eh_0 Not tainted 6.11.0-rc7 #1
Stack: (0x8ca2dc3c to 0x8ca2e000)
dc20:                                                                8c3a09b2
dc40: 000000f0 8c431048 00000000 8c39b81c 8c01142c 8c80f900 8c39b674 8c04fb0c
dc60: 0000007b 00000000 00010000 8c80f90c 8c80f900 8c80f900 8c80f900 00000000
dc80: 8c04d5a0 8c9c571c 8c9c60a0 8c9c55a4 00010000 8c80f90c 00000000 8c80f900
dca0: 8c050140 8c80f940 8c80f90c 8c80f900 8c04c8d0 8ca2dd6c 00000000 00000011
dcc0: 8c4df9a0 8c3a7000 8c0150ec 00000000 8c3a6fd8 400080f1 8c01142c 00000000
dce0: 40008000 69ae3000 00000000 fffff800 ffed35c6 00000800 8c9c4000 8ca2ddd8
dd00: 00000000 8ca2dd6c 8c9c55a4 8c9c60a0 8c9c571c 8ca2dd34 8c255e06 8c255e06
dd20: 40008000 00000000 000007ff 69ae3000 ffffffff 8c253d04 8c9c563c 00000000
dd40: 8c9c5634 00000000 fafbfcfd 00000000 00000000 00000000 00000000 000000ec
dd60: 00000000 8ca2dd64 8ca2dd64 8ff138c2 00000200 00000200 00000000 00000000
dd80: 8c2567fc 8c9c60a0 8c9c4000 00000001 8ca2ddd8 00000001 8c9c6200 00000000
dda0: 8c9c6200 00000200 00000000 00000001 00000000 00000000 8ca2dde8 00000001
ddc0: 00000000 00000001 8c9c629e 8c9c6400 8c9c68bc 8c9c61b4 00000046 01080000
dde0: 00000000 00000000 b0ec0000 00000000 8c9c58a4 00000004 00000000 00000002
de00: 000000fc 8c9c68bc 8c261ab2 8c9c5660 00000001 8c253d04 8c9c619c 8c9c60a0
de20: 00000000 8c9c57e8 00000000 8c264784 8c9c5660 00000000 00000000 00000000
de40: 8c9c69e8 8c9c4000 8c9c4000 8c01142c 8c9c68bc 8c011424 00000000 00000000
de60: 8c9c6a2c 00000000 8c264514 8c264124 00000000 00000000 8c260740 8c9c4000
de80: 00000000 8c264124 8c25febc 8c2627ce 00000000 00000000 8c264124 8c264514
dea0: 8c25e9b4 8c253cac 8c9c4000 8c264784 00000000 8c9c2040 8c264784 8c264310
dec0: 8c9c4000 8c01142c 00000000 8c264124 00000000 00000000 8c9c4000 8c264784
dee0: 8c2623a8 8c9c687c 8c37d2b4 00010000 8c253d04 8c9c57e8 00000000 00000000
df00: 8c9c6a40 8c9c687c 8c9c68bc 8c262742 00804000 8c9c2040 8c01142c 8c9c4000
df20: 00000000 8ca2df2c 8c9c2000 8ca2df2c 8ca2df2c 8c243894 8c243828 8c9c20bc
df40: 00000000 8c01142c 8c9c2000 8c3a2a8e 8ca2df6c 8c9c2000 8c243828 8c01142c
df60: 00000000 8c037772 8c827d54 8c9c2000 8c243828 8c01142c 00000000 8c92b800
df80: 8c93c3a0 8c0151c4 8c84bf38 8c8285dc 8c011424 00000000 8c01142c 8c46b41c
dfa0: 8c03e4d8 00000000 00000000 00000000 00000000 8c93c3a0 8c0376dc 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 40008000 00000000 00000000 00000000 00000000

Call trace:
 [<8c39b81c>] __report_bad_irq+0x34/0xac
 [<8c01142c>] arch_local_irq_restore+0x0/0x24
 [<8c39b674>] _printk+0x0/0x24
 [<8c04fb0c>] note_interrupt+0x24c/0x29c
 [<8c04d5a0>] handle_irq_event+0x54/0x84
 [<8c050140>] handle_level_irq+0x68/0x110
 [<8c04c8d0>] generic_handle_irq+0x1c/0x30
 [<8c3a7000>] do_IRQ+0x28/0x50
 [<8c0150ec>] ret_from_exception+0x0/0xc
 [<8c3a6fd8>] do_IRQ+0x0/0x50
 [<8c01142c>] arch_local_irq_restore+0x0/0x24
 [<8c255e06>] ata_exec_internal+0x176/0x428
 [<8c255e06>] ata_exec_internal+0x176/0x428
 [<8c253d04>] ata_dev_next+0x0/0x94
 [<8c2567fc>] ata_dev_read_id+0x164/0x454
 [<8c261ab2>] ata_eh_recover+0x6f6/0xe18
 [<8c253d04>] ata_dev_next+0x0/0x94
 [<8c264784>] ata_sff_postreset+0x0/0xb4
 [<8c01142c>] arch_local_irq_restore+0x0/0x24
 [<8c011424>] arch_local_save_flags+0x0/0x8
 [<8c264514>] ata_sff_prereset+0x0/0x94
 [<8c264124>] ata_sff_softreset+0x0/0x15c
 [<8c260740>] ata_eh_autopsy+0x24/0xd8
 [<8c264124>] ata_sff_softreset+0x0/0x15c
 [<8c25febc>] ata_eh_link_autopsy+0x0/0x860
 [<8c2627ce>] ata_do_eh+0x5a/0xfc
 [<8c264124>] ata_sff_softreset+0x0/0x15c
 [<8c264514>] ata_sff_prereset+0x0/0x94
 [<8c25e9b4>] ata_eh_link_report+0x0/0x5f8
 [<8c253cac>] ata_link_next+0x0/0x58
 [<8c264784>] ata_sff_postreset+0x0/0xb4
 [<8c264784>] ata_sff_postreset+0x0/0xb4
 [<8c264310>] ata_sff_error_handler+0x90/0xcc
 [<8c01142c>] arch_local_irq_restore+0x0/0x24
 [<8c264124>] ata_sff_softreset+0x0/0x15c
 [<8c264784>] ata_sff_postreset+0x0/0xb4
 [<8c2623a8>] ata_scsi_port_error_handler+0x110/0x450
 [<8c37d2b4>] memset+0x0/0x8c
 [<8c253d04>] ata_dev_next+0x0/0x94
 [<8c262742>] ata_scsi_error+0x5a/0x8c
 [<8c01142c>] arch_local_irq_restore+0x0/0x24
 [<8c243894>] scsi_error_handler+0x6c/0x2c4
 [<8c243828>] scsi_error_handler+0x0/0x2c4
 [<8c01142c>] arch_local_irq_restore+0x0/0x24
 [<8c3a2a8e>] schedule+0x1a/0xf0
 [<8c243828>] scsi_error_handler+0x0/0x2c4
 [<8c01142c>] arch_local_irq_restore+0x0/0x24
 [<8c037772>] kthread+0x96/0xc4
 [<8c243828>] scsi_error_handler+0x0/0x2c4
 [<8c01142c>] arch_local_irq_restore+0x0/0x24
 [<8c0151c4>] ret_from_kernel_thread+0xc/0x14
 [<8c011424>] arch_local_save_flags+0x0/0x8
 [<8c01142c>] arch_local_irq_restore+0x0/0x24
 [<8c03e4d8>] schedule_tail+0x0/0x58
 [<8c0376dc>] kthread+0x0/0xc4

handlers:
[<(ptrval)>] ata_sff_interrupt
Disabling IRQ #123
ata1.01: qc timeout after 5000 msecs (cmd 0xec)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
--------------9XcUTwgllYyIEUT0TdW1gO0I
Content-Type: text/plain; charset=UTF-8; name="linux-miniconfig"
Content-Disposition: attachment; filename="linux-miniconfig"
Content-Transfer-Encoding: base64

IyBtYWtlIEFSQ0g9c2ggYWxsbm9jb25maWcgS0NPTkZJR19BTExDT05GSUc9bGludXgtbWlu
aWNvbmZpZwojIG1ha2UgQVJDSD1zaCAtaiAkKG5wcm9jKQojIGJvb3Qgdm1saW51eCBjb25z
b2xlPXR0eVMwCgojIGFyY2hpdGVjdHVyZSBpbmRlcGVuZGVudApDT05GSUdfUEFOSUNfVElN
RU9VVD0xCkNPTkZJR19OT19IWj15CkNPTkZJR19ISUdIX1JFU19USU1FUlM9eQpDT05GSUdf
UkRfR1pJUD15CkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9TQ1JJUFQ9eQpD
T05GSUdfQkxLX0RFVj15CkNPTkZJR19CTEtfREVWX0lOSVRSRD15CkNPTkZJR19CTEtfREVW
X0xPT1A9eQpDT05GSUdfRVhUNF9GUz15CkNPTkZJR19FWFQ0X1VTRV9GT1JfRVhUMj15CkNP
TkZJR19WRkFUX0ZTPXkKQ09ORklHX0ZBVF9ERUZBVUxUX1VURjg9eQpDT05GSUdfTUlTQ19G
SUxFU1lTVEVNUz15CkNPTkZJR19OTFNfQ09ERVBBR0VfNDM3PXkKQ09ORklHX05MU19JU084
ODU5XzE9eQpDT05GSUdfU1FVQVNIRlM9eQpDT05GSUdfU1FVQVNIRlNfWEFUVFI9eQpDT05G
SUdfU1FVQVNIRlNfWkxJQj15CkNPTkZJR19UTVBGUz15CkNPTkZJR19UTVBGU19QT1NJWF9B
Q0w9eQpDT05GSUdfREVWVE1QRlM9eQpDT05GSUdfREVWVE1QRlNfTU9VTlQ9eQpDT05GSUdf
TkVUPXkKQ09ORklHX05FVERFVklDRVM9eQpDT05GSUdfTkVUX0NPUkU9eQpDT05GSUdfTkVU
Q09OU09MRT15CkNPTkZJR19QQUNLRVQ9eQpDT05GSUdfVU5JWD15CkNPTkZJR19JTkVUPXkK
Q09ORklHX0lQVjY9eQpDT05GSUdfRVRIRVJORVQ9eQpDT05GSUdfQ09NUEFUXzMyQklUX1RJ
TUU9eQpDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX0lLQ09ORklHPXkKQ09ORklHX0lL
Q09ORklHX1BST0M9eQoKIyBhcmNoaXRlY3R1cmUgc3BlY2lmaWMKQ09ORklHX0NQVV9TVUJU
WVBFX0oyPXkKQ09ORklHX0NQVV9CSUdfRU5ESUFOPXkKQ09ORklHX1NIX0pDT1JFX1NPQz15
CkNPTkZJR19TTVA9eQpDT05GSUdfSkNPUkVfRU1BQz15CkNPTkZJR19GTEFUTUVNX01BTlVB
TD15CkNPTkZJR19NRU1PUllfU1RBUlQ9MHgxMDAwMDAwMApDT05GSUdfQ01ETElORV9PVkVS
V1JJVEU9eQpDT05GSUdfRE5PVElGWT15CkNPTkZJR19GVVNFX0ZTPXkKQ09ORklHX0lOT1RJ
RllfVVNFUj15CkNPTkZJR19TUEk9eQpDT05GSUdfU1BJX0pDT1JFPXkKQ09ORklHX1NFUklB
TF9VQVJUTElURT15CkNPTkZJR19TRVJJQUxfVUFSVExJVEVfQ09OU09MRT15CkNPTkZJR19Q
V1JTRVFfU0lNUExFPXkKQ09ORklHX01NQz15CkNPTkZJR19NTUNfQkxPQ0s9eQpDT05GSUdf
TU1DX1NQST15CkNPTkZJR19VSU89eQpDT05GSUdfVUlPX1BEUlZfR0VOSVJRPXkKQ09ORklH
X01URD15CkNPTkZJR19NVERfU1BJX05PUj15CkNPTkZJR19NVERfU1NUMjVMPXkKQ09ORklH
X01URF9PRl9QQVJUUz15CkNPTkZJR19CSU5GTVRfRUxGX0ZEUElDPXkKQ09ORklHX0JJTkZN
VF9NSVNDPXkKQ09ORklHX0kyQz15CkNPTkZJR19JMkNfSEVMUEVSX0FVVE89eQpDT05GSUdf
Q01ETElORT0iY29uc29sZT10dHlVTDAgZWFybHljb24iCgojIGFyY2hpdGVjdHVyZSBleHRy
YQpDT05GSUdfSU5JVFJBTUZTX1NPVVJDRT0iL2hvbWUvbGFuZGxleS9qdW5rL3RveWJveC9y
b290L3NoMmViL2ZzIgo=

--------------9XcUTwgllYyIEUT0TdW1gO0I--
