Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7E1AF0C9
	for <linux-sh@vger.kernel.org>; Mon, 13 Jan 2025 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745019; cv=none; b=LyTwrH1GB4JP3SI0GcgwgA+hicoET0Mn+TH1M9QuPO+vIcwzYQYQiVkItX8n+gf541ian8Warsdi9mwjp0gEJ5axkLa+TSLgax2Iuen/DuV3YfkW5Gb0diQ/r0eZYFadzfrttX95U2xwiIDMuokPHGfcxHN2rNclcpVdjglkTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745019; c=relaxed/simple;
	bh=5Gu5X3oWw7N+TW7iVJW6O3CfHCU/gdAjtTm3TNHxcGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1rBiyFuGY/mBbkrRwA8WCRZ98BdTDSLCea8fmFHLpxvOWlHy5+7RQuAXc5uCmxzGNMQcRR816K0SzVM+EYmcH0GV00x19z3Y9d/ARCYaUCTaxlAslyJz4PVCzTxWHLS0aP52ykr6RR29VNpmPTYDaQLUOtG88hCI6Ybgp3ep84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ljsvv1zT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ljsvv1zT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21619108a6bso64504285ad.3
        for <linux-sh@vger.kernel.org>; Sun, 12 Jan 2025 21:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736745017; x=1737349817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Gu5X3oWw7N+TW7iVJW6O3CfHCU/gdAjtTm3TNHxcGQ=;
        b=Ljsvv1zT5odBQVBiO9HPbVJEAFXpd50i0TLZp0rLbnWLSqN+MZJOHHPGSSdxeDNQdW
         HC/Rkq0pmAopJ0TnahDTj10sQ86kDApJ5fPT/fiU/D4++6KUtGgoBNs6VQAmZFue+6OA
         gz0cRndhTWwIs05CqjbB6lgVLkfBUkJwplsDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736745017; x=1737349817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Gu5X3oWw7N+TW7iVJW6O3CfHCU/gdAjtTm3TNHxcGQ=;
        b=ZewvaMJGNvmtK/R0o/HT+l6c9oUZtZtvMCHSvWfYMDNTnVPs36ZDAyZosgfwjkPUo0
         xCOQhio3SwI7t4C94ShvQYmya9mQGkRjh7MLFNs6GcuY7Gta2jYIyAnxnRvFP8kAF9XV
         Q+6BXXOle5z0eTF4Sajx359U+4MB+gH9EcIylzM9PkWhx/o8rOsTHDsLBPTJveO5/i7g
         G4frxSwJ+xqmvp+O5hgbmzRIT+XLhzZ0ZPc4j0yBAKfB+vnkoNrHgpF/SZC87vmFMxfY
         Rn/i7l66HJxoswqLRC4D88JWdY6EkYX1+6H1/jJV0mYrACALjOdfUyfdbE65DTC6iCku
         VF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7Igq67/O4zdmZ25wd+lPP9e/MpL6pZiGZnnhGH1VuO5O98ctwji0CDDicI6rWcSeD5Zbul1WQ+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwsx/TEtvK26XUkhjc3N7gZguRiqnw0z0Q2qnkhN0/Xl897LAy
	DfqS0Fye+TDH8+ijKWCm4E4An2cRyf4TJuqKnPjHKvxQaidMNLC/w+o/rt7d//G8jp/t2N1MtbW
	onJ+/OVbxgrbKUxBFTvVYQN+Jjs9TldH8xtlG
X-Gm-Gg: ASbGnctIRjzGfeZctM9GYR60HAH3iJTEMWyEopHhsiIe9xrd6X605+plpH1qRlzyhrz
	G0t65grsFYqkX8LDLopnaEXDuSIBbQRTzPOP0br8=
X-Google-Smtp-Source: AGHT+IGM12nPucziNIwJ3ewGaWvHtohP++DZOO35GmGmbwVCN/TIxMVLxllOCEcUgTLwTtXB+L6hLE0lVeRgtODpIag=
X-Received: by 2002:a05:6a20:43a9:b0:1e1:b727:1801 with SMTP id
 adf61e73a8af0-1e88d15a830mr30499651637.27.1736745017369; Sun, 12 Jan 2025
 21:10:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111070751.2588654-1-yukaixiong@huawei.com> <20250111070751.2588654-17-yukaixiong@huawei.com>
In-Reply-To: <20250111070751.2588654-17-yukaixiong@huawei.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 13 Jan 2025 10:40:05 +0530
X-Gm-Features: AbW1kvb15aJAWs4dMA-1O4yfTe_qq6ymGjviDWt2j4MzAI2WDea4KyZDnt0GIcY
Message-ID: <CAH-L+nMzferXh=P0brckqWGLo06Rg+XG-3ToLZqA5TBObRZimQ@mail.gmail.com>
Subject: Re: [PATCH v5 -next 16/16] sysctl: remove unneeded include
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, joel.granados@kernel.org, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kees@kernel.org, j.granados@samsung.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, trondmy@kernel.org, anna@kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, 
	shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com, 
	souravpanda@google.com, hannes@cmpxchg.org, rientjes@google.com, 
	pasha.tatashin@soleen.com, david@redhat.com, ryan.roberts@arm.com, 
	ying.huang@intel.com, yang@os.amperecomputing.com, zev@bewilderbeest.net, 
	serge@hallyn.com, vegard.nossum@oracle.com, wangkefeng.wang@huawei.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d78ef6062b8f7558"

--000000000000d78ef6062b8f7558
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 12:49=E2=80=AFPM Kaixiong Yu <yukaixiong@huawei.com=
> wrote:
>
> Removing unneeded mm includes in kernel/sysctl.c.
>
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>


--=20
Regards,
Kalesh AP

--000000000000d78ef6062b8f7558
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIM2TOP9TtJ2BdQjXIc94PqF/qqG6PokycjwG8VMAQtDLMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDExMzA1MTAxN1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQATWJeIQzo3
YTKVVMtMXwgyKiHUSHJ9UHNOvPVPa8tBatC9JG46LvgEvLbK6I7seMbKeOWoCX1wIwBfVgJ/Ouyi
8pHe7Jx74+7Ryi05nsyscFsKaXwCLwtQZUzlUTN68agd+ZBg+frBhvoIFOJ42xYPdgbXY6EECKJB
HRtvbFHwWIJNqHZRPd9ijdzIHTiFA/kIff5HL5wqoj4LfYVOTZrKvA/1/nIBXQD77xCRFRadQsEi
beoU0uXtAVxHq7IerJqjj+tw6ni29atkqUC4LZM+pqTBQnYu6tGotDVTpLu7fxIo1Fiv4TFU9PDT
tMD8ijVVWxnAbZ5EbTM3KcbzeMWm
--000000000000d78ef6062b8f7558--
