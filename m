Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB04145B10;
	Sat, 30 Nov 2024 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732973741; cv=none; b=EIQTALfXKj0UF19GqaxDLw2NMZ//KrmRVEI3ZoDK/fSCQttuDQwBdkLyOujfYYE/MXzgkuTHfq0cbpIOuKBqipbCQNF6n7OEg07Wbin6khyMT6rgfXlghjJRt0xD9SvMQPQ/C8IBAe6uBJGANVyDkaBMvkzeeVlnOCYY+zqQlHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732973741; c=relaxed/simple;
	bh=P9f1SQIxR69ahFTc7cyOyjvp6evEr1XqTqvgOLGfB7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=g2kt/Ru2LzvRxmFA9On++jSxgc32DY718yh9mo6T5xxPF2u4n12dO3p1ebTyMUm/ZjPpjpw7x6m+iwuNIGTjgeqiCB7H4yPfaDzz2TUl7PPjfV5wHZGIpJcQivXh7mLpCrN3n/TQcL6xOh84geGe0BvzAgOcyDPUoCUIspcAYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Yr7RqofA reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Yr7RqofA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=L3eD9Q571nOGCypSpO4cHet0xe1nnjL94JqvBdZKtwo=; b=Y
	r7RqofAVJ8Q4f9l6b3HQLb90YuXLvLzYNAyzszqv7PMLW1wO7uBc6wqHgRXz9Bj9
	5jXxHozRS1YvCESb3yl0i08iCvNHCtmEOpJMl84mSuArQ8ZP7vDf/VGHnA//Zju3
	0Vw6hQ9fiTuSSv80pmRUjVB/QHA5vbLXbxolhoIlSA=
Received: from 00107082$163.com ( [111.35.188.140] ) by
 ajax-webmail-wmsvr-40-126 (Coremail) ; Sat, 30 Nov 2024 21:34:10 +0800
 (CST)
Date: Sat, 30 Nov 2024 21:34:10 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 13/13] sh/irq: use seq_put_decimal_ull_width() for
 decimal values
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <a9fe22747f20cae9fcc9b9d20109e7afbf8e6b93.camel@physik.fu-berlin.de>
References: <20241108162634.9945-1-00107082@163.com>
 <bc772ca68b843e89ec201db46e3dc94d55faebaf.camel@physik.fu-berlin.de>
 <a9fe22747f20cae9fcc9b9d20109e7afbf8e6b93.camel@physik.fu-berlin.de>
X-NTES-SC: AL_Qu2YAPWcvE4u5iWbYOkXn0oTju85XMCzuv8j3YJeN500lST09Cs8bG5iHlnH/PmgKxymoQmISxNpyeFhXYN6UaKxk5SP6pzEMOtd+BFuPWzx
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <57371ce2.3933.1937d47626c.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:figvCgD3P5pTFEtnWtozAA--.63493W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxinqmdK-zDG4gAEsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMTEtMzAgMjA6NDQ6MjYsICJKb2huIFBhdWwgQWRyaWFuIEdsYXViaXR6IiA8Z2xh
dWJpdHpAcGh5c2lrLmZ1LWJlcmxpbi5kZT4gd3JvdGU6Cj5IaSBEYXZpZCwKPgo+T24gU2F0LCAy
MDI0LTExLTMwIGF0IDEzOjQxICswMTAwLCBKb2huIFBhdWwgQWRyaWFuIEdsYXViaXR6IHdyb3Rl
Ogo+PiBPbiBTYXQsIDIwMjQtMTEtMDkgYXQgMDA6MjYgKzA4MDAsIERhdmlkIFdhbmcgd3JvdGU6
Cj4+ID4gUGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgZm9yIHJlYWRpbmcgL3Byb2MvaW50ZXJydXB0
cyBvbiBhcmNoIHNoCj4+ID4gCj4+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgV2FuZyA8MDAxMDcw
ODJAMTYzLmNvbT4KPj4gPiAtLS0KPj4gPiAgYXJjaC9zaC9rZXJuZWwvaXJxLmMgfCA0ICsrLS0K
Pj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4g
PiAKPj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9zaC9rZXJuZWwvaXJxLmMgYi9hcmNoL3NoL2tlcm5l
bC9pcnEuYwo+PiA+IGluZGV4IDRlNjgzNWRlNTRjZi4uOTAyMmQ4YWY5ZDY4IDEwMDY0NAo+PiA+
IC0tLSBhL2FyY2gvc2gva2VybmVsL2lycS5jCj4+ID4gKysrIGIvYXJjaC9zaC9rZXJuZWwvaXJx
LmMKPj4gPiBAQCAtNDMsOSArNDMsOSBAQCBpbnQgYXJjaF9zaG93X2ludGVycnVwdHMoc3RydWN0
IHNlcV9maWxlICpwLCBpbnQgcHJlYykKPj4gPiAgewo+PiA+ICAJaW50IGo7Cj4+ID4gIAo+PiA+
IC0Jc2VxX3ByaW50ZihwLCAiJSpzOiAiLCBwcmVjLCAiTk1JIik7Cj4+ID4gKwlzZXFfcHJpbnRm
KHAsICIlKnM6IiwgcHJlYywgIk5NSSIpOwo+PiA+ICAJZm9yX2VhY2hfb25saW5lX2NwdShqKQo+
PiA+IC0JCXNlcV9wcmludGYocCwgIiUxMHUgIiwgcGVyX2NwdShpcnFfc3RhdC5fX25taV9jb3Vu
dCwgaikpOwo+PiA+ICsJCXNlcV9wdXRfZGVjaW1hbF91bGxfd2lkdGgocCwgIiAiLCBwZXJfY3B1
KGlycV9zdGF0Ll9fbm1pX2NvdW50LCBqKSwgMTApOwo+PiA+ICAJc2VxX3ByaW50ZihwLCAiICBO
b24tbWFza2FibGUgaW50ZXJydXB0c1xuIik7Cj4+ID4gIAo+PiA+ICAJc2VxX3ByaW50ZihwLCAi
JSpzOiAlMTB1XG4iLCBwcmVjLCAiRVJSIiwgYXRvbWljX3JlYWQoJmlycV9lcnJfY291bnQpKTsK
Pj4gCj4+IFNvcnJ5IGZvciB0aGUgdmVyeSBsYXRlIHJlcGx5IQo+PiAKPj4gSSBkb24ndCBxdWl0
ZSB1bmRlcnN0YW5kIHdoeSBzZXFfcHV0X2RlY2ltYWxfdWxsX3dpZHRoKCkgc2hvdWxkIGJlIGZh
c3RlciB0aGFuIHNlcV9wcmludGYoKS4KPj4gCj4+IENhbiB5b3UgZWxhYm9yYXRlIG9uIHRoaXMg
YSBiaXQgbW9yZT8KPgo+SSBqdXN0IGNoZWNrZWQgZXhpc3RpbmcgbWVyZ2VzIG9mIHRoaXMgcGF0
Y2ggZm9yIG90aGVyIGFyY2hpdGVjdHVyZXMgd2hpY2ggaW5jbHVkZQo+YSBtb3JlIGVsYWJvcmF0
ZSBwYXRjaCBkZXNjcmlwdGlvbi4gSWYgeW91IGNvdWxkIGRvIHRoYXQgZm9yIFNIIGFzIHdlbGws
IEkgY2FuIHBpY2sKPnRoZSBwYXRjaCBmb3IgdjYuMTQuCj4KPkFkcmlhbgo+Cj4tLSAKPiAuJydg
LiAgSm9obiBQYXVsIEFkcmlhbiBHbGF1Yml0ego+OiA6JyA6ICBEZWJpYW4gRGV2ZWxvcGVyCj5g
LiBgJyAgIFBoeXNpY2lzdAo+ICBgLSAgICBHUEc6IDYyRkYgOEE3NSA4NEUwIDI5NTYgOTU0NiAg
MDAwNiA3NDI2IDNCMzcgRjVCNSBGOTEzCgpTdXJlLCBJIHdpbGwgbWFrZSB0aGUgY2hhbmdlLgoK
VG8gYmUgaG9uZXN0LCBJIGRvIG5vdCBoYXZlIGEgU0ggcGxhdGZvcm0gdG8gY29uZmlybSB0aGUg
cGVyZm9ybWFuY2UgY2hhbmdlcy4KSWYgY29udmVuaWVudCwgYSBzaW1wbGUgYHN0cmFjZSAtVCAt
ZSByZWFkIGNhdCAvcHJvYy9pbnRlcnJ1cHRzID4gL2Rldi9udWxsYApjYW4gYmUgdXNlZCB0byB2
ZXJpZnkgYW55IGltcHJvdmVtZW50LCBhbmQgdGhlIGNvcmUgY2hhbmdlIGluIGNvbW1pdApmOWVk
MWY3YzJlMjZmY2QxOTc4KGdlbmlycS9wcm9jOiBVc2Ugc2VxX3B1dF9kZWNpbWFsX3VsbF93aWR0
aCgpIGZvciBkZWNpbWFsIHZhbHVlcykKaXMgbmVlZGVkLgoKClRoYW5rcwpEYXZpZAo=
